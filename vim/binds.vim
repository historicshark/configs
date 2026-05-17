if !exists(g:os)
    let g:os = toupper(substitute(system('uname'), '\n', '', ''))
endif

let mapleader=" "

" visual move lines up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <leader>se :Sexplore<CR>
nnoremap <leader>ve :Vexplore!<CR>
nnoremap <leader>te :Texplore<CR>

" copy paste
if g:os =~ 'DARWIN'
    vnoremap <leader>y :w !pbcopy <CR> <CR> '<
    nnoremap <leader>p i<C-r>=trim(system('pbpaste'))<CR><Esc>
endif
if g:os =~ 'LINUX'
    vnoremap <leader>y :w !wl-copy <CR> <CR> '<
    nnoremap <leader>p i<C-r>=trim(system('wl-paste'))<CR><Esc>
endif

" quick fix navigation
nnoremap <leader>j :cnext<CR>zz
nnoremap <leader>k :cprev<CR>zz

" arg list navigation
nnoremap <Up> :prev<CR>
nnoremap <Down> :next<CR>

" map ctrl-b to make
nnoremap <C-B> :make! %<CR><CR> :cope<CR>

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" shortcut to save
nnoremap ;w :update<CR>

" diff
nnoremap <leader>dt :windo diffthis<CR>
nnoremap <leader>do :windo diffoff<CR>

" split line with K (opposite of J)
nnoremap K i<CR><Esc>

" toggle things
nnoremap <leader>3 :set relativenumber!<CR>
nnoremap <leader>h :set hlsearch!<CR>

" Bring results to midscreen
nnoremap n nzz
nnoremap N Nzz

" move through tabs
nnoremap <tab> gt
nnoremap <S-tab> gT

" surround
nnoremap <leader>s' `>a'<Esc>`<i'<Esc>
nnoremap <leader>s" `>a"<Esc>`<i"<Esc>
nnoremap <leader>s( `>a)<Esc>`<i(<Esc>
nnoremap <leader>s) `>a)<Esc>`<i(<Esc>
nnoremap <leader>s{ `>a}<Esc>`<i{<Esc>
nnoremap <leader>s} `>a}<Esc>`<i{<Esc>
nnoremap <leader>s[ `>a[<Esc>`<i[<Esc>
nnoremap <leader>s] `>a[<Esc>`<i[<Esc>

vnoremap <leader>s' `>a'<Esc>`<i'<Esc>
vnoremap <leader>s" `>a"<Esc>`<i"<Esc>
vnoremap <leader>s( `>a)<Esc>`<i(<Esc>
vnoremap <leader>s) `>a)<Esc>`<i(<Esc>
vnoremap <leader>s{ `>a}<Esc>`<i{<Esc>
vnoremap <leader>s} `>a}<Esc>`<i{<Esc>
vnoremap <leader>s[ `>a[<Esc>`<i[<Esc>
vnoremap <leader>s] `>a[<Esc>`<i[<Esc>

" alternate file
nnoremap <leader>a :e #<CR>

" set pwd
nnoremap <leader>ch :cd %:h<CR>
nnoremap <leader>th :tcd %:h<CR>
nnoremap <leader>lh :lcd %:h<CR>
