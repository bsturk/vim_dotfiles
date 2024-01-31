"" ----- delphi plugin overrides ----- 

" this prevents leading whitespace from being red
autocmd FileType delphi syntax clear delphiSpaceError

" sets mouse=a and that interferes with basic select/copy/paste in a terminal
" reset to my values again

set mouse=
set mousehide 

"" ----- unknown plugin or lazy framework ----- 

" set again since it blows this away
" reset to my values again

set runtimepath+=$VIMHOME
set runtimepath+=$VIMHOME/after

autocmd FileType * set colorcolumn=0
