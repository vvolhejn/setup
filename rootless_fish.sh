#!/bin/bash

# https://gist.github.com/masih/10277869
# Script for installing Fish Shell on systems without root access.
# Fish Shell will be installed in $HOME/.local/bin.
# It's assumed that wget and a C/C++ compiler are installed.
 
# exit on error
set -e
 
FISH_SHELL_VERSION=3.2.2
 
# create our directories
mkdir -p $HOME/.local $HOME/fish_shell_tmp
cd $HOME/fish_shell_tmp
 
# download source files for Fish Shell
wget http://github.com/fish-shell/fish-shell/releases/download/${FISH_SHELL_VERSION}/fish-${FISH_SHELL_VERSION}.tar.xz 

# extract files, configure, and compile

tar xvf fish-${FISH_SHELL_VERSION}.tar.xz
cd fish-${FISH_SHELL_VERSION}
mkdir build; cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$HOME/.local
# ./configure --prefix=$HOME/.local --disable-shared
make
make install

# Add the following to ~/.bashrc:
# if [[ $- = *i* ]]; then
#   exec ~/.local/bin/fish
# fi
