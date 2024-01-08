runtime usr/macros/selectbuffer.vim
runtime usr/macros/align.vim
runtime usr/macros/align_maps.vim
runtime usr/macros/align_regex.vim

colorscheme bsturk_dark

if &diff
    colorscheme CodeFactoryv3
endif

iab teh the
iab THe The
iab alos also
iab aslo also
iab becuase because
iab Becuase Because

iab zdate <C-R>=strftime("%m/%d/%y")<CR>
iab ztime <C-R>=strftime("%X")<CR>

source $VIMHOME/.vimrc-work

let $VIMSH              = 1
let g:vimsh_split_open  = 1

if !has("win32")
    let g:vimsh_pty_prompt_override = 0
    let g:vimsh_sh_arg              = '-i'
endif

let g:selBufActKeySeq = '\ls'

if has("browse")
    let g:netrw_list_hide = '\.DS_Store'
    let g:netrw_dirhistmax = 0
endif

if !has ("X11")     " title not restored when not compiled w/o X support
    let &titleold=getcwd()
endif

""  Show date and filesize in explorer
let g:explDetailedList = 1

if has('nvim')
    let g:python3_host_prog='/usr/bin/python3'
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GUID generation

if has("unix")
    iab zguid <C-R>=system('uuidgen <Bar> tr \[:lower:\] \[:upper:\]')[:-2]<CR>
elseif has ("macunix")
    iab zguid <C-R>=system('uuidgen')[:-2]<CR>
elseif has ("win32")
    " this is SLOOOWWWWW
    iab zguid <C-R>=system('powershell.exe -c "[guid]::NewGuid().ToString().ToUpper()"')[:-2]<CR>
    " this fails due to perms in %TMP%
    " iab zguid <C-R>=system("C:\Program Files\ (x86)\Windows\ Kits\10\bin\10.0.22000.0\x64\uuidgen.exe")[:-2]<CR>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tmux split window navigation

if has("nvim") && !has("gui_running")      " won't be in tmux if GUI, and nvim only
    if !empty($TMUX)
        let g:tmux_navigator_no_mappings = 1
        nnoremap <silent> <C-w>h :TmuxNavigateLeft<cr>
        nnoremap <silent> <C-w>j :TmuxNavigateDown<cr>
        nnoremap <silent> <C-w>k :TmuxNavigateUp<cr>
        nnoremap <silent> <C-w>l :TmuxNavigateRight<cr>
        nnoremap <silent> <C-w>\ :TmuxNavigatePrevious<cr>

        " no nvim in WSL due to move to newer glibc
        if g:in_wsl == 0
            tnoremap <silent> <C-w>h :TmuxNavigateLeft<cr>
            tnoremap <silent> <C-w>j :TmuxNavigateDown<cr>
            tnoremap <silent> <C-w>k :TmuxNavigateUp<cr>
            tnoremap <silent> <C-w>l :TmuxNavigateRight<cr>
            tnoremap <silent> <C-w>\ :TmuxNavigatePrevious<cr>
        endif
    endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" WSL yank support

if g:in_wsl == 1
    let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
    if executable(s:clip)
        augroup WSLYank
            autocmd!
            autocmd TextYankPost * if v:event.operator ==# 'y' | call system('cat |' . s:clip, @0) | endif
        augroup END
    endif
endif

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
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !has ("macunix")
    nmap <leader>mn  :call ToggleShowMenu()<CR>
endif

" ** Alt keys : NOTE: F, E, T, Y, B, and N are used for menu access! **

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

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
nmap <leader>he    :Vinarise<CR>
nmap <leader>hg    :echo synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name")<CR>
nmap <leader>hi    :echo synIDattr(synID(line("."),col("."),1),"name")<CR>
nmap <leader>hl    :set hls!<CR>:set hls?<CR>
nmap <leader>hw    :call AutoHighlightToggle()<CR>
nmap <leader>gf    :set guifont=*
nmap <leader>im    :call DisplayImage()<CR>
nmap <leader>in    :Info <cword><CR>

nmap <leader>nm           :call ToggleLineNumbers()<CR>
nmap <leader>ru           0O....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8

nmap <leader>sc           :call ToggleShowMenu()<CR>
nmap <leader>sh           :runtime after/usr/macros/vimsh/vimsh.vim<CR>
nmap <leader>cm           :runtime after/usr/macros/vc/vc.vim<CR>
nmap <silent> <leader>vc  :call VimCommanderToggle()<CR>
