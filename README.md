linux-cookbook
==============

This repo automates getting a fresh install of linux up and ready for
development the way I like it. I keep it here so I never have to remember what
it was I did to get my machine in it's current state. Following the steps below
should always get me/you from a fresh install to a dev machine set up to my
liking.

### Steps:
- Begin with a fresh install of Debian/whatever.
- Make yourself sudoer if you're not already.
- Install git: `sudo aptitude install build-essential git`
- Clone this repo: `git clone http://github.com/johnnymugs/linux-cookbook.git`
- Let this script run its magic: `./linux-cookbook/bootstrap.sh`

### Wishlist
- Be smarter/more tolerant of failure (don't install stuff that's already
installed -- should be able to run the script twice without issue)
- Run without prompting the user after first sudo
- Bind leader-f to cmd-t in vim

### TODO
- Add deb-multimedia sources
