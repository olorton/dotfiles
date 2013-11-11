# Dotfiles Readme

My dotfiles. Very much a WIP.

Reminder to self: check on issues.

## Setup

Install XCode first.

Clone the repo

    git clone git@github.com:olorton/dotfiles.git ~/.dotfiles

Run the script
    
    cd ~/.dotfiles
    script/bootstrap

###Install homebrew

    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

Now install my preferred list of homebrew apps.

    homebrew/install

###Remap Caps Lock to Launchpad

The above ```homebrew/install``` script also installed:

- PCKeyboardHack
- KeyboardRemap4MacBook

With these we can remap caps lock to a key combo to be used for Launchpad.

Open PCKeyboardHack and change the Caps Lock key to 110 (the strange application key on PC keyboards that no one uses).

Run this script to remap key 110 (now Caps Lock) to opt-space.

	osx/keyremap-defaults.sh

Unfortunately, KeyboardRemap4MacBook overrides the osx key repeat settings, so I have tweaked these numbers to my tastes.

Now set up that key-combo to open launchpad. Open system prefs > keyboard > shortcut > launchpad & dock > and change the shortcut.

###OSX Settings
    
    osx/set-defaults

## Configure Apps

Ideally all of this should be handled by the scripts above. For now I document here as a reminder of stuff to change.

### Sublime Text

Install package manager for ST3: https://sublime.wbond.net/installation

Packages to install:

- GitGutter
- PHP-Twig
- PHPcs

#### Set up PHP Code Sniffer

Install the dependencies:

    brew install php-code-sniffer php-md php-cs-fixer

Install the package ```phpcs``` in Sublime Text.

Open the phpcs settings file in ST: Sublime Text > Preferences > Package Settings > PHP Code Sniffer > Settings - User 

Add the following settings:

    {
        "phpcs_executable_path": "/usr/local/bin/phpcs",
        "php_cs_fixer_executable_path": "/usr/local/bin/php-cs-fixer",
        "phpmd_executable_path": "/usr/local/bin/phpmd",
        "phpcs_additional_args": {
            "--standard": "PSR2",
            "": "",
            "-n": ""
        },
    }

You can check your specific paths using these commands:

    $ which phpcs
    $ which phpmd
    $ which php-cs-fixer


[More details here](http://www.soulbroken.co.uk/code/sublimephpcs/)

## Local PHP dev environment using homebrew

I have not scripted a full configuration of a local php dev environment. Please refer to these docs for a detailed walkthrough: [docs](https://github.com/olorton/dotfiles/tree/master/docs)
