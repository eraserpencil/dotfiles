#!/bin/bash

echo " "

if [ -d $HOME/.bak]; then
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

cp $HOME/setup/.* $HOME

echo " "
echo "---------- Installing i3-Gaps ----------"
echo " "
sudo add-apt-repository ppa:jonathonf/i3
sudo apt update
sudo apt install i3

echo " "
echo "---------- Installing Vim 8.1 ----------"
echo " "
sudo apt install git

git clone https://github.com/vim/vim.git
cd vim
git checkout v8.1.1775
make clean
./configure --disable-gui --with-features=normal --enable-pythoninterp=yes --enable-terminal --enable-cscope --enable-perlinterp=yes --enable-xim --enable-fontset --with-python-config-dir=$HOME/.local/lib/python2.7 --prefix=/usr/local

make VIMRUNTIMEDIR=/usr/local/share/vim/vim81
sudo make install
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim


