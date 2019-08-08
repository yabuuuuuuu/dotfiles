#!/bin/sh
set -eu

DIR="$(cd "$(dirname "${BASH_SOURCE:-${(%):-%N}}")"; pwd)"
#source "${DIR}/install_zplug.sh"
source "${DIR}/helper"

# bash
#safe_link "bashrc" ".bashrc"

# zsh
safe_link "zshrc" ".zshrc"

# tmux
safe_link "tmux.conf" ".tmux.conf"

# emacs
safe_link "emacs.d" ".emacs.d"

# git
safe_link "gitconfig_common" ".gitconfig_common"
safe_copy "gitconfig_template" ".gitconfig"
safe_link "git_templates" ".git_templates"
