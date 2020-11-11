# Dotfiles Readme

My dotfiles: Don't fork these directly, create your own, but steal shamelessly.

## Setup

* [Install homebrew](http://brew.sh)
* [Install oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) (zsh comes with macOS Catalina)

Then:

```bash
git clone git@github.com:olorton/dotfiles.git ~/Code/dotfiles
cd ~/Code/dotfiles
brew bundle
bin/dotfiles-symlink
cat ~/.python-version | pyenv install -
```

TODO:
* pyenv file
* pipsi

When running Vim for the first time, install plugins using [vim-plug instructions](https://github.com/junegunn/vim-plug#installation).

### OSX defaults

TODO - fix the damn `bin/set-osx-defaults` file.

Currently using:

    defaults write NSGlobalDomain KeyRepeat -int 1
    defaults write NSGlobalDomain InitialKeyRepeat -int 25

Terminal typefaces I've used:
- Current: [DOSEGA](https://sourceforge.net/projects/dosega/)
- [M+1m console font](http://sourceforge.jp/projects/mplus-fonts/downloads/62344/mplus-TESTFLIGHT-059.tar.xz/)
