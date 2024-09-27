let b:ale_linters = []
let b:ale_fixers = ['trim_whitespace', 'remove_trailing_lines']
noremap <buffer> <Leader>a :ALEFix<CR>
noremap <buffer> <Leader>n :ALENextWrap<CR>
