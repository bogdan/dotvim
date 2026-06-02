let g:vim_svelte_plugin_open_devdocs = ''

set tabstop=2
set shiftwidth=2
set expandtab

let b:ale_linters = ['svelteserver']
let b:ale_lint_on_insert_leave = 1

source <sfile>:h/js_common.vim

set suffixesadd=.svelte,.ts,.js,.json

noremap <buffer> <Leader>a :ALEFix<CR>
noremap <buffer> <Leader>n :ALENextWrap<CR>

augroup SvelteReload
  autocmd! BufReadPost,BufUnload <buffer>
  " b:current_syntax and b:did_ftplugin survive nohidden unload; clear them so
  " vim-svelte-plugin rebuilds embedded TS/CSS syntax regions on reload.
  autocmd BufReadPost <buffer> unlet! b:current_syntax b:did_ftplugin | set syntax=svelte
  " ALE never re-attaches the native LSP (semantic tokens) after a nohidden
  " unload; tell it the buffer is closed so it re-opens it on the next lint.
  autocmd BufUnload <buffer> call ale#lsp#CloseDocument(str2nr(expand('<abuf>')))
augroup END
