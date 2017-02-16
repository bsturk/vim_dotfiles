" Stuff that should be done everytime this file is sourced
" should go below here...

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

map \fo :let &fen = !&fen<CR>

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

noremap  \((     :call AddParenSpaces('Normal')<CR>
vnoremap \((     <Esc>:call AddParenSpaces('Visual')<CR>
noremap  \(s     :call SurroundWordWithParen('Normal')<CR>
vnoremap \(s     <Esc>:call SurroundWordWithParen('Visual')<CR>

noremap g<C-]>   :cs find 3 <C-R>=expand("<cword>")<CR><CR>
noremap g<C-\>   :cs find 0 <C-R>=expand("<cword>")<CR><CR>
