# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# append to the history file, don't overwrite it
shopt -s histappend

# spell checks for 1 transposed, missing or  addititional character
shopt -s cdspell
# checks status of running/stopped jobs. Second exit needed as confirmation.
shopt -s checkjobs
# If set, the pattern "**" used in a pathname expansion context will match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    tmux|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

# chech whether we are in tmux or not
if ! { [ "$TERM" = "screen-256color" ] && [ -n "$TMUX" ]; } then
  TMUX_SHELL=no
else
  TMUX_SHELL=yes
fi

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    COLOR_DEFAULT_FG="\e[39m"
    COLOR_RED="\e[1;31m"
    COLOR_YELLOW="\e[1;33m"
    COLOR_GREEN="\e[0;32m"
    COLOR_LIGHT_GREEN="\e[1;32m"
    COLOR_OCHRE="\e[1;36m"
    COLOR_BLUE="\e[1;34m"
    COLOR_WHITE="\e[1;37m"
    RESET_ALL="\e[0m"
    RESET_BOLD="\e[21m"

    function git_warning {
      local git_status="$(git status 2> /dev/null)"

       if [[ ! $git_status == "" ]]; then
          if [[ ! $git_status =~ "working directory clean" ]]; then
            echo " [*]"
          elif [[ $git_status =~ "Your branch is ahead of" ]]; then
            echo " [*]"
          fi
      fi
    }

    PS1="${debian_chroot:+\($debian_chroot)}"

    PS1+="\[$COLOR_LIGHT_GREEN\][$HOSTNAME]\[$COLOR_DEFAULT_FG\]"
    PS1+="\[$COLOR_OCHRE\]\t \[$COLOR_DEFAULT_FG\]"
    PS1+="\[$COLOR_BLUE\]\u\[$COLOR_WHITE\]\[$COLOR_DEFAULT_FG\]:"
    PS1+="\[$COLOR_WHITE\]\w\[$COLOR_DEFAULT_FG\]"          # basename of pwd
    PS1+="\[$COLOR_YELLOW\]\$(__git_ps1 ' (%s)')\[$COLOR_DEFAULT_FG\]"           # prints current branch
    PS1+="\[$COLOR_RED\]\$(git_warning)\[$COLOR_DEFAULT_FG\]"
    PS1+=" \[$COLOR_BLUE\]\$\[$COLOR_DEFAULT_FG\]\[$RESET_ALL\] "   # '#' for root, else '$'
    export PS1
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
st)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

export TERM=tmux-256color

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -z /usr/local/bin/tmux ] && [ -f ~/.tmux.conf ]; then
   tmux source-file ~/.tmux.conf
fi

source ~/.bash_custom

alias tree="tree -f"
alias uu='apt update && sudo apt upgrade && sudo snap refresh'
alias df="df -h -x squashfs"
alias sudo='sudo '
alias dgrep='sudo dpkg --get-selections | grep '
alias mkdir="mkdir -p -v"
alias cdcon='cd ~/.config'
alias unlock='sudo rm /var/lib/apt/lists/lock && sudo rm /var/cache/apt/archives/lock && sudo rm /var/lib/dpkg/lock && sudo dpkg --configure -a'
alias cddot='cd $HOME/.dotfiles'

ln -fs $HOME/.dotfiles/.bashrc $HOME/.bashrc
ln -fs $HOME/.dotfiles/.tmux-keybinds $HOME/.tmux-keybinds
ln -fs $HOME/.dotfiles/.tmux-reset $HOME/.tmux-reset
ln -fs $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf
ln -fs $HOME/.dotfiles/.vimrc $HOME/.vimrc
ln -fs $HOME/.dotfiles/i3/config $HOME/.config/i3/config
ln -fs $HOME/.dotfiles/.bash_custom $HOME/.bash_custom
