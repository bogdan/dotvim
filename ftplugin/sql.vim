" Dadbod

if !exists('g:development_db')
  let g:development_db=0
endif
function! SwitchDb()
  if g:development_db == 1
    let g:current_db="postgresql://postgres:AsyncAwaitingIsMyReligion128@localhost:2346/unstoppable_website_production"
    let g:development_db=0
  else
    let g:current_db="postgresql:unstoppable_website_development" 
    let g:development_db=1
  endif
  echo "Using ".g:current_db
  command! -bang -nargs=? -range=-1 -complete=custom,db#command_complete Db  exe db#execute_command('<mods>', <bang>0, <line1>, <count>, g:current_db . ' ' . substitute(<q-args>,  '^[al]:\w\+\>\ze\s*\%($\|[^[:space:]=]\)', '\=eval(submatch(0))', ''))
endfunction

silent call SwitchDb()
map <Leader>n :call SwitchDb()<CR>
nmap <Leader>e :call SearchSelect()<CR>
vmap <Leader>e :Db<CR>
function! SearchSelect()
  let line1 = search('^select\|^update\|^create\|^delete from', 'cnb')
  let line2 = search(';$', 'cn')
  if line1 == 0
    echo "Query start not found"
    return
  endif
  if line1 == 0
    echo "Query end not found"
    return
  endif
  let lines = getbufline(bufnr('%'), line1, line2)
  let filtered = filter(lines, 'v:val !~ "--"')
  let query = join(filtered, ' ')
  echo query
  execute "silent Db ".query
endfunction

SQLSetType plsql
