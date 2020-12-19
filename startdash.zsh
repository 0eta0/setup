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

# homebrew
sh ./homebrew.sh

# install anyenv
if [ ! -e ~/.anyenv ]; then
    git clone https://github.com/riywo/anyenv ~/.anyenv

    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"

    anyenv install pyenv
    anyenv install rbenv
    anyenv install ndenv
    anyenv install goenv
fi

## Source
source ~/.zprofile
source ~/.zshrc
