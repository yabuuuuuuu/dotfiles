#!/usr/bin/env bash
set -eu

sudo yum -y install gcc libevent-devel ncurses-devel
curl -OL "https://github.com/tmux/tmux/releases/download/2.5/tmux-2.5.tar.gz"
tar xvf "tmux-2.5.tar.gz"
cd "tmux-2.5"

./configure
make -j 3
sudo make install
