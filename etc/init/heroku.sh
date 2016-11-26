#!/bin/bash

heroku_toolbelt_url="https://s3.amazonaws.com/assets.heroku.com/heroku-client/heroku-client.tgz"
heroku_root=${HOME}/.heroku

echo "Initialize heroku toolbelt."
if [[ ! -d "$heroku_root" ]]; then
  {
    mkdir $heroku_root
    cd $heroku_root

    curl -s $heroku_toolbelt_url | tar xz

    mv heroku-client/* .
    rmdir heroku-client
  }
fi
