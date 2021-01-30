del %HOMEPATH%\Documents\ValorantUltrawideHack\install_log.log

echo Creating install directory
mkdir "%HOMEPATH%\Documents\ValorantUltrawideHack"

@echo off
set LOGFILE=%HOMEPATH%\Documents\ValorantUltrawideHack\install_log.log
call :LOG > %LOGFILE%
exit /B

:LOG
mode con: cols=220 lines=50
color 09
title Kyle's Valorant Ultrawide Patch Installer
echo Kyle's Valorant Ultrawide Patch Installer
echo .
echo .
copy launcher.ico "%HOMEPATH%\Documents\ValorantUltrawideHack\launcher.ico"
echo Launching the big guns! - Getting your system information, graphics settings, and creating your custom Valorant profile...
Powershell.exe -executionpolicy Unrestricted -File SysSetup.ps1

echo Moving patch files to install directory...
copy ValorantLauncher.bat "%HOMEPATH%\Documents\ValorantUltrawideHack\ValorantLauncher.bat"
copy GameUserSettingsSrc.ini "%HOMEPATH%\Documents\ValorantUltrawideHack\GameUserSettingsSrc.ini"
echo Creating desktop shortcut...
copy "Valorant Ultrawide Launcher.lnk" "%HOMEPATH%\Desktop\Valorant Ultrawide Launcher.lnk"
echo Cleaning up install files...
del GameUserSettingsSrc.ini
del ValorantLauncher.bat
del "Valorant Ultrawide Launcher.lnk"
del SysSetup.ps1
del launcher.ico
echo .
echo ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
echo Complete! Please check the log for errors above.
echo .
echo Please be patient. The splash screen will appear stretched because the game was not written for ultrawide. The game itself and all menus will be in true ultrawide, NOT stretched. 
echo .
echo To launch Valorant in Ultrawide resolution, please click the "Valorant Ultrawide Launcher" shortcut on your Desktop. 
echo ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
del install.bat