# Install zprezto
mv zprezto ~/.zprezto
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# Install xcode
echo '#### Install xcode ####'
xcode-select --install

# Install homebrew
/usr/bin/ruby -e $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)
brew update

# Install Python using pyenv
echo '#### Install Python using pyenv ####'
echo '' >> ~/.zshenv
echo '# PYENV' >> ~/.zshenv
echo 'export PYENV_ROOT=/usr/local/var/pyenv' >> ~/.zshenv
echo 'if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi' >> ~/.zshenv
echo '' >> ~/.zshenv
source ~/.zshenv

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
echo '#### Install nodejs and npm using nodebrew ####'
echo '' >> ~/.zshenv
echo '# NODEBREW' >> ~/.zshenv
echo 'export NODEBREW_ROOT=/usr/local/var/nodebrew' >> ~/.zshenv
echo 'export PATH=$NODEBREW_ROOT/current/bin:$PATH' >> ~/.zshenv
echo '' >> ~/.zshenv
source ~/.zshenv

curl -L git.io/nodebrew | perl - setup
nodebrew install stable

# Install go
echo '#### Install go ####'
echo '' >> ~/.zshenv
echo '# GO' >> ~/.zshenv
echo 'export GOPATH=$HOME/.go' >> ~/.zshenv
echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> ~/.zshenv
echo '' >> ~/.zshenv
source ~/.zshenv

brew install go
