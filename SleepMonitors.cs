using System;
using System.Runtime.InteropServices;
using System.Threading;

internal static class SleepMonitors
{
    [DllImport("user32.dll")]
    private static extern IntPtr GetDesktopWindow();
    [DllImport("user32.dll", SetLastError = true)]
    private static extern IntPtr SendMessage(IntPtr window, uint message,
        IntPtr wParam, IntPtr lParam);

    [STAThread]
    private static int Main(string[] args)
    {
        if (args.Length == 1 && args[0] == "--check") return 0;
        if (args.Length != 0) return 2;
        // Let the click or keyboard shortcut finish before switching displays off.
        Thread.Sleep(2000);
        SendMessage(GetDesktopWindow(), 0x0112, new IntPtr(0xf170), new IntPtr(2));
        return 0;
    }
}
