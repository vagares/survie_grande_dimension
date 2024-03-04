

estimates_survival=function(nrep=1,n=200,p=100,a=0,rho=0.7,sr=0.5,b=1,beta0=0,
                            m1 =10.5,m0 = 10,nu=1,tau = 0.2){



Harrel_VC_Cox=matrix(0,nrow=nrep,ncol=1)
Harrel_VC_RF=matrix(0,nrow=nrep,ncol=1)

IBS_Cox=matrix(0,nrow=nrep,ncol=1)
IBS_RF=matrix(0,nrow=nrep,ncol=1)

for (m in 1:nrep){
  # generating dataset
  dat =data_gen(n,p,a,rho,sr,b,beta0,m1,m0,nu,ta)
  
  # Harrel_VC_Cox
  summaryCox = tryCatch(
    expr  = {est0 =}, error  =  function(cond) {
                           list()})
  
  Harrel_VC_Cox[m,]=
  Harrel_VC_RF[m,]=
    
  IBS_Cox[m,]=
  IBS_RF[m,]=
  
}
  


results=list()
results[[1]]=Harrel_VC_Cox
results[[2]]=IBS_Cox
results[[3]]=Harrel_VC_RF
results[[4]]=IBS_RF
names(Cox)=c("Harrel_VC","IBS_Cox","Harrel_VC_RF","IBS_RF")

return(results)

} 