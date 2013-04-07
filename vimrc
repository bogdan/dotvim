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
set statusline+=%{SyntasticStatuslineFlag()}
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
if has("gui_macvim")
  set shell=zsh\ -i
endif

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



"some stuff to get the mouse going in term
if has('mouse')
    set mouse=a
endif
set ttymouse=xterm2

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


map <silent> <F8> :QFix<CR>
map <silent> <s-F8> :bot copen<CR>
map <F9> :cnext<CR>
map <s-F9> :cfirst<CR>
map <F10> :cprevious<CR>
map <s-F10> :clast<CR>




"set patchmode=on


" indenting
"let treeexplvertical=1


"set langmap=ÊÃÕËÅÎÇÛİÚÈßÆÙ×ÁĞÒÏÌÄÖÜÑŞÓÍÉÔØÂÀ/êãõëåHçûıúèÿæù÷áğòïìäöüñşóíéôøâà/;qwertyuiop[]asdfghjkl;'zxcvbnm,./QWERTYUIOP[]ASDFGHJKL:'ZXCVBNM,./
"set langmap=éöóêåíãøùçõúôûâàïğîëäæıÿ÷ñìèòüáş/ÉÖÓÊÅHÃØÙÇÕÚÔÛÂÀÏĞÎËÄÆİß×ÑÌÈÒÜÁŞ/;qwertyuiop[]asdfghjkl;'zxcvbnm,./QWERTYUIOP[]ASDFGHJKL:'ZXCVBNM,./

let g:netrw_ftp_cmd           = 'ftp -p'

set autowrite

set selection=inclusive



set isk+=!
set isk+=?
autocmd BufReadPost * set isk+=-
autocmd BufReadPost * set isk-=#

set ruler


command! Re :source ~/.vimrc


"
" Plugins
"



" Rails

map ,t :wa<CR>:Rake<CR>:bot cwindow<CR>
map ,r :wa<CR>:Rake -<CR>:bot cwindow<CR>
map ,T :wa<CR>:.Rake<CR>:bot cwindow<CR>


" Ultisnips

source ~/.vim/snippets/support_functions.vim
let g:UltiSnipsSnippetDirectories=["snippets"]
let g:UltiSnipsEditSplit='horizontal'

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" DelimitMate


let g:delimitMate_apostrophes = ''

" Syntatic

let g:syntastic_enable_signs=1

" NERD tree
map <F5> :NERDTreeToggle<CR>
imap <F5> <ESC>:NERDTreeToggle<CR>a

" Yank ring

let g:yankring_history_dir = '~/.vim/'
let g:yankring_manual_clipboard_check = 0

" Bufexplorer
let g:bufExplorerShowRelativePath=1

" dbext
let g:dbext_default_history_file = 'tmp/dbext_sql_history.sql'
let g:dbext_table_names_number = 2
let g:dbext_table_names_case = 2
map <Leader>sc :DBResultsClose<CR>
map <Leader>sr :DBResultsRefresh<CR>

" hammer
let g:HammerQuiet = 1

" custom surrounds

xmap s   <Plug>VSurround

vmap ss s}gvs"a#<ESC>
"vmap sf s)i

let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"
let g:surround_{char2nr('f')} = "\1function: \r..*\r&\1(\r)"
let g:surround_{char2nr("y")} = "try(:\r)"


nmap csf lF(hciw
nmap dsf F(hdiwlds)
nmap dif ds(hviwd

autocmd FileType ruby vmap <buffer> ss _$<ESC>oend<ESC>gv_$j>gv_^<ESC>O
autocmd FileType ruby vmap <buffer> sif _$<ESC>oend<ESC>gv_^<ESC>Oif <ESC>gv_$j=gi
autocmd FileType haml set isk+=?,!
autocmd FileType javascript vmap <buffer> sif _$<ESC>o}<ESC>gv_^<ESC>Oif () {}<BS><ESC>gv_$j=gi<ESC>2hi
autocmd FileType haml vmap <buffer> ss >gv_^<ESC>O<BS>- 
autocmd FileType haml vmap <buffer> sif >gv_^<ESC>O- if
autocmd FileType haml set isk+=-,?,!
autocmd FileType eruby vmap <buffer> ss _$<ESC>o<% end %><ESC>gv_^<ESC>O<%  %><ESC>gv_$j=gi<ESC>2hi
autocmd FileType eruby vmap <buffer> sif _$<ESC>o<% end %><ESC>gv_^<ESC>O<% if  %><ESC>gv_$j=gi<ESC>2hi
autocmd FileType eruby set isk+=-,?,!


" My keys

cmap w!! %!sudo tee > /dev/null %

nmap <silent> <M-l> :set hlsearch<CR>:let @/='\<'.expand('<cword>').'\>'<CR>

" swap words
vnoremap <M-s> <Esc>`.``gvP``P


" stub default
map K k

map <F1> :call NERDComment(0, 'toggle')<CR>

map <Leader>a :Align
map <Leader># o#<cr> <cr><cr><bs><bs><esc>kkA
inoremap <C-U> <C-G>u<C-U>

map <F2> :wa<CR>
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

nmap <F3> <ESC>viw<ESC>:Ggrep! -w "<cword>" 
nmap <S-F3> <ESC>viw<ESC>:Ack! -w "<cword>" 
nmap <F4> <ESC>viw<ESC>:Ggrep! -w 
nmap <S-F4> <ESC>viw<ESC>:Ack! -wi 
vmap <F3> <ESC>:Ggrep! -w <S-Ins>
vmap <S-F3> <ESC>:Ack! -w <S-Ins>

function! ResetVim()
  let ft=&ft
  set ft=""
  let &ft=ft
  diffoff!
  Rrefresh!
endfunction

map <F11> :call ResetVim()<CR>


map <F12> :VCSCommit<CR>

map <C-a> <ESC>ggVG
map + mmgg=G:%s#\s*$##<CR>'m:noh<CR>
map <C-l> :noh<CR>
imap <C-l> <space><ESC>,b<ESC>i <ESC>lvi,ec<s-ins><esc>bX,els_
imap <C-k> <space><ESC>,b<ESC>i <ESC>lvi,ec<s-ins><esc>bX,els

map <M-w> <Plug>CamelCaseMotion_w
map <M-b> <Plug>CamelCaseMotion_b
map <M-e> <Plug>CamelCaseMotion_e
map ,w <Plug>CamelCaseMotion_w
map ,b <Plug>CamelCaseMotion_b
map ,e <Plug>CamelCaseMotion_e



let g:splitjoin_ruby_curly_braces = 0
nmap <Leader>j :SplitjoinJoin<cr>
nmap <Leader>s :SplitjoinSplit<cr>

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

