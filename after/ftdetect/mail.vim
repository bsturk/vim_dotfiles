au BufRead article.txt,letter.txt *.eml             set syntax=mail | set ft=mail
au BufRead /tmp/*.eml                               normal :g/^> -- $/,/^$/-1d^M/^$^M^L
au BufRead /tmp/mutt*                               normal :g/^> -- $/,/^$/-1d^M/^$^M^L

