#!/bin/sh

ESTIMATED_BACKUP_SIZE_IN_KB="$1"

# Capture signals with 'trap'
# - SIGTERM (kill)
#   - default signal for 'kill'. I assume this would be sufficient for simplicity, readability reasons.
#   - This is the way I use it from caller scripts.
# - SIGINT (Ctrl+C)
# - SIGQUIT (kill -? / exit)
# - SIGKILL (kill -9)
TERMINATE_EXECUTION_OF_SCRIPT="false"
trap handle_default_kill SIGTERM
trap handle_Ctrl_C_interrupt SIGINT

# For usual script termination
handle_default_kill() {
  TERMINATE_EXECUTION_OF_SCRIPT="true"
}

# For standalone script testing
handle_Ctrl_C_interrupt () {
  TERMINATE_EXECUTION_OF_SCRIPT="true"
}

main() {
  local animation_steps=(
    "-"
    "\\"
    "|"
    "/"
  )

  local step_index=0
  local number_of_steps=${#animation_steps[@]}
  while true
  do
    local progress_message=""
    
    if [[ -n "${ESTIMATED_BACKUP_SIZE_IN_KB}" ]]
    then
      # Because we're doing the beckup on a clean drive, therefore we can use 'df' utility
      local current_amount_of_backed_up_data_in_kb=$(df | grep D: | tr -s ' ' | cut -d ' ' -f3)
      
      local percent_completed=$(( current_amount_of_backed_up_data_in_kb * 100 / ESTIMATED_BACKUP_SIZE_IN_KB ))
      progress_message+="${percent_completed}% completed    "
      progress_message+="$current_amount_of_backed_up_data_in_kb/$ESTIMATED_BACKUP_SIZE_IN_KB    "
    fi
    
    progress_message+="${animation_steps[step_index]}"
    
    if [[ "${TERMINATE_EXECUTION_OF_SCRIPT}" = "true" ]]
    then
      progress_message=""
      
      local terminal_width=$(stty size | cut -d' ' -f2)
      #local terminal_width=$(mode con:cols=80)
      
      # to avoid newline at last character
      local reduced_terminal_width=$(( terminal_width - 1 ))
      for i in $(seq ${reduced_terminal_width})
      do
        progress_message+=" "
      done
      
      echo -ne "${progress_message} \r"
      
      local clean_termination=0
      exit ${clean_termination}
    fi
    
    echo -ne "${progress_message} \r"
    
    index_of_next_step=$((step_index + 1))
    step_index=${index_of_next_step}
    
    test $step_index -eq $number_of_steps
    local is_on_the_last_animation_step=$?
    if [[ ${is_on_the_last_animation_step} -eq 0 ]]
    then
      local index_of_first_step=0
      step_index=${index_of_first_step}
    fi
    
    local delay=0.07
    sleep $delay
  done
}

main
