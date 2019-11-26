#!/bin/bash

echo " "
echo "---------- Setting up wifi ----------"
echo " "

sudo apt install linux-headers-generic network-manager wireless-tools x11-xserver-utils blueman xbacklight compiz dconf-cli uuid-runtime

echo " "
echo "---------- Transferring configs -----------"
echo " "

if [ ! -d $HOME/.bak ]; then
    echo "Creating $HOME/.bak"
    mkdir $HOME/.bak
fi

if [ -f $HOME/.bashrc ]; then
    mv $HOME/.bashrc $HOME/.bak/.bashrc.bak
fi

if [ -f $HOME/.tmux.conf ]; then
    mv $HOME/.tmux.conf $HOME/.bak/.tmux.conf.bak
fi

if [ -f $HOME/.tmux-reset ]; then
    mv $HOME/.tmux-reset $HOME/.bak/.tmux-reset.bak
fi

if [ -f $HOME/.tmux-status ]; then
	mv $HOME/.tmux-status $HOME/.bak/.tmux-status.bak
fi

if [ -d $HOME/.vimrc ]; then
	mv $HOME/.vimrc $HOME/.bak/.vimrc.bak
fi

if [ -d $HOME/.Xresources ]; then
	mv $HOME/.Xresources $HOME/.bak/.Xresources.bak
fi

echo " "
echo "---------- Installing i3-Gaps ----------"
echo " "
sudo add-apt-repository ppa:jonathonf/i3
sudo apt update
sudo apt install i3-gaps

cp -r $HOME/config/bumblebee-status $HOME/.config/
cp -r $HOME/config/i3/ $HOME/.config/
rsync -vz --exclude '.git' $HOME/config/\.* $HOME

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
echo "---------- Installing other good to have packages -----------"

sudo apt install fonts-font-awesome firefox ncdu tree htop feh rxvt-unicode-256color

mkdir $HOME/Pictures
cp $HOME/config/dracula.png $HOME/Pictures/

echo " "
echo "---------- Installing Python 2.7 ----------"
echo " "

sudo apt install python-pip
pip install --user psutil netifaces
