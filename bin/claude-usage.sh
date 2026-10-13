#!/bin/bash
#
# Show 5h + 7d API usage limits in your statusline as two stacked braille
# progress bars (top: 5h session, bottom: 7d weekly), 8 characters wide.
# Output contains tmux style tags: the icon and bars sit on the tmux window tab
# colour, so the empty part of the bars is visible, and the dots change colour
# near the limit.
#
# Although heavily modified, this was based on:
#   https://gist.github.com/vildanbina/af6b1186fa529093bdd5d61bdf6d7b33

set -euo pipefail

CACHE="$HOME/.cache/cc-usage.txt"
LOCK="$HOME/.cache/cc-usage.lock"
CREDS="${CC_CREDENTIALS:-$HOME/.claude/.credentials.json}"
TTL="${CC_CACHE_TTL:-300}"
CLAUDE_ICON=""
# Background matches the tmux window tabs (status-bg); foregrounds are from
# Everforest Light (the Alacritty theme): bg0, orange, red
BLOCK_BG="${CC_BLOCK_BG:-#666666}"
BAR_FG="${CC_BAR_FG:-#fffbef}"
WARN_PCT=80
WARN_FG="#f57d26"
CRIT_PCT=95
CRIT_FG="#f85552"

get_mtime() {
    if [[ "$(uname -s)" == "Darwin" ]]; then
        stat -f '%m' "$1" 2>/dev/null || echo 0
    else
        stat -c '%Y' "$1" 2>/dev/null || echo 0
    fi
}

# Number of filled dot columns (0-16) for a percentage; any usage shows >= 1
bar_cols() {
    local n=$((($1 * 16 + 50) / 100))
    [[ $n -lt 1 && $1 -gt 0 ]] && n=1
    [[ $n -gt 16 ]] && n=16
    echo "$n"
}

# Render two 16-column bars into 8 braille chars (U+2800 + dot bitmask).
# Top bar uses dot rows 1-2, bottom bar dot rows 3-4.
braille_bars() {
    local top bottom i v out=""
    top=$(bar_cols "$1")
    bottom=$(bar_cols "$2")
    for ((i = 0; i < 8; i++)); do
        v=0
        [[ $top -gt $((2 * i)) ]] && v=$((v | 0x03))
        [[ $top -gt $((2 * i + 1)) ]] && v=$((v | 0x18))
        [[ $bottom -gt $((2 * i)) ]] && v=$((v | 0x44))
        [[ $bottom -gt $((2 * i + 1)) ]] && v=$((v | 0xA0))
        # UTF-8 encode by hand, as bash 3.2 printf has no \u
        out+=$(printf "\\xE2\\x$(printf '%X' $((0xA0 + (v >> 6))))\\x$(printf '%X' $((0x80 + (v & 0x3F))))")
    done
    echo "$out"
}

# Return cached if fresh
if [[ -f "$CACHE" ]]; then
    age=$(($(date +%s) - $(get_mtime "$CACHE")))
    [[ $age -lt $TTL ]] && cat "$CACHE" && exit 0
fi

# Rate limit API calls
if [[ -f "$LOCK" ]]; then
    age=$(($(date +%s) - $(get_mtime "$LOCK")))
    [[ $age -lt 60 ]] && { [[ -f "$CACHE" ]] && cat "$CACHE"; exit 0; }
fi
touch "$LOCK"

# Get token
token=""
if [[ -f "$CREDS" ]]; then
    token=$(jq -r '.claudeAiOauth.accessToken // empty' "$CREDS" 2>/dev/null)
elif [[ "$(uname -s)" == "Darwin" ]]; then
    # On macOS, Claude Code stores credentials in the Keychain
    creds_json=$(security find-generic-password -s "Claude Code-credentials" -w 2>/dev/null) || true
    if [[ -n "${creds_json:-}" ]]; then
        token=$(echo "$creds_json" | jq -r '.claudeAiOauth.accessToken // empty' 2>/dev/null)
    fi
fi
[[ -z "$token" ]] && echo "[No creds]" && exit 1

# Fetch usage
resp=$(curl -s --max-time 5 \
    "https://api.anthropic.com/api/oauth/usage" \
    -H "Authorization: Bearer $token" \
    -H "anthropic-beta: oauth-2025-04-20" \
    -H "User-Agent: claude-code/0.2.29" \
    -H "Content-Type: application/json" 2>/dev/null) || true

[[ -z "$resp" ]] && { [[ -f "$CACHE" ]] && cat "$CACHE"; echo "[Timeout]"; exit 1; }

session=$(echo "$resp" | jq -r '(.five_hour.utilization // empty) | floor' 2>/dev/null)
weekly=$(echo "$resp" | jq -r '(.seven_day.utilization // empty) | floor' 2>/dev/null)

if [[ -z "$session" || -z "$weekly" ]]; then
    [[ -f "$CACHE" ]] && cat "$CACHE"
    err_type=$(echo "$resp" | jq -r '.error.type // empty' 2>/dev/null)
    if [[ "$err_type" == "rate_limit_error" ]]; then
        echo "[API Rate limited]"
    else
        echo "[Error]"
    fi
    exit 1
fi

# Both bars share each character, so colour them together by the higher value
peak=$((session > weekly ? session : weekly))
bar_fg="$BAR_FG"
if [[ $peak -ge $CRIT_PCT ]]; then
    bar_fg="$CRIT_FG"
elif [[ $peak -ge $WARN_PCT ]]; then
    bar_fg="$WARN_FG"
fi

echo "#[bg=${BLOCK_BG},fg=${BAR_FG}] ${CLAUDE_ICON} #[fg=${bar_fg}]$(braille_bars "$session" "$weekly")#[default]" | tee "$CACHE"
