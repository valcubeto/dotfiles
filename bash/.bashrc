# ~/.bashrc: executed by bash(1) for non-login shells.
# See /usr/share/doc/bash/examples/startup-files (in the
# package bash-doc) for examples.

# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return ;;
esac

# Don't put duplicate lines or lines starting with space in
# the history.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it.
shopt -s histappend

# For setting history length see HISTSIZE and HISTFILESIZE
# in bash(1).
HISTSIZE=1000
HISTFILESIZE=2000

# Check the window size after each command and, if necessary,
# Update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion
# context will match all files and zero or more directories
# and subdirectories.
# shopt -s globstar

# Make less more friendly for non-text input files.
# See lesspipe(1).
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# -- PROMPT --

# set variable identifying the chroot you work in.
# (used in the prompt below).
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color).
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes ;;
esac

# Uncomment for a colored prompt, if the terminal has
# the capability; turned off by default to not distract
# the user: the focus in a terminal window should be on
# the output of commands, not on the prompt.
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429) (lack of such support is extremely rare,
    # and such a case would tend to support setf rather than setaf).
    color_prompt=yes
    else
    color_prompt=
    fi
fi

reset_style() { printf "\e[00m"; }

PS1='${debian_chroot:+($debian_chroot) }'
if [ "$color_prompt" = yes ]; then
    ansi() {
        printf "\\[\e[%sm\\]%s\\[\e[%sm\\]" "$1" "$2" "$3"
    }

    start_bold() {
        printf ""
        # printf "\\[\e[01m\\]";
    }

    bold_green() { ansi "01;32" "$1" "22;39"; }
    bold_blue() { ansi "01;34" "$1" "22;39"; }

    user() { bold_green '\u'; }
    working_dir() { bold_blue '\w'; }

    # Print a colored prompt, and display the command as bold.
    PS1+="$(printf '%s:%s \$ %s' "$(user)" "$(working_dir)" "$(start_bold)")"
    # Reset styles just before the command runs.
    # TODO: use PROMPT_COMMAND to enable it only once for
    # each command.
    # trap reset_style DEBUG

    unset ansi bold_green bold_blue start_bold
    unset user working_dir
else
    PS1+='\u:\w \$ '
fi

# No longer needed.
unset color_prompt force_color_prompt

# if this is an xterm set the title to "user@host: dir".
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#     ;;
# *)
#     ;;
# esac

# Enable color support of ls and also add handy aliases.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && \
      eval "$(dircolors -b ~/.dircolors)" || \
      eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# Colored GCC warnings and errors.
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export BASHRC="$HOME/.bashrc"

# Alias definitions.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
# Double quotes because syntax highlighting breaks.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# Avoid preppending again if you `source` multiple times
path_preppend() {
  # Do nothing if path doesn't exist.
  if [ ! -d "$1" ]; then
    echo "$1 NOT added to PATH: file does not exist"
    return 1
  fi
  case ":$PATH:" in
    # Don't preppend if already present.
    *":$1:"*) ;;
    *) PATH="$1:$PATH" ;;
  esac
}

# Bun
export BUN_INSTALL="$HOME/.bun"
path_preppend "$BUN_INSTALL/bin"

# Cargo
export CARGO_HOME="$HOME/.cargo"
path_preppend "$CARGO_HOME/bin"

# Alacritty
export ALACRITTY_CFG="$HOME/.config/alacritty"

function vscw {
  cd "$(\
    wmctrl -lx | \
    grep vscodium | \
    awk '{ gsub(/~/, ENVIRON["HOME"], $NF); print $NF }' \
  )";
}

