@ECHO OFF
SETLOCAL
CD %HOME%

CALL :MAKE_LINK vimfiles vimfiles /D
CALL :MAKE_LINK _vimrc _vimrc
CALL :MAKE_LINK _gvimrc _gvimrc
CALL :MAKE_LINK .gitconfig .gitconfig

PAUSE
GOTO :EOF

:MAKE_LINK
  IF EXIST %HOME%\%2\con RMDIR /Q %HOME%\%2
  IF EXIST %HOME%\%2 DEL /Q %HOME%\%2
  IF ERRORLEVEL 1 GOTO :EOF
  MKLINK %3 %HOME%\%2 %~dp0\%1
GOTO :EOF
