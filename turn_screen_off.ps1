# Source: http://www.powershellmagazine.com/2013/07/18/pstip-how-to-switch-off-display-with-powershell/

# Turn display off by calling WindowsAPI.
 
# PostMessage(HWND_BROADCAST,WM_SYSCOMMAND, SC_MONITORPOWER, POWER_OFF)
# HWND_BROADCAST  0xffff
# WM_SYSCOMMAND   0x0112
# SC_MONITORPOWER 0xf170
# POWER_OFF       0x0002
 
Add-Type -TypeDefinition '
using System;
using System.Runtime.InteropServices;
 
namespace Utilities {
   public static class Display
   {
      [DllImport("user32.dll", CharSet = CharSet.Auto)]
      private static extern IntPtr PostMessage(
         IntPtr hWnd,
         UInt32 Msg,
         IntPtr wParam,
         IntPtr lParam
      );
 
      public static void PowerOff ()
      {
         PostMessage(
            (IntPtr)0xffff, // HWND_BROADCAST
            0x0112,         // WM_SYSCOMMAND
            (IntPtr)0xf170, // SC_MONITORPOWER
            (IntPtr)0x0002  // POWER_OFF
         );
      }
   }
}
'
Start-Sleep -Seconds 3
[Utilities.Display]::PowerOff()

# Usage
#
# 1. Open PowerShell as a regular user
# 1. Go to the directory with the script
#
#         cd C:\path\to\directory\with\script
#
# 1. Execute the script
#
#         powershell -ExecutionPolicy Bypass .\turn-off-screen.ps1

# Sources
# - https://duckduckgo.com/?q=powershell+shut+down+screen+turn+off&ia=web
# - https://gist.github.com/oledid/fb02951b6b1848d1418d
# - https://gist.github.com/PCHSwS/39e213aac7c574b89673da8dc575e7fa#file-turn-off-screen-ps1
# - https://duckduckgo.com/?q=how+to+run+scripts+in+powershell&ia=web
# - https://lazyadmin.nl/powershell/run-a-powershell-script/
# - https://duckduckgo.com/?q=start+powershell+with+execution+policy&ia=web
# - https://www.technicalfeeder.com/2020/09/start-powershell-with-specified/
# - https://duckduckgo.com/?q=powershell+sleep&ia=web&natb=v344-4vb&cp=atbsc
# - https://www.itechguides.com/powershell-sleep/
