param([switch]$Check)
$ErrorActionPreference = 'Stop'
Add-Type @'
using System;
using System.Runtime.InteropServices;
public static class DisplayPower {
    [DllImport("user32.dll", SetLastError=true)]
    public static extern bool SendNotifyMessage(IntPtr h, uint m, UIntPtr w,
        IntPtr l);
}
'@
if ($Check) { exit 0 }
Start-Sleep -Seconds 2

$sent = [DisplayPower]::SendNotifyMessage([IntPtr]0xffff, 0x0112, [UIntPtr]0xf170, [IntPtr]2)
if (!$sent) { exit 1 }

