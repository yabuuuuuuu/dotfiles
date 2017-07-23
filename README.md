# dotfiles
## new
* `github.com`との管理方法を見直した
* `git init`からやり直し全てのコミット履歴をリセットした

## ブランチ
* `master` -> [github.com](https://github.com/yabuuuuuuu/dotfiles)の `master`

## インストール
環境ごとに適切な`install`をぶっ叩く．

たぶんMacでもLinuxでも動く．

## 中身
### bash
* 特に使っていないのでどうでもいい

### zsh
* current: `v5.3.1`
* locale: `en_US.UTF-8`
* prompt
* completion
* alias
* 環境固有の設定は`zshrc.mac`や`.zshec.local`に記述してinclude

### tmux
* current: `v2.5`
  - `v1.8+`でたぶん動く
* default shell: zsh
* prefix key: `C-t` (`C-b`はどう考えてもキャレットの左移動なので...)
* 日本語が正しく表示されないときは`-u`オプションを付けてattachする
* 環境依存の設定は`.tmux.conf.local`などに記述してinclude

### emacs
* current: `25.2.1`
  - require: `24+`
* プラグインは`package.el`による管理に移行した
* `sudo emacs`ではたぶん動かない

### misc(miscellaneous)フォルダ
* ゴミ置き場
