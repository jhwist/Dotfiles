"
" ========================================================================
" Vundle stuff
" ========================================================================
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle (required)!
Bundle 'gmarik/vundle'
"
" My bundles
Bundle 'tpope/vim-pathogen'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-unimpaired'
Bundle 'vim-ruby/vim-ruby'
Bundle 'wincent/Command-T'
"
" Use Pathogen:
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


set nocompatible
set nobackup
set modeline
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set noincsearch
set nohlsearch
set autoindent
set cindent
set showmatch
set showcmd
set visualbell
set nowrap
set langmenu=en
lang C
set expandtab
set shiftwidth=2
set laststatus=2
set wrapscan
set autowrite
set spell
set spellfile=~/.vim-spell.utf.add

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  filetype plugin indent on
endif " has("autocmd")

" this function remaps <CR> to __go
" __go unmaps <CR> and calls "gf" (go file)
function! MapCR()
  map <CR> __go
  map __go :unmap <CR>gf:cd %:h
endf

" vim: set ft=vim :
