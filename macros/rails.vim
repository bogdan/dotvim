
command! -nargs=0 Rschema :Rfind db/schema.rb
command! -nargs=0 RSschema :RSfind db/schema.rb
command! -nargs=0 RVschema :RVfind db/schema.rb



"Rnavcommand service app/services/ -suffix=.rb
Rnavcommand worker app/workers/ -suffix=.rb
"Rnavcommand factory spec/factories/ -suffix=.rb
"Rnavcommand task lib/tasks -suffix=.rake
Rnavcommand shared spec/traits -suffix=.rb
"Rnavcommand grid app/grids -suffix=.rb
Rnavcommand trait app/traits -suffix=.rb
"Rnavcommand yml config -suffix=.yml
Rnavcommand acceptance spec/acceptance -suffix=.rb

let g:ctags_command='ctags'
let g:rake_ctags_arguments='--regex-ruby="/^[ \t]*(trait|attr_accessor|has_many|belongs_to|has_one|metric|scope|alias|alias_method|named_scope|factory)[ \t(]+:([A-Za-z_]+).*$/\2/f,function/"'
let g:rails_ctags_arguments='--exclude='.RailsRoot().'/tmp --exclude='.RailsRoot().'/public/system --exclude='.RailsRoot().'/public/uploads --languages=-javascript --langdef=coffee --langmap=coffee:.coffee --regex-coffee="/^class ([A-Za-z.]+)( extends [A-Za-z.]+)?$/\1/c,class/" --regex-coffee="/^[ \t]*@?([A-Za-z.]+):.*[-=]>.*$/\1/f,function/" --regex-coffee="/^[ \t]*([A-Za-z.]+)[ \t]+=.*[-=]>.*$/\1/f,function/" --regex-coffee="/^[ \t]*([A-Za-z.]+)[ \t]+=[^->\n]*$/\1/v,variable/" '.g:rake_ctags_arguments
