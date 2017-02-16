function! XcodeClean()
    silent execute ':!osascript -e "tell application \"Xcode\"" -e "Clean" -e "end tell"'
endfunction
command! -complete=command XcodeClean call XcodeClean()

function! XcodeDebug()
    silent execute ':!osascript -e "tell application \"Xcode\"" -e "Debug" -e "end tell"'
endfunction
command! -complete=command XcodeDebug call XcodeDebug()

if globpath(expand('<afile>:p:h'), '*.xcodeproj') != '' |
    setl makeprg=open\ -a\ xcode\ &&\ osascript\ -e\ 'tell\ app\ \"Xcode\"\ to\ build'
endif

" Command-K cleans the project
noremap <D-k> :XcodeClean<CR>

" Command-Return cleans the project
noremap <D-CR> :XcodeDebug<CR>
