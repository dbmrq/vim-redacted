" redacted.vim - The best way to ████ the ████
" Author:   Daniel Ballester Marques
" Version:  0.2
" License:  Same as Vim

if exists("g:autoloaded_redacted") || &cp | finish | endif
let g:autoloaded_redacted = 1

highlight Redacted ctermfg=black ctermbg=black guifg=black guibg=black

function! s:strcut(s, l)
    let [s, l] = ['', 0]
    for c in split(a:s, '\zs')
        let s .= c
        if strlen(s) > a:l
            break
        endif
    endfor
    return s
endfunction

function! s:getSelectedPattern(visual)
    let start = a:visual ? getpos("'<") : getpos("'[")
    let end = a:visual ? getpos("'>") : getpos("']")
    let lines = getline(start[1], end[1])
    if len(lines) == 0
        return
    endif
    let lines[-1] = s:strcut(lines[-1], end[2] - 1)
    let lines[0] = lines[0][start[2] - 1:]
    let escapedLines = []
    for line in lines 
        call add(escapedLines, escape(line, '\')) 
    endfor
    return "\\V" . join(escapedLines, "\\n")
endfunction

function! s:getAllPatterns()
    let patterns = []
    for pattern in get(b:, 'redacted', [])
        call add(patterns, pattern[1])
    endfor
    return patterns
endfunction

function! redacted#redact(visual, ...)
    if a:0
        let pattern = a:1
    else
        let pattern = s:getSelectedPattern(a:visual)
    endif
    let match = [matchadd("Redacted", pattern), pattern]
    if !exists('b:redacted') | let b:redacted = [] | endif
    call add(b:redacted, match)
endfunction

function! redacted#clear(visual)
    if a:visual
        let allPatterns = s:getAllPatterns()
        let selectedPattern = s:getSelectedPattern(1)
        let index = index(allPatterns, selectedPattern)
        if index >= 0
            call matchdelete(b:redacted[index][0])
            call remove(b:redacted, index)
            return
        endif
    endif
    for pattern in b:redacted
        silent! call matchdelete(pattern[0])
    endfor
    let b:redacted = []
endfunction

function! redacted#persist()
    let patterns = s:getAllPatterns()
    let error = writefile(patterns, b:redactedFile)
    if error == 0
        redraw | echo "Your Redacted patterns were saved to " . b:redactedFile
    else
        echom "There was a problem persisting your Redacted patters"
    endif
endfunction

