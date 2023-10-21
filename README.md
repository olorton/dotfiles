# My dotfiles

## Setup

* [Install homebrew](http://brew.sh)
* [Install oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) (zsh comes with macOS Catalina)

Then:

```bash
git clone git@github.com:olorton/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
brew bundle
bin/dotfiles-symlink
git clone https://github.com/dracula/alacritty.git ~/dev/dracula_alacritty
cat ~/.python-version | pyenv install -
```

TODO:
* pyenv file
* pipsi

When running Vim for the first time, install plugins using [vim-plug instructions](https://github.com/junegunn/vim-plug#installation). Because of how I have configured vim you will also need to create the following dirs: `mkdir -p ~/.vim/tmp/{undo,backup}`

Terminal typefaces I've used:
- Current: [DOSEGA](https://sourceforge.net/projects/dosega/)
- [M+1m console font](http://sourceforge.jp/projects/mplus-fonts/downloads/62344/mplus-TESTFLIGHT-059.tar.xz/)

### Colour theme: Dracula

Already configured for vim and alacritty.

For Slack: `#282A36,#44475A,#44475A,#8BE9FD,#6272A4,#FFFFFF,#50FA7B,#FF5555`

### Speed up key repeat

    defaults write NSGlobalDomain KeyRepeat -int 1           # normal minimum is 2 (30 ms)
    defaults write NSGlobalDomain InitialKeyRepeat -int 10   # normal minimum is 15 (225 ms)

### Fix font rendering on 1080p screens

    defaults -currentHost delete -globalDomain AppleFontSmoothing
    defaults write -g CGFontRenderingFontSmoothingDisabled -bool YES

Source: [nvucuong.medium.com/macos-blurry-texts-on-an-external-full-hd-monitor-d2a955c25607](https://nvucuong.medium.com/macos-blurry-texts-on-an-external-full-hd-monitor-d2a955c25607)

## Tips

Sync dotfiles to vagrant box:

```bash
rsync -av --delete -e "vagrant ssh --" $DOTFILES :~/
```
