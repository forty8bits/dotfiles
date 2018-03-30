#!/usr/bin/env bash

# Generated on http://patorjk.com/software/taag with the Small Slant font.
if [ -z "$HIDE_LOGO" ]; then
    cat << "EOF"

  __  _____  ____  ____  ___________________  ___   ___    ______ __
 / / / / _ )/ __ \/ __ \/_  __/ __/_  __/ _ \/ _ | / _ \  / __/ // /
/ /_/ / _  / /_/ / /_/ / / / _\ \  / / / , _/ __ |/ ___/ _\ \/ _  /
\____/____/\____/\____/ /_/ /___/ /_/ /_/|_/_/ |_/_/  (_)___/_//_/


EOF
fi

# Needs to run as root; ask for password to run sudo if necessary.
if [ $EUID != 0 ]; then sudo -s HIDE_LOGO=1 "$0" "$@"; exit $?; fi

# This'll be used later for running user-local installs and setup for certain
# things, e.g. installation of Pipenv.
if [ -n "$SUDO_USER" ]; then
    REAL_USER=$SUDO_USER
else
    REAL_USER=$(whoami)
fi

# Install some fundamental tools and libraries I'll likely always need.
for pkg in build-essential curl git; do
    echo "Installing ${pkg} if necessary..."
    apt-get -y install $pkg
done

# Install Pipenv and pyenv for Python development nirvana.
sudo -H -u "$REAL_USER" -s pip3 install --user -U pipenv
sudo -H -u "$REAL_USER" -s curl \
    -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer \
    | sudo -H -u "$REAL_USER" -i

# Finally, unleash the files upon the system.
sudo -H -u "$REAL_USER" -s stow dotfiles
