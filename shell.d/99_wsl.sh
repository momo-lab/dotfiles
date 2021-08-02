if [ -n "$WSL_DISTRO_NAME" ]; then
  # VcXsrv Windows X Server settings
  export DISPLAY=$(hostname).mshome.net:0.0
fi
