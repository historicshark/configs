if !exists(g:has_fzf)
    let g:has_fzf = executable('fzf')
endif
if !exists(g:has_rg)
    let g:has_rg = executable('rg')
endif

if has_fzf && has_rg
    function! SmartComplete()
        let l:prefix = expand('<cword>')
        "let l:tags = systemlist('if [[ -e tags ]]; then cut -f1 tags; fi')
        "if !empty(l:tags)
        "    call fzf#run({
        "        \ 'source': l:tags,
        "        \ 'options': '--query=' . l:prefix,
        "        \ 'sink': function('s:InsertWord'),
        "        \ 'down': '40%',
        "        \ })
        "    return
        "endif

        let l:bufwords = s:BufferWords(l:prefix)
        if !empty(l:bufwords)
            echo 'buffer complete'
            call fzf#run({
                \ 'source': l:bufwords,
                \ 'options': '--query=' . l:prefix,
                \ 'sink': function('s:InsertWord'),
                \ 'down': '40%',
                \ })
            return
        endif

        echo 'rg complete'
        call fzf#run({
            \ 'source': 'rg -o "\b[A-Za-z_][A-Za-z0-9_]*\b" | sort -u',
            \ 'options': '--query=' . l:prefix,
            \ 'sink': function('s:InsertWord'),
            \ 'down': '40%',
            \ })
        "else
        "  call s:RGComplete(l:prefix)
        "endif
    endfunction

    function! s:BufferWords(current)
        let l:words = {}

        for l:buf in getbufinfo({'bufloaded': 1})
            for l:line in getbufline(l:buf.bufnr, 1, '$')
                for l:word in split(l:line, '\W\+')
                    if l:word =~# '^[A-Za-z_][A-Za-z0-9_]*$' && l:word !=# a:current && a:current =~ l:word
                        let l:words[l:word] = 1
                    endif
                endfor
            endfor
        endfor

        return keys(l:words)
    endfunction

    function! s:RGComplete(prefix)
        call fzf#run({
            \ 'source': 'rg -o "\b[A-Za-z_][A-Za-z0-9_]*\b" | sort -u',
            \ 'options': '--query=' . a:prefix,
            \ 'sink': function('s:InsertWord'),
            \ 'down': '40%',
            \ })
    endfunction


    function! s:InsertWord(line)
        let l:word = split(a:line, ':')[-1]
        execute "normal! ciw" . l:word
        call feedkeys("a", 'n')
    endfunction

    inoremap <C-N> <Esc>:call SmartComplete()<CR>
endif
