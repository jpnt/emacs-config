#!/bin/sh
# Cleans up .emacs.d folder
rm -rfIv $(cat .gitignore | tr -d "/" | tr "\n" " ")
