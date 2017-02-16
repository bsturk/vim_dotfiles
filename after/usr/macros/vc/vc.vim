" file:     vc.vim
" purpose:  support file for vc, when sourced starts a vc session
"
" author:   brian m sturk   bsturk@adelphia.net,
"                           http://users.adelphia.net/~bsturk
" created:  06/03/03
" last_mod: 
" version:  see vc.py
"
" usage:    :so[urce] vc.vim

function! VimCmdrRedraw()
    redraw
endfunction

pyfile <sfile>:p:h/vc.py
