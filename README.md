dotfiles
========

INSTALL for Windows
--------

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

