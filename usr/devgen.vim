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

" by default don't auto close ( and ", do a ,) to toggle paredit when editing lisp langs
let g:paredit_mode = 0

""""""""""""""""""""""""""
"       vimcmdline
""""""""""""""""""""""""""

" this starts vimcmdline if editing a supported filetype
let cmdline_map_start          = '<leader>s'

" this sends the entire line when in insert mode, etc
let cmdline_map_send_paragraph = '<leader>e'

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

func Eatchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunc

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

map      <leader>fo     :let &fen = !&fen<CR>
noremap  <leader>((     :call AddParenSpaces('Normal')<CR>
vnoremap <leader>((     <Esc>:call AddParenSpaces('Visual')<CR>
noremap  <leader>(s     :call SurroundWordWithParen('Normal')<CR>
vnoremap <leader>(s     <Esc>:call SurroundWordWithParen('Visual')<CR>

" cscope
noremap g<C-]>   :cs find 3 <C-R>=expand("<cword>")<CR><CR>
noremap g<C-\>   :cs find 0 <C-R>=expand("<cword>")<CR><CR>
