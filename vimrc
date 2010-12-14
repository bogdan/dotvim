"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

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
set statusline+=%{StatuslineTabWarning()}
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




"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
if !exists("b:statusline_tab_warning")
    let tabs = search('^\t', 'nw') != 0
    let spaces = search('^ ', 'nw') != 0

    if tabs && spaces
        let b:statusline_tab_warning =  '[mixed-indenting]'
    elseif (spaces && !&et) || (tabs && &et)
        let b:statusline_tab_warning = '[&et]'
    else
        let b:statusline_tab_warning = ''
    endif
endif
return b:statusline_tab_warning
endfunction



"indent settings
set shiftwidth=4
set softtabstop=4
set tabstop=2
set expandtab
set autoindent
set smartindent

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

"display tabs and trailing spaces
"set list
"set listchars=tab:â–·â‹…,trail:â‹…,nbsp:â‹…

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"load ftplugins and indent files
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

"turn on syntax highlighting
syntax on

"some stuff to get the mouse going in term
if has('mouse')
    set mouse=a
endif
set ttymouse=xterm2

"tell the term has 256 colors
set t_Co=256

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
nnoremap <C-B> :BufExplorer<cr>

"map to fuzzy finder text mate stylez
nnoremap <c-f> :FuzzyFinderTextMate<CR>

"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$



"visual search mappings
"function! s:VSetSearch()
"let temp = @@
"norm! gvy
"let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
"let @@ = temp
"endfunction
"vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
"vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>


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

function! s:sub(str,pat,rep)
return substitute(a:str,'\v\C'.a:pat,a:rep,'')
endfunction

function! Singularize(word)
" Probably not worth it to be as comprehensive as Rails but we can
" still hit the common cases.
let word = a:word
if word =~? '\.js$' || word == ''
    return word
endif
let word = s:sub(word,'eople$','ersons')
let word = s:sub(word,'[aeio]@<!ies$','ys')
let word = s:sub(word,'xe[ns]$','xs')
let word = s:sub(word,'ves$','fs')
let word = s:sub(word,'ss%(es)=$','sss')
let word = s:sub(word,'s$','')
let word = s:sub(word,'%([nrt]ch|tatus|lias)\zse$','')
let word = s:sub(word,'%(nd|rt)\zsice$','ex')
return word
endfunction

function! Pluralize(word)
let word = Singularize(a:word)
if word == ''
    return word
endif
let word = s:sub(word,'[aeio]@<!y$','ie')
let word = s:sub(word,'%(nd|rt)@<=ex$','ice')
let word = s:sub(word,'%([osxz]|[cs]h)$','&e')
let word = s:sub(word,'f@<!f$','ve')
let word .= 's'
let word = s:sub(word,'ersons$','eople')
return word
endfunction

" toggles the quickfix window.
command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
else
    bot copen 10
    let g:qfix_win = bufnr("$")
endif
endfunction

map <silent> <F8> :QFix<CR>
map <F9> :cnext<CR>
map <F10> :cprevious<CR>




"set patchmode=on


" indenting
"let treeexplvertical=1


set langmap=ÊÃÕËÅÎÇÛİÚÈßÆÙ×ÁĞÒÏÌÄÖÜÑŞÓÍÉÔØÂÀ/êãõëåHçûıúèÿæù÷áğòïìäöüñşóíéôøâà/;qwertyuiop[]asdfghjkl;'zxcvbnm,./QWERTYUIOP[]ASDFGHJKL:'ZXCVBNM,./
set langmap=éöóêåíãøùçõúôûâàïğîëäæıÿ÷ñìèòüáş/ÉÖÓÊÅHÃØÙÇÕÚÔÛÂÀÏĞÎËÄÆİß×ÑÌÈÒÜÁŞ/;qwertyuiop[]asdfghjkl;'zxcvbnm,./QWERTYUIOP[]ASDFGHJKL:'ZXCVBNM,./

let g:netrw_ftp_cmd           = 'ftp -p'

set autowrite

set selection=inclusive



set isk+=!
set isk+=?
set isk+=-

set guifont=Inconsolata\ Medium\ 12
set guioptions-=r
set guioptions-=T
set guioptions-=L
set guioptions-=m
set ruler

" Make star command stay on current word
map * :norm! *<CR>N

command! Re :source ~/.vimrc


"
" Plugins
"

" Rails

map ,t :wa<CR>:Rake<CR>:bot cwindow<CR>
map ,r :wa<CR>:Rake -<CR>:bot cwindow<CR>
map ,T :wa<CR>:.Rake<CR>:bot cwindow<CR>


" snipMate

source ~/.vim/snippets/support_functions.vim

" delimitMate


let g:delimitMate_apostrophes = ''

" Syntatic
let g:syntastic_enable_signs=1


" Allml
"let g:allml_global_maps = 1

" NERD tree
map <F5> :NERDTreeToggle<CR>
imap <F5> <ESC>:NERDTreeToggle<CR>a

" Yank ring

let g:yankring_history_dir = '~/.vim/'

" Bufexplorer
let g:bufExplorerShowRelativePath=1

" dbext
let g:dbext_default_history_file = 'tmp/dbext_sql_history.sql'
let g:dbext_table_names_number = 2
let g:dbext_table_names_case = 2
map <Leader>sc :DBResultsClose<CR>
map <Leader>sr :DBResultsRefresh<CR>

" custom surrounds

vmap ss s}gvs"a#<ESC>
vmap sf s)i

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


autocmd  BufNewFile,BufRead *.mustache set syntax=mustache
autocmd  BufNewFile,BufRead *.treetop set syntax=treetop

" My keys

" stub default
map <F1> j 
map <Leader>a :Align
map <Leader># o#<cr> <cr><cr><bs><bs><esc>kkA
inoremap <C-U> <C-G>u<C-U>

map <F2> :wa<CR>
imap <F2> <ESC>:wa<CR>a

vmap <C-c> "+y<ESC>
map <C-v> "+gP
imap <C-v> <ESC>"+gP

" Grep
nmap <F3> <ESC>viw<ESC>:Ggrep! -w <cword> 
nmap <C-F3> <ESC>viw<ESC>:Grep -rw <cword> 
nmap <F4> <ESC>viw<ESC>:Ggrep! -w 
nmap <C-F4> <ESC>viw<ESC>:Grep -rwi 
map ,g :Grep -riw
map <Leader>g :Grep -riw 
vmap <F3> <ESC>:Ggrep! -w <S-Ins>
vmap <C-F3> <ESC>:Grep -rw <S-Ins>
map <F11> :Rrefresh<CR>

map <F12> :set encoding=utf8<CR>

map <C-a> <ESC>ggVG
map + mmgg=G:%s#\s*$##<CR>'m:noh<CR>
map <C-l> :noh<CR>
imap <C-l> <space><ESC>,b<ESC>i <ESC>lvi,ec<s-ins><esc>bX,els_
imap <C-k> <space><ESC>,b<ESC>i <ESC>lvi,ec<s-ins><esc>bX,els


