#!/bin/sh
set -eu

DIR="$(cd "$(dirname "${BASH_SOURCE:-${(%):-%N}}")"; pwd)"
#source "${DIR}/install_zplug.sh"
source "${DIR}/helper"

# zsh
safe_link "zshrc" ".zshrc"
safe_link "zshrc_mac" ".zshrc_mac"

# tmux
safe_link "tmux.conf" ".tmux.conf"
safe_link "tmux_mac.conf" ".tmux_mac.conf"

# emacs
safe_link "emacs.d" ".emacs.d"

# git
safe_link "gitconfig_common" ".gitconfig_common"
safe_copy "gitconfig_template" ".gitconfig"
safe_link "git_templates" ".git_templates"
safe_copy "git-authors" ".git-authors"

# ssh
safe_copy "ssh/config_mac_template" ".ssh/config"
