@echo off
title �R�}���h �v�����v�g
echo.
echo Disabled CommandPrompt ver 1.0.1
echo.
set homedir=C:\Users\%username%\

:Main_Cmd
set Main=
set /p Main="%cd%>"
  if "%Main%"=="ls" dir & echo. & goto main_cmd

::����R�}���h�̓��̓`�F�b�N
set sethome=sethome
set home=home 
echo %Main% | findstr %sethome% > nul
  if %ERRORLEVEL% equ 0 goto 1

echo %Main% | findstr %home% > nul
  if %ERRORLEVEL% equ 0 goto home

::�R�}���h���s
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
  if "%homedir%"=="ECHO �� <ON> �ł��B" goto invalidpass
for /f "usebackq delims=" %%a in (`echo %homedir:~1,2%`) do set homedirchk=%%a
  if not "%homedirchk%"==":\" goto invalidpass
set curd=%cd%
cd %homedir% >nul 2>&1
  if %errorlevel% equ 1 goto invalidpass
cd %curd%
echo home�� %homedir% �ɐݒ肵�܂����B
echo.
goto main_cmd

:sethome_help
echo [usage]: sethome (path)
echo.
echo [description]
echo home�Ƀp�X��ݒ肵�܂��B
echo home�Ƒł��ƂŁAsethome�Ŏw�肳�ꂽ�p�X��cd���܂��B
echo �N�����̃f�t�H���g�́AC:\Users\%username%\�ł��B
echo �ċN�������ꍇ�̓f�t�H���g�ɖ߂�܂��B
echo.
goto Main_Cmd

:invalidpass
echo �����ȃp�X�ł��B & echo.
goto Main_Cmd

:home
for /f "usebackq delims=" %%a in (`echo %Main:~0,4%`) do set home=%%a
  if not "%home%"=="home" goto commandcheck
for /f "usebackq delims=" %%a in (`echo %Main:~4%`) do set home2=%%a
  if not "%home2%"=="ECHO �� <ON> �ł��B" goto commandcheck
  if not "%home%"=="home" goto commandcheck
cd %homedir% & echo. 
goto main_cmd



