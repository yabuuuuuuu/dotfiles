#!/usr/bin/env bash
set -eu

sudo yum -y install python-devel
curl -O "https://bootstrap.pypa.io/get-pip.py"
sudo python get-pip.py
sudo pip install fabric
