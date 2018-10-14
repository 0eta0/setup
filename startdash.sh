# Install xcode
xcode-select --install
# Install homebrew
/usr/bin/ruby -e $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)
brew update

# Install Python using pyenv
sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /

echo 'export PYENV_ROOT=/usr/local/var/pyenv' >> ~/.bash_profile
echo 'if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi' >> ~/.bash_profile
source ~/.bash_profile

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
echo 'export NODEBREW_ROOT=/usr/local/var/nodebrew' >> ~/.bash_profile
echo 'export PATH=$NODEBREW_ROOT/current/bin:$PATH' >> ~/.bash_profile
source ~/.bash_profile

curl -L git.io/nodebrew | perl - setup
nodebrew install stable

# Install gcc
cd /usr/local/opt/
mkdir gcc
cd gcc
wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/7-2018q2/gcc-arm-none-eabi-7-2018-q2-update-mac.tar.bz2
tar -xf gcc-arm-none-eabi-7-2018-q2-update-mac.tar.bz2
rm gcc-arm-none-eabi-7-2018-q2-update-mac.tar.bz2
cd ../../bin/
ln -s ../opt/gcc/gcc-arm-none-eabi-7-2018-q2-update
