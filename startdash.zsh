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

# install asdf
## nodejs
zsh -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs 15.4.0
asdf global nodejs 15.4.0
## python
asdf plugin-add python
asdf install python 3.9.1
asdf install python 2.7.18
asdf global python 3.9.1 2.7.18
## go
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf install golang 1.15.6
asdf global golang 1.15.6
## ruby
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf install ruby 2.7.2
asdf global ruby 2.7.2
## rust
asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
asdf install rust 1.48.0 -y
asdf global rust 1.48.0
## flutter stable
asdf install stable
asdf global flutter 2.8.1-stable

## Source
source ~/.zprofile
source ~/.zshrc
