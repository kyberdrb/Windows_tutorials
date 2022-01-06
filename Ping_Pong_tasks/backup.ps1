function ClearContentsOfLogFile($LogFile) {
    Clear-Content -Force $LogFile
}

function Log($Message) {
    Add-Content -Force -Encoding UTF8 $LogFile "$(Get-Date -Format "dd-MM-yyyy HH:mm:ss") - LOG_BACKUP_INFO - $Message"
    echo "$Message"
}

function CleanBackupDirectory($LogFile) {
    Log "Cleanup - Start Time"

    Remove-Item D:\* -Force -Recurse -ErrorAction SilentlyContinue -ErrorVariable ErrorOutput
    
    if($ErrorOutput) {
        Write-Output $ErrorOutput | Out-File -Encoding UTF8 -Append $LogFile
    }
}

function CopyItem($From, $To) {
    # replace with the original Copy-Item command - robocopy got stuck randomly each run
    #robocopy "$From" "$To" /e /copy:dat /dcopy:dat /ipg:10 /r:0 /w:0 /x /v /fp /bytes
    
	# Test out this command
    Copy-Item -Verbose -Force -Recurse -ErrorAction SilentlyContinue -ErrorVariable ErrorOutput "$From" "$To"

    if($ErrorOutput) {
        Write-Output $ErrorOutput | Out-File -Encoding UTF8 -Append $LogFile
    }
}

function BackupFilesAndFolders($LogFile) {
    Log "Backup - Start Time (Cleanup - End Time)"

    $UserName = dir C:\Users | Select-String -Pattern uchovia

    CopyItem C:\Users\$UserName\Desktop D:\UserProfileFiles\Desktop
    CopyItem C:\Users\$UserName\AppData D:\UserProfileFiles\AppData
    CopyItem C:\Users\$UserName\Downloads D:\UserProfileFiles\Downloads
    CopyItem C:\Users\$UserName\Documents D:\UserProfileFiles\Documents
    CopyItem C:\Users\$UserName\Pictures D:\UserProfileFiles\Pictures
    CopyItem C:\Programme D:\Programme
}

function FinalizeBackup($LogFile) {
    Log "Backup - End Time"
    Write-Host 'Stlacte lubovolnu klavesu pre finalizaciu zalohovania...'
    $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown') >$null *>&1
}

function BackupComputer {
    $LogFile = "C:\Programme\backup\log.txt"

    ClearContentsOfLogFile $LogFile
    CleanBackupDirectory $LogFile
    BackupFilesAndFolders $LogFile
    FinalizeBackup $LogFile
}

BackupComputer
