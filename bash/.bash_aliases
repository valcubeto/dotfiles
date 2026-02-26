# Some shortcuts.
alias p="printlnf"
alias i="sudo apt install"
alias v="nvim"
alias c="codium -a"
alias reload=". $BASHRC"

# -P: No page.
alias bat="batcat -P --theme 'Monokai Extended' --style 'numbers'"

# "github install".
alias ghi="git clone --depth=1"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias -- "-"="cd -"

# Prints paths in PATH env var, splitting with new lines.
alias path="echo \"${PATH//:/$'\n'}\""

alias grep='grep --color=auto -E'

# Add an "alert" alias for long running commands.
# Example: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
