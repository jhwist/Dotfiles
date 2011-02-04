version 6.0
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
set cpoptions=aABceFs$
set guioptions=-m
map! <S-Insert> *
imap <silent> <Plug>IMAP_JumpBack =IMAP_Jumpfunc('b', 0)
imap <silent> <Plug>IMAP_JumpForward =IMAP_Jumpfunc('', 0)
vmap <NL> <Plug>IMAP_JumpForward
nmap <NL> <Plug>IMAP_JumpForward
map Q gq
nmap gx <Plug>NetrwBrowseX
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
vmap <silent> <Plug>IMAP_JumpBack `<i=IMAP_Jumpfunc('b', 0)
vmap <silent> <Plug>IMAP_JumpForward i=IMAP_Jumpfunc('', 0)
vmap <silent> <Plug>IMAP_DeleteAndJumpBack "_<Del>i=IMAP_Jumpfunc('b', 0)
vmap <silent> <Plug>IMAP_DeleteAndJumpForward "_<Del>i=IMAP_Jumpfunc('', 0)
nmap <silent> <Plug>IMAP_JumpBack i=IMAP_Jumpfunc('b', 0)
nmap <silent> <Plug>IMAP_JumpForward i=IMAP_Jumpfunc('', 0)
imap <NL> <Plug>IMAP_JumpForward
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set backspace=2
set showmatch
set showmode
set nohlsearch
set ai
set ts=2
set sw=2
set fileencodings=ucs-bom,utf-8,default
set wrap
set laststatus=2
set viminfo='20,\"1000,n~/.vim/viminfo
set mouse=a
set mousemodel=popup
set ruler
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.info,.aux,.log,.dvi,.bbl,.out,.o,.lo
set termencoding=utf-8
set window=39
filetype indent on
"Minibuffer Explorer Settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
" alt+n or alt+p to navigate between entries in QuickFix
map <silent> <m-p> :cp <cr>
map <silent> <m-n> :cn <cr>


"autocmd BufNewFile,BufRead  *.tex source ~/.vim/tex
autocmd BufNewFile,BufRead *_spec.rb compiler rspec
autocmd BufNewFile,BufRead  /tmp/mutt* source ~/.vim/mutt
autocmd BufNewFile,BufRead  *article* source ~/.vim/mutt
autocmd BufNewFile,BufRead  *letter* source ~/.vim/mutt
autocmd BufNewFile,BufRead  [Mm]akefile* set nosmarttab
autocmd BufReadPre */src/*  set patchmode=.orig
autocmd BufReadPre /var/log/* set nowrap
autocmd BufReadPre *.log set nowrap
autocmd BufReadPre */usr/ports/*  set patchmode=.orig
autocmd! BufReadPre,FileReadPre   *.gz set bin
autocmd  BufReadPost,FileReadPost *.gz '[,']!gunzip
autocmd  BufReadPost,FileReadPost *.gz set nobin
map __start :imap  __cmd|imap  __end
noremap __end :iunmap <CR>|iunmap :"Vish ended.0f!xx
noremap __cmd 0f$ly$:r !";echo $PS1A 
noremap __scmd :r !echo $PS1A 
map ,S __start__scmd

" latexsuite
sy on
let g:tex_fold_enabled=1
filetype plugin on
set grepprg=grep\ -nH\ $*

" The Attach me mode.
map __a_start :imap <C-V><CR> <C-O>__a_cmd\|imap <C-V><ESC> <C-V><ESC>__a_end\|imap <C-V><C-V><C-V><C-I> <C-V><C-N>\|imap <C-V><C-N> <C-V><C-X><C-V><C-F><CR> 
noremap __a_end :iunmap <C-V><CR>\|iunmap <C-V><ESC>\|iunmap <C-V><C-V><C-V><C-I>\|iunmap <C-V><C-V><C-V><C-N><CR>dd`a:"Attach mode ended.<CR>
noremap __a_cmd oAttach:<Space>
noremap __a_scmd 1G/^$/<CR>:noh<CR>OAttach:<Space>
map ,a ma__a_start__a_scmd
" vim: set ft=vim :
