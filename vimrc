" Vundle
" -------------------------------------------------------------
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Plugins
" -------------------------------------------------------------
" Bundle 'https://github.com/vim-scripts/AutoComplPop'
Bundle 'https://github.com/vim-scripts/FuzzyFinder'
Bundle 'https://github.com/vim-scripts/L9'
Bundle 'https://github.com/vim-scripts/omlet.vim'
Bundle 'https://github.com/vim-scripts/VimClojure'
" Bundle 'https://github.com/vim-scripts/Vim-JDE'
Bundle 'https://github.com/aghareza/vim-gitgrep'
Bundle 'https://github.com/derekwyatt/vim-scala'
Bundle 'https://github.com/vim-scripts/surround.vim'
Bundle 'https://github.com/vim-scripts/syntaxhaskell.vim'
Bundle 'https://github.com/kana/vim-filetype-haskell'
Bundle 'https://github.com/kchmck/vim-coffee-script'
Bundle 'https://github.com/pangloss/vim-javascript'
Bundle 'https://github.com/mattn/gist-vim'
Bundle 'https://github.com/mattn/webapi-vim.git'
Bundle 'https://github.com/mattn/googlesuggest-complete-vim.git'
Bundle 'https://github.com/mileszs/ack.vim'
Bundle 'https://github.com/tangledhelix/vim-octopress'
Bundle 'https://github.com/tpope/vim-endwise'
Bundle 'https://github.com/tpope/vim-fugitive'
Bundle 'https://github.com/tpope/vim-git'
Bundle 'https://github.com/tpope/vim-haml'
Bundle 'https://github.com/tpope/vim-rails'

" General
" -------------------------------------------------------------
set enc=utf-8
set nocompatible
set shell=zsh
set grepprg=ack
set nobackup
set noswapfile
syntax on
filetype plugin on
filetype indent on

let $ZSH_ENV="~/.zshrc"
cd ~ | let g:home = getcwd() | cd -

" Keymappings
" -------------------------------------------------------------
noremap - $
noremap <C-j> 3j
noremap <C-k> 3k
" noremap <C-h> 3h
" noremap <C-l> 3l
noremap <Space>. :<C-u>edit $MYVIMRC<Enter>
noremap <Space>s. :<C-u>source $MYVIMRC<Enter>
noremap <C-p> :bp<CR>
noremap <C-n> :bn<CR>
" noremap <C-p> :cp<CR>
" noremap <C-n> :cn<CR>
nnoremap Y y$
nnoremap R gR
nnoremap <C-d> :bd<CR>
" nnoremap <Space>h :hide bp!<CR>
" nnoremap <Space>l :hide bn!<CR>
vnoremap s y:%s/<C-R>"//g<Left><Left>
inoremap <C-b> <left>
inoremap <C-f> <right>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Del>
inoremap <C-k> <C-o>D
" inoremap <C-y> <C-o>p " This is too slow...
inoremap <C-j> <C-x><C-u>
inoremap <C-l> <C-o>:call ToggleLang()<Enter>
let mapleader = ";"
let maplocalleader = ","

" File
" -------------------------------------------------------------
set hidden
set autoread
set isfname-==
set tags+=tags;
" set wildmode=list,full
if has('persistent_undo')
  set undodir=./.vimundo,~/.vimundo
  set undofile
endif

