set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Bundle 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'puremourning/vimspector'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
"Plugin 'airblade/vim-gitgutter'
Plugin 'itchyny/lightline.vim'

Plugin 'arzg/vim-colors-xcode'

" All of your Plugins must be added before the following line
" Plugin 'sagi-z/vimspectorpy', { 'do': { -> vimspectorpy#update() } }
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

colorscheme xcode

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" Start NERDTree when Vim is started without file arguments.
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" you complete me plugin?
let g:ycm_autoclose_preview_window_after_completion=1

" lightline status bar wasn't showing so add this
set laststatus=2

" using lightline, so the -- INSERT -- is unnecessary
set noshowmode 

" Map ctrl-f to :Rg (fzf)
nmap <C-F> :exec("Rg")<CR>
nmap <C-\> :exec("Rg ".expand("<cword>"))<CR>

" Vimspector
let g:vimspector_base_dir='/Users/historicshark/.vim/bundle/vimspector'
nmap <F5> <Plug>VimspectorContinue
nmap <F3> <Plug>VimspectorStop
nmap <F4> <Plug>VimspectorRestart
nmap <F9> <Plug>VimspectorToggleBreakpoint
nmap <F8> <Plug>VimspectorRunToCursor
nmap <F10> <Plug>VimspectorStepOver
nmap <F11> <Plug>VimspectorStepInto
nmap <F12> <Plug>VimspectorStopOut
nmap <F1> :VimspectorReset<CR>
" let g:vimspector_enable_mappings = 'HUMAN'
" packadd! vimspector

" Other configuration
syntax on
set ruler
set bs=indent,eol,start
set ignorecase
set smartcase
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
" set nowrap
set number
set relativenumber

" use ctags to jump to the definition of the current word under the cursor
"map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

