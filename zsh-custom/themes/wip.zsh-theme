# TODO rename WIP THEME

dir_segment() {
    print -n "%(?.%{%K{blue}%}.%{%K{red}%})%{%F{black}%} %~ "
}

git_segment() {
    print -n "%{%K{yellow}%{%F{black}%} main "
}

prompt_wip_precmd() {
    # vcs_info
    PROMPT="%{%f%b%k%}$(dir_segment)$(git_segment)%{%f%b%k%} "
    RPROMPT="$(rprompt_git)"
}

prompt_wip_setup() {
    autoload -Uz add-zsh-hook
    # autoload -Uz vcs_info
    # prompt_opts=(cr subst percent)
    add-zsh-hook precmd prompt_wip_precmd
}

rprompt_git() {
    c=$(git rev-list --walk-reflogs --count refs/stash 2> /dev/null)
    [[ -n "$c" ]] && (
        prompt_segment yellow black
        echo "%{%K{yellow}%{%F{black}%} $c stash "
    )
}

prompt_wip_setup "$@"
