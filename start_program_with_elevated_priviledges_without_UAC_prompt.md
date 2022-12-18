1. Open `Task Scheduler`.
1. In the left pane, click on directory `Task Scheduler Library`.
1. Click on `Create Task` on the right pane.
    - tab `General`
        - name `start Open Hardware Monitor - without UAC prompt`
        - check **Run with highest priviledges** - checking this option will bypass/skip the UAC prompt and executes the commands in `Action` tab as Administrator directly
    - tab `Actions`

        Program: `cmd.exe`
        Arguments: `/c start "" taskkill /IM OpenHardwareMonitor.exe /F`

        Program: `cmd.exe`
        Arguments: `/c start "" timeout 1`

        Program: `cmd.exe`
        Arguments: `/c start "" C:\Programme\openhardwaremonitor-v0.9.6\OpenHardwareMonitor\OpenHardwareMonitor.exe`
    
    - tab `Conditions` - uncheck all

1. Create a shortcut, e.g. on the `Desktop` with this `Target`

        schtasks /run /tn "start Open Hardware Monitor - without UAC prompt"

---

Sources
- https://duckduckgo.com/?q=run+as+administrator+without+uac+prompt&ia=web
- https://answers.microsoft.com/en-us/windows/forum/all/how-do-i-always-run-a-program-as-an-administrator/f5bd3020-7135-4f03-8820-521b4b35a3b8
- **MAIN GUIDE: https://winaero.com/create-elevated-shortcut-to-skip-uac-prompt-in-windows-10/**
- https://duckduckgo.com/?q=killall+equivalent+command+prompt+windows&ia=web
- https://www.blackmoreops.com/2018/11/09/kill-all-matching-processes-on-windows-from-command-prompt/
- https://duckduckgo.com/?q=start+multiple+commands+cmd+-c&ia=web
- https://stackoverflow.com/questions/48199915/passing-multiple-commands-to-start-command-in-batch-file
- https://linuxhint.com/sleep-five-seconds-cmd/