" Editing
" -------------------------------------------------------------
set autoindent smartindent
set smarttab
set tabstop=2 softtabstop=2 shiftwidth=2
set expandtab
set cinoptions=t0,:0,g0,(0
set backspace=indent,eol,start
set formatoptions=tcqnmM
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<
set iskeyword+=!,?
set virtualedit=block

" Moving
" -------------------------------------------------------------
set showmatch matchtime=1
set matchpairs+=<:>
set whichwrap+=h,l,<,>,[,],b,s

" Display
" -------------------------------------------------------------
syntax on
colorscheme desert
highlight SpecialKey cterm=underline, ctermfg=darkgrey
if system("echo -n `uname`") == "Darwin"
  highlight SpecialKey cterm=underline, ctermfg=white
endif
set number
set nowrap
set ruler
set ruf=%45(%12f%=\ %m%{'['.(&fenc!=''?&fenc:&enc).']'}\ %l-%v\ %p%%\ [%02B]%)
set statusline=%F[%n]%m%=%{(&fenc!=''?&fenc:&enc).':'.&ff}%y\ %{(&list?'>':'')}\ \(%l,%v\)\ %p%%\ [0x%02B]
set showcmd
set cmdheight=1
set laststatus=2
set shortmess+=I
set nofoldenable
set vb t_vb=

" Search
" -------------------------------------------------------------
set ignorecase
set smartcase
set incsearch
set hlsearch
set keywordprg=man\ -a

" Completion, History
" -------------------------------------------------------------
set wildmenu
if version >= 703
  if has('patch107')
    set wildignorecase
  endif
endif
set history=50

" Others
" -------------------------------------------------------------
set completefunc=googlesuggest#Complete
let g:googlesuggest_language = 'en'
nmap <C-c> :FufBuffer<CR>

" Auto execute commands
" -------------------------------------------------------------
augroup Autocmds
  au!
  au BufEnter * lcd %:p:h
  au BufNewFile *.h  call InsertIncludeGuard() | call C_Settings()
  au BufNewFile *.sh call append(0, "#!/bin/sh")             | normal! G
  au BufNewFile *.rb call append(0, "#!/usr/bin/env ruby")   | normal! G
  au BufNewFile *.py call append(0, "#!/usr/bin/env python") | normal! G
  au BufNewFile *.pl call append(0, "#!/usr/bin/env perl")   | normal! G
  au BufWritePost * silent! %s/\s\+$//e
  au BufReadPost * silent! set fileformat=unix
  au BufWritePost * if getline(1) =~ "^#!" | exe "silent !chmod +x %" | endif
  au BufNewFile,BufReadPost \cmakefile,*.mak setlocal noexpandtab
  au BufNewFile,BufRead *.thor,buildfile,Buildfile set filetype=ruby

  au FileType c          call C_Settings()
  au FileType make       call Makefile_Settings()
  au FileType cpp        call Cpp_Settings()
  au FileType java       call Java_Settings()
  au FileType scala      call Scala_Settings()
  au FileType ruby       call Ruby_Settings()
  au FileType python     call Python_Settings()
  au FileType javascript call Javascript_Settings()
  au FileType html       call HTML_Settings()
  au FileType vim        call Vim_Settings()
  au FileType yaml       call Yaml_Settings()
  au FileType cucumber   call Yaml_Settings()
  au FileType text       setlocal textwidth=78
augroup END

" Language settings
" -------------------------------------------------------------
function! C_Settings()
  set isk-=!
  setlocal noexpandtab
  setlocal ts=8 sts=8 sw=8
  set fo-=ro
  " Yank with same indent level
  nnoremap <buffer> p p=`]
  set foldmethod=syntax
  syn region myFold start="{" end="}" transparent fold
  set foldnestmax=1
  iab case case<CR><C-D>break;<Up>
  iab default: default:<CR>break;<Up>
  if filereadable("./Makefile")
    setlocal makeprg=make
  else
    setlocal makeprg=gcc\ %
  endif
endfunction

function! Makefile_Settings()
  setlocal noexpandtab
  setlocal ts=8 sts=8 sw=8
endfunction

function! Cpp_Settings()
  call C_Settings()
  setlocal expandtab
  setlocal ts=2 sts=2 sw=2
endfunction

let java_highlight_all=1
function! Java_Settings()
  setlocal noexpandtab
endfunction

let vimclojure#WantNailgun = 1
let vimclojure#HighlightBuiltins = 1
let vimclojure#ParenRainbow = 1
let vimclojure#SplitPos = "bottom"
let vimclojure#SplitSize = 10

function! Scala_Settings()
endfunction

function! Ruby_Settings()
  comp ruby
  nnoremap <buffer> <F5> :make %<CR>
  iab <buffer> ei each_with_index
endfunction

function! Python_Settings()
endfunction

function! Javascript_Settings()
endfunction

function! HTML_Settings()
  inoremap <C-r>c <C-r>=system("randcolor")<CR>
  nnoremap <buffer> <F5> :!s %<CR>
endfunction

function! Vim_Settings()
  setlocal tw=0
  nnoremap <buffer> <F5> :so %<CR>
  setlocal formatoptions-=o
  " Execute selected region as a command
  nnoremap <space>e yy:@"<CR>
  vnoremap <space>e y:@"<CR>
endfunction

function! Yaml_Settings()
endfunction

" Other functions
" -------------------------------------------------------------
function! InsertIncludeGuard()
  let fl = getline(1)
  if fl =~ "^#if"
    return
  endif
  let basename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  normal! gg
  execute "normal! i#ifndef " . basename
  execute "normal! o#define " . basename .  "\<CR>\<CR>"
  execute "normal! Go#endif   /* " . basename . " */"
  3
endfunction
