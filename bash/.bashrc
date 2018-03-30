# Keep a lot of history, aka a potentially job-saving record of commands.
HISTSIZE=5000

# Don't add duplicate lines or lines beginning with a space to history.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it.
shopt -s histappend

# Enable ** for matching across arbitrary depth of subdirectories.
shopt -s globstar

# Check the window size after each command and, if necessary, update the values
# of $LINES and $COLUMNS.
shopt -s checkwinsize

# Enable less handling of some other filetypes beyond plain text; rarely used,
# but a potentially useful carryover from Ubuntu MATE 17.10's default .bashrc.
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable bash completions; copied from Ubuntu MATE 17.10's default .bashrc.
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Enable colour support in some commonly used utilities.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Keep Ubuntu MATE 17.10's useful ls aliases.
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Make sure git prompt functions are available in subshells, e.g. pipenv shell.
export -f __git_eread
export -f __git_ps1
export -f __git_ps1_colorize_gitstring
export -f __git_ps1_show_upstream

# I like a simple, but thoroughly git-aware, prompt.
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM=1
PS1='\[\033[0;34m\]\w' # Blue current working directory.
PS1+='\[\033[0;33m\]$(__git_ps1 " (%s)")' # Yellow git information (if a repo).
PS1+='\[\033[0m\]\[\033[2m\] \$ \[\033[0m\]' # Dimmed dollar-prompt.

# Set $TERM appropriately if not running inside tmux.
if [ -z "$TMUX" ]; then
  export TERM=xterm-256color
fi

# Ensure $TERM is set appropriately when using ssh (including through Vagrant).
alias ssh='TERM=screen ssh'
vagrant() {
  if [[ $1 == 'ssh' ]]; then
    TERM=screen command vagrant "$@"
  else
    command vagrant "$@"
  fi
}

# Include user's own bin dir in $PATH; pip --user installs here by default.
export PATH="$HOME/.local/bin:$PATH"

# Enable completion for pipenv commands.
eval "$(pipenv --completion)"

# Enable pyenv and plugins.
export PATH="/home/gareth/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
