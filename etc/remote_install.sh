dotfiles_path=~/ghq/github.com/momo-lab/dotfiles
mkdir -p $dotfiles_path
git clone https://github.com/momo-lab/dotfiles.git $dotfiles_path
cd $dotfiles_path
./install.sh init
