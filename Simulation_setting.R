
set.seed(23051986)

for (i in (1:nrow(scenarios))){
  nrep=scenarios[i,1]
  nsample=scenarios[i,2]
  psample=scenarios[i,3]
  asample=scenarios[i,4]
  rhosample=scenarios[i,5]
  srsample=scenarios[i,6]
  bsample=scenarios[i,7]
  beta0sample=scenarios[i,8]
  m1sample=scenarios[i,9]
  m0sample=scenarios[i,10]
  nusample=scenarios[i,11]
  tausample=scenarios[i,12]

  results=estimates_survival(nrep=nrep,n=nsample,p=psample,a=asample,rho=rhosample,sr=srsample,b=bsample,beta0=beta0sample,
                             m1 =m1sample,m0 = m0sample,nu=nusample,tau = tausample)
  
  flnameEst = "results"
  flname=paste0("./Results/",flnameEst,"_",
                    "nrep=",nrep,"_",
                    "n=",nsample,"_",
                    "p=",psample,"_",
                    "a=",asample,"_",
                "rho=",rhosample,"_",
                "sr=",srsample,"_",
                "b=",bsample,"_",
                "beta0=",beta0sample,"_",
                "m1=",m1sample,"_",
                "m0=",m0sample,"_",
                "nu=",nusample,"_",
                "tau=",tausample,"_",
                    ".RData")

save(results,file=flname)

print(i)  
}

