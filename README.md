# My dotfiles

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

Terminal typefaces I've used in the past, and leave here because I might come back to them:
- Current: [DOSEGA](https://sourceforge.net/projects/dosega/)
- [M+1m console font](http://sourceforge.jp/projects/mplus-fonts/downloads/62344/mplus-TESTFLIGHT-059.tar.xz/)

## macOS fixes

### Speed up key repeat

    defaults write NSGlobalDomain KeyRepeat -int 1           # normal minimum is 2 (30 ms)
    defaults write NSGlobalDomain InitialKeyRepeat -int 10   # normal minimum is 15 (225 ms)

### Fix font rendering on 1080p screens

    defaults -currentHost write -g AppleFontSmoothing -int 0

## TODOs

- Replace oh-my-zsh with something more vanilla, I barely use these features.
- Add pre-commit hook to check I'm commiting as the right user, e.g.

    ```
    #!/bin/sh
    if [ "$(git config user.name)" = "username" ]; then
        echo "Direct commits from this account are not allowed."
        exit 1
    fi
    ```
