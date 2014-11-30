# Dotfiles Readme

For Yosemite, TODO - list what this does!

Make sure that you have the latest os updates before starting.

This is intended to be run on a fresh installation of Mac OSX Yosemite, it will probably not work on upgraded systems from Mavericks.

## Setup

- Open the terminal and clone the dotfiles repo `git clone https://github.com:olorton/dotfiles.git ~/.dotfiles` then switch to that directory `cd ~`
- [Install homebrew](http://brew.sh). Follow the instructions to install XCode Command line tools, or just install XCode before hand. Make sure that you run `brew doctor` before you start, it should say `Your system is ready to brew.` if everything is ok.
- Run the inital setup script `bin/initialsetup`

You can either run selected provisioner tasks, or the whole lot, take your pick.

	bin/provision basic-apps
	bin/provision dev-tools
	bin/provision php-dev
	bin/provision games
	bin/provision home

Or install everything

	bin/provision all





















---------------------------------------------------------------------
Run the script
    
    cd ~/.dotfiles
    script/bootstrap

###Install homebrew

- [Install from here](http://brew.sh).

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