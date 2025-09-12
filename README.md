# My dotfiles

This repository contains my personal dotfiles for customizing my development environment, including settings for the shell, editor, and various applications. It's primarily intended for personal reference, but feel free to explore it for inspiration.

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

## Terminal Typefaces

A reference of fonts I've previously used:

- [DOSEGA](https://sourceforge.net/projects/dosega/)
- [M+1m console font](http://sourceforge.jp/projects/mplus-fonts/downloads/62344/mplus-TESTFLIGHT-059.tar.xz/)

## macOS fixes

### Speed up key repeat

```bash
defaults write NSGlobalDomain KeyRepeat -int 1           # normal minimum is 2 (30 ms)
defaults write NSGlobalDomain InitialKeyRepeat -int 10   # normal minimum is 15 (225 ms)
```

### Fix font rendering on 1080p screens

```bash
defaults -currentHost write -g AppleFontSmoothing -int 0
```

### TODO

- Configure local includes for `zsh`, `vim`, `nvim`, `bin`, and `alacritty` using a `.local` suffix pattern.
- Configure the `cmus` directory via `.zshrc.local`.
- Enhance the shell prompt to display Python virtual environment details (e.g., from Poetry or `$VIRTUAL_ENV`).
