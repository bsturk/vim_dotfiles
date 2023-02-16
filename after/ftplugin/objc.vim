runtime usr/devgen.vim
runtime usr/ccom.vim
runtime usr/cdev.vim

if has("mac") || has("macunix")
    runtime after/usr/xcode.vim
endif

let b:match_words = '@\(implementation\|interface\):@end'
setl inc=^\s*#\s*import omnifunc=objc#cocoacomplete#Complete

set define=^\(#\s*define\|[a-z]*\s*const\s*[a-z]*\)

noremap <leader>hf   :call FSwitch('%', '')<CR>

iab #i      #import
iab @i      @interface
iab @I      @implementation
iab @e      @end
iab zp      @public
iab zP      @protected
