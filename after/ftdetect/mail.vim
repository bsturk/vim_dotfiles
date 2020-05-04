au BufRead article.txt,letter.txt *.eml             set syntax=mail | set ft=mail
au BufRead /tmp/*.eml                               normal :g/^> -- $/,/^$/-1d^M/^$^M^L
au BufRead /tmp/mutt*                               normal :g/^> -- $/,/^$/-1d^M/^$^M^L
au BufNewFile,BufRead /tmp/mutt*                    set noautoindent filetype=mail wm=0 tw=9999 nonumber digraph nolist nowrap
au BufNewFile,BufRead ~/tmp/mutt*                   set noautoindent filetype=mail wm=0 tw=9999 nonumber digraph nolist nowrap
