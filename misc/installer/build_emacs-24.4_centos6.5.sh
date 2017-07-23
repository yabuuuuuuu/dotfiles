# build emacs24.4 for centos 6.5 amd64

yum -y install gcc make ncurses-devel
curl -O http://public.p-knowledge.co.jp/gnu-mirror/gnu/emacs/emacs-24.4.tar.xz
tar xvf emacs-24.4.tar.xz
cd emacs-24.4
# clangの方がコンパイルが早い
#./configure --without-sound --without-x --without-selinux CC='clang' CXX='clang++' CFLAGS='-O3' CPPFLAGS='-O3'
./configure --without-sound --without-x --without-selinux CFLAGS='-O3' CPPFLAGS='-O3'
make -j 3
sudo make install

