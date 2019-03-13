# Initial env
echo '#### Initial env ####'
echo 'export CLICOLOR=1' > ~/.bash_profile
echo "export LSCOLORS=DxGxcxdxCxegedabagacad" >> ~/.bash_profile
echo 'if [ -f ~/.bashrc ]; then source ~/.bashrc; fi' >> ~/.bash_profile
echo "export PS1='\[\033[32m\]\u@\h:\[\033[0m\]\[\033[34m\]\w\[\033[33m\]$(__git_ps1)\[\033[00m\]\[\033[31m\] $ \[\033[0m\]'" >> ~/.bash_profile
echo '' >> ~/.bash_profile

# Install xcode
echo '#### Install xcode ####'
xcode-select --install

# Install homebrew
/usr/bin/ruby -e $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)
brew update

# Install Python using pyenv
echo '#### Install Python using pyenv ####'
sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /

echo 'export PYENV_ROOT=/usr/local/var/pyenv' >> ~/.bash_profile
echo 'if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi' >> ~/.bash_profile
echo '' >> ~/.bash_profile

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
echo 'export NODEBREW_ROOT=/usr/local/var/nodebrew' >> ~/.bash_profile
echo 'export PATH=$NODEBREW_ROOT/current/bin:$PATH' >> ~/.bash_profile
echo '' >> ~/.bash_profile
source ~/.bash_profile

curl -L git.io/nodebrew | perl - setup
nodebrew install stable

# Install go
echo '#### Install go ####'
echo 'export GOPATH=$HOME/.go' >> ~/.bash_profile
echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> ~/.bash_profile
echo '' >> ~/.bash_profile
source ~/.bash_profile

brew install go

# Install gcc
echo '#### Install gcc ####'
brew install wget
cd /usr/local/opt/
mkdir -p gcc
cd gcc
wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/7-2018q2/gcc-arm-none-eabi-7-2018-q2-update-mac.tar.bz2
tar -xf gcc-arm-none-eabi-7-2018-q2-update-mac.tar.bz2
rm gcc-arm-none-eabi-7-2018-q2-update-mac.tar.bz2
cd ../../bin/
ln -s ../opt/gcc/gcc-arm-none-eabi-7-2018-q2-update

# Create .bashrc
echo '#### Create .bashrc ####'
touch ~/.bashrc
echo 'source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash' > ~/.bashrc
echo 'source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh' >> ~/.bashrc
echo 'GIT_PS1_SHOWDIRTYSTATE=true' >> ~/.bashrc
echo '' >> ~/.bashrc
echo 'GITCOMPPATH="/Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash"' >> ~/.bashrc
echo 'if [ -f ${GITCOMPPATH} ]; then' >> ~/.bashrc
echo '. ${GITCOMPPATH}' >> ~/.bashrc
echo 'fi' >> ~/.bashrc

# Apply .bash_profile
echo '#### Apply .bash_profile ####'
source ~/.bash_profile
