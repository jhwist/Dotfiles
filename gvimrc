version 6.0
source ~/.vimrc
colorscheme desert

if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
let &cpo=s:cpo_save
unlet s:cpo_save
"lang en
syntax on
set columns=80
set lines=45
set background=dark
set guioptions=agirLm
set helplang=en
set langmenu=none
set window=44
"
" vim: set ft=vim :
