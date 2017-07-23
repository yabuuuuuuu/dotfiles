# build tmux 1.9a centos6.5

# libeventが古いと怒られてbuild出来ないので，一旦新しいものを入れておく．
cd
curl -L -O https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz
tar xvf libevent-2.0.21-stable.tar.gz
cd libevent-2.0.21-stable
./configure
make -j 3
sudo make install

cd
curl -L -O http://downloads.sourceforge.net/tmux/tmux-1.9a.tar.gz
tar xvf tmux-1.9a.tar.gz
cd tmux-1.9a
export LIBEVENT_CFLAGS="-I/usr/local/include"
export LIBEVENT_LIBS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib -levent"
./configure
make -j 3
sudo make install
