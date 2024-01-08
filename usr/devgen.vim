"if has('nvim')
    "runtime usr/devgen.lua
"endif

set expandtab
set fillchars=stl:_,stlnc:-,vert:\|,fold:\ ,diff:- 
set foldlevel=0 
set foldmethod=indent 
set foldnestmax=2 
set formatoptions-=o
set formatoptions-=r
set nofoldenable
set shiftwidth=4
set tabstop=4
set textwidth=9999

"" when using pico8 don't have tabwidth of 1 and border
let g:pico8_config={ 'imitate_console' : 0 }

" by default don't auto close ( and ", do a ,) to toggle paredit when editing lisp langs
let g:paredit_mode = 0

""""""""""""""""""""""""""
"       vimcmdline
""""""""""""""""""""""""""

" this starts vimcmdline
let cmdline_map_start          = '<LocalLeader>z'
" this sends the entire line when in insert mode, etc
let cmdline_map_send_paragraph = '<LocalLeader>e'
" NOTE: you can select in visual mode and press <SPACE> to send it all or in
"       normal mode press <SPACE> to send the current line

""""""""""""""

func! AddParenSpaces(mode)
    let savecol = col(".")
    let saverow = line(".")

	if a:mode == 'Normal'
        exec '%s:(\([^ )]\):( \1:eg'
        exec '%s/\([^ (]\))/\1 )/eg'
    else
        exec "'<,'>s/(\\([^ )]+\\)/( \\1/eg"
        exec "'<,'>s/\\([^ (]+\\))/\\1 )/eg"
    endif
    
	exec ':'. saverow
	exec 'normal ' . savecol . '|' 
endfun
    
""""""""""""""

func! SurroundWordWithParen(mode)
    let savecol = col(".")
    let saverow = line(".")

	if a:mode == 'Normal'
        exe "norm bi( \<esc>"
        exe "norm ea )\<esc>"
        
    else    " visual        
        "exec "'<,'>s/"
        "exec "'<,'>s/"
        echo "Not implemented yet!!!\n"
    endif
    
	exec ':'. saverow
	exec 'normal ' . savecol . '|' 
endfun

""""""""""""""

if &diff
     map \is :call IwhiteToggle()<CR>
     function! IwhiteToggle()
       if &diffopt =~ 'iwhiteall'
         set diffopt-=iwhiteall
       else
         set diffopt+=iwhiteall
       endif
     endfunction
 endif

map      \fo     :let &fen = !&fen<CR>
noremap  \((     :call AddParenSpaces('Normal')<CR>
vnoremap \((     <Esc>:call AddParenSpaces('Visual')<CR>
noremap  \(s     :call SurroundWordWithParen('Normal')<CR>
vnoremap \(s     <Esc>:call SurroundWordWithParen('Visual')<CR>

" cscope
noremap g<C-]>   :cs find 3 <C-R>=expand("<cword>")<CR><CR>
noremap g<C-\>   :cs find 0 <C-R>=expand("<cword>")<CR><CR>
