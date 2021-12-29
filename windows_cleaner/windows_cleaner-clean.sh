DISPLAY_BUFFER_FILE="$1"

wait_for_cleanmgr_to_finish() {
	while true
	do
		cleanmgr_process_info=$(tasklist | findstr "cleanmgr")
		
		if [[ -z "$cleanmgr_process_info" ]]
		then
			break
		fi
	done
	
	local message="$1"
	echo "$message" | tee --append "$DISPLAY_BUFFER_FILE"
}

clean_systemspace() {
	gsudo cleanmgr /SAGERUN:0
	wait_for_cleanmgr_to_finish "  • systemspace cleaning done"
}

clean_userspace() {
	cleanmgr /SAGERUN:0
	wait_for_cleanmgr_to_finish "  • userspace cleaning done"
}


main() {
	clean_systemspace
	clean_userspace
}

main
