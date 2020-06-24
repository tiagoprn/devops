#!/bin/bash

# Creates a zettelkasten file inside the current folder
# This must work seamlessly from i3, I will add a mapping to it.

QUICKNOTES_DIR=/storage/docs/notes/quick
TIMESTAMP="$(date "+%Y-%m-%d-%H%M%S-%3N")"
FILENAME=$QUICKNOTES_DIR/$TIMESTAMP.md

vim "$FILENAME"

