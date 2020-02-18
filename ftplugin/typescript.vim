let b:ale_linters = ['tsserver', 'tslint']
let b:ale_fixers = ['tslint', 'prettier']

map <C-]> :ALEGoToDefinition<CR>
map <C-'> :ALEFindReferences<CR>
map g] :ALEHover<CR>
map <C-w>] :ALEGoToDefinitionInSplit<CR>

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
set suffixesadd=.ts,.js,.json
set isfname+=@-@ " Node modules organization name
set path+=node_modules

set iskeyword=@,48-57,_,192-255,-,$


let b:surround_{char2nr("P")} = "Promise<\r>"
let b:surround_{char2nr("i")} = "if () {\n  \r\n}"
let b:surround_{char2nr("l")} = "console.log(\r)"
let b:surround_{char2nr("a")} = "(async () => {\n  \r\n})()"
let b:surround_{char2nr("w")} = "(await \r)"
let g:surround_{char2nr("y")} = "try {\n  \r\n} catch(error) {\n  if (!(error instanceof )) throw error;\n  \n}"
let g:surround_{char2nr("_")} = "_.\1function: \1(\r)"
vmap sif siwa

