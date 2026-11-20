# Sleep Monitors

Turn off all Windows monitors with one click. The PC stays running. Move the mouse or press a key to wake the displays.

The app waits two seconds so the launching click or keypress can finish. It has no background process and needs no administrator access. It does not lock the computer or change power settings; normal sleep timers still apply.

## Install

On Windows 10 or 11, run from this folder:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1
```

This builds an optional executable with the Windows .NET Framework compiler, installs the files under `%LOCALAPPDATA%\SleepMonitors`, and adds desktop and Start menu shortcuts that run the PowerShell script without a console window.

- Click **Sleep Monitors**, or press **Ctrl+Alt+F12**.
- To pin it: search **Sleep Monitors** in Start, right-click it, and select **Pin to taskbar** (under **More** on some Windows versions).

## Build

Run `build.ps1`. Output: `dist\SleepMonitors.exe`. The `--check` argument exits without switching off the displays.

The executable is unsigned and may be blocked by Windows Application Control. The shortcuts use `sleep-monitors.ps1`; run it with `-Check` to validate loading without turning off the displays. Neither installer nor app changes security policies.

The app sends Windows `WM_SYSCOMMAND / SC_MONITORPOWER` with the display-off value `2`. Some drivers, applications or input devices may wake the displays again.

## Remove

Unpin the app, delete its desktop and Start menu shortcuts, then delete `%LOCALAPPDATA%\SleepMonitors`.
