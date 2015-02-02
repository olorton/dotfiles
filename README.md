# Dotfiles Readme

This is more than just a standard dotfiles repo. Using ansible I can install a whole bunch of apps and set up a development environment.

This is my dotfiles setup. There are many like it, but this one is mine. Do fork it and make it your own, but you want to make sure that you *do* read the source to ensure that my settings do not screw up your system. This is intended to be run on a fresh installation of Mac OSX Yosemite, it will probably not work on upgraded systems from Mavericks.

Make sure that you have the latest os updates before starting.

## Setup

- Open the terminal and clone the dotfiles repo `git clone https://github.com:olorton/dotfiles.git ~/.dotfiles` then switch to that directory `cd ~`
- [Install homebrew](http://brew.sh). Follow the instructions to install XCode Command line tools, or just install XCode before hand. Make sure that you run `brew doctor` before you start, it should say `Your system is ready to brew.` if everything is ok.
- Run the inital setup script `bin/initialsetup`
- Run the ansible script `bin/dotfiles provision`

You'll need to reboot after this. Some things won't work properly until them. E.g. dnsmasq

## Configure Apps

I'd like for all of this to be scripted. It's on my todo list. For now do the following:

### Sublime text

Install [Package Control](https://packagecontrol.io/installation). Then install the following packages:

- GitGutter
- ApacheConf
- Behat
- INI
- PHP-Twig
- SideBarEnhancements
- Theme Spacegray

You'll also want the [M+1m console font](http://sourceforge.jp/projects/mplus-fonts/downloads/62344/mplus-TESTFLIGHT-059.tar.xz/)
