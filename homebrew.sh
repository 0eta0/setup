#!/bin/bash

brews=(
    git
    peco
    htop
    imagemagick
    gpg
    nkf
    tig
    wget
    ffmpeg
    cargo
    ghq
    coreutils
    curl
    asdf
)

casks=(
    charles
    docker
    google-chrome
    google-japanese-ime
    iterm2
    visual-studio-code
)

# Install Homebrew
if ! command -v brew > /dev/null 2>&1 ; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# brew install
for app in "${brews[@]}"
do
    brew install "$app"
done

# brew cask
for app in "${casks[@]}"
do
    brew install --cask "$app"
done