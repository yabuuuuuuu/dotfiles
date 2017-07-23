# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# prompt
PS1="[\[\e[1;32m\]\u@\H\[\e[00m\]:\[\e[1;32m\]\w\[\e[00m\]]$ "


# alias
## lsのエイリアス（linuxとBSD系でオプションが違う）
case "${OSTYPE}" in
darwin*|freebsd*)
  alias ls="ls -G"
  ;;
linux*)
  alias ls="ls --color=auto"
  ;;
esac
alias ll="ls -lh"
alias la="ls -lah"

