#!/bin/bash
#
# Show 5h + 7d API usage limits in your statusline
#
# Although heavily modified, this was based on:
#   https://gist.github.com/vildanbina/af6b1186fa529093bdd5d61bdf6d7b33

set -euo pipefail

CACHE="$HOME/.cache/cc-usage.txt"
LOCK="$HOME/.cache/cc-usage.lock"
CREDS="${CC_CREDENTIALS:-$HOME/.claude/.credentials.json}"
TTL="${CC_CACHE_TTL:-300}"
CLAUDE_ICON=""

get_mtime() {
    if [[ "$(uname -s)" == "Darwin" ]]; then
        stat -f '%m' "$1" 2>/dev/null || echo 0
    else
        stat -c '%Y' "$1" 2>/dev/null || echo 0
    fi
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

echo "${CLAUDE_ICON} 5h: ${session}% | 7d: ${weekly}%" | tee "$CACHE"
