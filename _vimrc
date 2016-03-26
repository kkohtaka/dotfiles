" Copyright (C) 2016 Kazumasa Kohtaka <kkohtaka@gmail.com> All right reserved

"""""""""""
" Generic "
"""""""""""

syntax on
set number

set smartindent
set autoindent
set cindent

set incsearch
set ignorecase
set smartcase
set hlsearch

set backspace=indent,eol,start

set showmatch

set expandtab
"set tabstop=2
"set shiftwidth=2
"set softtabstop=2
set tabstop=4
set shiftwidth=4
set softtabstop=4

set list
set listchars=tab:>.,trail:_

set history=100

set showmode

set scrolloff=12

colorscheme desert

""""""""""
" Vundle "
""""""""""

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'grarik/vundle'

Bundle 'kchmck/vim-coffee-script'
Bundle 'pangloss/vim-javascript'
Bundle 'godlygeek/tabular'
Bundle 'guileen/vim-node'
Bundle 'tpope/vim-markdown'
Bundle 'mattn/webapi-vim'
Bundle 'mattn/ideone-vim'
Bundle 'scrooloose/nerdtree'
Bundle 'dart-lang/dart-vim-plugin'
Bundle 'Shougo/neocomplcache'
Bundle 'jceb/vim-hier'
Bundle 'digitaltoad/vim-jade'
Bundle 'wavded/vim-stylus'
Bundle 'othree/html5-syntax.vim'
Bundle 'funorpain/vim-cpplint'
Bundle 'aklt/plantuml-syntax'
Bundle 'haskell.vim'
Bundle 'SingleCompile'
Bundle 'teneighty/vim-ant'
Bundle 'vim-scripts/java_checkstyle.vim'
Bundle 'Dinduks/vim-java-get-set'
Bundle 'rizzatti/funcoo.vim'
Bundle 'rizzatti/dash.vim'

filetype plugin indent on   " required!

let g:ideone_open_buffer_after_post = 1

""""""""""""
" NERDTree "
""""""""""""

autocmd vimenter * NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let g:NERDTreeDirArrows=0
let g:NERDTreeWinSize=40

""""""""""""""""""""""""""""""""""""""""""
" vim -b : edit binary using xxd-format! "
""""""""""""""""""""""""""""""""""""""""""

augroup Binary
  au!
  au BufReadPre  *.img let &bin=1
  au BufReadPost *.img if &bin | %!xxd -g 1
  au BufReadPost *.img set ft=xxd | endif
  au BufWritePre *.img if &bin | %!xxd -r
  au BufWritePre *.img endif
  au BufWritePost *.img if &bin | %!xxd -g 1
  au BufWritePost *.img set nomod | endif
augroup END

"""""""""""
" CPPLint "
"""""""""""

autocmd FileType cpp map <buffer> <F3> :call Cpplint()<CR>

""""""""""""
" PlantUML "
""""""""""""

let g:plantuml_executable_script="~/dotfiles/plantuml"

