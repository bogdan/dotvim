let g:vim_svelte_plugin_open_devdocs = ''

set tabstop=2
set shiftwidth=2
set expandtab

let b:ale_linters = []
let b:ale_fixers = ['prettier']

source <sfile>:h/js_common.vim

set suffixesadd=.svelte,.ts,.js,.json


augroup SvelteReload
  autocmd! BufReadPost <buffer>
  " b:current_syntax and b:did_ftplugin survive nohidden unload; clear them so
  " vim-svelte-plugin rebuilds embedded TS/CSS syntax regions on reload.
  autocmd BufReadPost <buffer> unlet! b:current_syntax b:did_ftplugin | set syntax=svelte
augroup END
