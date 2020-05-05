root=$HOME/.ghr-get
if [ ! -d $root ]; then
  git clone https://github.com/momo-lab/ghr-get.git $root
fi

ghr-get junegunn/fzf-bin
ghr-get monochromegane/the_platinum_searcher
ghr-get github/hub
ghr-get x-motemen/ghq
ghr-get momo-lab/git-now
ghr-get b4b4r07/ssh-keyreg
ghr-get stedolan/jq
