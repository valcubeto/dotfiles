# This is a modification of the default Linux Mint bashrc.

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
HISTCONTROL=ignoreboth:erasedups

# Warn about running background jobs before exiting.
shopt -s checkjobs

# Attempts to correct minor spelling errors in dir names
# during completion.
shopt -s dirspell

# When the line is empty, tab completion does nothing.
shopt -s no_empty_cmd_completion

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

# Set variable identifying the chroot you work in.
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

PS1="${debian_chroot:+($debian_chroot) }"
if [ "$color_prompt" = yes ]; then
    # Looks like dark magic the first time you see it.
    # The `\\[` and `\\]` are for the bash prompt,
    # to tell it anything inside it is not printable
    # (sometimes the cursor position breaks otherwise).
    # `\e` is the escape character. Basically sends an
    # instruction to the terminal. In this case, it starts
    # with `[` and ends with `m`. Styles are just numbers,
    # sepparated by semicolons.
    # Search "ANSI escape codes" for more info!
    # `$1` is the style start, and `$3` the style end.
    # `%s` gets replaced with the corresponding argument.
    ansi() {
        printf "\\[\e[%sm\\]%s\\[\e[%sm\\]" "$1" "$2" "$3"
    }

    # This was originally to display the input as bold.
    # I realized it was a bad idea.
    # start_bold() {
    #     printf "\\[\e[01m\\]";
    # }

    bold_green() { ansi "01;32" "$1" "22;39"; }
    bold_blue()  { ansi "01;34" "$1" "22;39"; }

    user() { bold_green '\u'; }
    working_dir() { bold_blue '\w'; }

    # Print a colored prompt.
    PS1+="$(printf '%s:%s \$ ' "$(user)" "$(working_dir)")"
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

# May be located at "$HOME/.bash/bashrc".
export BASHRC="$HOME/.bashrc"

# Alias definitions.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
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


# Avoid preppending again, if you `source` multiple times.
# See `alias path` in `.bash_aliases`
path_preppend() {
  # Do nothing if path doesn't exist.
  if [ ! -d "$1" ]; then
    echo "$1 NOT added to PATH: file does not exist"
    return 1
  fi
  case ":$PATH:" in
    # Do nothing if already present.
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

# This function finds the title of VSCodium (likely
# the current workspace path) and changes the current
# directory.
# I can't find an appropiate name for this function.
# I'll probably use a keyboard shortcut for calling it.
go_to_vscodium_workspace() {
  # wmctrl -lx: list all windows, and display their app name.
  # grep vscodium (-): only get the line containing "vscodium"
  # awk: `$` is an "operator" to get the field at the given index.
  #      `NF` is the number of fields, so `$NF` returns the last field.
  #      `gsub` replaces the character `~` with the value of the
  #      environment variable $HOME.
  #      I don't remember why the `~` symbol didn't work tbh.
  cd "$( \
    wmctrl -lx | \
    grep vscodium | \
    awk '{ gsub(/^~/, ENVIRON["HOME"], $NF); print $NF }' \
  )"
}

dotfiles() {
  (
    set -e
    cd $HOME/Dev/dotfiles
    git add . && \
      git commit -m "dotfiles function" && \
      git push
  )
}
