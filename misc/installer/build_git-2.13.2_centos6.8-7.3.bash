#!/usr/bin/env bash
set -eu

VERSION="git-2.13.2"

sudo yum -y install curl-devel expat-devel openssl-devel zlib-devel perl-ExtUtils-MakeMaker
sudo yum -y remove git
curl -O "https://www.kernel.org/pub/software/scm/git/${VERSION}.tar.xz"
tar xvf "${VERSION}.tar.xz"
cd "${VERSION}"

sudo make -j 3 prefix=/usr/local all
sudo make prefix=/usr/local install
