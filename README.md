dotfiles
========

Install
-------

webからとってきて直接実行するならこう

    bash $(curl -sL http://dot.momo-lab.net)


上記のことを手動でやるならこう

    cd ~
    git clone git@github.com:momo-lab/dotfiles.git
    cd dotfiles
    ./install.sh init

Windowsの場合は、Git Bash上で実行すること。

Dependencies
------------
#### Linux
apt-get とかで入れればよろし

- git
- vim
- zsh

#### Windows
- git for Windows <https://git-for-windows.github.io/>
- Kaoriya版gvim <http://www.kaoriya.net/software/vim/> (Optional)

