#!/usr/bin/env zsh

DOT_PATH="${DOT_PATH:-${HOME}/dotfiles}"
ZPLUG_HOME="${ZPLUG_HOME:-${HOME}/.zplug}"

if [ ! -d "${ZPLUG_HOME}" ]; then
  cp -r "${DOT_PATH}/zplug" "${ZPLUG_HOME}"
  source "${HOME}/.zshrc"
fi

# 未インストール項目をインストールする
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug clean
zplug clear
# zplug status
zplug load
