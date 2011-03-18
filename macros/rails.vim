command! -nargs=0 Rroutes :Rfind routes.rb
command! -nargs=0 RSroutes :RSfind routes.rb
command! -nargs=0 RVroutes :RVfind routes.rb

command! -nargs=0 Rschema :Rfind db/schema.rb
command! -nargs=0 RSschema :RSfind db/schema.rb
command! -nargs=0 RVschema :RVfind db/schema.rb



Rnavcommand sass app/stylesheets/ -suffix=.sass
Rnavcommand factory spec/factories/ -suffix=.rb
Rnavcommand task lib/tasks -suffix=.rake
Rnavcommand shared spec/traits -suffix=.rb
Rnavcommand feature features -suffix=.feature
Rnavcommand report app/reports -suffix=.rb
Rnavcommand steps features/step_definitions -suffix=_steps.rb
Rnavcommand trait app/traits -suffix=.rb
Rnavcommand notifier app/notifiers -suffix=.rb
Rnavcommand worker app/workers -suffix=.rb
Rnavcommand util app/utils -suffix=.rb
