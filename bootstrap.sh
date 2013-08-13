#!/bin/bash

# clear sudo credentials
sudo -K

# install boatload of packages we know we need
sudo aptitude install -y ruby1.9.1 ruby1.9.1-dev make libncurses-dev libgnome2-dev \
  libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev \
  libxt-dev

if vim --version | grep -q '+ruby'
  echo Sweet, vim already installed and compiled with Ruby support.
else
  echo Compiling vim with Ruby support...
  wget ftp://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2
  tar -xjvf vim-7.3.tar.bz2
  cd vim73 && ./configure --prefix=/usr/local \
      --enable-gui=no \
      --without-x \
      --disable-nls \
      --with-tlib=ncurses \
      --enable-multibyte \
      --enable-rubyinterp \
      --with-features=huge \
      --enable-gui=gnome2 && \
  make && sudo make install
fi

# set up vim config
git clone git@github.com:johnnymugs/vim-config.git ~/.vim
cd ~/.vim
git submodule update --init
ln -s ~/.vim/vimrc ~/.vimrc

# compile command-t plugin for vim
cd ~/.vim/bundle/command-t
bundle
rake make
