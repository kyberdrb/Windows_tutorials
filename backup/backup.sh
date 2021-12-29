#!/bin/sh

DATE_AND_TIME_FOR_LOG_ENTRIES=$(date "+%s")
DATE_AND_TIME_FOR_FILENAME=$(date "+%Y_%m_%d-%H_%M_%S")

SCRIPT_DIR="$(dirname "$(readlink --canonicalize "$0")")"
LOG_DIR="${SCRIPT_DIR}/logs"
LOG_FILE="${LOG_DIR}/backup-${DATE_AND_TIME_FOR_FILENAME}.log"

SHUTDOWNGUARD_PID=0
ANIMATION_PID=0

ESTIMATED_BACKUP_SIZE_IN_KB=0

BACKUP_FOLDER="/d"

DIRECTORIES_FOR_BACKUP=(
  "/c/Users/${USERNAME}/Desktop"
  "/c/Users/${USERNAME}/AppData"
  "/c/Users/${USERNAME}/Downloads"
  "/c/Users/${USERNAME}/Documents"
  "/c/Users/${USERNAME}/Pictures"
  "/c/Programme"
)

start_support_processes() {
  /c/Users/Ňuchovia/git/Windows_tutorials/backup/busy-animation.sh &
  ANIMATION_PID="$!"
  
  /c/Users/Ňuchovia/git/Windows_tutorials/backup/ShutdownGuard/ShutdownGuard.exe &
	SHUTDOWNGUARD_PID="$!"
}

show_info_message() {
  echo "Teraz sa cisti pocitac a zalohuju sa subory"
	echo
	
	echo "Bude to chvilu trvat..."
	echo
}

clean_temp_files() {
	echo "$(date "+%s"):$(date "+%Y/%m/%d %H:%M:%S") - LOG_BACKUP_INFO - Cleanup - Start Time" >> "${LOG_FILE}"
	echo >> "${LOG_FILE}"
  
	echo "¤ Clearing temporary files"
  ${SCRIPT_DIR}/../windows_cleaner/windows_cleaner-clean.sh "$DISPLAY_BUFFER_FILE"
	echo
}

