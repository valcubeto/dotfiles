# If you `source` multiple times (`reload` here),
# you may want to clear old aliases.
unalias -a

alias reload='source $BASHRC'

python() {
    test "$#" = 0 \
        && ptpython \
        || python3 "$@"
}

# Some shortcuts.
alias print='printf "%s\n"'
alias apti='sudo apt install'
alias giti='git clone --depth=1'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- '-'='cd -'

# Default flags.
alias codium='codium -a'
alias grep='grep -E --color=auto'
alias pathcheck='pathcheck --status-style=icons --header --footer --descriptions --format="{path:<}(  {status:-})(  {description:<})"'
alias bat='batcat --paging=never --theme="Monokai Extended" --style="numbers"'
alias eza='eza --all --header --color --icons --no-quotes --level=1 --sort=Name --group-directories-first --no-permissions --no-user --time-style="+%e %b, %H:%M"'
alias ls='eza'
alias ll='ls -l'
