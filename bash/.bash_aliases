# If you `source` multiple times (`reload` here),
# you may want to clear old aliases.
unalias -a

# Some shortcuts.
alias p="printlnf "%s""
alias i="sudo apt install"
alias v="nvim"
alias c="codium -a"
alias reload=". $BASHRC"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias -- "-"="cd -"

# "github install".
alias ghi="git clone --depth=1"

# Default flags.
alias grep="grep --color=auto -E"
alias path="path -Qsnerd-font"
# -P: No page.
alias bat="batcat -P --theme 'Monokai Extended' --style 'numbers'"

# Add an "alert" alias for long running commands.
# Example: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e "\""s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//"\"")"'
