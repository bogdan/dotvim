let b:ale_linters = ['eslint', 'tsserver']
map <C-]> :ALEGoToDefinition<CR>
map g] :ALEHover<CR>
map <C-w>] :ALEGoToDefinitionInSplit<CR>

set suffixesadd=.ts,.js,.json
set isfname+=@-@ " Node modules organization name
set path+=node_modules

set iskeyword=@,48-57,_,192-255,-,$


