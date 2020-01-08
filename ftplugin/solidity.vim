set path+=node_modules
set isfname+=@-@ " vendor imports
let b:ale_linters=['solc']
let g:ale_solidity_solc_options='--allow-paths=. @openzeppelin=./node_modules/@openzeppelin'
