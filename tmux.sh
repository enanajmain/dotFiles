#!/usr/bin/env bash
# Author: Enan Ajmain
# Email : 3nan.ajmain@gmail.com
# Github: https://github.com/enanajmain

if [ -z "$1" ]; then
    session_name="enan"
else
    session_name=$1
fi

cd ~
tmux has-session -t="$session_name"

if [ $? != 0 ]; then
    tmux new-session -s "$session_name" -d
    tmux rename-window -t "$session_name" shell

    # tmux new-window -t "$session_name"
    # tmux rename-window -t "$session_name" files
    # tmux send-keys -t "$session_name" 'vifm' C-m

    tmux next-window
fi

tmux attach-session -t "$session_name"
