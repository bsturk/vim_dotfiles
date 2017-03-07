" objc_header_switch.vim
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

    if currentExtension == "m" || currentExtension == "M"

        " already opened in same directory
        if bufexists(currentFileWOExt . ".hh")
            call Decho ("already opened")
            exec "buffer " . currentFileWOExtNorPath . ".hh"
        elseif bufexists(currentFileWOExt . ".HH")
            call Decho ("already opened")
            exec "buffer " . currentFileWOExtNorPath . ".HHH"

        " not opened but in same directory
        elseif filereadable(currentFileWOExt . ".hh")
            call Decho ("not opened but in same dir")
            exec "e " . currentFileWOExt . ".hh"
        elseif filereadable(currentFileWOExt . ".HH")
            call Decho ("not opened but in same dir")
            exec "e " . currentFileWOExt . ".HH"

        else
            call Decho ("checking path")
            " in 'path'?
            " Any way to use :find here??
            let match = globpath(&path, currentFileWOExtNorPath . ".hh")

            if match == ""
                let match = globpath(&path, currentFileWOExtNorPath . ".HH")
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

            if bufexists(currentFileWOExtNorPath . ".hh")
                call Decho ("already opened but no path in filename")
                exec "buffer " . currentFileWOExtNorPath . ".hh"
            elseif bufexists(currentFileWOExtNorPath . ".HH")
                call Decho ("already opened but no path in filename")
                exec "buffer " . currentFileWOExtNorPath . ".HH"

            " try matching filename in any path and ends in .[hh|HH]
            else
                let i = 1
                while i <= bufnr ("$")
                    let name_only = expand("#" . i . ":t:r")
                    call Decho ("checking for " . name_only)

                    if name_only == currentFileWOExtNorPath 
                        call Decho ("found a match!")
                        let extension = expand("#" . i . ":e")

                        call Decho ("extension is " . extension)
                        if extension == "hh" || extension == "HH"
                            echo "** Found same filename ending in " . extension . " but in different dir **"
                            exec "buffer " . i
                            break
                        endif
                    endif

                    let i = i + 1
                endwhile
            endif
        endif

    elseif currentExtension == "hh" || currentExtension == "HH"
        " already opened in same directory
        if bufexists(currentFileWOExt . ".m")
            call Decho ("already opened")
            exec "buffer " . currentFileWOExtNorPath . ".m"
        elseif bufexists(currentFileWOExt . ".M")
            call Decho ("already opened")
            exec "buffer " . currentFileWOExtNorPath . ".M"

        " not opened but in same directory
        elseif filereadable(currentFileWOExt . ".m")
            call Decho ("not opened but in same dir")
            exec "e " . currentFileWOExt . ".m"
        elseif filereadable(currentFileWOExt . ".M")
            call Decho ("not opened but in same dir")
            exec "e " . currentFileWOExt . ".M"

        else
            " in 'path'?
            " Any way to use :find here??

            call Decho ("checking path")
            let match = globpath(&path, currentFileWOExtNorPath . ".m")

            if match == ""
                let match = globpath(&path, currentFileWOExtNorPath . ".M")
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

            if bufexists(currentFileWOExtNorPath . ".m")
                call Decho ("already opened but no path in filename")
                exec "buffer " . currentFileWOExtNorPath . ".m"
            elseif bufexists(currentFileWOExtNorPath . ".M")
                call Decho ("already opened but no path in filename")
                exec "buffer " . currentFileWOExtNorPath . ".M"

            " try matching filename in any path and ends in .[m/M]
            else
                let i = 1
                while i <= bufnr ("$")
                    let name_only = expand("#" . i . ":t:r" )
                    call Decho ("checking for " . name_only)

                    if name_only == currentFileWOExtNorPath 
                    call Decho ("found a match!")
                        let extension = expand("#" . i . ":e")
                        call Decho ("extension is " . extension)

                        if extension == "m" || extension == "M"
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
