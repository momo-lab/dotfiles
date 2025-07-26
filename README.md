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

構成
-------

このdotfilesは、以下のツールによって構成管理されています。

- **[mise](https://mise.jdx.dev/) ([.config/mise/config.toml](.config/mise/config.toml)):**
  CLIツールや言語ランタイムのバージョン管理を行います。
  `ghq`, `fzf`, `neovim`, `node` などのツールをインストール・管理します。
- **[sheldon](https://sheldon.cli.rs/) ([.config/sheldon/plugins.toml](.config/sheldon/plugins.toml)):**
  Zshのプラグイン管理を行います。
  `zsh-completions`, `zsh-syntax-highlighting` などのプラグインを読み込みます。
- **[Neovim Config](./.config/nvim):**
  Neovimの設定はLuaで行われています。
  プラグイン管理には`lazy.nvim`を使用しており、設定は`.config/nvim/lua/plugins`以下に分割されています。

Dependencies
------------
#### Linux
apt-get とかで入れればよろし

- git
- zsh

#### Windows
- git for Windows <https://git-for-windows.github.io/>
- Kaoriya版gvim <http://www.kaoriya.net/software/vim/> (Optional)

How to use
----------

## tmux
prefixは「Ctrl + t」。
とりあえず、「Ctrl+t」→「?」としておけば、できることがわかる。
