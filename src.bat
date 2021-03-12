@echo off
title コマンド プロンプト
echo.
echo Disabled CommandPrompt ver 1.0.1
echo.
set homedir=C:\Users\%username%\

:Main_Cmd
set Main=
set /p Main="%cd%>"
  if "%Main%"=="ls" dir & echo. & goto main_cmd

::自作コマンドの入力チェック
set sethome=sethome
set home=home 
echo %Main% | findstr %sethome% > nul
  if %ERRORLEVEL% equ 0 goto 1

echo %Main% | findstr %home% > nul
  if %ERRORLEVEL% equ 0 goto home

::コマンド実行
:commandcheck
%Main%
echo.
goto main_cmd

:1
for /f "usebackq delims=" %%a in (`echo %Main:~0,8%`) do set homedirc=%%a
  if "%homedirc%"=="sethome " goto 2
for /f "usebackq delims=" %%a in (`echo %Main:~6%`) do set homedirc2=%%a
  if "%homedirc2%"=="e" goto sethome_help
  if not "%homedirc%"=="sethome " goto commandcheck
:2
for /f "usebackq delims=" %%a in (`echo %Main:~8%`) do set homedir=%%a
  if "%homedir%"=="ECHO は <ON> です。" goto invalidpass
for /f "usebackq delims=" %%a in (`echo %homedir:~1,2%`) do set homedirchk=%%a
  if not "%homedirchk%"==":\" goto invalidpass
set curd=%cd%
cd %homedir% >nul 2>&1
  if %errorlevel% equ 1 goto invalidpass
cd %curd%
echo homeを %homedir% に設定しました。
echo.
goto main_cmd

:sethome_help
echo [usage]: sethome (path)
echo.
echo [description]
echo homeにパスを設定します。
echo homeと打つことで、sethomeで指定されたパスにcdします。
echo 起動時のデフォルトは、C:\Users\%username%\です。
echo 再起動した場合はデフォルトに戻ります。
echo.
goto Main_Cmd

:invalidpass
echo 無効なパスです。 & echo.
goto Main_Cmd

:home
for /f "usebackq delims=" %%a in (`echo %Main:~0,4%`) do set home=%%a
  if not "%home%"=="home" goto commandcheck
for /f "usebackq delims=" %%a in (`echo %Main:~4%`) do set home2=%%a
  if not "%home2%"=="ECHO は <ON> です。" goto commandcheck
  if not "%home%"=="home" goto commandcheck
cd %homedir% & echo. 
goto main_cmd



