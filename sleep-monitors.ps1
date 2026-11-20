param([switch]$Check)
$ErrorActionPreference = 'Stop'
Add-Type @'
using System;
using System.Runtime.InteropServices;
public static class DisplayPower {
    [DllImport("user32.dll")]
    public static extern IntPtr GetDesktopWindow();
    [DllImport("user32.dll", SetLastError=true)]
    public static extern IntPtr SendMessage(IntPtr h, uint m, IntPtr w,
        IntPtr l);
}
'@
if ($Check) { exit 0 }
Start-Sleep -Seconds 2

# SC_MONITORPOWER returns a message result, not a Boolean success flag.
[DisplayPower]::SendMessage([DisplayPower]::GetDesktopWindow(), 0x0112, [IntPtr]0xf170, [IntPtr]2) | Out-Null

