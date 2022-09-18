packadd! dracula
packadd! dracula_pro
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
set hlsearch   " highlight all search results
set ignorecase " do case insensitive search
set noswapfile " disable swap file
set clipboard^=unnamedplus

set clipboard^=unnamed " use system clilpboard for yank
" set cursorline
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set number
set autoindent
set nobackup
set noswapfile
set encoding=utf-8
set fileencodings=utf8
set termencoding=utf-8
set ruler
set splitbelow
set splitright
syntax on

let mapleader = "'" " remap the leader to ''', right next to 'l'

inoremap jk <ESC> " remap escape to "jk"
nnoremap <leader>n :NERDTreeFocus<CR>
" Ctrl-j/k deletes blank line below/above, and Alt-j/k inserts.
nnoremap <C-j> o<ESC>k
nnoremap <C-k> O<ESC>j
nnoremap <silent><M-j> gg
nnoremap <silent><M-k> G
nnoremap ZX :q!<CR>
nnoremap ZZ :wq!<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>= :%s/\s\+$//e<CR>
autocmd BufWrite *.cs :call %s/\s\+$//ge

" colors ->
set t_Co=256
let g:rehash256 = 1
let g:airline_theme='onehalfdark'
let g:lightline = { 'colorscheme': 'onehalfdark' }
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
let g:dracula_colorterm=0
colorscheme dracula_pro
" <- colors

" Table mode ->
function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'
" <- Table mode

" xml formatting ->
set formatexpr=xmlformat#Format()
augroup XML
    autocmd!
    autocmd FileType xml let g:xml_syntax_folding=1
    autocmd FileType xml setlocal foldmethod=syntax
    autocmd FileType xml :syntax on
    autocmd FileType xml :%foldopen!
augroup END
" <- xml formatting
