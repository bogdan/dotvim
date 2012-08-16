command! -nargs=0 Rroutes :Rfind routes.rb
command! -nargs=0 RSroutes :RSfind routes.rb
command! -nargs=0 RVroutes :RVfind routes.rb

command! -nargs=0 Rschema :Rfind db/schema.rb
command! -nargs=0 RSschema :RSfind db/schema.rb
command! -nargs=0 RVschema :RVfind db/schema.rb



Rnavcommand jade app/jades/ -suffix=.jade
Rnavcommand service app/services/ -suffix=.rb
Rnavcommand worker app/workers/ -suffix=.rb
Rnavcommand factory spec/factories/ -suffix=.rb
Rnavcommand task lib/tasks -suffix=.rake
Rnavcommand shared spec/traits -suffix=.rb
Rnavcommand grid app/grids -suffix=.rb
Rnavcommand trait app/traits -suffix=.rb
Rnavcommand yml config -suffix=.yml
Rnavcommand acceptance spec/acceptance -suffix=.rb

let g:rake_ctags_arguments='--regex-ruby="/^[ \t]*(attr_accessor|has_many|belongs_to|has_one|scope)[ \t(]+:([A-Za-z_]+).*$/\2/f,function/"'
let g:rails_ctags_arguments='--exclude='.RailsRoot().'/public/system --exclude='.RailsRoot().'/public/uploads --languages=-javascript --langdef=coffee --langmap=coffee:.coffee --regex-coffee="/^class ([A-Za-z.]+)( extends [A-Za-z.]+)?$/\1/c,class/" --regex-coffee="/^[ \t]*@?([A-Za-z.]+):.*[-=]>.*$/\1/f,function/" --regex-coffee="/^[ \t]*([A-Za-z.]+)[ \t]+=.*[-=]>.*$/\1/f,function/" --regex-coffee="/^[ \t]*([A-Za-z.]+)[ \t]+=[^->\n]*$/\1/v,variable/" '.g:rake_ctags_arguments
