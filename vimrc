" ========================================================================
" Vundle stuff
" ========================================================================
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle (required)!
Bundle 'gmarik/vundle'

" My bundles
Bundle 'tpope/vim-pathogen'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-bundler'
Bundle 'ecomba/vim-ruby-refactoring'
Bundle 'vim-ruby/vim-ruby'
Bundle 'kien/ctrlp.vim'
Bundle 'ack.vim'
"
" Use Pathogen:
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

let ackprg = 'ag --column --nocolor --ignore log'
set grepprg=ag\ --column\ --nocolor\ --ignore\ log'

set nonumber
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
set showmode
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
set nospell
set spellfile=~/.vim-spell.utf.add
set gdefault
set noesckeys
set nofoldenable
set noequalalways
command! Q q 

" Educate myself
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

let g:ctrlp_max_height = 15
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_reversed = 0

let mapleader = ","
nmap <Leader>bi :source ~/.vimrc<cr>:BundleInstall<cr>
map <Leader>o :call RunCurrentLineInTest()<CR>
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
map <Leader>t :call RunCurrentTest()<CR>
map <Leader>a :AS<CR>
map <Leader>n :call RenameFile()<cr>
let mapleader = "\\"

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Test-running stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RunCurrentTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFile()

    if match(expand('%'), '\.feature$') != -1
      call SetTestRunner("!cucumber")
      exec g:bjo_test_runner g:bjo_test_file
    elseif match(expand('%'), '_spec\.rb$') != -1
      call SetTestRunner("!rspec")
      exec g:bjo_test_runner g:bjo_test_file
    else
      call SetTestRunner("!ruby -Itest")
      exec g:bjo_test_runner g:bjo_test_file
    endif
  else
    exec g:bjo_test_runner g:bjo_test_file
  endif
endfunction

function! SetTestRunner(runner)
  let g:bjo_test_runner=a:runner
endfunction

function! RunCurrentLineInTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFileWithLine()
  end

  exec "!rspec" g:bjo_test_file . ":" . g:bjo_test_file_line
endfunction

function! SetTestFile()
  let g:bjo_test_file=@%
endfunction

function! SetTestFileWithLine()
  let g:bjo_test_file=@%
  let g:bjo_test_file_line=line(".")
endfunction

function! CorrectTestRunner()
  if match(expand('%'), '\.feature$') != -1
    return "cucumber"
  elseif match(expand('%'), '_spec\.rb$') != -1
    return "rspec"
  else
    return "ruby"
  endif
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  filetype plugin indent on
    " Detect Perforce files
    au BufRead,BufNewFile /tmp/tmp.\d\+.\d\+ set filetype=p4spec
    au BufNewFile,BufRead  /tmp/mutt* source ~/.vim/mutt
    au BufNewFile,BufRead  [Mm]akefile* set nosmarttab
    au BufReadPre */src/*  set patchmode=.orig
    au BufReadPre /var/log/* set nowrap
    au BufReadPre *.log set nowrap
    au BufReadPre */usr/ports/*  set patchmode=.orig
  endif " has("autocmd")

" this function remaps <CR> to __go
" __go unmaps <CR> and calls "gf" (go file)
function! MapCR()
  map <CR> __go
  map __go :unmap <CR>gf:cd %:h
endf

" The famous vim-shell
map __start :imap  __cmd|imap  __end
noremap __end :iunmap <CR>|iunmap :"Vish ended.0f!xx
noremap __cmd 0f$ly$:r !";echo $PS1A 
noremap __scmd :r !echo $PS1A 
map ,S __start__scmd

" vim: set ft=vim : nospell
