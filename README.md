# dotfiles

## Install

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

WSL2 + Ubuntu前提です。

## 構成

このdotfilesは、以下のツールによって構成管理されています。

- **[mise](https://mise.jdx.dev/) ([.config/mise/config.toml](.config/mise/config.toml)):**
  CLIツールや言語ランタイムのバージョン管理を行います。
  `ghq`, `fzf`, `neovim`, `node` などのツールをインストール・管理します。
  `npm install -g`する場合はmiseのnpm backendを使用すること。
- **[sheldon](https://sheldon.cli.rs/) ([.config/sheldon/plugins.toml](.config/sheldon/plugins.toml)):**
  Zshのプラグイン管理を行います。
  `zsh-completions`, `zsh-syntax-highlighting` などのプラグインを読み込みます。
- **[Neovim Config](./.config/nvim):**
  Neovimの設定はLuaで行われています。
  プラグイン管理には`lazy.nvim`を使用しており、設定は`.config/nvim/lua/plugins`以下に分割されています。

## Dependencies

- git
- zsh
- win32yank.exe(手動導入の場合 chmod +x が必要)

その他、mise install時に必要なライブラリあり(未整理)

## How to use

## tmux

prefixは「Ctrl + t」。
とりあえず、「Ctrl+t」→「?」としておけば、できることがわかる。
