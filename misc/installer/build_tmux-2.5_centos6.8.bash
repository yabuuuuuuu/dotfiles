#!/usr/bin/env bash
set -eu

sudo yum -y install gcc kernel-devel make ncurses-devel

curl -OL "https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz"
tar xvf "libevent-2.0.22-stable.tar.gz"
cd "libevent-2.0.22-stable"
./configure --prefix=/usr/local
make
sudo make install

curl -OL "https://github.com/tmux/tmux/releases/download/2.5/tmux-2.5.tar.gz"
tar xvf "tmux-2.5.tar.gz"
cd "tmux-2.5"
LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
make -j 3
sudo make install
