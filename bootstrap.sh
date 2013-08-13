#!/bin/bash

# clear sudo credentials
sudo -K

# store current directory
cwd=$(pwd)

echo Installing necessary packages...
sudo aptitude install -y ruby1.9.1 ruby1.9.1-dev make libncurses-dev libgnome2-dev \
  libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev \
  libxt-dev postgresql postgresql-contrib redis-server imagemagick gvim sl \
  icedtea-7-plugin gnome-do libffi-dev libgdbm-dev libncurses5-dev libreadline-dev \
  libssl-dev libyaml-dev zlib1g-dev ttf-ancient-fonts

if vim --version | grep -q '+ruby'
then
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

echo Cloning vim config...
git clone http://github.com/johnnymugs/vim-config.git ~/.vim
cd ~/.vim
git submodule update --init
ln -s ~/.vim/vimrc ~/.vimrc

echo Compiling Command-T for vim...
sudo gem install bundler
cd ~/.vim/bundle/command-t
bundle
rake make

echo Getting the heroku-cli app...
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

echo Adding rspec config...
cp $cwd/dotfiles/rspec ~/.rspec

echo Adding gitconfig...
cp $cwd/dotfiles/gitconfig ~/.gitconfig

echo Installing Google Chrome...
cd $cwd
wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-*.deb
sudo apt-get install -f

echo Installing Ruby 2.0...
cd $cwd
wget http://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p247.tar.gz
tar -xzvf ruby-2.0.0-p247.tar.gz
cd ruby-2.0.0-p247
./configure --prefix=/opt/rubies/ruby-2.0.0-p247
make
sudo make install

echo Installing chruby...
cd $cwd
wget -O chruby-0.3.6.tar.gz https://github.com/postmodern/chruby/archive/v0.3.6.tar.gz
tar -xzvf chruby-0.3.6.tar.gz
cd chruby-0.3.6/
sudo make install

# final instructions
echo Be sure to add this to your .bash_profile or .bashrc
echo source /usr/local/share/chruby/chruby.sh
echo source /usr/local/share/chruby/auto.sh
echo

# set up postgres... on second thought this could be kinda dangerous, just
# provide instructions
echo Now go change /etc/postgresql/9.1/main/pg_hba.conf
echo Edit the line that reads...
echo local all postgres peer
echo to
echo local all postgres trust
echo ONLY FOR DEV MACHINES, NOT PROD OBVI
echo (and restart postgres afterwards)

echo
echo All done!

# return to where we started
cd $cdw
