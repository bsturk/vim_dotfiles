runtime usr/devgen.vim
runtime usr/ccom.vim

set include=^#\s*import 
set includeexpr=substitute(v:fname,'\\.','/','g')

if !has("unix")
    set shellpipe=>\ %s\ 2>&1
endif

iab zb  boolean
iab zF  finally<CR>{<CR>}<Up><CR><C-R>=Eatchar(' ')<CR>
iab #i  import
iab #p  package
iab zpr System.out.println( );<C-O>2h
iab zS  static

let java_highlight_java_lang_ids=1
let java_allow_cpp_keywords=1
