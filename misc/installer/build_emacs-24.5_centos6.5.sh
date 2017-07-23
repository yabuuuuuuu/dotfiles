# build emacs24.5 for centos 6.5 amd64

yum -y install gcc make ncurses-devel

curl -O http://ftp.jaist.ac.jp/pub/GNU/emacs/emacs-24.5.tar.xz
curl -O http://ftp.jaist.ac.jp/pub/GNU/emacs/emacs-24.5.tar.xz.sig

gpg --verify emacs-24.5.tar.xz.sig
if [ $? -ne 0 ]; then
    exit $?;
fi

tar xvf emacs-24.5.tar.xz
cd emacs-24.5
# clangの方がコンパイルが早い
#./configure --without-sound --without-x --without-selinux CC='clang' CXX='clang++' CFLAGS='-O3' CPPFLAGS='-O3'
./configure --without-sound --without-x --without-selinux CFLAGS='-O3' CPPFLAGS='-O3'
make -j 3
sudo make install

