# compile vim with ruby support

# packages for vim w/ ruby
package 'libncurses-dev'
package 'libgnome2-dev'
package 'libgtk2.0-dev'
package 'libatk1.0-dev'
package 'libbonoboui2-dev'
package 'libcairo2-dev'
package 'libx11-dev'
package 'libxpm-dev'
package 'libxt-dev'

# compile vim from source
unless `ruby --version | grep +ruby` == ""
  `wget ftp://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2`
  `tar -xjvf vim-7.3.tar.bz2`
  `cd vim73 && ./configure --prefix=/usr/local \
      --enable-gui=no \
      --without-x \
      --disable-nls \
      --with-tlib=ncurses \
      --enable-multibyte \
      --enable-rubyinterp \
      --with-features=huge \
      --enable-gui=gnome2 && \
  make && sudo make install`
end
