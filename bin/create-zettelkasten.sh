#!/bin/bash

# Creates a zettelkasten file inside the current folder
# This must work seamlessly from i3, I will add a mapping to it.

CARDS_DIR=/storage/docs/notes/zettelkasten/cards
TIMESTAMP="$(date "+%Y-%m-%d-%H%M%S-%3N")"
FILENAME=$CARDS_DIR/$TIMESTAMP.md

mkdir -p $CARDS_DIR

vim "$FILENAME" +'normal!ggIztk'

