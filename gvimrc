colorscheme inkpot
if has("gui_macvim")
  macm Tools.List\ Errors key=<nop>
  set macmeta
  set guifont=Inconsolata:h20
  set shell=zsh\ -i
  set clipboard=unnamed
else
  set guifont="Inconsolate Medium 16"
endif
set guioptions=egitc
set guipty

"let g:loaded_dispatch=1
"let g:autoloaded_dispatch=1
