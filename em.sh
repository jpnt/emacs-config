#!/bin/bash
# Create executable emacsclient script
# NOTE: Must run: emacs --daemon &
file=$HOME/.local/bin/em
touch $file
chmod 744 $file
echo "emacsclient -c -a emacs" > $file
