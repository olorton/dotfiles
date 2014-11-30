#!/usr/bin/env bash

path="/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"

dest="$HOME/.dotfiles/bin/"

if [ -e "$path" ]
then
    # if [ -e "$dest" ]
    # then
        #rm -rf $dest
    # fi
    ln -s "$path" "$dest"
    exit 0
else
    echo "Failed to link Sublime Text to $dest"
    exit 1
fi

