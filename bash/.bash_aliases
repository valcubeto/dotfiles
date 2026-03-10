# If you `source` multiple times (`reload` here),
# you may want to clear old aliases.
unalias -a

alias reload='. $BASHRC'

# Some shortcuts.
alias p='printf "%s\n"'
alias i='sudo apt install'
alias v='nvim'
alias c='codium -a'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- '-'='cd -'

# 'github install'.
alias ghi='git clone --depth=1'

# Default flags.
alias grep='grep --color=auto -E'
alias path='path -Qsnerd-font'
alias bat='batcat --paging=never --theme="Monokai Extended" --style="numbers"'
alias eza='eza --all --header --color --icons --no-quotes --level=1 --sort=Name --group-directories-first --no-permissions --no-user --time-style="+%e %b, %H:%M"'
alias ls='eza'
alias ll='ls -l'

# Add an "alert" alias for long running commands.
# Example: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e "\""s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//"\"")"'

last_command() {
    history | \
        tail -n1 | \
        sed -e "s/^\s*[0-9]\+\s*//;s/[;&|]\s*last_command$//"
}
