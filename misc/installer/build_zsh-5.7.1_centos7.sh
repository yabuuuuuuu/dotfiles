#!/bin/sh

set -x
sudo yum groupinstall -y "Development Tools"
sudo yum install -y ncurses-devel
curl -OL "https://jaist.dl.sourceforge.net/project/zsh/zsh/5.7.1/zsh-5.7.1.tar.xz"
tar xvf "zsh-5.7.1.tar.xz"
cd "zsh-5.7.1"

./configure --enable-multibyte --enable-unicode9
make
sudo make install
