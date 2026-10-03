
set isfname+=@-@ " Node modules organization name
set iskeyword=@,48-57,_,192-255,-,$
set path+=node_modules

noremap <buffer> <Leader>a :ALEFix<CR>
noremap <buffer> <Leader>n <Cmd>lua vim.diagnostic.goto_next()<CR>
