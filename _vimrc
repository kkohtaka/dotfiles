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
set tabstop=2
set shiftwidth=2
set softtabstop=2

set list
set listchars=tab:>.,trail:_

set history=100

set showmode

set scrolloff=12

colorscheme desert

" Vundle

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'grarik/vundle'

Bundle 'scrooloose/nerdtree'
Bundle 'Shougo/neocomplcache'
Bundle 'godlygeek/tabular'
Bundle 'jceb/vim-hier'
Bundle 'pangloss/vim-javascript'
Bundle 'guileen/vim-node'
Bundle 'dart-lang/dart-vim-plugin'
Bundle 'digitaltoad/vim-jade'
Bundle 'othree/html5-syntax.vim'
Bundle 'SingleCompile'

filetype plugin indent on

" NERDTree

autocmd vimenter * NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" vim -b : edit binary using xxd-format!

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

