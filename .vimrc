set autoindent 
set backspace=indent,eol,start
set backup 
set backupcopy=yes
set backupext=.bak
set belloff=all
set browsedir=current
set cmdheight=1
set cmdwinheight=2
set complete=.,w,u,b,i,d,t
set completeopt="menu,noinsert,noselect"
set confirm 
set cpoptions+=B
set expandtab
set guioptions=ia
set hidden 
set ignorecase 
set incsearch 
set laststatus=2
set matchpairs=(:),{:},[:],<:>
set matchtime=1
set modeline
set modelines=2
set noautowrite 
set noeol
set noerrorbells
set nofixeol
set nohlsearch
set nowrap 
set nowrapscan 
set pastetoggle=<C-<>
set ruler 
set rulerformat=%25(#%n\ %m%r%y\ %P\ <%l,%c%V>%)
set scroll=15
set sessionoptions=buffers,curdir,folds,globals,localoptions,options,winpos,winsize
set shiftwidth=4
set shortmess=aAoOtIc	" make messages fit into one line
set showcmd
set showmatch 
set showmode 
set smartcase 
set splitbelow
set splitright
set statusline=%<%F%m%=#%n\ %([%R]%)\ %([%Y]%)\ %P\ [%b\-0x%B]\ <%l,%c%V>
set suffixes+=\.zip,\.gz
set tabstop=4
set textwidth=80
set title
set titlelen=100
set titlestring=%<%F%m%r%=\ [\ %{getcwd()}\ ]\ -on-\ %{hostname()}
set updatecount=200
set whichwrap+=<,>,[,]                                                          
set wildignore=*.bak,*.~,*.obj,*.tmp,*.001,*.~mp,*.hlp,*.swp,*.def,*.class
set wildmenu 
"set wildmode=longest,list
set winaltkeys=menu

" disables any bell in vim
set visualbell
set t_vb=

if !has('nvim')
    set clipboard=unnamed,autoselect
    set ttymouse=
    set nocompatible    " NOTE: nvim is always nocompatible
endif

if has("autocmd")  " must be done first for some reason, this enables after/ftplugin stuff
    filetype plugin indent on
endif

if has("syntax") 
    syntax on
endif    

let MYTMP=$TMP

set runtimepath+=$VIMHOME
set runtimepath+=$VIMHOME/after
set packpath+=$VIMHOME

""""""""""""""""""""" START platform/env specific """""""""""""""""""""""""

" without this, it takes over a minute to start in docker

if $IN_DOCKER == 1
	set clipboard=
endif

let g:in_wsl = 0
set shell=bash

if has("unix")
    set diffopt-=internal       " UNIX platforms use external tool and may not have been compiled with support for internal diff
    set guioptions+=F
    set guifont=Monospace\ 10,Bitstream\ Vera\ Sans\ Mono\ 12,Monospace\ 8,Terminal\ 10,MiscFixed\ 8
    set encoding=utf8   " GTK likes this
    let $PAGER=''

    let MYTMP=$HOME . '/.tmp'  " I don't want these deleted on reboot, so not in /tmp

    " WSL check
	let uname = substitute(system('uname'),'\n','','')

	if uname == 'Linux'
		let lines = readfile("/proc/version")
		if lines[0] =~ "Microsoft"
            let g:in_wsl = 1
        endif
    endif
endif

if has ('win32') || has( 'win64' ) && has('gui_running')
    set shell=cmd.exe

    " point to my nvim-data dir on the server so there aren't duplicate
    " plugins or out of sync

    let $XDG_DATA_HOME = 'g:\.local\share'
endif    

if has ("macunix")
    set diffopt-=internal       " UNIX platforms use external tool and may not have been compiled with support for internal diff
	set clipboard=unnamed

    if !has('gui_running')
          set t_Co=256
    endif
endif

""""""""""""""""""""" END platform/env specific """""""""""""""""""""""""

let &backupdir=MYTMP . '/recover'   " backups
let &directory=MYTMP . '/recover'   " swap files

" bootstrap all of my stuff
runtime usr/functions.vim
runtime usr/norm.vim

if has('nvim') 
    runtime usr/init.lua
endif

" set again as some plugin blows this away
set runtimepath+=$VIMHOME
set runtimepath+=$VIMHOME/after

" these are done after plugins due to some plugins setting mouse=a
" these interfere with basic select/copy/paste

set mouse=
set mousehide 
