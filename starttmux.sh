#!/usr/bin/zsh

session="olafurg-com"

tmux start-server

tmux new-session -d -s $session -n server

tmux new-window -n console
tmux new-window -n vim

tmux attach-session -t $session
