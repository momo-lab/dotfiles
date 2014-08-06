dotfiles
========

INSTALL for Windows
--------

### 環境変数 HOME を設定

基本は `SET HOME=%HOMEDRIVE%%HOMEPATH%` なので設定しないでよいんだけど、
HOMEの指定があった方がいろいろ楽ちんなことが多いので。
（最近はそうでもないのかな？）

### install.bat を管理者権限で実行

これで、各ファイルにシンボリックリンクが張られます。

### git submoduleの初期化

```
> git submodule init
> git submodule update
```

### .gitconfig_localの作成

以下のような .gitconfig_local を作成する。
もともと、git configで追加していたユーザ毎の設定なんかをここに書くこと。

```
[user]
  email = momotaro.n@gmail.com
  name = momotaro
[github]
  user = momo-lab
```

