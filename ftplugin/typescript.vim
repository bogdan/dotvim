let b:ale_linters = ['tsserver', 'eslint']
let b:ale_fixers = ['eslint', 'prettier']
" let b:ale_linters = ['tsserver']
" let b:ale_fixers = ['prettier']

map <buffer> <C-]> :ALEGoToDefinition<CR>
map <buffer> <C-'> :call setqflist([])<CR>:ALEFindReferences -relative -quickfix<CR>:bot copen<CR>
map <buffer> g] :ALEHover<CR>
map <buffer> <C-w>] :ALEGoToDefinition -split<CR>

function! TsIncludeExpr(file)
  if (filereadable(a:file))
    return l:file
  else
    let l:file2=substitute(a:file,'$','/index.ts','g')
    return l:file2
  endif
endfunction
set includeexpr=TsIncludeExpr(v:fname)
set include=import\_s.\\zs[^'\"]*\\ze
set suffixesadd=.ts,.js,.json,.jsx,.tsx
set isfname+=@-@ " Node modules organization name
set path+=node_modules
set path+=../node_modules

set iskeyword=@,48-57,_,192-255,-,$

let g:ale_javascript_eslint_options="--parser-options='{project: null}' --rule=\'{'@typescript-eslint/no-floating-promises': 'off', '@typescript-eslint/no-misused-promises': 'off'}\'"

let b:surround_{char2nr("P")} = "Promise<\r>"
let b:surround_{char2nr("i")} = "if () {\n  \r\n}"
let b:surround_{char2nr("l")} = "console.log(\r)"
let b:surround_{char2nr("a")} = "(async () => {\n  \r\n})()"
let b:surround_{char2nr("w")} = "(await \r)"
let g:surround_{char2nr("y")} = "try {\n  \r\n} catch(error) {\n  if (!(error instanceof )) throw error;\n  \n}"
let g:surround_{char2nr("_")} = "_.\1function: \1(\r)"

vnoremap <buffer> sif siwa

noremap <buffer> <Leader>a :ALEFix<CR>
noremap <buffer> <Leader>o :ALEOrganizeImports<CR>
noremap <buffer> <Leader>n :ALENextWrap<CR>
