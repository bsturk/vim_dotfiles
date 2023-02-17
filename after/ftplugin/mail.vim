set syntax=mail
set noautoindent 
set wm=0 
set tw=9999 
set nonumber 
set digraph 
set nolist 
set nowrap
normal :g/^> -- $/,/^$/-1d^M/^$^M^L
