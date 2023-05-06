let mapleader = "\<Space>"

let g:python3_host_prog = '/home/vb/.config/nvim/venv/bin/python'

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" colorscheme
Plug 'morhetz/gruvbox'

" css3 syntax highlight
Plug 'hail2u/vim-css3-syntax'

" highlight colors
"Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" file tree
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }

" fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" commenting text
Plug 'tpope/vim-commentary'

" git wrapper
Plug 'tpope/vim-fugitive'

" Show indentation
Plug 'Yggdroot/indentLine'

" Highlink yank for a second
Plug 'machakann/vim-highlightedyank'

" Zen mode
Plug 'https://github.com/junegunn/goyo.vim'

" Visual local history
Plug 'sjl/gundo.vim'

" Surround text with something
Plug 'tpope/vim-surround'

" Allow repeating of custom commands like surround
Plug 'tpope/vim-repeat'

" Haskell highlighting
Plug 'neovimhaskell/haskell-vim'

" Multifile replace
Plug 'wincent/ferret'

" Show list of merge conflicts
Plug 'wincent/vcs-jump'

" Functions for manipulating highlight groups
Plug 'wincent/pinnacle'

" Markdown preview in browser
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Vimwiki - note-taking app
"Plug 'vimwiki/vimwiki'
Plug 'lervag/wiki.vim'

" Vimwiki folding
Plug 'lervag/wiki-ft.vim'

" Vimwiki lists
Plug 'lervag/lists.vim'

" Aligning
Plug 'junegunn/vim-easy-align'

" Calendar
Plug 'itchyny/calendar.vim'

Plug 'andys8/vim-elm-syntax'

" Plug 'nvim-treesitter/nvim-treesitter'

Plug 'neovim/nvim-lspconfig'

" Autocompletion

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" Plug 'hrsh7th/nvim-compe'

" Latex support with VimTex, requires latexmk (or another latex engine) and
" zathura - document viewer
"Plug 'lervag/vimtex'

" snippets
Plug 'sirver/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" use s[ab] to find ab instead of /ab
"Plug 'justinmk/vim-sneak'

call plug#end()
