#!/bin/bash

BINDINGS=$(cat /storage/src/dot_files/.tmux.conf | grep '^bind[-key]*' | grep '  #@ ' | sed 's/bind-key -T copy-mode-vi //g' | sed 's/bind-key -T root //g' | sed 's/bind-key //g' | sed 's/bind //g')

echo -e "$BINDINGS" | \
	awk 'BEGIN { FS = "#@"} {word_end_index= match($1, " "); binding_text=substr($1, 0, word_end_index); print $2 " @ " binding_text}' | \
	column -t -s '@' | \
	sort | \
	dmenu -fn Monospace:size=12 -c -bw 2 -l 20 -p 'Filter a tmux binding:'

