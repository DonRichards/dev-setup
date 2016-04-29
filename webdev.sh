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

# Remove outdated versions from the cellar.
brew cleanup

npm install -g coffee-script
npm install -g grunt-cli
npm install -g jshint
npm install -g less
npm install -g yo
npm install -g node-gyp
npm install -g nodemon

gem install -n /usr/local/bin sass scss_lint hologram susy bundler jekyll

# Mongodb
sudo mkdir /data/db
sudo chmown -R $USER /data/db
brew install mongodb
brew tap homebrew/services
brew services start mongodb 

# House Keeping
rbenv rehash
npm update -g npm
gem update --system
update