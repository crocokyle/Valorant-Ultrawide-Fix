 
del ValorantLauncher_log.log
set LOGFILE=ValorantLauncher_log.log
call :LOG > %LOGFILE%
exit /B
:LOG
echo Patching Valorant screen resolution...
copy C:\Users\me\AppData\Local\VALORANT\Saved\Config\bd20b341-ef13-542a-bcf7-dc3523cc43c9\Windows\GameUserSettingsSrc.ini C:\Users\me\AppData\Local\VALORANT\Saved\Config\bd20b341-ef13-542a-bcf7-dc3523cc43c9\Windows\GameUserSettings.ini
echo Killing your Windows taskbar until game has closed...
echo Launching Valorant in Ultrawide
"C:\Riot Games\Riot Client\RiotClientServices.exe" --launch-product=valorant --launch-patchline=live
