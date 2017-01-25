#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Corrects Possible File System Permissions Errors
sudo chown -R `whoami` /usr/local

# Make sure we’re using the latest Homebrew.
brew update
brew install node
# brew cask install haskell-platform

# Remove outdated versions from the cellar.
brew cleanup

# npm install -g coffee-script
npm install -g grunt-cli
npm install -g jshint
npm install -g less
# npm install -g yo
npm install -g node-gyp
npm install -g nodemon

gem install -n /usr/local/bin sass scss_lint hologram susy bundler jekyll

# Mongodb
sudo mkdir /data/db
sudo chmown -R $USER /data/db
brew install mongodb
brew tap homebrew/services
brew services start mongodb

# Daily stuff
curl -L https://raw.githubusercontent.com/kciter/daily/master/installer.sh | sudo sh
if [ -d "/usr/local/daily" ]
then
    echo "Directory /usr/local/daily exists."
    cp daily /usr/local/daily/command.txt
else
    echo "Making empty directory for Daily..."
    mkdir /usr/local/daily
    cp daily /usr/local/daily/command.txt
fi

# Jenkins Setup
brew install jenkins
brew cask install java
ln -sfv /usr/local/opt/jenkins/*.plist ~/Library/LaunchAgents
sudo defaults write /Library/Preferences/org.jenkins-ci httpPort 7070
sudo launchctl unload /Library/LaunchDaemons/org.jenkins-ci.plist
sudo launchctl load /Library/LaunchDaemons/org.jenkins-ci.plist

# House Keeping
rbenv rehash
npm update -g npm
gem update --system
update
