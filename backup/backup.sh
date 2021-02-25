#!/bin/sh

LOG_FILE="/c/Programme/backup/log.txt"
SHUTDOWNGUARD_PID=""

clear_contents_of_log_file() {
	/c/Programme/backup/ShutdownGuard/ShutdownGuard.exe &
	SHUTDOWNGUARD_PID=$!
	
    echo "¤ Clearing contents of log file"
    cat /dev/null | tee /c/Programme/backup/log.txt
}

clean_backup_directory() {
    echo "¤ Cleaning backup directory"
    
    echo "$(date) - LOG_BACKUP_INFO - Cleanup - Start Time" >> /c/Programme/backup/log.txt
    echo >> /c/Programme/backup/log.txt

    rm -vrf /d/* >> /c/Programme/backup/log.txt 2>&1
}

copy_file() {
    SOURCE=$1
    DESTINATION=$2
    cp --recursive --verbose --force --preserve=mode,ownership,timestamps $SOURCE $DESTINATION >> $LOG_FILE 2>&1
}

backup_files_and_folders() {
    echo "¤ Backing up files"
	echo
	
	echo "Prosim, nechaj pocitac zapnuty, zalohuju sa subory"
	echo
	
	local estimated_backup_finish_time=$(date -d "150 minutes" +"%H:%M")
	echo "Bude to trvat priblizne do ${estimated_backup_finish_time}"
	echo

    echo >> /c/Programme/backup/log.txt
    echo "$(date) - LOG_BACKUP_INFO - Backup - Start Time (Cleanup - End Time)" >> /c/Programme/backup/log.txt
    echo >> /c/Programme/backup/log.txt

    mkdir -p /d/UserProfileFiles >> /c/Programme/backup/log.txt 2>&1

    cp --recursive --verbose --force --preserve=mode,ownership,timestamps /c/Users/${USERNAME}/Desktop /d/UserProfileFiles/Desktop >> /c/Programme/backup/log.txt 2>&1
    cp --recursive --verbose --force --preserve=mode,ownership,timestamps /c/Users/${USERNAME}/AppData /d/UserProfileFiles/AppData >> /c/Programme/backup/log.txt 2>&1
    cp --recursive --verbose --force --preserve=mode,ownership,timestamps /c/Users/${USERNAME}/Downloads /d/UserProfileFiles/Downloads >> /c/Programme/backup/log.txt 2>&1
    cp --recursive --verbose --force --preserve=mode,ownership,timestamps /c/Users/${USERNAME}/Documents /d/UserProfileFiles/Documents >> /c/Programme/backup/log.txt 2>&1
    cp --recursive --verbose --force --preserve=mode,ownership,timestamps /c/Users/${USERNAME}/Pictures /d/UserProfileFiles/Pictures >> /c/Programme/backup/log.txt 2>&1
    cp --recursive --verbose --force --preserve=mode,ownership,timestamps /c/Programme /d/Programme >> /c/Programme/backup/log.txt 2>&1
}

finalize_backup() {
    echo "¤ Backup complete"

    echo >> /c/Programme/backup/log.txt
    echo "$(date) - LOG_BACKUP_INFO - Backup - End Time" >> /c/Programme/backup/log.txt
    echo >> /c/Programme/backup/log.txt
	
	kill $SHUTDOWNGUARD_PID

	echo
	echo "Teraz mozes pocitac bezpecne vypnut"
	echo
	
    read -rsn1 -p "Stlacte lubovolnu klavesu na zatvorenie okna..."
    echo
}

main() {
	echo "Prosim, nechaj pocitac zapnuty, zalohuju sa subory"
	echo
	
	echo "Bude to chvilu trvat..."
	echo

    clear_contents_of_log_file
    clean_backup_directory
    backup_files_and_folders
    finalize_backup
}

main
