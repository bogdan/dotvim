" Dadbod

if !exists('g:development_db')
  let g:development_db=-1
endif
function! SwitchDb()
  let g:development_db= (g:development_db + 1) % 2
  if g:development_db == 0
    let g:current_db="postgresql:test_app_development"
  elseif g:development_db == 1
    let g:current_db = "postgres://ueqhp48dtsrrck:p2a521be9787787387f345564afdb311fef6c8d9299c2192814991151e295d9db@ec2-44-209-183-31.compute-1.amazonaws.com:5432/db8r6irjkb6q88"
  endif
  echo "Using ".g:current_db
  command! -bang -nargs=? -range=-1 -complete=custom,db#command_complete Db  exe db#execute_command('<mods>', <bang>0, <line1>, <count>, g:current_db . ' ' . substitute(<q-args>,  '^[al]:\w\+\>\ze\s*\%($\|[^[:space:]=]\)', '\=eval(submatch(0))', ''))
endfunction

silent call SwitchDb()
map <buffer> <Leader>n :call SwitchDb()<CR>
nmap <buffer> <Leader>e :call SearchSelect()<CR>
vmap <buffer> <Leader>e :Db<CR>

function! SearchSelect()
  let terms = ['with', 'select', 'update', 'delete from', 'create index', 'drop index', 'explain', 'create or replace', 'drop view']
  let pattern = join(map(terms, {_, v -> '^'.v}), '\|')
  let line1 = search(pattern, 'cnb')
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

set isk=@,48-57,_,192-255,!,?,-
" SQLSetType plsql
