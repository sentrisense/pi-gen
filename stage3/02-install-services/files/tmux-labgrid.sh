#!/bin/bash

cd ~
. /home/example_user/esp-idf/export.sh

boards=()
#boards=("2.1.X" "3.3.X" "3.6.X")
#labgrid-client -p wifi_place acquire

for board in "${boards[@]}"; do
	labgrid-client -p ${board}_place acquire
	labgrid-client -p ${board}_place io high
	labgrid-client -p ${board}_charger_place acquire
	labgrid-client -p ${board}_charger_place io low
done

sn="labgrid-lab"
target_directory="/home/example_user/firmware/tools/boardclass"

if tmux has-session -t "$sn">/dev/null; then
        echo 'labgrid tmux session is already created'
else
        tmux new-session -d -s "$sn"
        echo 'labrid session created'
        for board in "${boards[@]}"; do
                tmux new-window -t "$sn" -n "${board}"
                tmux send-keys "cd $target_directory" C-m
                tmux send-keys "python" C-m
                tmux send-keys "from boards import boards" C-m
                tmux send-keys "boards[\"${board}\"].power_on()" C-m
                tmux split-window -v -p 99
                tmux send-keys "labgrid-client -p ${board}_place console --logfile ./logfile/${board}_log"

        done
fi



