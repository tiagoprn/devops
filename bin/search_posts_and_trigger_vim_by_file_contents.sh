#!/bin/bash

vim-fzf-search() {
    if [ $# == 0 ]; then
        echo 'Error: search term was not provided.'
        return
    fi
    local match=$(
      rg --color=never --line-number "$1" |
        fzf -i --exact --no-multi --delimiter : \
            --preview "bat --color=always --line-range {2}: {1}"
      )
    local file=$(echo "$match" | cut -d':' -f1)
    if [ -n "$file" ]; then
        vim $file +$(echo "$match" | cut -d':' -f2)
    fi
}

contents=$(printf "i3\narch\npycharm\nnmcli" | dmenu -p 'Type the word you want to search on the folder:')

cd /storage/src/tiagoprnl/content/posts && vim-fzf-search $contents

