
command! -nargs=0 Rschema :Rfind db/schema.rb
command! -nargs=0 RSschema :RSfind db/schema.rb
command! -nargs=0 RVschema :RVfind db/schema.rb



"Rnavcommand service app/services/ -suffix=.rb
"Rnavcommand worker app/workers/ -suffix=.rb
"Rnavcommand factory spec/factories/ -suffix=.rb
"Rnavcommand task lib/tasks -suffix=.rake
"Rnavcommand shared spec/traits -suffix=.rb
"Rnavcommand grid app/grids -suffix=.rb
"Rnavcommand trait app/traits -suffix=.rb
"Rnavcommand yml config -suffix=.yml
"Rnavcommand acceptance spec/acceptance -suffix=.rb

let g:ctags_command='ctags'
let g:rake_ctags_arguments='--regex-ruby="/^[ \t]*(trait|attr_accessor|has_many|belongs_to|has_one|metric|scope|alias|alias_method|named_scope|factory|define_method|class_attribute|filter|column)[ \t(]+:([A-Za-z_]+).*$/\2/f,function/"'
let root = rails#app().path()
let g:rails_ctags_arguments='--exclude='.root.'/db --exclude='.root.'/tmp --exclude='.root.'/node_modules --exclude='.root.'/public/assets --exclude='.root.'/vendor --languages=ruby '.g:rake_ctags_arguments
