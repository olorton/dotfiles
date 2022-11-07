# Chunky Blocks, a ZSH theme
#
# A basic ZSH theme that takes my preferred bit of Agnoster, but without the
# need for any modified fonts.
#
# Features:
# - PWD shown
# - Red background shown when the previous command exited with a non-0 status
# - Current git branch shown, and coloured if on a dirty working tree
# - New line added if PWD gets too long, an attempt to maintain a sensible
#   prompt lenght

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=" *"
ZSH_THEME_GIT_PROMPT_CLEAN=""

dir_segment() {
    print -n "%(?.%{%K{blue}%}.%{%K{red}%})%{%F{black}%} %~ "
}

git_segment() {
    working_tree_is_clean() {
        [[ "$(parse_git_dirty)" == "${ZSH_THEME_GIT_PROMPT_CLEAN}" ]]
    }
    ref="$vcs_info_msg_0_"
    if [[ -n "$ref" ]]; then
        if working_tree_is_clean; then
            print -n "%{%K{green}%}%{%F{black}%} $(git_prompt_info) "
        else
            print -n "%{%K{yellow}%}%{%F{black}%} $(git_prompt_info) "
        fi
        # Stashes
        c=$(git rev-list --walk-reflogs --count refs/stash 2> /dev/null)
        [[ -n "$c" ]] && (
            print -n "%{%K{blue}%}%{%F{black}%} $c stash "
        )
    fi
}

end_prompt() {
    declare -i cols
    declare -i pwd_len
    declare -i max_len
    cols=$(tput cols)
    pwd_len="${#PWD}"
    max_len=$((cols / 2))
    if (( pwd_len > max_len )); then
        print -R -e "\n$"
    fi
}

prompt_wip_precmd() {
    vcs_info
    PROMPT="TODO SERVER %{%f%b%k%}$(dir_segment)$(git_segment)%{%f%b%k%}$(end_prompt) "
}

prompt_wip_setup() {
    autoload -Uz add-zsh-hook
    autoload -Uz vcs_info
    add-zsh-hook precmd prompt_wip_precmd
}

prompt_wip_setup "$@"
