map <buffer> <C-]> :ALEGoToDefinition<CR>
map <buffer> <C-'> :call setqflist([])<CR>:ALEFindReferences -relative -quickfix<CR>:bot copen<CR>
map <buffer> g] :ALEHover<CR>
map <buffer> <C-w>] :ALEGoToDefinition -split<CR>

set isfname+=@-@ " Node modules organization name
set path+=node_modules
