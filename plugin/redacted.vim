" redacted.vim - The best way to ████ the ████
" Author:   Daniel Ballester Marques
" Version:  0.2
" License:  Same as Vim

if exists("g:loaded_redacted") || &cp | finish | endif
let g:loaded_redacted = 1

augroup Redacted
    autocmd!
    autocmd BufNewFile,BufRead * call s:init()
augroup END

function! s:init()
    let b:redactedFile = expand('%:h') . "/." . expand('%:t') . ".redacted"
    if filereadable(b:redactedFile)
        let patterns = filter(readfile(b:redactedFile), 'v:val != ""')
        for pattern in patterns
            call redacted#redact(0, pattern)
        endfor
    endif
endfunction

function! Redact(pattern)
    call redacted#redact(0, a:pattern)
endfunction

command! -range=0 -bang Redact if <bang>0 == 1 |
    \ call redacted#clear(<range>) | else | call redacted#redact(1) | endif

command! RedactedW call redacted#persist()

xnoremap <silent> <Plug>Redact :call redacted#redact(1)<CR>
nnoremap <silent> <Plug>Redact :set opfunc=redacted#redact<CR>g@

