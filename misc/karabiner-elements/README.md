
### 導入方法(現在の環境のメモ)
##### やったこと
* Karabiner Elements
  - Simple Modifications
    - F19 -> `vk_none`
  - Complex Modifications
    - 左Command -> EISUU (if_alone)
    - 右Command -> F19 (if_alone)
  - 
* System Prefarence
  - F19 -> 「前の入力ソースを選択」

※ Karabinerにあった`VK_JIS_TOGGLE_EISUU_KANA`が見当たらなかったので「前の入力ソースを選択」を代わりに使う

※ 「前の入力ソースを選択」をF19(何かしらの使わ無さそうなkey)に割り当て，右Commandを単体で押下した場合をF19にする
  

### 作り方のメモ
1. `karabiner-elements`をインストールする
2. karabiner elementsから[complex modifications rules](https://pqrs.org/osx/karabiner/complex_modifications/)をダウンロードして有効化する
3. 「コマンドキーを単体で押したときに、英数・かなキーを送信する。（左コマンドキーは英数、右コマンドキーはかな）」というルール
4. `~/.config/karabiner/karabiner.json`ができるので，必要に応じて編集する
   - デフォルトではトグルになっていないので，上記のように編集した


* 最近のバージョンはjsonを手で変更しなくて良くなったため，jsonを直接編集することにより，その後のGUIでの変更がどう反映されるのかがちょっと怪しい
