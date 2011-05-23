Abolish ir{,s,id,ids,p,sp,c} industr{y,ies,y_id,y_ids,_controller}
Abolish cm{,s,id,ids,p,sp,c} compan{y,ies,y_id,y_ids,_controller}
Abolish se{,s,id,ids,p,sp,c} securit{y,ies,y_id,y_ids,_controller}
Abolish ac{,s,id,ids,p,sp,c} activit{y,ies,y_id,y_ids,_controller}
Abolish jo{,s,id,ids,p,sp,c} job_opportunit{y,ies,y_id,y_ids,_controller}



Abolish sg{,s,id,ids,p,sp,c} suggestion{,s,_id,_ids,_controller}
Abolish ct{,s,id,ids,p,sp,c} comment{,s,_id,_ids,_controller}
Abolish cs{,id,ids,p,sp,c} customer{,_id,_ids,_controller}
Abolish rj{,s,id,ids,p,sp,c} recommended_job{,s,_id,_ids,_controller}
Abolish zc{,s,id,ids,p,sp,c} zip_code{,s,_id,_ids,_controller}
"Abolish rp{,s,id,ids,p,sp,c} report{,s,_id,_ids,_controller}
"Abolish ds{,s,id,ids,p,sp,c} distribution{,s,_id,_ids,_controller}
Abolish fi{,s,id,ids,p,sp,c} feed_item{,s,_id,_ids,_controller}
"Abolish ed{,s,id,ids,p,sp,c} education{,s,_id,_ids,_controller}
"Abolish fn{,s,id,ids,p,sp,c} function{,s,_id,_ids,_controller}
"Abolish ll{,s,id,ids,p,sp,c} level{,s,_id,_ids,_controller}
Abolish pr{,s,id,ids,p,sp,c} profile{,s,_id,_ids,_controller}
"Abolish pt{,s,id,ids,p,sp,c} partner{,s,_id,_ids,_controller}
"Abolish mp{,s,id,ids,p,sp,c} matching_profile{,s,_id,_ids,_controller}
"Abolish me{,s,id,ids,p,sp,c} metro_area{,s,_id,_ids,_controller}
"Abolish ln{,s,id,ids,p,sp,c} location{,s,_id,_ids,_controller}
Abolish tt{,s,id,ids,p,sp,c} title{,s,_id,_ids,_controller}
"Abolish jt{,s,id,ids,p,sp,c} job_title{,s,_id,_ids,_controller}

iab Wz Wizard


set nocompatible

if filereadable('vimrc')
    source vimrc
endif

"
" General
"

iab crt create
iab Tr Traits
Abolish req{,s} request{,s}
Abolish er{,s} error{,s}
Abolish impl{,s} implementation{,s}
Abolish bhvr{,s} behavior{,s}
Abolish assoc{,s} associations{,s}
Abolish ele{,s} element{,s}
Abolish aru{,s} argument{,s}


"
" Ruby
"

iab prot protected
iab priv private
iab publ public
iab inc include
iab ts to_s



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

