#!/bin/bash
# heavily cribbed from http://www.opinionatedprogrammer.com/2011/06/chef-solo-tutorial-managing-a-single-server-with-chef/
# this should be run on the machine you are imaging

chef_binary=/usr/local/bin/chef-solo

# clear sudo credentials
sudo -K

# Are we on a vanilla system?
if ! test -f "$chef_binary"; then
  echo "Installing Ruby and Chef. You will likely be prompted for a sudo password."
  export DEBIAN_FRONTEND=noninteractive
  # Upgrade headlessly (this is only safe-ish on vanilla systems)
  sudo aptitude update &&
  sudo apt-get -o Dpkg::Options::="--force-confnew" \
    --force-yes -fuy dist-upgrade &&
  # Install Ruby and Chef
  sudo aptitude install -y ruby1.9.1 ruby1.9.1-dev make
  sudo gem install --no-rdoc --no-ri chef
fi &&

"$chef_binary" -c solo.rb -j solo.json
