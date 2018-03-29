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

# Enable bash completions; copied from Ubuntu MATE 17.10's default .bashrc.
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Make sure git prompt functions are available in subshells, e.g. pipenv shell.
export -f __git_eread
export -f __git_ps1
export -f __git_ps1_colorize_gitstring
export -f __git_ps1_show_upstream

# I like a simple, but thoroughly git-aware, prompt. It's all dimmed; user input
# should have focus, not a flashy prompt.
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

# Enable completion for pipenv commands.
eval "$(pipenv --completion)"

# Enable pyenv and plugins.
export PATH="/home/gareth/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
