" Perforce spec filetype
"
" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

function! PrepareDescription()
    exec "/Description:$"
    exec "normal j2l"
    exec "normal 4l"
endfunction

setlocal nospell
setlocal noautoindent
setlocal nocindent
setlocal nosmartindent
setlocal shiftwidth=2
noremap C C<tab>
call PrepareDescription()
