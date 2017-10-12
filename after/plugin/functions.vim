"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

func! GetScriptNumber(script_name)
    " Return the <SNR> of a script.
    "
    " Args:
    "   script_name : (str) The name of a sourced script.
    "
    " Return:
    "   (int) The <SNR> of the script; if the script isn't found, -1.
    " Usage:
    "'  call eval(printf("<SNR>%d_foo()", GetScriptNumber("bar.vim")))

    redir => scriptnames
    silent! scriptnames
    redir END

    for script in split(l:scriptnames, "\n")
        if l:script =~ a:script_name
            return str2nr(split(l:script, ":")[0])
        endif
    endfor

    return -1
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

func! CDCurBuf()
if bufname ("%") != "" && isdirectory (expand ("%:p:h"))
    cd %:p:h 
	echo "':cd %:p:h'\t\t chdir: --> " . (expand("%:p:h"))
endif
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

func! ToggleLineNumbers()
    if &number == 1
        set nonumber
    else
        set number
    endif
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

func! ToggleShowMenu()
    if has("gui_running")
        if &guioptions !~# "m"
            set guioptions+=m
            echo "Showing menu..."
        else
            set guioptions-=m
            echo "Hiding menu..."
        endif
    endif
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 
" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
 
function! AutoHighlightToggle()
   let @/ = ''
   if exists('#auto_highlight')
     au! auto_highlight
     augroup! auto_highlight
     setl updatetime=4000
     set nohls
     return 0
  else
    set hls
    augroup auto_highlight
    au!
    au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=25
  return 1
 endif
endfunction
