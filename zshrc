### 基本設定
autoload -U colors; colors # カラー表示を有効
export LANG=en_US.UTF-8
ulimit -u unlimited # 1ユーザあたりのプロセス数上限


### key bind(Emacs)
bindkey -e


### prompt
case ${UID} in
# root
0)
    PROMPT="%B[%F{cyan}%/%f@%F{green}%M%f]
%F{red}%n%f #%b "
    ;;
# 一般ユーザ
*)
    PROMPT="%B[%F{cyan}%/%f@%F{green}%M%f]
%F{green}%n%f $%b "
    ;;
esac

RPROMPT="%*"


# gitがある環境の場合
if type git > /dev/null 2>&1; then
    # 右プロンプト
    precmd(){
        RPROMPT='$(__git_ps1 "[%s]")%*'
    }
    source ~/.zsh_completions.d/git-completion/git-prompt.sh
    setopt prompt_subst # プロンプト内で変数を展開
    GIT_PS1_SHOWDIRTYSTATE=1 # 未stageの変更があれば「*」 stage済の変更があれば「+」
    GIT_PS1_SHOWSTASHSTATE=1 # stashが存在すれば「$」
    GIT_PS1_SHOWUNTRACKEDFILES=1 # untrackなファイルがあれば「%」
    GIT_PS1_SHOWUPSTREAM="verbose" # コミットの差分状態を表示(下記)
    #         | upstream | local | eq |
    # auto    |    <     |   >   | =  |
    # verbose |   u-N    |  u+N  | =  |
    #GIT_PS1_DESCRIBE_STYLE="default"
    GIT_PS1_SHOWCOLORHINTS=0 # DIRTYSTATEが有効な時，カラー表示

    # git系コマンドの補完, 最近のzshは同梱らしい
    #zstyle ':completion:*:*:git:*' script ~/.zsh_completions.d/git-completion/git-completion.bash
    #zstyle ':completion:*:*:git:*' script ~/.zsh_completions.d/git-completion/git-completion.zsh
    #fpath=(~/.zsh_completions.d/git-completion $fpath)
fi

# zsh-completionsによる補完強化
fpath=(~/.zsh_completions.d/zsh-completions/src $fpath)


### 補完関連
autoload -Uz compinit; compinit # 補完有効
#autoload -Uz predict-on; predict-on # 先行補完を有効
setopt correct # スペルミスの訂正を行う
setopt list_packed # compact viewを有効
setopt no_beep # beepを鳴らさない
setopt nolistbeep # beepを鳴らさない


### history
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
setopt share_history # historyを異なるzsh間で共有
# historyから除外するコマンドの指定(ls,cd,rm,man系)
zshaddhistory(){
    local line=${1%%$'\n'}
    local cmd=${line%% *}
    [[ ${cmd} != (l|l[sal]) && ${cmd} != (c|cd) && ${cmd} != (r[mr]) && ${cmd} != (m|man) ]]
}


### lsのエイリアス（linuxとBSD系でオプションが違う）
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


### cd / auto pushd関連
#setopt auto_cd # ディレクトリ名で勝手にcd
setopt auto_pushd # 自動でpushd(cd -[tab])
DIRSTACKSIZE=100
setopt pushd_ignore_dups # 同一ディレクトリは古い方を削除する
setopt pushd_to_home # 引数を省略した場合は$HOMEへ移動
# cdのあとにlsを自動で実行
function cd(){
    builtin cd $@
    ls
}


### その他設定
setopt notify # background jobの状態報告を即座に行う
setopt rm_star_wait # 特定の対象へのrm実行前に10秒待ち，その後確認する


### 環境依存設定の読み込み
# Mac用
if [ -f ~/.zshrc_mac ]; then
    source ~/.zshrc_mac
fi

# FreeBSD用
if [ -f ~/.zshrc_bsd ]; then
    source ~/.zshrc_bsd
fi

# ローカル設定
if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi

#################################################
# プロンプト表示フォーマットのメモ
# http://zsh.sourceforge.net/Doc/Release/zsh_12.html#SEC40
#################################################
# %% %を表示
# %) )を表示
# %l 端末名省略形
# %M ホスト名(FQDN)
# %m ホスト名(サブドメイン)
# %n ユーザー名
# %y 端末名
# %# rootなら#、他は%を表示
# %? 直前に実行したコマンドの結果コード
# %d ワーキングディレクトリ %/ でも可
# %~ ホームディレクトリからのパス
# %h ヒストリ番号 %! でも可
# %a The observed action, i.e. "logged on" or "logged off".
# %S (%s) 反転モードの開始/終了 %S abc %s とするとabcが反転
# %U (%u) 下線モードの開始/終了 %U abc %u とするとabcに下線
# %B (%b) 強調モードの開始/終了 %B abc %b とするとabcを強調
# %t 時刻表示(12時間単位、午前/午後つき) %@ でも可
# %T 時刻表示(24時間表示)
# %* 時刻表示(24時間表示秒付き)
# %w 日表示(dd) 日本語だと 曜日 日
# %W 年月日表示(mm/dd/yy)
# %D 年月日表示(yy-mm-dd)
# %F 文字の色(%fで終了) *1
# %K 文字背景の色(%kで終了) *1
#
# *1:色は基本だけなら、0:black、1:red、2:green、3:yellow、4:blue、5:magenta、6:cyan、7:whiteが利用できる。数字は色の番号。

