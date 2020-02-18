set nocompatible
call pathogen#infect() 

"load ftplugins and indent files
filetype plugin indent on
syntax on


"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000


set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default
" Set ignore case search
set ic

set diffopt=filler,iwhite,vertical

autocmd Bufread * set wrap
set wrap


set virtualedit=all


set backupext=.bak
set backupdir="~/tmp"
set nobackup
set nowritebackup

"statusline setup
set statusline=%f       "tail of the filename

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*


set statusline+=%h      "help file flag
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%*

"set statusline+=%{StatuslineTrailingSpaceWarning()}

set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

"indent settings
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set autoindent
set smartindent

"folding settings
set foldmethod=manual   "don't use fold
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing



"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

set autoread


"some stuff to get the mouse going in term
if has('mouse')
    set mouse=a
endif
if !has('nvim')
  set ttymouse=xterm2
endif

"tell the term has 256 colors
"set t_Co=256

"do not hide buffers when not displayed
set nohidden

"dont load csapprox if we no gui support - silences an annoying warning
if !has("gui")
    let g:CSApprox_loaded = 1
endif


function! MoveToVisualAreaExtrema(wantEnd) range
normal gv
let l:mode = mode()
" only character (v) and line mode (V) work with this implementation
if !(l:mode == 'v' || l:mode == 'V')
    throw 'must be in character- or line-visual mode'
endif
" get original posision
let l:iLn = line('.')
let l:iCl = col('.')
" move to other end of visual selection
normal o
" get current position
let l:cLn = line('.')
let l:cCl = col('.')
let l:atEnd = (l:cLn > l:iLn) || (l:cLn == l:iLn) && (l:cCl > l:iCl)
if a:wantEnd != l:atEnd
    normal o
endif
if l:mode == 'V'
    execute 'normal ' . (a:wantEnd ? '$' : '0')
endif
endfunction
vmap _^ :call MoveToVisualAreaExtrema(0)<CR>
vmap _$ :call MoveToVisualAreaExtrema(1)<CR>



"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"map to bufexplorer
nnoremap <C-B> :BufExplorerHorizontalSplit<CR>
nnoremap <Leader>b :BufExplorer<CR>
nnoremap <Leader>bs :BufExplorerHorizontalSplit<CR>
nnoremap <Leader>bv :BufExplorerVerticalSplit<CR>




"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$




"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
if &filetype !~ 'commit\c'
    if line("'\"") > 0 && line("'\"") <= line("$")
        exe "normal! g`\""
        normal! zz
    endif
end
endfunction



" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif


