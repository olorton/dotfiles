# Dotfiles Readme

My dotfiles. Very much a WIP.

Reminder to self: check on issues.

## Setup

Clone the repo

    xcode-select --install
    git clone git@github.com:olorton/dotfiles.git ~/.dotfiles

Run the script
    
    cd ~/.dotfiles
    script/bootstrap

###Install homebrew

    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

Now install my preferred list of homebrew apps.

    homebrew/install


###OSX Settings
    
    osx/set-defaults

## Configure Apps

Ideally all of this should be handled by the scripts above. For now I document here as a reminder of stuff to change.

### Sublime Text

Install package manager for ST3: https://sublime.wbond.net/installation

Packages to install:

- GitGutter
- PHP-Twig

Other stuff to look at:

- [PHPCS](http://www.soulbroken.co.uk/code/sublimephpcs/)
