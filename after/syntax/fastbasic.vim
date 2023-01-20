" Vim syntax file
" Language:	FastBasic (Atari 800)
" Maintainer:	Brian M Sturk
" Last Change:  07/05/22

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn keyword basicFunction ABS abs
syn keyword basicFunction ADR adr
syn keyword basicFunction ASC asc
syn keyword basicFunction ATN atn
syn keyword basicFunction CHR$ chr$
syn keyword basicFunction CLOAD cload
syn keyword basicFunction CLOG clog
syn keyword basicFunction CLOSE close
syn keyword basicFunction CLR clr
syn keyword basicFunction COLOR color
syn keyword basicFunction COM com
syn keyword basicFunction CONT cont
syn keyword basicFunction COS cos
syn keyword basicFunction CSAVE csave
syn keyword basicFunction DATA data
syn keyword basicFunction DEG deg
syn keyword basicFunction DOS dos
syn keyword basicFunction DPEEK dpeek
syn keyword basicFunction DRAWTO drawto
syn keyword basicFunction ENTER enter
syn keyword basicFunction ERR err
syn keyword basicFunction EXP exp
syn keyword basicFunction EXP10 exp10
syn keyword basicFunction FRE fre
syn keyword basicFunction GET get
syn keyword basicFunction GRAPHICS graphics
syn keyword basicFunction INPUT input
syn keyword basicFunction INT int
syn keyword basicFunction KEY key
syn keyword basicFunction LEN len
syn keyword basicFunction LETLIST letlist
syn keyword basicFunction LOAD load
syn keyword basicFunction LOCATE locate
syn keyword basicFunction LOG log
syn keyword basicFunction LOG10 log10
syn keyword basicFunction LPRINT lprint
syn keyword basicFunction NOTE note
syn keyword basicFunction OPEN open
syn keyword basicFunction PADDLE paddle
syn keyword basicFunction PEEK peek
syn keyword basicFunction PLOT plot
syn keyword basicFunction PMADR pmadr
syn keyword basicFunction POINT point
syn keyword basicFunction POKE poke
syn keyword basicFunction POP pop
syn keyword basicFunction POSITION position
syn keyword basicFunction PRINT print
syn keyword basicFunction PTRIG ptrig
syn keyword basicFunction PUT put
syn keyword basicFunction RAND rand
syn keyword basicFunction RAD rad
syn keyword basicFunction READ read
syn keyword basicFunction RESTORE restore
syn keyword basicFunction RND rnd
syn keyword basicFunction SAVE save
syn keyword basicFunction SETCOLOR setcolor
syn keyword basicFunction SGN sgn
syn keyword basicFunction SIN sin
syn keyword basicFunction SOUND sound
syn keyword basicFunction SQR sqr
syn keyword basicFunction STATUS status
syn keyword basicFunction STICK stick
syn keyword basicFunction STRIG strig
syn keyword basicFunction STR$ str$
syn keyword basicFunction TIME time
syn keyword basicFunction USR usr
syn keyword basicFunction VAL val
syn keyword basicFunction XIO xio

syn keyword basicStorage  DIM dim
syn keyword basicStorage  BYTE byte
syn keyword basicStorage  WORD word

syn keyword basicConditional AND and
syn keyword basicConditional BYE bye
syn keyword basicConditional DO do
syn keyword basicConditional ELIF elif
syn keyword basicConditional ELSE else
syn keyword basicConditional END end
syn keyword basicConditional ENDIF endif
syn keyword basicConditional ENDPROC endproc
syn keyword basicConditional EXIT exit
syn keyword basicConditional FOR for
syn keyword basicConditional GOSUB gosub
syn keyword basicConditional GO TO go to
syn keyword basicConditional GOTO goto
syn keyword basicConditional IF if
syn keyword basicConditional LOOP loop
syn keyword basicConditional NEW new
syn keyword basicConditional NEXT next
syn keyword basicConditional NOT not
syn keyword basicConditional ON on
syn keyword basicConditional OR or
syn keyword basicConditional PROC proc
syn keyword basicConditional REPEAT repeat
syn keyword basicConditional RETURN return
syn keyword basicConditional RUN run
syn keyword basicConditional STEP step
syn keyword basicConditional STOP stop
syn keyword basicConditional THEN then
syn keyword basicConditional TO to
syn keyword basicConditional TRAP trap
syn keyword basicConditional UNTIL until
syn keyword basicConditional WEND wend
syn keyword basicConditional WHILE while

syn keyword basicSpecial BGET bget
syn keyword basicSpecial BPUT bput
syn keyword basicSpecial DEC dec
syn keyword basicSpecial DLI dli
syn keyword basicSpecial DPOKE dpoke
syn keyword basicSpecial EXEC exec
syn keyword basicSpecial FCOLOR fcolor
syn keyword basicSpecial FILLTO fillto
syn keyword basicSpecial INC inc
syn keyword basicSpecial MOVE move
syn keyword basicSpecial MSET mset
syn keyword basicSpecial PAUSE pause
syn keyword basicSpecial PMGRAPHICS pmgraphics
syn keyword basicSpecial PMHPOS pmhpos
syn keyword basicSpecial TIMER timer

syn keyword basicTodo contained	TODO NOTE

"integer number, or floating point number without a dot.
syn match  basicNumber		"\<\d\+\>"

"floating point number, with dot
syn match  basicNumber		"\<\d\+\.\d*\>"

"floating point number, starting with a dot
syn match  basicNumber		"\.\d\+\>"

syn match   basicMathsOperator "-\|=\|[:<>+\*^/\\]\|AND\|OR"

syn region  basicLabel	start="^[a-zA-Z]" end="$"
syn region  basicString	 start=+"+ skip=+\\\\\|\\"+ end=+"+

syn region  basicComment	start="REM" end="$" contains=basicTodo
syn match   basicComment         '\'.*$'
syn match   basicComment         '\..*$'
syn region  basicLineNumber	start="^\d" end="\s"
syn match   basicTypeSpecifier  "[a-zA-Z0-9][\$%&!#]"ms=s+1

syn match   basicFilenumber    "#\d\+"

" Define the default highlighting.
" Only when an item doesn't have highlighting yet

hi def link basicLabel		Label
hi def link basicStorage	StorageClass
hi def link basicConditional	Conditional
hi def link basicRepeat		Repeat
hi def link basicLineNumber	Comment
hi def link basicNumber		Number
hi def link basicError		Error
hi def link basicStatement	Statement
hi def link basicString		String
hi def link basicComment	Comment
hi def link basicSpecial	Special
hi def link basicTodo		Todo
hi def link basicFunction	Identifier
hi def link basicTypeSpecifier  Type
hi def link basicFilenumber     basicTypeSpecifier

let b:current_syntax = "fastbasic"

let &cpo = s:cpo_save
unlet s:cpo_save
" vim: ts=8
