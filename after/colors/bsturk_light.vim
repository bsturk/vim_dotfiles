hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "bms_light"

hi Directory      term=bold                                    ctermfg=DarkGreen                                                guifg=#00c000
hi ErrorMsg       term=standout                                ctermfg=White          ctermbg=Red                               guifg=Black            guibg=Red
hi IncSearch      term=reverse           cterm=reverse                                                      gui=reverse                                guibg=darkgreen
hi ModeMsg        term=bold              cterm=bold                                                         gui=bold              
hi MoreMsg        term=bold                                    ctermfg=DarkGreen                            gui=bold            guifg=SeaGreen
hi NonText        term=bold                                    ctermfg=Blue                                 gui=bold            guifg=yellow
hi Question       term=standout                                ctermfg=DarkGreen                            gui=bold            guifg=SeaGreen
hi SpecialKey     term=bold                                    ctermfg=DarkBlue                                                 guifg=Blue
hi StatusLine     term=bold,reverse      cterm=bold            ctermfg=Yellow         ctermbg=DarkBlue      gui=none            guifg=lawngreen        guibg=royalblue4
hi StatusLineNC   term=reverse           cterm=reverse         ctermfg=Black          ctermbg=DarkGreen                         guifg=lightblue        guibg=darkblue
hi Title          term=bold                                    ctermfg=DarkMagenta                          gui=bold            guifg=darkgrey         guibg=black
hi Visual         term=standout          cterm=reverse         ctermfg=DarkMagenta                          gui=reverse         guifg=#E7E7FF          guibg=fg
hi VisualNOS      term=bold,underline    cterm=bold,underline                                               gui=bold,underline  guifg=DarkBlue         guibg=springgreen
hi WarningMsg     term=standout                                ctermfg=DarkRed                                                  guifg=Black            guibg=green
hi WildMenu       term=standout                                ctermfg=DarkRed        ctermbg=DarkBlue                          guifg=Black            guibg=Yellow
hi LineNr         term=underline                               ctermfg=DarkYellow                                               guifg=black            guibg=darkgrey
hi Normal                                                      ctermfg=Black          ctermbg=White                             guifg=black            guibg=white
hi Search         term=reverse                                                        ctermbg=DarkCyan                                                 guibg=#c0c000
hi Comment        term=bold                                    ctermfg=DarkGrey                             gui=none            guifg=#CC0000
hi Constant       term=underline                               ctermfg=Yellow                               gui=none            guifg=#FF00CC
hi Special        term=bold                                    ctermfg=Red                                                      guifg=#02B902
hi Identifier     term=underline                               ctermfg=DarkYellow                                               guifg=#00c0c0
hi Statement      term=bold                                    ctermfg=DarkCyan                             gui=bold            guifg=#0099FF
hi PreProc        term=underline                               ctermfg=Green                                                    guifg=#009966
hi Type           term=underline                               ctermfg=DarkGreen                                                guifg=#006699
hi Ignore                                                      ctermfg=White                                                    guifg=bg
hi Error          term=reverse                                 ctermfg=White          ctermbg=Blue                              guifg=White            guibg=Red
hi Todo           term=standout                                ctermfg=DarkRed        ctermbg=DarkCyan                          guifg=#000080          guibg=#c0c000
hi Folded         term=standout                                ctermfg=DarkRed        ctermbg=DarkCyan                          guifg=#FF8400                       
hi FoldColumn     term=standout                                ctermfg=DarkRed        ctermbg=DarkCyan                          guifg=#FFFFE0
hi Label                                                                                                                        guifg=magenta
hi Operator                                                                                                 gui=none            guifg=#FF8400
hi Cursor                                                                                                                       guifg=bg               guibg=LightGreen

hi javaExternal   term=none                                    ctermfg=Green                                                    guifg=#009966
hi javaDocTags    term=bold                                    ctermfg=Red                                                      guifg=#02B902
hi javaDocComment term=bold                                    ctermfg=DarkGrey                             gui=none            guifg=#6600CC
hi javaType       term=none                                    ctermfg=DarkGreen                                                guifg=#0099FF
hi javaPunct      gui=bold            guifg=black
hi javaNumber     term=none                                    ctermfg=Yellow                               gui=none            guifg=#00FFFF
hi javaLangClass  term=none                                    ctermfg=Yellow                               gui=none            guifg=#0000FF

set guicursor=n:block-nCursor-blinkwait300-blinkon200-blinkoff150
set guicursor=i:ver30-iCursor-blinkwait300-blinkon200-blinkoff150
set guicursor=v:block-vCursor-blinkwait300-blinkon200-blinkoff150
set guicursor=c:block-cCursor-blinkwait300-blinkon200-blinkoff150
set guicursor=r:hor10-rCursor-blinkwait300-blinkon200-blinkoff150
set guicursor=ci:ver30-ciCursor-blinkwait300-blinkon200-blinkoff150
set guicursor=cr:ver30-crCursor-blinkwait300-blinkon200-blinkoff150
set guicursor=sm:ver30-smCursor-blinkwait300-blinkon200-blinkoff150
set guicursor=o:ver30-oCursor-blinkwait300-blinkon200-blinkoff150

hi nCursor      gui=reverse                  guifg=green            guibg=bg
hi iCursor      gui=reverse                  guifg=orange           guibg=bg 
hi vCursor      gui=reverse                  guifg=magenta          guibg=bg 
hi cCursor      gui=reverse                  guifg=red              guibg=bg 
hi rCursor      gui=reverse                  guifg=turquoise        guibg=bg 
hi ciCursor     gui=reverse                  guifg=blue             guibg=bg
hi crCursor     gui=reverse                  guifg=red              guibg=bg
hi smCursor     gui=reverse                  guifg=blue             guibg=bg
hi oCursor      gui=reverse                  guifg=darkblue         guibg=bg 
