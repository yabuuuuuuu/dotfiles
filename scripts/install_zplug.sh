#!/bin/sh

# https://github.com/zdharma/zplugin#installation
if !(type docker >/dev/null 2>&1); then
  echo 'install: zplug'
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
fi
