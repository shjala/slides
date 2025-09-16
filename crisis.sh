#!/bin/bash
SESSION="cyber-crisis"
export TERM=xterm-256color

tmux new-session -d -s $SESSION

# Pane 0: Matrix effect on top
tmux send-keys -t $SESSION "cmatrix -C green" C-m

# Split below for slides (middle - largest)
tmux split-window -v -t $SESSION
tmux send-keys -t $SESSION:0.1 "mdp slides.md" C-m

# Split below for logs (bottom)
tmux split-window -v -t $SESSION:0.1
tmux send-keys -t $SESSION:0.2 "clear && while true; do pv -qL 15 fake.log; sleep 2; done" C-m

# Resize panes - matrix small, slides large, logs small
tmux select-pane -t $SESSION:0.0
tmux resize-pane -t $SESSION:0.0 -y 8

tmux select-pane -t $SESSION:0.2
tmux resize-pane -t $SESSION:0.2 -y 8

# Attach to the session
tmux attach -t $SESSION
