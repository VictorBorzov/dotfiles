set runtimepath^=~/.config/nvim/plugged/wiki.vim

let g:wiki_root = '~/wiki'

let g:wiki_filetypes = ['md', 'wiki']
let g:wiki_link_extension = '.md'
let g:wiki_link_target_type = 'md'

let g:wiki_link_toggles = {
      \ 'md': 'wiki#link#wiki#template',
      \ 'wiki': 'wiki#link#md#template',
      \ 'org': 'wiki#link#org#template',
      \ 'adoc_xref_bracket': 'wiki#link#adoc_xref_inline#template',
      \ 'adoc_xref_inline': 'wiki#link#adoc_xref_bracket#template',
      \ 'date': 'wiki#link#wiki#template',
      \ 'shortcite': 'wiki#link#md#template',
      \ 'url': 'wiki#link#md#template',
      \}

let s:regular_template = g:wiki_root . '/.templates/frontmatted.md'
"writes 0 if file not readable
"echom filereadable(s:regular_template) s:regular_template

let g:wiki_templates = [
      \ { 'match_func': {x -> v:true},
      \   'source_filename': s:regular_template}
      \]

