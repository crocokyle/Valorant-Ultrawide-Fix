$ScriptDir = Split-Path $script:MyInvocation.MyCommand.Path

# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  #Exit
 }
}

$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"
Start-Transcript -path $env:HOMEPATH\Documents\ValorantUltrawideHack\SysSetup_log.log -append



$SearchDir = $env:LOCALAPPDATA + '\VALORANT\Saved\Config'
$TokenizedResults = gci -Recurse -Filter "GameUserSettings.ini" -File -Path $SearchDir -Force
$SrcPath = $ScriptDir + '\GameUserSettingsSrc.ini'
$TargetPath = $TokenizedResults.DirectoryName + '\GameUserSettingsSrc.ini'
$ExistingSettings = $TokenizedResults.DirectoryName + '\GameUserSettings.ini'

# Debugging variables
Write-Host "SearchDir: " $SearchDir
Write-Host "TokenizedResults: " $TokenizedResults
Write-Host $TokenizedResults.DirectoryName
Write-Host "ScriptDir: " $ScriptDir
Write-Host "SrcPath: " $SrcPath
Write-Host "TargetPath: " $TargetPath
Write-Host "ExistingSettings: " $ExistingSettings

function WriteLauncher {
    $fName = $ScriptDir + '\ValorantLauncher.bat'
    New-Item $fName
    ' '  | Out-File $fName -Append -encoding "oem"
    'del ValorantLauncher_log.log' | Out-File $fName -Append -encoding "oem"
    'set LOGFILE=ValorantLauncher_log.log' | Out-File $fName -Append -encoding "oem"
    'call :LOG > %LOGFILE%' | Out-File $fName -Append -encoding "oem"
    'exit /B' | Out-File $fName -Append -encoding "oem"
    ':LOG' | Out-File $fName -Append -encoding "oem"
    'echo Patching Valorant screen resolution...' | Out-File $fName -Append -encoding "oem"
    'copy ' + $TargetPath + ' ' + $TokenizedResults.DirectoryName + '\GameUserSettings.ini' | Out-File $fName -Append -encoding "oem"
    'echo Killing your Windows taskbar until game has closed...' | Out-File $fName -Append -encoding "oem"
    'echo Launching Valorant in Ultrawide' | Out-File $fName -Append -encoding "oem"
    '"C:\Riot Games\Riot Client\RiotClientServices.exe" --launch-product=valorant --launch-patchline=live' | Out-File $fName -Append -encoding "oem"
}

function GetGraphicsInfo5 {
    $existing_data = Get-Content $ExistingSettings
    $firstFive = $existing_data | Select-Object -First 5    
    return $firstFive
}

function GetGraphicsInfo15 {
    $existing_data = Get-Content $ExistingSettings
    $last = $existing_data | Select-Object -Last 15    
    return $last
}

function WriteGameSettings {
    $existingSettingsfile = Get-Content $ExistingSettings
    Write-Host "Getting your native monitor resolution..."
    $ScreenResolution = Get-WmiObject -Class Win32_DesktopMonitor | Select-Object ScreenWidth,ScreenHeight
    Write-Host "Creating your Valorant graphics profile..."
    $SrcIniName = $ScriptDir + '\GameUserSettingsSrc.ini'
    New-Item $SrcIniName
    GetGraphicsInfo5 | Out-File $SrcIniName -Append -encoding "UTF8"
    'bShouldLetterbox=False' | Out-File $SrcIniName -Append -encoding "UTF8"
    'bLastConfirmedShouldLetterbox=False' | Out-File $SrcIniName -Append -encoding "UTF8"
    'bUseVSync=False' | Out-File $SrcIniName -Append -encoding "UTF8"
    'bUseDynamicResolution=False' | Out-File $SrcIniName -Append -encoding "UTF8"
    'ResolutionSizeX=' + $ScreenResolution.ScreenWidth | Out-File $SrcIniName -Append -encoding "UTF8"
    'ResolutionSizeY=' + $ScreenResolution.ScreenHeight | Out-File $SrcIniName -Append -encoding "UTF8"
    'LastUserConfirmedResolutionSizeX=' + $ScreenResolution.ScreenWidth | Out-File $SrcIniName -Append -encoding "UTF8"
    'LastUserConfirmedResolutionSizeY=' + $ScreenResolution.ScreenHeight | Out-File $SrcIniName -Append -encoding "UTF8"
    'WindowPosX=0' | Out-File $SrcIniName -Append -encoding "UTF8"
    'WindowPosY=0' | Out-File $SrcIniName -Append -encoding "UTF8"
    'LastConfirmedFullscreenMode=2' | Out-File $SrcIniName -Append -encoding "UTF8"
    'PreferredFullscreenMode=2' | Out-File $SrcIniName -Append -encoding "UTF8"
    'AudioQualityLevel=0' | Out-File $SrcIniName -Append -encoding "UTF8"
    'LastConfirmedAudioQualityLevel=0' | Out-File $SrcIniName -Append -encoding "UTF8"
    $existingSettingsfile | Select-Object -Index 19 | Out-File $SrcIniName -Append -encoding "UTF8"
    'DesiredScreenWidth=' + $ScreenResolution.ScreenWidth | Out-File $SrcIniName -Append -encoding "UTF8"
    'DesiredScreenHeight=' + $ScreenResolution.ScreenHeight | Out-File $SrcIniName -Append -encoding "UTF8"
    'LastUserConfirmedDesiredScreenWidth=' + $ScreenResolution.ScreenWidth | Out-File $SrcIniName -Append -encoding "UTF8"
    'LastUserConfirmedDesiredScreenHeight=' + $ScreenResolution.ScreenHeight | Out-File $SrcIniName -Append -encoding "UTF8"
    $existingSettingsfile | Select-Object -Index 24 | Out-File $SrcIniName -Append -encoding "UTF8"
    $existingSettingsfile | Select-Object -Index 25 | Out-File $SrcIniName -Append -encoding "UTF8"
    $existingSettingsfile | Select-Object -Index 26 | Out-File $SrcIniName -Append -encoding "UTF8"
    $existingSettingsfile | Select-Object -Index 27 | Out-File $SrcIniName -Append -encoding "UTF8"
    $existingSettingsfile | Select-Object -Index 28 | Out-File $SrcIniName -Append -encoding "UTF8"
    $existingSettingsfile | Select-Object -Index 29 | Out-File $SrcIniName -Append -encoding "UTF8"
    $existingSettingsfile | Select-Object -Index 30 | Out-File $SrcIniName -Append -encoding "UTF8"
    'FullscreenMode=2' | Out-File $SrcIniName -Append -encoding "UTF8"
    '' | Out-File $SrcIniName -Append -encoding "UTF8"
    '[/Script/Engine.GameUserSettings]' | Out-File $SrcIniName -Append -encoding "UTF8"
    'bUseDesiredScreenHeight=True' | Out-File $SrcIniName -Append -encoding "UTF8"
    GetGraphicsInfo15 | Out-File $SrcIniName -Append -encoding "UTF8"
}

$host.ui.RawUI.WindowTitle = "Kyle's Valorant Ultrawide Patch Installer"
Write-Host ""
Write-Host "Kyle's Valorant Ultrawide Patch Installer"
Write-Host " "
Write-Host "Elevating permissions..."
Write-Host "Getting system information..."

WriteGameSettings
Write-Host ""
Write-Host "Copying patch files to game directory..."
Write-Host ""
copy $SrcPath $TargetPath
Write-Host "Creating your custom Valorant launch script..."
WriteLauncher

Stop-Transcript
