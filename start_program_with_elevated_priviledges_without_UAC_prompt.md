1. `Create Task` in `Task Scheduler Library` in `Task Scheduler`
    - with name `start Open Hardware Monitor - without UAC prompt`
    - with these `Actions`

        Program: `cmd.exe`
        Arguments: `/c start "" taskkill /IM OpenHardwareMonitor.exe /F`

        Program: `cmd.exe`
        Arguments: `/c start "" timeout 1`

        Program: `cmd.exe`
        Arguments: `/c start "" C:\Programme\openhardwaremonitor-v0.9.6\OpenHardwareMonitor\OpenHardwareMonitor.exe`

1. Create a shortcut, e.g. on a `Desktop` with this `Target`

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
