# zmodload zsh/zprof
DOT_PATH="${HOME}/dotfiles"
ZPLUG_HOME="${HOME}/.zplug"
LANG=en_US.UTF-8
ulimit -u unlimited

bindkey -e # emacs bind
setopt correct # スペルミスの訂正を行う
setopt list_packed # compact viewを有効
setopt no_beep # beepを鳴らさない
setopt nolistbeep # beepを鳴らさない
setopt notify # background jobの状態報告を即座に行う
setopt rm_star_wait # 特定の対象へのrm実行前に10秒待ち，その後確認する


##### history
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
setopt bang_hist # cshスタイルの履歴展開を有効（!cなど）
setopt hist_ignore_dups # 直前のイベントと全く同じものは記憶しない
setopt hist_ignore_all_dups # 既存のものと全く同じ場合，古い方を削除する
setopt hist_ignore_space # 先頭がスペースのコマンドは記憶しない
setopt hist_no_functions # 関数定義は記憶しない
setopt hist_no_store # historyコマンドは記憶しない
setopt hist_reduce_blanks # 余分なスペースを取り除く
setopt inc_append_history # 履歴をインクリメンタルに追加
setopt share_history # historyを異なるzsh間で共有


##### load
autoload -Uz compinit
source "${ZPLUG_HOME}/init.zsh"

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zdharma/fast-syntax-highlighting"
zplug "momo-lab/zsh-abbrev-alias"
zplug "zdharma/history-search-multi-word"
zplug "mollifier/cd-gitroot"
zplug "djui/alias-tips"
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
zplug "motemen/ghq", as:command, from:gh-r
zplug "stedolan/jq", from:gh-r, as:command, rename-to:jq
zplug "b4b4r07/emoji-cli", on:"stedolan/jq"
# zplug "mrowa44/emojify", as:command
zplug "b4b4r07/enhancd", use:init.sh

source "${DOT_PATH}"/scripts/vercomp.zsh
vercomp "${ZSH_VERSION}" "5.2.0"
if [[ $? -le 1 ]]; then # 5.2.0+
  zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, as:theme
else
  echo "spaceship-prompt is not loaded: ZSH_VERSION ${ZSH_VERSION} < 5.2.0"
fi

# 未インストール項目をインストールする
#if ! zplug check --verbose; then
#    printf "Install? [y/N]: "
#    if read -q; then
#        echo; zplug install
#    fi
#fi

zplug load

### zsh-abbrev-alias
abbrev-alias -g L="less +F"
# git push origin B<push space key>
abbrev-alias -g -e B='$(git symbolic-ref --short HEAD 2> /dev/null)'

### emoji-cli
bindkey '^xe' emoji::cli
bindkey '^x^e' emoji::cli

### enhancd
ENHANCD_HOOK_AFTER_CD=ls

### prompt
# 軽量化のため
# https://github.com/denysdovhan/spaceship-prompt/blob/master/spaceship.zsh#L41
SPACESHIP_PROMPT_ORDER=(
  time          # Time stampts section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
#   hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  node          # Node.js section
  ruby          # Ruby section
#   elixir        # Elixir section
#   xcode         # Xcode section
#   swift         # Swift section
  golang        # Go section
  php           # PHP section
#   rust          # Rust section
#   haskell       # Haskell Stack section
#   julia         # Julia section
  docker        # Docker section
  aws           # Amazon Web Services section
  venv          # virtualenv section
#   conda         # conda virtualenv section
  pyenv         # Pyenv section
#   dotnet        # .NET section
#   ember         # Ember.js section
  kubectl       # Kubectl context section
#   terraform     # Terraform workspace section
  exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status
#   vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_TIME_SHOW=true
# SPACESHIP_USER_SHOW=always
# SPACESHIP_HOST_SHOW=always
SPACESHIP_HOST_SHOW_FULL=true
SPACESHIP_DIR_TRUNC=5
SPACESHIP_DIR_LOCK_SYMBOL=🔐
SPACESHIP_GIT_BRANCH_PREFIX=🐙
SPACESHIP_BATTERY_THRESHOLD=75
SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_BATTERY_SYMBOL_CHARGING=⬆


##### functions
# historyから除外するコマンドの指定(ls,cd,rm,man系)
zshaddhistory() {
    local line=${1%%$'\n'}
    local cmd=${line%% *}
    [[ ${cmd} != (l|l[sal]) && ${cmd} != (c|cd) && ${cmd} != (r[mr]) && ${cmd} != (m|man) ]]
}

# cdの後にls
function lcd() {
   builtin cd $@
   ls
}

# ghq + fzf
function fgh() {
  local dir
  dir=$(ghq list > /dev/null | fzf-tmux --height 40% --reverse +m) &&
    cd $(ghq root)/$dir
}

# fbr - checkout git branch (including remote branches)
function fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux --height 40% -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}


##### aliases
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

if type docker >/dev/null 2>&1; then
  # 停止しているコンテナの削除
  alias drm='docker rm $(docker ps -a -q)'

  # REPOSITORYが<none>なイメージの削除
  #alias drmi="docker rmi $(docker images | awk '/^<none>/ { print $3 }')"
  alias drmi="docker images | awk '/^<none>/ { print $3 }' | xargs docker rmi"

  # Select a docker container to start and attach to
  function fda() {
    local cid
    cid=$(docker ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')

    [ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
  }

  # Select a running docker container to stop
  function ds() {
    local cid
    cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

    [ -n "$cid" ] && docker stop "$cid"
  }
fi


##### include
function zc(){
  if [ ! -e "~/${1}.zwc" ] || [ "${DOT_DOT_PATH}/${1}" -nt "~/${1}.zwc" ]; then
#     zcompile "~/${1}"
  fi
}
# Mac用
if [ -f ~/.zshrc_mac ]; then
  zc ".zshrc_mac"
  source ~/.zshrc_mac
fi

# FreeBSD用
if [ -f ~/.zshrc_bsd ]; then
  zc ".zshrc_bsd"
  source ~/.zshrc_bsd
fi

# ローカル設定
if [ -f ~/.zshrc_local ]; then
  zc ".zshrc_local"
  source ~/.zshrc_local
fi

zc ".zshrc"

if type zprof >/dev/null 2>&1; then
  zprof
fi
