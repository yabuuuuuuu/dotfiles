#!/bin/sh
set -eu

DIR="$(cd "$(dirname "${BASH_SOURCE:-${(%):-%N}}")"; pwd)"
source "${DIR}/helper"

# bash
safe_delete ".bash_profile"
safe_delete ".bashrc"

# zsh
safe_delete ".zshrc"
safe_delete ".zshrc_docker"
safe_delete ".zshrc_mac"
safe_delete ".zshrc_linux"
safe_delete ".zshrc_bsd"
safe_delete ".zshrc_local"
safe_delete ".zsh_completions.d"

# tmux
safe_delete ".tmux.conf"
safe_delete ".tmux_mac.conf"

# emacs
safe_delete ".emacs.d"

# git
safe_delete ".gitconfig_common"
safe_delete ".gitconfig"
safe_delete ".git-authors"
safe_delete ".git_templates"

# ssh
safe_delete ".ssh/config"
