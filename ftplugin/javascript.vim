let b:ale_linters = ['tsserver']
map <C-]> :ALEGoToDefinition<CR>
map <C-'> :ALEFindReferences<CR>
map g] :ALEHover<CR>
map <C-w>] :ALEGoToDefinitionInSplit<CR>

set suffixesadd=.ts,.js,.json
set isfname+=@-@ " Node modules organization name
set path+=node_modules

