runtime after/macros/selectbuffer.vim
runtime after/macros/align.vim
runtime after/macros/align_maps.vim
runtime after/macros/align_regex.vim

iab teh the
iab THe The
iab alos also
iab aslo also
iab becuase because
iab Becuase Because

iab zdate <C-R>=strftime("%m/%d/%y")<CR>
iab ztime <C-R>=strftime("%X")<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let $VIMSH              = 1
let g:vimsh_split_open  = 1
"let g:vimsh_sh         = 'c:\root\cygwin.bat'

if !has("win32")
    let g:vimsh_pty_prompt_override = 0
    let g:vimsh_sh_arg              = '-i'
endif

let g:selBufActKeySeq = '\ls'

if has("browse")
    let g:netrw_list_hide='\.DS_Store'
endif

if !has ("X11")     " title not restored when not compiled w/o X support
    let &titleold=getcwd()
endif

""  Show date and filesize in explorer
let g:explDetailedList = 1

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

let g:TextModeColorsOn = 0
let g:PrevFGColor      = 0
let g:PrevBGColor      = 0

func! ToggleTextMode()
	let g:TextModeColorsOn=!g:TextModeColorsOn

	if g:TextModeColorsOn
		" if text mode isn't on get the fg and bg colors to restore later
		let g:PrevBGColor = synIDattr(synIDtrans(hlID("Normal")), "bg")
		let g:PrevFGColor = synIDattr(synIDtrans(hlID("Normal")), "fg")

		exec "hi Normal guibg=#260062 guifg=grey77"
	else    
		exec "hi Normal guibg=" . g:PrevBGColor . " guifg=" . g:PrevFGColor
	endif
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("win32")
    func! PrintBuffer (mode)
        if(!g:printer_spool_started)
            exe "!start " . $UTILITY . "/Misc/Print_File/PrFile32.exe /s:". $TEMP ."/spool/*.*"
            let g:printer_spool_started = 1
        endif

        if a:mode == 'Visual'
            let tmp_file=$TEMP . "/spool/Partial-" . expand ("%:t")
            exec ":'<,'>w! ". tmp_file
        else
            let tmp_file= $TEMP. "/spool/" . expand ("%:t")
            exec "w! ". tmp_file
        endif
    endfunc

    map  <M-Space>         :simalt ~<CR>
    imap <M-Space>         <C-O>:simalt ~<CR>
    cmap <M-Space>         <C-C><M-Space>
    nmap <M-p>             :call PrintBuffer ('Normal')<CR>
    vmap <M-p>             <Esc>:call PrintBuffer ('Visual')<CR>
endif
 
" ** Alt keys : NOTE: F, E, T, Y, B, and N are used for menu access! **

nmap  '            `
vmap  <M-a>        "*x
vmap  <M-c>        "*y
nmap  <M-v>        \\Paste\\ 
imap  <M-v>        x<Esc>\\Paste\\"_s
cmap  <M-v>        <C-R>*
vmap  <M-v>        "-cx<Esc>\\Paste\\"_x  
nmap  \\Paste\\    "=@*.'xy'<CR>gPFx"_2x:echo<CR>

nmap  gf           <C-W>f
nmap  gc           gdb<C-W>f

nmap Y             y$
nmap <C-Space>     i<Space><Esc>

" calculator in insert mode
imap <C-S>         <C-O>yiW<End>=<C-R>=<C-R>0<CR>

""  Jump to previous spot in alt file
noremap <C-^>      <C-^>`"                       

vmap <leader>alre  :call DoAlign()<CR>
nmap <leader>cd    :call CDCurBuf()<CR>
nmap <leader>ee    :Explore<CR>
nmap <leader>es    :Sexplore<CR>
nmap <leader>hi    :echo synIDattr(synID(line("."),col("."),1),"name")<CR>
nmap <leader>hg    :echo synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name")<CR>
nmap <leader>hl    :set hls!<CR>:set hls?<CR>
nmap <leader>in    :Info <cword><CR>

if !has ("macunix")
    nmap <leader>mn  :call ToggleShowMenu()<CR>
endif
nmap <leader>nm           :call ToggleLineNumbers()<CR>
nmap <leader>ru           0O....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8
nmap <leader>tx           :call ToggleTextMode()<CR>

nmap <leader>sh           :runtime after/usr/macros/vimsh/vimsh.vim<CR>
nmap <leader>cm           :runtime after/usr/macros/vc/vc.vim<CR>
nmap <silent> <leader>vc :cal VimCommanderToggle()<CR>
