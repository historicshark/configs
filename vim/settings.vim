if !exists(g:os)
    let g:os = toupper(substitute(system('uname'), '\n', '', ''))
endif

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
set incsearch
set showcmd
"set mouse=n
set scrolloff=3
set complete=t,.,w,b,u

" ignore docstring missing for module, class, functions
augroup python_make
    autocmd FileType python set makeprg=pylint\ --output-format=text\ --msg-template=\"{path}:{line}:{column}:{msg}\"\ --reports=n\ --score=n\ --max-line-length=150\ --extension-pkg-allow-list=PyQt5\ --disable=C0114,C0115,C0116
    autocmd FileType python set errorformat=%f:%l:%c:%m
augroup END

" status line
set laststatus=2
set statusline=
set statusline+=%-10.3n\
set statusline+=%f
set statusline+=%h%m%r%w
set statusline+=\[%{strlen(&ft)?&ft:'none'}]
set statusline+=%=
set statusline+=%-14(%l,%c%V%)
set statusline+=%-10L
set statusline+=%p%%
