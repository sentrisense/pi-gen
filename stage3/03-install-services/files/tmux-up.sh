#!/bin/bash

cd ~

sn="labgrid-lab"

if tmux has-session -t "$sn">/dev/null; then
        echo 'labgrid tmux session is already created'
else
        tmux new-session -d -s "$sn"
        echo 'labrid session created'
fi



