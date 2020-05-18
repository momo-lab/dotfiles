# my tools
export GHR_GET_ROOT=$HOME/.ghr-get
export PATH=$GHR_GET_ROOT/bin:$PATH
type ghr-get > /dev/null 2>&1 && eval "$(ghr-get init -)"
