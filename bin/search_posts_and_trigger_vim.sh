#!/bin/bash
vim-fzf() {
    local file=$(
      fzf --exact --no-multi --preview 'bat --color=always --line-range :500 {}'
      )
    if [ -n "$file" ]; then
        vim $file
    fi
}
cd /storage/src/tiagoprnl/content/posts && vim-fzf

