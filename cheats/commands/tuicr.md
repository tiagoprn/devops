# tuicr cheatsheet (interactive only)

view modes (unified / side-by-side)...: :diff
next hunk.............................: ]
previous hunk.........................: [
toggle file list (sidebar)............: <leader>e
toggle commit selector................: <leader>s
next / previous file..................: } / {
search file paths (file list).........: /
filter files in/out (regex)...........: i / e   (I / E to clear)
toggle line wrap......................: :set wrap!
toggle relative line numbers..........: :set relativenumber!
refresh / reload diff.................: :e
help..................................: ?
next / previous comment...............: m / M
add line comment (on a diff line).....: c
add file comment......................: C
add review comment....................: <leader>c
add range comment.....................: v / V to select, then c
delete comment at cursor..............: dd
edit comment at cursor................: i   (A: edit at end, vim mode)
list pending comments.................: :summary
copy review to clipboard..............: y   (Y: copy the comment at cursor)
toggle file / hunk reviewed...........: r / R
open file in $EDITOR..................: e
save session..........................: :w
save and quit (prompts to copy).......: :x  /  :wq  /  ZZ
quit..................................: q   (quick), :q (warns), :q! (force)
