# My dotfiles

This repository contains configuration files that help customize my development environment, including settings for the shell, editor, and various applications. Do not try to use this repo as it is! These dotfiles are intended to serve as a reference for others looking to set up their own dotfiles. Feel free to explore and use these to influence your own ideas!

## Setup

* [Install homebrew](http://brew.sh)
* [Install oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) (zsh comes with macOS Catalina)

Then:

```bash
git clone git@github.com:olorton/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
bin/dotfiles-symlink
cat ~/.python-version | pyenv install -
source ~/.zshrc
dedit
```

#
Here are some terminal typefaces I've used in the past, included here for future reference:
- Current: [DOSEGA](https://sourceforge.net/projects/dosega/)
- [M+1m console font](http://sourceforge.jp/projects/mplus-fonts/downloads/62344/mplus-TESTFLIGHT-059.tar.xz/)

## macOS fixes

### Speed up key repeat

    defaults write NSGlobalDomain KeyRepeat -int 1           # normal minimum is 2 (30 ms)
    defaults write NSGlobalDomain InitialKeyRepeat -int 10   # normal minimum is 15 (225 ms)

### Fix font rendering on 1080p screens

    defaults -currentHost write -g AppleFontSmoothing -int 0

### TODO

- Set the local includes up for zsh, vim, nvim, bin, alacritty, use the name <thing>.local
- Set up cmus dir based on a .zshrc.local file
- Add venv details to prompt, either use poetry to show python version and erros if not valid. OR just show the output of $VIRTUAL_ENV
