" unmap the tmux stuff, it interfers with the vim bindings for the REPL

autocmd WinEnter * if bufname('%') =~ 'zepl' | unmap n <C-W>\
autocmd WinEnter * if bufname('%') =~ 'zepl' | unmap n <C-W>h
autocmd WinEnter * if bufname('%') =~ 'zepl' | unmap n <C-W>j
autocmd WinEnter * if bufname('%') =~ 'zepl' | unmap n <C-W>k
autocmd WinEnter * if bufname('%') =~ 'zepl' | unmap n <C-W>l
