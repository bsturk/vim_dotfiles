runtime usr/devgen.vim
runtime usr/ccom.vim

set define=^\(#\s*define\|[a-z]*\s*const\s*[a-z]*\)

iab #i #include
iab #d #define
iab #e #endif
iab zb bool
