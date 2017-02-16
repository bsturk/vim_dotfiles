runtime after/usr/devgen.vim
runtime after/usr/ccom.vim
runtime after/usr/cdev.vim

if has("mac") || has("macunix")
    runtime after/usr/xcode.vim
endif

let b:match_words = '@\(implementation\|interface\):@end'
setl inc=^\s*#\s*import omnifunc=objc#cocoacomplete#Complete

set define=^\(#\s*define\|[a-z]*\s*const\s*[a-z]*\)

noremap <leader>hf   :call SwitchCH()<CR>

iab #i      #import
iab @i      @interface
iab @I      @implementation
iab @e      @end
iab zp      @public
iab zP      @protected

runtime after/usr/macros/objc_header_switch.vim
