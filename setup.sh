#!/bin/bash

sudo apt update && sudo apt upgrade

echo " "
echo "---------- Setting up hardware ----------"
echo " "

sudo apt install linux-headers-generic network-manager wireless-tools x11-xserver-utils blueman xbacklight compiz dconf-cli uuid-runtime

echo " "
echo "---------- Transferring configs -----------"
echo " "

ln -fs $HOME/.dotfiles/.bashrc $HOME/.bashrc
ln -fs $HOME/.dotfiles/.tmux-keybinds $HOME/.tmux-keybinds
ln -fs $HOME/.dotfiles/.tmux-reset $HOME/.tmux-reset
ln -fs $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf
ln -fs $HOME/.dotfiles/.vimrc $HOME/.vimrc

echo " "
echo "---------- Installing i3-Gaps ----------"
echo " "
sudo add-apt-repository ppa:jonathonf/i3
sudo apt update
sudo apt install i3-gaps
ln -fs $HOME/.dotfiles/i3/config $HOME/.config/i3/config

echo " "
echo "---------- Installing Vim 8.1 ----------"
echo " "
sudo apt install libncurses5-dev git python-dev gcc

git clone https://github.com/vim/vim.git $HOME/src/vim
cd $HOME/src/vim
git checkout v8.1.1775
make clean
cd src
make dist clean
cd ..
./configure --disable-gui --with-features=normal --enable-pythoninterp=yes --enable-terminal --enable-cscope --enable-perlinterp=yes --enable-xim --enable-fontset --with-python-config-dir=/usr/local/lib/python2.7/config --prefix=/usr/local

make VIMRUNTIMEDIR=/usr/local/share/vim/vim81
sudo make install
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim

echo " "
echo "---------- Installing Ripgrep ----------"
echo " "
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
sudo dpkg -i ripgrep_11.0.2_amd64.deb

echo " "
echo "---------- Installing Tilix ----------"
echo " "

sudo add-apt-repository ppa:webupd8team/terminix
sudu apt update
dconf load /com/gexperts/Tilix/ < $HOME/.dotfiles/terminix.dconf
dconf reset -f /com/gexperts/Terminix/
ln -fs $HOME/.dotfiles/tilix $HOME/.config/tilix

echo " "
echo "---------- Installing other good to have packages -----------"

sudo apt install chromium fonts-font-awesome firefox ncdu tree htop feh rxvt-unicode-256color tilix

ln -fs $HOME/.dotfiles/.mozilla	$HOME/.mozilla
mkdir $HOME/Pictures
cp $HOME/config/dracula.png $HOME/Pictures/

echo " "
echo "---------- Installing Python 2.7 ----------"
echo " "

sudo apt install python-pip
pip install --user psutil netifaces

echo " "
echo "---------- Installing Python 3 ----------"
sudo apt install python3-pip python3 python3-dev
pip install --user virtualenv
