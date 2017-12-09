" redacted.vim - The best way to ████ the ████
" Author:   Daniel Ballester Marques
" Version:  0.1
" License:  Same as Vim

if exists("g:loaded_redacted") || &cp | finish | endif
let g:loaded_redacted = 1

highlight Redacted ctermfg=black ctermbg=black guifg=black guibg=black
au ColorScheme * highlight Redacted
    \ ctermfg=black ctermbg=black guifg=black guibg=black

function! s:redact(visual)
    let start = a:visual ? getpos("'<") : getpos("'[")
    let end = a:visual ? getpos("'>") : getpos("']")
    let lines = getline(start[1], end[1])
    let lines[-1] = lines[-1][: end[2] - 1]
    let lines[0] = lines[0][start[2] - 1:]
    let escapedLines = []
    for line in lines 
        call add(escapedLines, escape(line, '\')) 
    endfor
    if !exists('w:redactedIDs') | let w:redactedIDs = [] | endif
    call add(w:redactedIDs,
        \ matchadd("Redacted", "\\V" . join(escapedLines, "\\n")))
endfunction

function! s:clear()
    let i = 0
    while i < len(w:redactedIDs)
        silent! call matchdelete(w:redactedIDs[i])
        silent! call remove(w:redactedIDs, i)
        let i += 1
    endwhile
endfunction

command! -range=% -bang Redact if <bang>0 == 1 |
    \ call s:clear() | else | call s:redact(1) | endif

vnoremap <Plug>Redact :call <SID>redact(1)<CR>
nnoremap <Plug>Redact :set opfunc=<SID>redact<CR>g@

