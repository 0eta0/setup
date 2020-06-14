# Install zprezto
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/setup/zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# Install xcode
xcode-select --install

# Install homebrew
/usr/bin/ruby -e $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)
brew update

# Update git
brew install git tig

# update git config
ln -s ./.gitconfig ~/.gitconfig

# Install peco
brew install peco

# Install pyenv and latest Python
brew install pyenv

array=($(pyenv install --list | grep -E "^  2."))
num=${#array[@]}-1
while ( echo ${array[$num]} | grep dev )
do
  num=$(($num-1))
done
CFLAGS="-I$(xcrun --show-sdk-path)/usr/include" pyenv install -v ${array[$num]}

array=($(pyenv install --list | grep -E "^  3."))
num=${#array[@]}-1
while ( echo ${array[$num]} | grep dev )
do
  num=$(($num-1))
done
pyenv install -v ${array[$num]}
pyenv global ${array[$num]}

# Install nodejs and npm using nodebrew
curl -L git.io/nodebrew | perl - setup
nodebrew install stable

# Install go
brew install go

# Install imagemagick
brew install imagemagick

source ~/.zprofile
source ~/.zshrc