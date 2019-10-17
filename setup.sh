#!/bin/bash
sudo apt install make
echo ''
echo 'Run `make [target]` to install.'
echo 'Available targets are:'
echo '~/[path to file under files/]'
cat Makefile | grep -oP '^\w*:' | sed 's/:$//'
