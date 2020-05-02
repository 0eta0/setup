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

# Update git
brew install git

# Install Python using pyenv
echo '#### Install Python using pyenv ####'
echo '' >> ~/.zprofile
echo '# PYENV' >> ~/.zprofile
echo 'export PYENV_ROOT=/usr/local/var/pyenv' >> ~/.zprofile
echo 'if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi' >> ~/.zprofile
echo '' >> ~/.zprofile
source ~/.zprofile

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
echo '' >> ~/.zprofile
echo '# NODEBREW' >> ~/.zprofile
echo 'export NODEBREW_ROOT=/usr/local/var/nodebrew' >> ~/.zprofile
echo 'export PATH=$NODEBREW_ROOT/current/bin:$PATH' >> ~/.zprofile
echo '' >> ~/.zprofile
source ~/.zprofile

curl -L git.io/nodebrew | perl - setup
nodebrew install stable

# Install go
echo '#### Install go ####'
echo '' >> ~/.zprofile
echo '# GO' >> ~/.zprofile
echo 'export GOPATH=$HOME/.go' >> ~/.zprofile
echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> ~/.zprofile
echo '' >> ~/.zprofile
source ~/.zprofile

brew install go
