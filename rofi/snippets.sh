#!/bin/bash

SNIPS=/storage/src/dot_files/text_snippets

FILE=$(ls $SNIPS | rofi -dmenu)

if [ -f $SNIPS/$FILE ]; then
	DATA=$([ -x "$SNIPS/$FILE"] && bash "$SNIPS/$FILE" || head --bytes=-1 $SNIPS/$FILE)
	printf "$DATA" | xclip -selection clipboard
	printf "$DATA" | xclip -selection primary
	xdotool key shift+Insert
fi
