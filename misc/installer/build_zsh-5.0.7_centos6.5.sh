# build zsh 5.0.7 centos6.5

cd
curl -L http://sourceforge.net/projects/zsh/files/zsh/5.0.7/zsh-5.0.7.tar.bz2/download -o zsh-5.0.7.tar.bz2
tar xvf zsh-5.0.7.tar.bz2
cd zsh-5.0.7
./configure
make -j 3
sudo make install
