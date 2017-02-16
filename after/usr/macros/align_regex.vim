" ====================================================================
" Just call :AlignRe with a quoted regular expression.
"
"    :%AlignRe =       will align the whole file on the '=' character
"   
"    This can also be done with visual selection
"
"       NOTE: "magic" must be escaped with "\\" that's *2*
"              
"       TODO: If any of the lines to match's regex is on column
"             1 it will not be indented
"              
"             i.e.
"             
"    ln 1     foo
"    ln 2       foo
"    ln 3     foo
"    ln 4           foo
"
"             being selected and running align on it will only align
"             lines 2 and 4.
"
" ====================================================================

fu! DoAlign(...) range
    let alignexp = input("Enter align regex (magic is already esc'ed)\n:")
    echo "\n"

    if (strlen( alignexp ) < 1)
        echo "No input given..."
        return
    endif

    let alignexp = escape( alignexp, ".*[^$" )

    let originaletvalue = &expandtab
    exe 'set et'
    exe a:firstline . "," . a:lastline . "retab"

    let originaicvalue = &ignorecase
    exe 'set noic'

    " can't figure out how to pass the a:firstline etc without this
    call AlignOnRE(a:firstline, a:lastline, alignexp)

    if ( originaletvalue == 0 )
       exe 'set noet'
       exe a:firstline . "," . a:lastline . "retab!"
    endif

    let &ignorecase = originaicvalue
endf

com! -range AlignRe <line1>,<line2>call AlignOnRE(<q-args>)
fun! AlignOnRE(...) range
    if (a:0 == 1)
        let firstline=a:firstline
        let lastline=a:lastline
        let regex="\"" . a:1 . "\""
    else
        let firstline=a:1
        let lastline=a:2
        let regex="\"" . a:3 . "\""
    endif

    let last = 0
    let i = firstline
    while i <= lastline
        exec "let col" . i . "= match(getline(i)," . regex . ")"
        exec 'if col' . i . '> last | let last = col' . i . '| endif'
        let i = i + 1
    endwhile
    let i = firstline
    while i <= lastline
        exec ' let col = col' . i
        if col >= 0
            let j = 1
            exec 'let N = last - col' . i
            let s = ""
            while j <= N
                let s = s . " "
                let j = j + 1
            endwhile
            let dots = strpart(getline(i), 0, col)
            let dots = substitute(dots, '.', '.', 'g')
            let str = substitute(getline(i), '^' . dots, '&' . s, '')
            call setline(i, str)
        endif
        let i = i + 1
    endwhile
endfun
