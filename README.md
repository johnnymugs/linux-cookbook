linux-cookbook
==============

This repo automates getting a fresh install of linux up and ready for development the way I like it. I keep it here so I never have to remember what it was I did to get my machine in it's current state. Following the steps below should always get me/you from a fresh install to a dev machine set up to my liking.

### Steps:

- Begin with a fresh install of Debian/whatever.
- You are a sudoer.
- Install git: `sudo aptitude install build-essential git`
- Clone this repo: `git clone git@github.com:johnnymugs/linux-cookbook.git`
- Let this script run its magic: `cd linux-cookbook && bootstrap.sh`
