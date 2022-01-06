# Windows Backup Script

Add this tutorial to my repo "Windows_tutorials"

## Testing the script

1. Open PowerShell as Administrator
1. Open a new PowerShell session, i.e. subshell, with enabled script execution

        powershell.exe -ExecutionPolicy Bypass -File C:\Programme\backup\backup.ps1

## Script description

Script operations

1. Format backup drive
1. Backup folders
1. Show message that the backup has completed

## Task scheduling

- with opened powershell window
- as current user

## Sources

- https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy
- https://superuser.com/questions/989210/how-do-i-create-a-log-of-robocopy-actions-and-save-in-a-text-file-named-with-tod/989217#989217
- https://www.windowstricks.in/2018/08/how-to-run-the-powershell-script-in-scheduled-task-with-run-as-administrator.html
- https://community.spiceworks.com/topic/2176151-powershell-script-runs-fine-manually-but-won-t-run-in-task-scheduler?page=1#entry-8085238
- https://stackoverflow.com/questions/50370658/bypass-vs-unrestricted-execution-policies/50372106#50372106
- https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-7
- https://www.windowscentral.com/how-assign-permanent-drive-letter-windows-10
- https://www.thomasmaurer.ch/2012/04/replace-diskpart-with-windows-powershell-basic-storage-cmdlets/
- https://devblogs.microsoft.com/scripting/use-powershell-to-initialize-raw-disks-and-to-partition-and-format-volumes/
- https://www.sevenforums.com/tutorials/211758-task-scheduler-create-task-display-message-reminder.html
- https://www.lifewire.com/msg-command-2618093
- https://stackoverflow.com/questions/11013132/how-can-i-enable-the-windows-server-task-scheduler-history-recording/14651161#14651161
- http://woshub.com/schedule-task-to-start-when-another-task-finishes/
- https://stackoverflow.com/questions/41497122/keeping-powershell-window-open-and-task-scheduler
- https://stackoverflow.com/questions/41497122/keeping-powershell-window-open-and-task-scheduler/41497344#41497344
- https://superuser.com/questions/741945/delete-all-files-from-a-folder-and-its-sub-folders/1264901#1264901
- https://stackoverflow.com/questions/27861176/how-to-capture-error-output-only-in-a-variable-in-powershell/27861374#27861374
- https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/clear-variable?view=powershell-7
- https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date?view=powershell-7
- https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/add-content?view=powershell-7
- https://stackoverflow.com/questions/29562103/powershell-append-to-output/29562515#29562515
- https://stackoverflow.com/questions/20886243/press-any-key-to-continue/20886446#20886446
- https://lifeofbrianoc.com/2017/09/01/add-press-any-key-to-continue-to-a-powershell-script/
- https://stackoverflow.com/questions/15113413/how-do-i-concatenate-strings-and-variables-in-powershell/15113467#15113467
- https://powershell.org/forums/topic/log-for-copy-item/
- https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/out-file?view=powershell-7
- https://github.com/PowerShell/PowerShell/issues/9152#issuecomment-473591088
- https://stackoverflow.com/questions/18780956/suppress-console-output-in-powershell/18782669#18782669

---

- https://gist.github.com/damc-dev/eb5e1aef001eef78c0f4
- https://www.dev-tips-and-tricks.com/run-a-node-script-with-windows-task-scheduler
- https://joshuatz.com/posts/2020/using-windows-task-scheduler-to-automate-nodejs-scripts/

## Another Windows guide - Format drive in PowerShell

    Clear-Disk 1 -RemoveData -Confirm:$false
    Initialize-Disk 1 -PartitionStyle MBR -PassThru
    New-Partition -DiskNumber 1 -UseMaximumSize
    Get-Partition -DiskNumber 1 -PartitionNumber 1 | Format-Volume -FileSystem NTFS -Confirm:$false
    Get-Partition -DiskNumber 1 -PartitionNumber 1 | Set-Partition -NewDriveLetter D

## Scheduling the - Ping and Pong tasks

Describe the creation of the scheduled job in the _Task Scheduler_ which performs the backup regularily

- See "Task Manager" task with name "BackupComputer" - Ping task

- When running the task, use the following user account: **SYSTEM**
    - that's why the backup script didn't run from the _Task Scheduler_
    - add step-by-step guide with pictures to follow

- "Task Manager" task with name "BackupCompleted" - Pong task
    - notification

    Step 1: Open an elevated Task Scheduler (ie. right-click on the Task Scheduler icon and choose Run as administrator)

    Step 2: In the Actions pane (right pane, not the actions tab), click Enable All Tasks History

    That's it. Not sure why this isn't on by default, but it isn't.

Run the _ping_ task. Then check the history either in thehttp://woshub.com/schedule-task-to-start-when-another-task-finishes/ _TaskScheduler_ in the _History_ tab or in the _EventViewer_ `eventvwr` (run as Administrator) under _Applications and Services Logs - Microsoft - Windows - TaskScheduler - Operational_.

**Finish the rest of the guide according to the site: http://woshub.com/schedule-task-to-start-when-another-task-finishes/**

<Event xmlns="http://schemas.microsoft.com/win/2004/08/events/event">
    <System>
        <Provider Name="Microsoft-Windows-TaskScheduler" Guid="{DE7B24EA-73C8-4A09-985D-5BDADCFA9017}" /> 
        <EventID>102</EventID> 
        <Version>0</Version> 
        <Level>4</Level> 
        <Task>102</Task> 
        <Opcode>2</Opcode> 
        <Keywords>0x8000000000000001</Keywords> 
        <TimeCreated SystemTime="2020-05-17T16:46:05.884904600Z" /> 
        <EventRecordID>11</EventRecordID> 
        <Correlation ActivityID="{F018BDD1-9F21-4D04-97EA-57DD14B388FF}" /> 
        <Execution ProcessID="912" ThreadID="3148" /> 
        <Channel>Microsoft-Windows-TaskScheduler/Operational</Channel> 
        <Computer>family_PC</Computer> 
        <Security UserID="S-1-5-18" /> 
    </System>
    <EventData Name="TaskSuccessEvent">
        <Data Name="TaskName">\BackupComputer</Data> 
        <Data Name="UserContext">NT AUTHORITY\SYSTEM</Data> 
        <Data Name="InstanceId">{F018BDD1-9F21-4D04-97EA-57DD14B388FF}</Data> 
    </EventData>
</Event>

Parse needed fields:

<Channel>Microsoft-Windows-TaskScheduler/Operational</Channel> 
<EventID>102</EventID>
<Provider Name="Microsoft-Windows-TaskScheduler" .../>
<Data Name="TaskName">\BackupComputer</Data> 

Go to the _XML_ tab

<Select Path="Microsoft-Windows-TaskScheduler/Operational">*[System[Provider[@Name='Microsoft-Windows-TaskScheduler'] and Task = 102]]</Select>

<Select Path="Microsoft-Windows-TaskScheduler/Operational">*[EventData[@Name='TaskSuccessEvent'][Data[@Name='TaskName']='\BackupComputer']]</Select>

- http://woshub.com/schedule-task-to-start-when-another-task-finishes/

## PowerShell examples - another repo

- Get free space for a disk

        Get-WmiObject -Class Win32_logicaldisk -Filter "DeviceID = 'D:'" | Select-Object -Property DeviceID, DriveType, VolumeName, @{L='FreeSpaceGB';E={"{0:N2}" -f ($_.FreeSpace /1GB)}}, @{L="Capacity";E={"{0:N2}" -f ($_.Size/1GB)}}


    - Sources:
        - https://mcpmag.com/articles/2018/01/26/view-drive-information-with-powershell.aspx
