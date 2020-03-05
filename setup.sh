#!/bin/bash

set -e

download_dir=$HOME/Documents
script_loc="${0%/*}"

sudo apt update && sudo apt upgrade

echo " "
echo "---------- Setting up necessary packages ----------"
echo " "

sudo apt install linux-headers-generic network-manager wireless-tools x11-xserver-utils blueman xbacklight compiz dconf-cli uuid-runtime curl

echo " "
echo "---------- Transferring configs -----------"
echo " "

ln -fs $script_loc/.bashrc $HOME/.bashrc
ln -fs $script_loc/.tmux-keybinds $HOME/.tmux-keybinds
ln -fs $script_loc/.tmux-reset $HOME/.tmux-reset
ln -fs $script_loc/.tmux.conf $HOME/.tmux.conf
ln -fs $script_loc/.vimrc $HOME/.vimrc

echo "hiMakedir"
if [ ! -d $download_dir ]; then
    echo "Makedir"
    mkdir -p $download_dir
cd $download_dir
trap 'Symlinking failed'

echo " "
echo "---------- Installing i3-Gaps ----------"
echo " "

sudo apt install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf xutils-dev libtool automake libxcb-shape0-dev
git clone https://github.com/Airblader/xcb-util-xrm
cd xcb-util-xrm
git submodule update --init
./autogen.sh --prefix=/usr
make
sudo make install
cd $download_dir
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
git checkout gaps && git pull
autoreconf --force --install
rm -rf build
mkdir build
cd build
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install
mkdir $HOME/.config/i3
ln -fs $script_loc/i3/config $HOME/.config/i3/config
trap 'Installing i3 failed' EXIT

echo " "
echo "---------- Installing Vim 8.1 ----------"
echo " "
cd $download_dir
sudo apt install libncurses5-dev git python-dev gcc

git clone https://github.com/vim/vim.git $download_dir/vim
cd vim
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
trap 'Installing Vim 8.1 failed' EXIT

echo " "
echo "---------- Installing Tmux 3.0 ----------"
echo " "
sudo apt install libevent-dev
cd $download_dir
git clone https://github.com/tmux/tmux.git
cd tmux && git checkout 2.9
sh autogen.sh
./configure && make
trap 'Installing Tmux3.0 failed' EXIT

echo " "
echo "---------- Installing Ripgrep ----------"
echo " "
cd $download_dir
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
sudo dpkg -i ripgrep_11.0.2_amd64.deb
trap 'Installing Ripgrep failed' EXIT

echo " "
echo "---------- Installing Tilix ----------"
echo " "

sudo add-apt-repository ppa:webupd8team/terminix
sudo apt update
sudo apt install tilix
dconf load /com/gexperts/Tilix/ < $HOME/.dotfiles/.terminix.dconf
dconf reset -f /com/gexperts/Terminix/
ln -fs $HOME/.dotfiles/tilix $HOME/.config/tilix
trap 'Installing Tilix failed' EXIT

echo " "
echo "---------- Installing other good to have packages -----------"

sudo apt install chromium-browser fonts-font-awesome firefox ncdu tree htop feh rxvt-unicode-256color evince tmux texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra

cd $download_dir
wget https://github.com/jgm/pandoc/releases/download/2.8.0.1/pandoc-2.8.0.1-1-amd64.deb
sudo dpkg -i pandoc-2.8.0.1-1-amd64.deb


mkdir $HOME/Pictures
cp $HOME/.dotfiles/dracula.png $HOME/Pictures/

echo " "
echo "---------- Installing Python 2.7 ----------"
echo " "

sudo apt install python-pip
pip install --user psutil netifaces

echo " "
echo "---------- Installing Python 3 ----------"
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update
sudo apt install python3-pip python3 python3-dev python3.7
pip3 install --user virtualenv
