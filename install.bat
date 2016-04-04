@ECHO OFF
SETLOCAL

CALL :DEPLOY
CALL :INITIALIZE
PAUSE
GOTO :EOF

:DEPLOY
  echo Deploy dotfiles.
  IF "%HOME%" == "" SET HOME=%HOMEDRIVE%%HOMEPATH%
  CD /D %HOME%

  FOR /F "usebackq" %%I IN (`dir /b %~dp0`) DO CALL :MAKE_LINK %%I
GOTO :EOF

:INITIALIZE
  echo Initialize vim plugins.
  
GOTO :EOF

:MAKE_LINK
  SET FILENAME=%~nx1
  REM %HOME%にリンクを張る必要がないファイルを除外
  IF NOT "%FILENAME:~0,1%" == "." GOTO :EOF
  IF "%FILENAME:~-1%" == "~" GOTO :EOF
  IF "%FILENAME%" == ".git" GOTO :EOF

  SET SRCPATH=%~dp0%FILENAME%
  IF "%FILENAME%" == ".vimrc" SET FILENAME="_vimrc"
  SET LINKPATH=%HOME%\%FILENAME%

  REM すでにあるリンクを削除
  IF EXIST %LINKPATH%\ RMDIR /Q %LINKPATH%
  IF EXIST %LINKPATH% DEL /Q %LINKPATH%
  IF ERRORLEVEL 1 GOTO :EOF

  REM リンク作成
  SET MKLINK_OPT=
  IF EXIST %SRCPATH%\ SET MKLINK_OPT=/D
  MKLINK %MKLINK_OPT% %LINKPATH% %SRCPATH%
GOTO :EOF

