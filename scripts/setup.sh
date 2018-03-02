#!/bin/bash -
###############################################################################
# setup.sh
# This script creates everything needed to get started on a new machine
###############################################################################

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

cd $HOME

DOTFILES_DIR=$HOME/dotfiles
DOTFILE_SCRIPTS_DIR=$DOTFILES_DIR/scripts

# Change to the dotfiles directory
cd $DOTFILES_DIR

###############################################################################
# Create commonly used directories
###############################################################################
# TODO: These directory names are duplicated elsewhere. Reduce duplication
mkdir -p $HOME/bin # Third-party binaries
mkdir -p $HOME/lib # Third-party software
mkdir -p $HOME/history # Zsh and Bash history files
mkdir -p $HOME/Development
mkdir -p $HOME/Development/tools
mkdir -p $HOME/.psql # psql history directory


###############################################################################
# Install software on machine
###############################################################################
# Get the uname string
unamestr=`uname`

# Install zprezto first, as the machine script doesn't install it
ZSH_DIR="$HOME/.zprezto"
if [[ -d $ZSH_DIR ]]; then
  # Update Zsh if we already have it installed
  cd $ZSH_DIR
  git pull
  git submodule update --init --recursive
else
  # Install it if don't have a ~/.zprezto directory
  git clone --recursive https://github.com/sorin-ionescu/prezto.git $ZSH_DIR

  setopt EXTENDED_GLOB
  for rcfile in "${ZSH_DIR}"/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZSH_DIR}/.${rcfile:t}"
  done

  # Set Zsh as default shell
  chsh -s /bin/zsh
fi

# Define a function used by the setup scripts to run all the custom install
# scripts.
run_install_scripts() {
  scripts_list="$1"
  install_scripts_dir=$HOME/dotfiles/scripts/setup/install

  # Run each script
  for file in $scripts_list; do
    "$install_scripts_dir/$file"
  done
}

# Run the OS-specific setup scripts
if [[ "$unamestr" == 'Darwin' ]]; then
  "$DOTFILE_SCRIPTS_DIR/setup/darwin.sh"
elif [[ "$unamestr" == 'Linux' ]]; then
  "$DOTFILE_SCRIPTS_DIR/setup/linux.sh"
fi
