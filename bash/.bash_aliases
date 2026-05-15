# If you `source` multiple times (`reload` here),
# you may want to clear old aliases.
unalias -a

alias loadrc='source $BASHRC'

python() {
    # If no args provided, open the REPL
    test "$#" = 0 \
        && ptpython \
        || python3 "$@"
}

# Some shortcuts.
alias apti='sudo apt install'
alias giti='git clone --depth=1'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- '-'='cd -'

# Default flags.
alias codium='codium -a'
alias grep='grep -E --color=auto'
alias pathcheck='pathcheck --status-style=icons --header --footer --descriptions --format="│ ({status:-} │ ){path:<}( │ {description:<}) │"'
alias bat='batcat --paging never --theme ansi --style numbers'
alias eza='eza --all --header --color --icons --no-quotes --sort=Name --group-directories-first --time-style="+%e %b, %H:%M"'
alias ls='eza'
alias ll='ls -l'
