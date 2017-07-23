#!/usr/bin/env bash
set -eu

VERSION="emacs-25.2"

sudo yum -y install gcc make ncurses-devel
curl -O "http://ftp.jaist.ac.jp/pub/GNU/emacs/${VERSION}.tar.xz"
tar xvf "${VERSION}.tar.xz"
cd "${VERSION}"

# clangの方がコンパイルが早い
#./configure --without-sound --without-x --without-selinux CC='clang' CXX='clang++' CFLAGS='-O3' CPPFLAGS='-O3'
./configure --without-sound --without-x --without-selinux CFLAGS='-O3' CPPFLAGS='-O3'
make -j 3
sudo make install
