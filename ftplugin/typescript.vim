set tabstop=2
set shiftwidth=2
set expandtab
let b:ale_linters = ['eslint']
let b:ale_fixers = ['eslint', 'prettier']

source <sfile>:h/js_common.vim

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


noremap <buffer> <Leader>o <Cmd>lua vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })<CR>

