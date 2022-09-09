#!/bin/zsh

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
    jq
    asdf
    keith/formulae/reminders-cli
)

casks=(
    charles
    docker
    google-chrome
    iterm2
    visual-studio-code
)

# Install Homebrew
if ! type brew > /dev/null; then
    echo "Install Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
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
