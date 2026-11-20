param([switch]$Check)
$ErrorActionPreference = 'Stop'
Add-Type @"
using System;
using System.Runtime.InteropServices;
public static class DisplayPower {
    [DllImport("user32.dll", SetLastError=true)]
    public static extern IntPtr SendMessageTimeout(IntPtr h, uint m, IntPtr w,
        IntPtr l, uint flags, uint timeout, out UIntPtr result);
}
"@
if ($Check) { exit 0 }
Start-Sleep -Seconds 2
$result = [UIntPtr]::Zero
# Broadcast to top-level windows; skip hung recipients after one second each.
# A timeout is not proof that the display-off command failed.
[DisplayPower]::SendMessageTimeout([IntPtr]0xffff, 0x0112, [IntPtr]0xf170,
    [IntPtr]2, 2, 1000, [ref]$result) | Out-Null
