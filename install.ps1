$ErrorActionPreference = 'Stop'
& "$PSScriptRoot/build.ps1"
$destination = Join-Path $env:LOCALAPPDATA 'SleepMonitors'
New-Item -ItemType Directory -Path $destination -Force | Out-Null
Copy-Item -LiteralPath "$PSScriptRoot/dist/SleepMonitors.exe" -Destination $destination -Force
Copy-Item -LiteralPath "$PSScriptRoot/sleep-monitors.ps1" -Destination $destination -Force
$shell = New-Object -ComObject WScript.Shell
foreach ($folder in @([Environment]::GetFolderPath('Desktop'), [Environment]::GetFolderPath('Programs'))) {
    $shortcut = $shell.CreateShortcut((Join-Path $folder 'Sleep Monitors.lnk'))
    $shortcut.TargetPath = "$env:WINDIR\System32\WindowsPowerShell\v1.0\powershell.exe"
    $shortcut.Arguments = '-NoProfile -WindowStyle Hidden -File "' + (Join-Path $destination 'sleep-monitors.ps1') + '"'
    $shortcut.WorkingDirectory = $destination
    $shortcut.Description = 'Turn off all monitors after two seconds. Keep the PC running.'
    $shortcut.IconLocation = "$env:WINDIR/System32/display.dll,0"
    if ($folder -eq [Environment]::GetFolderPath('Desktop')) { $shortcut.Hotkey = 'CTRL+ALT+F12' }
    $shortcut.Save()
}
Write-Output 'Installed. Open Sleep Monitors from Start or the desktop, or press Ctrl+Alt+F12.'
