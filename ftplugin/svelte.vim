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
