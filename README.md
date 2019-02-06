Pull Request test!  Hi Oliver

# Dotfiles Readme

My dotfiles: Don't fork these directly, create your own, but steal shamelessly.

## Setup

[Install homebrew](http://brew.sh). Follow the instructions to install XCode Command line tools, or just install XCode before hand. 

```bash
sudo brew install zsh git
```

or on Debian:

```bash
sudo apt install zsh git
```

Then:

```bash
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
git clone git@github.com:olorton/dotfiles.git ~/Code/dotfiles
~/Code/dotfiles/bin/dotfiles-symlink
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

When running Vim for the first time, also run `:PluginInstall` and restart vim.

### OSX defaults

TODO - fix the damn `bin/set-osx-defaults` file.

Currently using:

    defaults write NSGlobalDomain KeyRepeat -int 1
    defaults write NSGlobalDomain InitialKeyRepeat -int 25

Terminal typefaces I've used:
- Current: [DOSEGA](https://sourceforge.net/projects/dosega/)
- [M+1m console font](http://sourceforge.jp/projects/mplus-fonts/downloads/62344/mplus-TESTFLIGHT-059.tar.xz/)