clean_backup_directory() {
  echo "¤ Cleaning backup directory"
  echo

  # TODO 5. instead of deleting all files on the backup drive or folder
  #  iterate over paths in the global array and recursivelly remove only listed items
  #  to prevent unpleasant surprises by deleting other data on the backup drive
  
  for dir_index in ${!DIRECTORIES_FOR_BACKUP[@]}
  do
    local directory_for_deletion="${DIRECTORIES_FOR_BACKUP[$dir_index]}"
    local path_for_deletion="${BACKUP_FOLDER}"
    local source_drive="/$(echo "$directory_for_deletion" | cut -d'/' -f2)"
    local directory_for_deletion_without_drive_name=$(echo ${directory_for_deletion#$source_drive})
    path_for_deletion+="${directory_for_deletion_without_drive_name}"
    
    echo "rm -vrf "${path_for_deletion}""
    
    # TODO test actual deletion
    rm -vrf "${path_for_deletion}" >> "${LOG_FILE}" 2>&1
  done
  
  # TODO 6. remove deleting the entire directory/drive - use the loop instead - keep other user's files not related to backup to give more consideration to the user
  #rm -vrf "${BACKUP_FOLDER}/*" >> "${LOG_FILE}" 2>&1
}

estimate_backup_size() {
	echo "¤ Estimating backup size"
  
  for dir_index in ${!DIRECTORIES_FOR_BACKUP[@]}
  do
    local directory_for_backup="${DIRECTORIES_FOR_BACKUP[$dir_index]}"
    local backed_up_dir_size_in_KB=$(du -s "$directory_for_backup" 2>/dev/null | cut -f1)
    ESTIMATED_BACKUP_SIZE_IN_KB=$((ESTIMATED_BACKUP_SIZE_IN_KB + backed_up_dir_size_in_KB))
  done
  
  echo "  Estimated backup size: $ESTIMATED_BACKUP_SIZE_IN_KB" KB
  echo
}

copy_file() {
  SOURCE="$1"
  DESTINATION="$2"
  cp --recursive --verbose --force --preserve=mode,ownership,timestamps "${SOURCE}" "${DESTINATION}" >> "${LOG_FILE}" 2>&1
}

backup_files_and_folders() {
	echo "¤ Backing up files"
	echo
	
	echo "Prosim, nechaj pocitac zapnuty, zalohuju sa subory"
	echo
  
  local last_backup_log_filename=$(ls -c1 "${LOG_DIR}/" | head -n 1)
  local last_backup_log="${LOG_DIR}/${last_backup_log_filename}"
  local start_timestamp=$(head -n 1 "${last_backup_log}" | cut -d ':' -f1)
  local end_timestamp=$(tail -n 2 "${last_backup_log}" | cut -d ':' -f1 | tr -d '\n')
  local duration_of_last_backup_in_seconds=$(( end_timestamp - start_timestamp ))
  local duration_of_last_backup_in_seconds_in_human_readable_format=$(date -d@${duration_of_last_backup_in_seconds} -u "+%H:%M")
  echo "Posledna zaloha trvala (hodiny:minuty) - ${duration_of_last_backup_in_seconds_in_human_readable_format}"
  
  local estimated_backup_finish_time=$(date -d "${duration_of_last_backup_in_seconds} seconds"  +"%H:%M")
	echo "Zalohovanie bude trvat priblizne do ${estimated_backup_finish_time}"
	echo
  
  kill $ANIMATION_PID
  wait $ANIMATION_PID 2>/dev/null
  
  /c/Users/Ňuchovia/git/Windows_tutorials/backup/busy-animation.sh "$ESTIMATED_BACKUP_SIZE_IN_KB" &
  ANIMATION_PID="$!"
	
  echo >> "${LOG_FILE}"
  echo "$(date "+%s"):$(date "+%Y/%m/%d %H:%M:%S") - LOG_BACKUP_INFO - Backup - Start Time (Cleanup - End Time)" >> "${LOG_FILE}"
  echo >> "${LOG_FILE}"

  mkdir -p /d/UserProfileFiles >> "${LOG_FILE}" 2>&1
  
  # TODO 4. delete this when the for loop will do the work - keep this, when it doesn't work and backs up everything at once
  # copy_file "/c/Users/${USERNAME}/Desktop" "/d/UserProfileFiles/Desktop" >> "${LOG_FILE}" 2>&1
  # copy_file "/c/Users/${USERNAME}/AppData" "/d/UserProfileFiles/AppData" >> "${LOG_FILE}" 2>&1
  # copy_file "/c/Users/${USERNAME}/Downloads" "/d/UserProfileFiles/Downloads" >> "${LOG_FILE}" 2>&1
  # copy_file "/c/Users/${USERNAME}/Documents" "/d/UserProfileFiles/Documents" >> "${LOG_FILE}" 2>&1
  # copy_file "/c/Users/${USERNAME}/Pictures" "/d/UserProfileFiles/Pictures" >> "${LOG_FILE}" 2>&1
  # copy_file "/c/Programme" "/d/Programme" >> "${LOG_FILE}" 2>&1
  
  # TODO 3. iterate the global array of directories and files for backup instead of duplicating file and folder paths
  for dir_index in ${!DIRECTORIES_FOR_BACKUP[@]}
  do
    local directory_for_backup="${DIRECTORIES_FOR_BACKUP[$dir_index]}"
    # TODO generalize: strip '/c' and prepend ${BACKUP_FOLDER} instead to a new variable e.g. 'local backup_path'
    # copy_file "/c/Users/${USERNAME}/Desktop"   "${BACKUP_FOLDER}/UserProfileFiles/Desktop" >> "${LOG_FILE}" 2>&1
    # copy_file "/c/Users/${USERNAME}/AppData"   "${BACKUP_FOLDER}/UserProfileFiles/AppData" >> "${LOG_FILE}" 2>&1
    # copy_file "/c/Users/${USERNAME}/Downloads" "${BACKUP_FOLDER}/UserProfileFiles/Downloads" >> "${LOG_FILE}" 2>&1
    # copy_file "/c/Users/${USERNAME}/Documents" "${BACKUP_FOLDER}/UserProfileFiles/Documents" >> "${LOG_FILE}" 2>&1
    # copy_file "/c/Users/${USERNAME}/Pictures"  "${BACKUP_FOLDER}/UserProfileFiles/Pictures" >> "${LOG_FILE}" 2>&1
    #
    local backup_path="${BACKUP_FOLDER}"
    local source_drive="/$(echo "$directory_for_backup" | cut -d'/' -f2)"
    local directory_for_backup_without_drive_name=$(echo ${directory_for_backup#$source_drive})
    backup_path+="${directory_for_backup_without_drive_name}"
    
    #echo "copy_file "${directory_for_backup}" "${backup_path}""
    
    # TODO test the actual copying
    copy_file "${directory_for_backup}" "${backup_path}" >> "${LOG_FILE}" 2>&1
  done
}

finalize_backup() {
  kill $SHUTDOWNGUARD_PID 2>/dev/null
  wait $SHUTDOWNGUARD_PID 2>/dev/null
  
  kill $ANIMATION_PID 2>/dev/null
  wait $ANIMATION_PID 2>/dev/null

  echo "¤ Backup complete"
  echo
  
  echo >> "${LOG_FILE}"
  echo "$(date "+%s"):$(date "+%Y/%m/%d %H:%M:%S") - LOG_BACKUP_INFO - Backup - End Time" >> "${LOG_FILE}"
  echo >> "${LOG_FILE}"
  
	echo "Teraz mozes pocitac bezpecne vypnut"
	echo
	
  read -rsn1 -p "Stlacte lubovolnu klavesu na zatvorenie okna..."
  echo
}

main() {
  start_support_processes
  show_info_message
	clean_temp_files
  clean_backup_directory
	estimate_backup_size
  backup_files_and_folders
  finalize_backup
}

main
