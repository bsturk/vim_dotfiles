" header_switch.vim
"
" Author: bsturk@comcast.net
"
" Heavily modified from one I found on the web, if you're the
" original author please tell me your name so I can give you credit.
"
" This version will check and resolve a matching include/cpp file for the other in
" this manner/order:
"
" Suggestions, etc welcomed!

"   -> already opened in same directory             i.e ~/foo.h  ~/foo.cpp
"   -> not opened but in the same directory         i.e ~/foo.h  ~/foo.cpp
"   -> in your 'path'
"   -> already loaded but in different dir ( with warning )
"
"   turn g:debug = 1 to see verbose printouts of what's happening
"

""""""""""""""

let g:debug=0

func! Decho(...)
    if g:debug
        echo a:1
    endif
endfunc

""""""""""""""

func! SwitchCH()
    let currentExtension        = expand("%:e")
    let currentFileWOExt        = expand("%:r")
    let currentFileWOExtNorPath = expand("%:t:r")

    call Decho ("current extension is " . currentExtension)

    if currentExtension == "cpp" || currentExtension == "CPP" || currentExtension == "c" || currentExtension == "C"
        " already opened in same directory
        if bufexists(currentFileWOExt . ".h")
            call Decho ("already opened")
            exec "buffer " . currentFileWOExtNorPath . ".h"
        elseif bufexists(currentFileWOExt . ".H")
            call Decho ("already opened")
            exec "buffer " . currentFileWOExtNorPath . ".H"

        " not opened but in same directory
        elseif filereadable(currentFileWOExt . ".h")
            call Decho ("not opened but in same dir")
            exec "e " . currentFileWOExt . ".h"
        elseif filereadable(currentFileWOExt . ".H")
            call Decho ("not opened but in same dir")
            exec "e " . currentFileWOExt . ".H"

        else
            call Decho ("checking path")
            " in 'path'?
            " Any way to use :find here??
            let match = globpath(&path, currentFileWOExtNorPath . ".h")

            if match == ""
                let match = globpath(&path, currentFileWOExtNorPath . ".H")
            endif

            if match != ""
                call Decho ("found " . match . " in path")
                exec "e " . match
                return
            endif

            call Decho ("checking for same name with correct ext")

            " already loaded but from different dir than .
            " TODO: could cause problems if more than one file with
            " exact same name in different dir

            if bufexists(currentFileWOExtNorPath . ".h")
                call Decho ("already opened but no path in filename")
                exec "buffer " . currentFileWOExtNorPath . ".h"
            elseif bufexists(currentFileWOExtNorPath . ".H")
                call Decho ("already opened but no path in filename")
                exec "buffer " . currentFileWOExtNorPath . ".H"

            " try matching filename in any path and ends in .[hH]
            else
                let i = 1
                while i <= bufnr ("$")
                    let name_only = expand("#" . i . ":t:r")
                    call Decho ("checking for " . name_only)

                    if name_only == currentFileWOExtNorPath 
                        call Decho ("found a match!")
                        let extension = expand("#" . i . ":e")

                        call Decho ("extension is " . extension)
                        if extension == "h" || extension == "H"
                            echo "** Found same filename ending in " . extension . " but in different dir **"
                            exec "buffer " . i
                            break
                        endif
                    endif

                    let i = i + 1
                endwhile
            endif
        endif

    elseif currentExtension == "h" || currentExtension == "H"
        " already opened in same directory
        if bufexists(currentFileWOExt . ".cpp")
            call Decho ("already opened")
            exec "buffer " . currentFileWOExtNorPath . ".cpp"
        elseif bufexists(currentFileWOExt . ".CPP")
            call Decho ("already opened")
            exec "buffer " . currentFileWOExtNorPath . ".CPP"
        elseif bufexists(currentFileWOExt . ".c")
            call Decho ("already opened")
            exec "buffer " . currentFileWOExtNorPath . ".c"
        elseif bufexists(currentFileWOExt . ".C")
            call Decho ("already opened")
            exec "buffer " . currentFileWOExtNorPath . ".C"

        " not opened but in same directory
        elseif filereadable(currentFileWOExt . ".cpp")
            call Decho ("not opened but in same dir")
            exec "e " . currentFileWOExt . ".cpp"
        elseif filereadable(currentFileWOExt . ".CPP")
            call Decho ("not opened but in same dir")
            exec "e " . currentFileWOExt . ".CPP"
        elseif filereadable(currentFileWOExt . ".c")
            call Decho ("not opened but in same dir")
            exec "e " . currentFileWOExt . ".c"
        elseif filereadable(currentFileWOExt . ".C")
            call Decho ("not opened but in same dir")
            exec "e " . currentFileWOExt . ".C"

        else
            " in 'path'?
            " Any way to use :find here??

            call Decho ("checking path")
            let match = globpath(&path, currentFileWOExtNorPath . ".cpp")

            if match == ""
                let match = globpath(&path, currentFileWOExtNorPath . ".c")
            endif

            if match == ""
                let match = globpath(&path, currentFileWOExtNorPath . ".CPP")
            endif

            if match == ""
                let match = globpath(&path, currentFileWOExtNorPath . ".C")
            endif

            if match != ""
                call Decho ("found " . match . " in path")
                exec "e " . match
                return
            endif

            call Decho ("checking for same name with correct ext")

            " already loaded but from different dir than .
            " TODO: could cause problems if more than one file with
            " exact same name in different dir

            if bufexists(currentFileWOExtNorPath . ".cpp")
                call Decho ("already opened but no path in filename")
                exec "buffer " . currentFileWOExtNorPath . ".cpp"
            elseif bufexists(currentFileWOExtNorPath . ".c")
                call Decho ("already opened but no path in filename")
                exec "buffer " . currentFileWOExtNorPath . ".c"
            elseif bufexists(currentFileWOExtNorPath . ".CPP")
                call Decho ("already opened but no path in filename")
                exec "buffer " . currentFileWOExtNorPath . ".CPP"
            elseif bufexists(currentFileWOExtNorPath . ".C")
                call Decho ("already opened but no path in filename")
                exec "buffer " . currentFileWOExtNorPath . ".C"

            " try matching filename in any path and ends in .[cpp/CPP/c/C]
            else
                let i = 1
                while i <= bufnr ("$")
                    let name_only = expand("#" . i . ":t:r" )
                    call Decho ("checking for " . name_only)

                    if name_only == currentFileWOExtNorPath 
                    call Decho ("found a match!")
                        let extension = expand("#" . i . ":e")
                        call Decho ("extension is " . extension)

                        if extension == "cpp" || extension == "c" || extension == "CPP" || extension == "C" 
                            echo "** Found same filename ending in " . extension . " but in different dir **"
                            exec "buffer " . i
                            break
                        endif
                    endif

                    let i = i + 1
                endwhile
            endif
        endif
    endif
endfunc
