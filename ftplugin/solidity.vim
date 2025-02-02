set path+=node_modules
set isfname+=@-@ " vendor imports
let b:ale_linters=['solc']
let g:ale_solidity_solc_options='--allow-paths=. @openzeppelin=./node_modules/@openzeppelin hardhat=./node_modules/hardhat'
set tabstop=4
set shiftwidth=4
set expandtab
noremap <buffer> <Leader>n :ALENextWrap<CR>
runtime ftplugin/javascript/splitjoin.vim
let b:splitjoin_trailing_comma = 0
set isk=@,48-57,_,192-255,!,?,-
