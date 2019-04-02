# dotfiles

## ブランチ
* `master` -> [github.com](https://github.com/tyabuki/dotfiles)の `master`

## インストール
環境ごとに適切な`install`を呼ぶ

## 中身
### bash
* 普段使っていないのでどうでもいい

### zsh
* 環境固有の設定は`zshrc.mac`や`.zshec.local`に記述してincludeする

### tmux
* バージョン: `v2.9a`
  - `v1.8+`でたぶん動く
* default shell: zsh
* prefix key: `C-t` (`C-b`はどう考えてもキャレットの左移動なので...)
* 日本語が正しく表示されないときは`-u`オプションを付けてattachする
* 環境依存の設定は`.tmux.conf.local`などに記述してincludeする

### emacs
* バージョン: `26.2`
  - `24+`でたぶん動く
* プラグインは`package.el`による管理に移行した
* `sudo emacs`ではたぶん動かない
