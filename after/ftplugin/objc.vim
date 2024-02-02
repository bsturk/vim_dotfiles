runtime usr/devgen.vim
runtime usr/ccom.vim

let b:match_words = '@\(implementation\|interface\):@end'
setl inc=^\s*#\s*import omnifunc=objc#cocoacomplete#Complete

set define=^\(#\s*define\|[a-z]*\s*const\s*[a-z]*\)

iab #i #import
iab @i @interface
iab @I @implementation
iab @e @end
iab zp @public
iab zP @protected
