#!/usr/bin/env bash

set -eou pipefail

dragon -a $(ls -la $HOME/screenshots/* | awk '{print $NF}' | grep $(date +%Y-%m-%d) | sort -r | dmenu -fn 'Jetbrains Mono:size=14' -c -bw 1 -l 20 -p 'Choose screenshot:')
