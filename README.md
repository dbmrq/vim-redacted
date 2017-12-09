# redacted.vim

![redacted](https://user-images.githubusercontent.com/15813674/33798938-fb1bd3e6-dd08-11e7-97bf-97c67ffe814d.png)

## How to use it

Just select some text and use `:Redact` to redact it. Use `:Redact!` to clear
the text.

You can also map an operator with `<Plug>Redact`:

    nmap <leader>r <Plug>Redact
    vmap <leader>r <Plug>Redact

## But *why*?

I wrote Redacted because I often have to paraphrase something I wrote, but
it's hard to do it when you're looking at the original words; it feels like
there's no other way to say it. So I though, "it would be nice if I could read
a sentence, hide it, and then try to come up with a new way to explain it
without looking at the original text". So there you have it. You could also
use it to make something like flash cards; you can cover the answers with
Redacted and select them in visual mode when you want to see what's behind.

## See also

You may also be interested in my other plugins:

- [Ditto: highlight overused words](https://github.com/dbmrq/vim-ditto) :speak_no_evil:
- [Dialect: project specific spellfiles](https://github.com/dbmrq/vim-dialect) :speech_balloon:
- [Chalk: better fold markers](https://github.com/dbmrq/vim-chalk) :pencil2:
- [Howdy: a tiny MRU start screen for Vim](https://github.com/dbmrq/vim-howdy) :wave:

