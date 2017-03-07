" -*- vim -*-
" FILE: "/home/joze/.vim/functions/Page.vim"
" LAST MODIFICATION: "Die, 18 Jul 2000 07:43:50 +0200 (joze)"
" (C) 1999 - 2000 by Johannes Zellner, <johannes@zellner.org>
" $Id: Page.vim,v 1.8 2000/07/19 22:32:19 joze Exp $


" PURPOSE:
"   - redirects the output of vim commands to a split (new) buffer.
"     most useful for searching thru long outputs as you get them
"     from `:map' or `:autocmd'.
"
" USAGE:
"   put this line in your ~/.vimrc
"      :source ~/<dir where you put>/Page.vim
"
" EXAMPLES:
"   :Page map
"   :Page autocmd
"
"   The temporary buffer is automatically deleted if it's left.
"
" LICENSE:
"   BSD type license: http://www.zellner.org/copyright.html
"   if you like this script type :help uganda<Enter>
"
" URL: http://www.zellner.org/vim/functions/Page.vim


if !exists("g:vimautoload")
    command! -nargs=1 Page call Page (<q-args>)
endif

"autocmd BufLeave * if expand('<afile>')==''|bd!|endif

function! Page(...)
    let tmp = tempname()
    let more = &more
    set nomore
    if v:version >= 600
	silent exe 'redir >'.tmp | exe a:1 | redir END
    else
	exe 'redir >'.tmp | exe a:1 | redir END
    endif
    exe 'sp '.tmp
    exe 'au BufLeave '.tmp.' bd! | call delete("'.tmp.'") | au! BufLeave '.tmp
    let &more = more
endfunction

function! PageR(...)
    new
    let more = &more
    set nomore
    redir @j
    exe a:1
    redir END
    put j
    let &more = more
endfunction