function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec('bot '.a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nmap <script> <silent> <F8> :call ToggleList('Quickfix', 'c')<CR>
map <F9> :cprevious<CR>
map <s-F9> :cfirst<CR>
map <F10> :cnext<CR>
map <s-F10> :clast<CR>


map <M-H> <C-w>h
map <M-J> <C-w>j
map <M-K> <C-w>k
map <M-L> <C-w>l
map <M-O> <C-w>o
map <M-{> <C-w>[
map <M-}> <C-w>]


nmap <M->> >>
nmap <M-<> <<
vmap <M->> >gv
vmap <M-<> <gv

"set patchmode=on

function! OpenFile()
  call feedkeys(':e '.@+."\<cr>")
endfunction
map <M-q> :call OpenFile()<cr>



"set langmap= √’À≈Œ«€›⁄»ﬂ∆Ÿ◊¡–“œÃƒ÷‹—ﬁ”Õ…‘ÿ¬¿/Í„ıÎÂHÁ˚˝˙ËˇÊ˘˜·ÚÔÏ‰ˆ¸Ò˛ÛÌÈÙ¯‚‡/;qwertyuiop[]asdfghjkl;'zxcvbnm,./QWERTYUIOP[]ASDFGHJKL:'ZXCVBNM,./
"set langmap=ÈˆÛÍÂÌ„¯˘Áı˙Ù˚‚‡ÔÓÎ‰Ê˝ˇ˜ÒÏËÚ¸·˛/…÷” ≈H√ÿŸ«’⁄‘€¬¿œ–ŒÀƒ∆›ﬂ◊—Ã»“‹¡ﬁ/;qwertyuiop[]asdfghjkl;'zxcvbnm,./QWERTYUIOP[]ASDFGHJKL:'ZXCVBNM,./

let g:netrw_ftp_cmd           = 'ftp -p'

set autowrite

set selection=inclusive

autocmd FileType ruby,haml,eruby set isk+=?,!
autocmd BufReadPost * set isk+=-
autocmd BufReadPost * set isk-=#

set ruler


command! Re :source ~/.vimrc


"
" Plugins
"



" Rails

 
map ,t :wa<CR>:call setqflist(['Working...'])<CR>:Rake<CR>:bot cwindow<CR>
map ,r :wa<CR>:call setqflist(['Working...'])<CR>:Rake -<CR>:bot cwindow<CR>
map ,T :wa<CR>:call setqflist(['Working...'])<CR>:.Rake<CR>:bot cwindow<CR>

let g:rails_projections = {
    \ "config/*.yml": {
    \   "command": "yml"
    \ },
    \ "app/services/*.rb": {
    \   "command": "service"
    \ },
    \ "app/grids/*_grid.rb": {
    \   "command": "grid",
    \   "affinity": "model",
    \   "related": 'app/models/%i.rb'
    \ },
    \ "app/workers/*.rb": {
    \   "command": "worker",
    \   "affinity": "model",
    \ },
    \ "spec/features/*_spec.rb": {
    \   "command": "feature",
    \ },
    \ "spec/factories/*.rb": {
    \   "command": "factory",
    \   "affinity": "model",
    \   "related": "app/models/%i.rb",
    \ },
    \ "app/liquid/*": {"command": "liquid"},
    \ "support/2018/*.rb": {"command": "support"}}
    "\ "features/support/env.rb": {"command": "support"}}


" Ultisnips

let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

source ~/.vim/UltiSnips/support_functions.vim
"let g:UltiSnipsSnippetDirectories=["snippets"]
let g:UltiSnipsEditSplit='horizontal'

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsNoPythonWarning=1
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips'] 

" Gist

let g:gist_clip_command = 'pbcopy'

" DelimitMate

let g:delimitMate_apostrophes = ''


vmap <Leader>r y:@"<CR>


" FZF

set rtp+="/usr/local/bin/fzf"
map <Leader>f :Files<CR>
map <Leader>v :vs<CR>:Files<CR>

" Syntatic

let g:syntastic_enable_signs=1
let g:syntastic_javascript_checkers = ['lynt']
let g:syntastic_typescript_checkers = ['lynt']
let g:syntastic_scilla_checkers = ['scillachecker']
let g:syntastic_scilla_scillachecker_args = '-libdir '.$HOME.'/makabu/unstoppable/scilla/src/stdlib'

" ALE

let g:ale_lint_on_text_changed = 'never'
let g:ale_completion_enabled = 1
let g:ale_completion_delay = 100
let g:ale_completion_tsserver_autoimport = 1
set completeopt=menu
map <Leader>a :ALEFix<CR>
"let g:ale_lint_on_insert_leave = 1



" NERD tree
map <F5> :NERDTreeToggle<CR>
imap <F5> <ESC>:NERDTreeToggle<CR>a

let NERDTreeMinimalUI=1 
" Yank ring

map <Leader>r V"0p
let g:yankring_history_dir = '~/.vim/'
let g:yankring_manual_clipboard_check = 0
"let g:yankring_enabled = 0
"
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" replace currently selected text with default register
" without yanking it
vnoremap <leader>p "_dP

" Vim tag

let g:vim_tags_auto_generate=0
let g:vim_tags_ignore_files = ['.gitignore', '.svnignore', '.cvsignore', 'tmp', 'node_modules']
let ruby_regex=''
let javascript_regex=''
let g:custom_ctag_options = join([ ruby_regex, javascript_regex ])
let g:vim_tags_project_tags_command = "{CTAGS} -R ".custom_ctag_options." {OPTIONS} {DIRECTORY}"

map g[ :call MyGrep('"def .*'.expand('<cword>').'" ')<CR><CR><CR>


map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>


"let g:yankstack_map_keys = 0

"nmap <C-p> <Plug>yankstack_substitute_older_paste
"xmap <C-p> <Plug>yankstack_substitute_older_paste
"imap <C-p> <Plug>yankstack_substitute_older_paste
"nmap <C-n> <Plug>yankstack_substitute_newer_paste
"xmap <C-n> <Plug>yankstack_substitute_newer_paste
"imap <C-n> <Plug>yankstack_substitute_newer_paste

" Bufexplorer
let g:bufExplorerShowRelativePath=1

" hammer
let g:HammerQuiet = 1

" custom surrounds

xmap s   <Plug>VSurround

vmap ss s}gvs"a#<ESC>
"vmap sf s)i

let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"
let g:surround_{char2nr('f')} = "\1function: \r..*\r&\1(\r)"


nmap csf lF(hciw
nmap dsf F(hdiwlds)
nmap dif ds(hviwd

autocmd FileType ruby vmap <buffer> ss _$<ESC>oend<ESC>gv_$j>gv_^<ESC>O
autocmd FileType ruby vmap <buffer> sif _$<ESC>oend<ESC>gv_^<ESC>Oif <ESC>gv_$j=gi
autocmd FileType javascript vmap <buffer> sif _$<ESC>o}<ESC>gv_^<ESC>Oif () {}<BS><ESC>gv_$j=gi<ESC>2hi
autocmd FileType haml vmap <buffer> ss >gv_^<ESC>O<BS>- 
autocmd FileType haml vmap <buffer> sif >gv_^<ESC>O- if
autocmd FileType eruby vmap <buffer> ss _$<ESC>o<% end %><ESC>gv_^<ESC>O<%  %><ESC>gv_$j=gi<ESC>2hi
autocmd FileType eruby vmap <buffer> sif _$<ESC>o<% end %><ESC>gv_^<ESC>O<% if  %><ESC>gv_$j=gi<ESC>2hi


" My keys

" No Right Controll on mac
nmap <M-t> <C-t>
nmap <M-6> <C-6>
nmap <M-w> <C-w>

cmap w!! %!sudo tee > /dev/null %


" swap words
vnoremap <M-s> <Esc>`.``gvP``P


" stub default
map K k

" NERD Commenter
map <F1> :call NERDComment(0, 'toggle')<CR>
let g:NERDRemoveExtraSpaces=1
let g:NERDSpaceDelims=1

inoremap <C-U> <C-G>u<C-U>


map <F2> :wa<CR>
vmap <F2> <ESC>:wa<CR>gv
imap <F2> <ESC>:wa<CR>a

vmap <C-c> "+y<ESC>
map <C-v> "+gp
imap <C-v> <ESC>"+gp

map <F6> vi)s<CR>gv:s/,/,\r/g<CR>gv=

" git grep and ack

if executable("ack-grep")
  let g:ackprg="ack-grep -H --nocolor --nogroup --column"
else
  let g:ackprg="ack -H --nocolor --nogroup --column"
endif

function! MyGrep(ending)
  if exists("b:git_dir")
    let cmd = ":Ggrep! -w"
  else
    let cmd = ":Ack! -w"
  endif
  call feedkeys(cmd.' '.a:ending)
endfunction

nmap <F3> :call MyGrep('"'.expand('<cword>').'" ')<CR>
nmap <S-F3> <ESC>viw<ESC>:Ack! -w "<cword>" 
nmap <F4> :call MyGrep("")<CR>
nmap <S-F4> <ESC>viw<ESC>:Ack! -wi 
"vmap <F3> <ESC>:Ggrep! -w <S-Ins>
"vmap <S-F3> <ESC>:Ack! -w <S-Ins>

function! ResetVim()
  let ft=&ft
  set ft=""
  let &ft=ft
  diffoff!
  if exists('b:rails_root')
    Rrefresh
  endif
endfunction

map <F11> :call ResetVim()<CR>:source ~/.vimrc<CR>



map <C-a> <ESC>ggVG
map + mmgg=G:%s#\s*$##<CR>'m:noh<CR>
map <C-l> :noh<CR>
imap <C-l> <space><ESC>,b<ESC>i <ESC>lvi,ec<s-ins><esc>bX,els_
imap <C-k> <space><ESC>,b<ESC>i <ESC>lvi,ec<s-ins><esc>bX,els
nmap <silent> <M-l> :set hlsearch<CR>:let @/='\<'.expand('<cword>').'\>'<CR>

map <M-w> <Plug>CamelCaseMotion_w
map <M-b> <Plug>CamelCaseMotion_b
map <M-e> <Plug>CamelCaseMotion_e
map ,w <Plug>CamelCaseMotion_w
map ,b <Plug>CamelCaseMotion_b
map ,e <Plug>CamelCaseMotion_e

" AutoPairs
let g:AutoPairsMultilineClose = 0
let g:AutoPairFlyMode=1

let g:splitjoin_ruby_curly_braces = 0
nmap <Leader>j :SplitjoinJoin<cr>
nmap <Leader>s :SplitjoinSplit<cr>
let g:splitjoin_trailing_comma = 1

map <M-r> :RV<cr>
map <M-v> :AV<cr>
map <M-o> <C-w><C-o>

command! -range -nargs=1 SendToCommand <line1>,<line2>call SendToCommand(<q-args>) 

function! SendToCommand(UserCommand) range
    " Get a list of lines containing the selected range
    let SelectedLines = getline(a:firstline,a:lastline)
    " Convert to a single string suitable for passing to the command
    let ScriptInput = join(SelectedLines, "\n") . "\n"
    " Run the command
    let result = system(a:UserCommand, ScriptInput)
    " Echo the result (could just do "echo system(....)")
    echo result

endfunction

au BufRead,BufNewFile *.hamlc set ft=haml

autocmd FileType ruby
      \ if expand('%') =~# '_test\.rb$' |
      \   compiler rubyunit | setl makeprg=testrb\ \"%:p\" |
      \ elseif expand('%') =~# '_spec\.rb$' |
      \   compiler rspec | setl makeprg=zeus\ rspec\ \"%:p\" |
      \ else |
      \   compiler ruby | setl makeprg=ruby\ -wc\ \"%:p\" |
      \ endif


let g:test#javascript#jest#executable = ". /usr/local/opt/nvm/nvm.sh && nvm use 12.12.0 && TEST_BLOCKCHAIN=1 yarn test"
"autocmd User Bundler
      "\ if &makeprg !~# 'bundle' | setl makeprg^=bundle\ exec\  | endif


" Trim whitespace
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,ruby,python,typescript,javascript,json autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

if has("gui_macvim") || has("gui_vimr")
  colorscheme inkpot
  set clipboard=unnamed
endif
if has("gui_macvim")
  "set shell=zsh\ -i
  set guifont=Inconsolata:h20
  set macmeta
  set guipty
  set guioptions=egitc
endif

"let g:loaded_dispatch=1
"let g:autoloaded_dispatch=1
