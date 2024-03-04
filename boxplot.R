
source("scenarios.R")

scenarios_boxplot=scenarios

pname = "tau"
library(ggplot2)
library(gridExtra)

levelsvec=tauvec
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
  
  load(flname)
  
  boxplotHarrel=cbind(rep(1,times=nrep),
                             rep(scenarios_boxplot[[pname]][i],times=nrep),
                          results$Harrel_VC_Cox)
  
  boxplotHarrel=cbind(rep(2,times=nrep),
                      rep(scenarios_boxplot[[pname]][i],times=nrep),
                      results$Harrel_VC_RF)
  
  
}  
titlename=paste0("n=",unique(scenarios_boxplot[,2]),
                 ", ",pname)

colnames(boxplotHarrel)=c("Estimator",pname,"Harrel")
boxplotHarrel=data.frame(boxplotHarrel)

boxplotHarrel[,1]=factor(boxplotHarrel[,1],
                       levels=1:2,
                       labels=c("Cox","RF"))
boxplotHarrel[,2]=factor(boxplotHarrel[,2],
                         levels=levelsvec,
                         labels = as.character(levelsvec*100))
# Boxplots for beta
plotHarrel=ggplot(boxplotHarrel,aes(x=get(pname),y=Harrel,fill=Estimator))+
  geom_boxplot()+
  xlab("Fixed % of censoring")+
  ylab("Harrel")+
  geom_hline(yintercept=250,lty=1,col="orange")+
  ggtitle(titlename)

