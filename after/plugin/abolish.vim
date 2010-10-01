
set nocompatible

if filereadable('vimrc')
    source vimrc
endif

"
" General
"

Abolish crt create
Abolish req{,s} request{,s}
Abolish er{,s} error{,s}
Abolish impl{,s} implementation{,s}
Abolish bhvr{,s} behavior{,s}
Abolish assoc{,s} associations{,s}
Abolish tr{,s} trait{,s}
Abolish ele{,s} element{,s}
Abolish aru{,s} argument{,s}


"
" Ruby
"

Abolish prot protected
Abolish priv private
Abolish publ public
Abolish inc{,s} include{,s}
Abolish ts to_s



" ActiveRecord

Abolish dpds :dependent => :destroy

Abolish v{p,s,u,n,i,e,f}o validates_{presence,size,uniqueness,numericality,inclusion,existence,format}_of 
Abolish int integer
Abolish str string


Abolish cond{,s} condition{,s}


" Rspec
Abolish bnil be_nil
Abolish subj subject
Abolish resp response

Abolish s{d,n} should{,_not}
Abolish s{d,n}b{n,e,s,t,f,v,r} should{,_not} be_{nil,empty,success,true,false,valid,redirect}


" ActionView
Abolish obj{,s} object{,s}

" ActionController

Abolish cont{,s} controller{,s}
Abolish pgnt paginate
Abolish ppp :page => params[:page]
Abolish pppp paginate(:page => params[:page])

Abolish pid params[:id]
Abolish fpid find(params[:id])

" ActiveSupport

Abolish bl blank?

