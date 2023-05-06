" Hover information
nnoremap <silent> <Leader>k :lua vim.lsp.buf.hover()<CR>

" Find references
nnoremap <silent> gr :lua vim.lsp.buf.references()<CR>

" Rename
nnoremap <silent> <Leader>R :lua vim.lsp.buf.rename()<CR>

" Format
nnoremap <silent> <Leader>F :lua vim.lsp.buf.format()<CR>

" Code action
nnoremap <silent> <Leader>A :lua vim.lsp.buf.code_action()<CR>
