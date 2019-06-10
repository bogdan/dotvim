call ale#Set('scilla_checker_executable', 'scilla-checker')

function! Zz(buffer, lines) abort
    try
        let l:data = json_decode(join(a:lines, "\n"))
    catch
        return []
    endtry
    if !has_key(l:data, 'errors')
      return []
    endif
    "echo join(a:lines, "\n")

    let l:errors = l:data['errors']

    let l:output = []
    for l:error in l:errors
        let l:start_location = l:error['start_location']
        let l:message = trim(l:error['error_message'])
        let l:last_symbol = l:message[len(message) - 1]
        if l:last_symbol != ':'
          call add(l:output, {
                \   'lnum': start_location['line'],
                \   'col': start_location['column'],
                \   'text': message,
                \})
        endif
        "\   'code': l:error['cop_name'],
        "\   'end_col': l:start_col + l:error['location']['length'] - 1,
        "\   'type': ale_linters#ruby#rubocop#GetType(l:error['severity']),
    endfor
    "echo l:output

    return l:output
endfunction

call ale#linter#Define('scilla', {
\   'name': 'checker',
\   'executable': {b -> ale#Var(b, 'scilla_checker_executable')},
\   'command': '%e  -jsonerrors -libdir /Users/bogdan/makabu/unstoppable/scilla/src/stdlib %t',
\   'output_stream': 'both',
\   'callback': {b, l -> Zz(b, l)},
\})
"\   'callback': function('ale_linters#scilla#HandleCheckerOutput'),
