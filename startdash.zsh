#! /bin/zsh

export ZPREZTODIR=$HOME/setup/prezto
export ZDOTDIR=$HOME/setup/prezto

# install prezto
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/runcoms/^README.md(.N); do
  ln -s ${ZDOTDIR:-$HOME}/runcoms/${rcfile:t} ${HOME}/.${rcfile:t} 
done

# alias
ln -s $PWD/gitconfig ${HOME}/.gitconfig
ln -s $PWD/gitignore ${HOME}/.gitignore

git config --global core.excludesfile ~/.gitignore

# homebrew
sh ./homebrew.sh

# reload
source ~/.zshrc

# install asdf

## nodejs
zsh -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs 20.11.0
asdf global nodejs 20.11.0

## python
asdf plugin-add python
asdf install python 3.12.1
asdf install python 2.7.18
asdf global python 3.12.1 2.7.18

## go
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf install golang 1.21.6
asdf global golang 1.21.6

## ruby
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf install ruby 3.3.0
asdf global ruby 3.3.0

## rust
asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
asdf install rust 1.75.0 -y
asdf global rust 1.75.0

## flutter stable
asdf plugin add flutter
asdf install flutter 3.29.0-stable
asdf global flutter 3.29.0-stable
## terraform stable
asdf plugin add terraform
asdf install terraform 1.5.6
asdf global terraform 1.5.6

## Source
source ${HOME}/.zprofile
source ${HOME}/.zshrc
