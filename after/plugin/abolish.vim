


iab tt title



set nocompatible

if filereadable('vimrc')
    source vimrc
endif

"
" General
"

iab crt create
iab Tr Traits
Abolish er{,s} error{,s}
Abolish ele{,s} element{,s}
Abolish aru{,s} argument{,s}


"
" Ruby
"

iab prot protected
iab priv private
iab publ public
iab inc include


" ActiveRecord

iab dpds :dependent => :destroy

Abolish v{p,s,u,n,i,e,f}o validates_{presence,size,uniqueness,numericality,inclusion,existence,format}_of 
iab int integer
iab str string


iab cond conditions


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
iab pgnt paginate
iab ppp :page => params[:page]
iab pppp paginate(:page => params[:page])

iab pid params[:id]
iab fpid find(params[:id])

" ActiveSupport

iab bl blank?

