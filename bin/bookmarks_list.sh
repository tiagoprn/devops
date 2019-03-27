#!/bin/bash
find /storage/docs/notes -name '.BrowserBookmarks' | xargs cat | sort | grep -e '^.'
