n=200
p=100
a=0
rho=0.7
sr=0.5
b=1
beta0=0
m1 =10.5
m0 = 10
nu=1
tauvec = c(0.2,0.4,0.6) 
     

nrep=1  # number of repetitions

scenarios=NULL
for (i in 1:length(tauvec)){
      scenarios=rbind(scenarios,c(nrep,n,p,a,rho,sr,b,beta0,m1,m0,nu,tauvec[i]))
}


colnames(scenarios)=c("nrep","n","p","a","rho","sr","b","beta0",
                              "m1","m0","nu","tau")

scenarios=data.frame(scenarios)

