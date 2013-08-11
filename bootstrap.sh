#!/bin/bash
# heavily cribbed from http://www.opinionatedprogrammer.com/2011/06/chef-solo-tutorial-managing-a-single-server-with-chef/

# this should be run on the machine you are imaging
chef_binary=/var/lib/gems/1.9.1/bin/chef-solo

# Are we on a vanilla system?
if ! test -f "$chef_binary"; then
  export DEBIAN_FRONTEND=noninteractive
  # Upgrade headlessly (this is only safe-ish on vanilla systems)
  aptitude update &&
  apt-get -o Dpkg::Options::="--force-confnew" \
    --force-yes -fuy dist-upgrade &&
  # Install Ruby and Chef
  aptitude install -y ruby1.9.1 ruby1.9.1-dev make &&
  sudo gem1.9.1 install --no-rdoc --no-ri chef --version 0.10.0
fi &&

"$chef_binary" -c solo.rb -j solo.json
