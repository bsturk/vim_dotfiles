set autoindent 
set backspace=indent,eol,start
set backup 
set backupcopy=yes
set backupext=.bak
set browsedir=current
set clipboard=unnamed,autoselect
set cmdheight=1
set cmdwinheight=2
set complete=.,w,u,b,i,d,t
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
set mousehide 
set noautowrite 
set nocompatible 
set noeol
if v:version >= 7.4.785
    set nofixeol
endif
set nohlsearch
set nowrap 
set nowrapscan 
set pastetoggle=<C-<>
set ruler 
set rulerformat=%25(#%n\ %m%r%y\ %P\ <%l,%c%V>%)
set runtimepath+=$MYVIM/after
set scroll=15
set sessionoptions=buffers,curdir,folds,globals,localoptions,options,winpos,winsize
set shiftwidth=4
set shortmess=aAoOtI	" make messages fit into one line
set showcmd
set showmatch 
set showmode 
set smartcase 
set splitbelow
set statusline=%<%F%m%=#%n\ %([%R]%)\ %([%Y]%)\ %P\ [%b\-0x%B]\ <%l,%c%V>
set suffixes+=\.zip,\.gz
set tabstop=4
set textwidth=80
set title
set titlelen=100
set titlestring=%<%F%m%r%=\ [\ %{getcwd()}\ ]\ -on-\ %{hostname()}
set updatecount=200
set viminfo='0,\"0,:40,n~/.viminfo
set whichwrap+=<,>,[,]                                                          
set wildignore=*.bak,*.~,*.obj,*.tmp,*.001,*.~mp,*.hlp,*.swp,*.def,*.class
set wildmenu 
"set wildmode=longest,list
set winaltkeys=menu
  
if has("unix")
    set shell=sh
    set guioptions+=F
    set guifont=Monospace\ 10,Bitstream\ Vera\ Sans\ Mono\ 12,Monospace\ 8,Terminal\ 10,MiscFixed\ 8
    set encoding=utf8   " GTK likes this
    let $PAGER=''

	set backupdir=~/.tmp/recover        " backups
	set directory=~/.tmp/recover        " swap files

    source ~/.vimrc-work

elseif has ("win32")
    set backupdir=$TMP/recover
    set directory=$TMP/recover

    if !(has("gui_running"))
        set shell=sh
    else
        set lines=90
        set columns=100
    endif

    source g:/.vimrc-work
endif    

if has ("macunix")
	set clipboard=unnamed

    if !has('gui_running')
          set t_Co=256
      endif
endif

if has("autocmd")  " must be done first for some reason
    filetype plugin indent on
endif

if has("syntax") 
    syntax on
endif    

" without this, it takes over a minute to start in docker
if $IN_DOCKER == 1
	set clipboard=
endif

" pathogen plugin manager
execute pathogen#infect()

colorscheme bsturk_dark
