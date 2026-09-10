
command! -nargs=0 Rschema :Rfind db/schema.rb
command! -nargs=0 RSschema :RSfind db/schema.rb
command! -nargs=0 RVschema :RVfind db/schema.rb

let g:ctags_command = trim(system('brew --prefix universal-ctags')) . '/bin/ctags'
let g:rake_ctags_arguments='--kinddef-ruby=d,definition,definitions --regex-ruby="/^[ \t]*(trait|attr_accessor|has_many|belongs_to|has_one|metric|scope|alias|alias_method|named_scope|factory|define_method|class_attribute|filter|column|attribute)[ \t(]+:([A-Za-z_]+).*$/\2/d/" --regex-ruby="/^\#  ([a-z_][a-z0-9_]*)[ \t]+:[a-z]/\1/d/"'
let root = rails#app().path()
let g:rails_ctags_arguments='--exclude='.root.'/db --exclude='.root.'/tmp --exclude='.root.'/node_modules --exclude='.root.'/.venv --exclude='.root.'/public/assets --exclude='.root.'/vendor --languages=ruby '.g:rake_ctags_arguments
