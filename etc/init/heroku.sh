#!/bin/bash

heroku_toolbelt_url="https://cli-assets.heroku.com/heroku-linux-x64.tar.gz"
heroku_root=${HOME}/.heroku

echo "Initialize heroku toolbelt."
if [[ ! -d "$heroku_root" ]]; then
  {
    mkdir $heroku_root
    cd $heroku_root

    curl -s $heroku_toolbelt_url | tar xz

    mv heroku/* .
    rmdir heroku
  }
fi
