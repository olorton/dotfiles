# Dotfiles Readme

My dotfiles: Don't fork these directly, create your own, but steal shamelessly.

## Setup

- Open the terminal and clone the dotfiles repo `git clone https://github.com:olorton/dotfiles.git ~/.dotfiles` then switch to that directory `cd ~`
- [Install homebrew](http://brew.sh). Follow the instructions to install XCode Command line tools, or just install XCode before hand. Make sure that you run `brew doctor` before you start, it should say `Your system is ready to brew.` if everything is ok.
- Run: `~/.dotfiles/bin/dotfiles-symlink`

### OSX defaults

TODO - fix the damn `bin/set-osx-defaults` file.

Currently using:

    defaults write NSGlobalDomain KeyRepeat -int 1
    defaults write NSGlobalDomain InitialKeyRepeat -int 25

Terminal typefaces I've used:
- Current: [DOSEGA](https://sourceforge.net/projects/dosega/)
- [M+1m console font](http://sourceforge.jp/projects/mplus-fonts/downloads/62344/mplus-TESTFLIGHT-059.tar.xz/)
