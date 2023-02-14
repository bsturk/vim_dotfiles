runtime after/usr/devgen.vim

set expandtab

iab z* ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
iab z/ ;;;;;;;;;;;;;

" slimv lisp IDE
let g:slimv_swank_cmd = '! tmux new-window -d -n REPL-SBCL "sbcl --load ~/.vim/pack/dev/start/slimv/slime/start-swank.lisp"'
