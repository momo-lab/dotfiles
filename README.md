dotfiles
========

Install
-------

webからとってきて直接実行するならこう

```sh
eval "$(curl -sL http://dot.momo-lab.net)"
```

上記のことを手動でやるならこう

```sh
dotfiles_path=~/ghq/github.com/momo-lab/dotfiles
mkdir -p $dotfiles_path
git clone https://github.com/momo-lab/dotfiles.git $dotfiles_path
cd $dotfiles_path
./install.sh init
```

Windowsの場合は、Git Bash上で実行すること。

Dependencies
------------
#### Linux
apt-get とかで入れればよろし

- git
- vim
- zsh
- unzip (for ghr-get)

Bash on Ubuntu on Windows の場合は以下も入れておくこと

- make

#### Windows
- git for Windows <https://git-for-windows.github.io/>
- Kaoriya版gvim <http://www.kaoriya.net/software/vim/> (Optional)

How to use
----------

## tmux
prefixは「Ctrl + t」。
とりあえず、「Ctrl+t」→「?」としておけば、できることがわかる。
