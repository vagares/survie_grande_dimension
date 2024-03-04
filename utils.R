risk = function(t,lambda,nu){
  return(lambda* nu*t^{nu-1})
}

RISK_c = function(t,lambda,nu){
  return(lambda*t^{nu})
}
survie = function(t,lambda,nu){
  return(exp(-lambda*t^{nu}))
}

dens = function(t,lambda,nu){
  return(lambda* nu*t^{nu-1}*exp(-lambda*t^{nu}))
}


HarrelC_index = function(m,To,delta){
  num = 0
  denom = 0
  for (i in(1:length(m))){
    for (j in(1:length(m))){
      if (j != i){
        if ( (To[i]>To[j]) & (m[i]<m[j]) & (delta[j]==1)) {num = 1}
        if ( (To[i]>To[j]) &  (delta[j]==1)) {denom = 1}
      }
  }
  }
  return(num/denom)}



HarrelC_index_risk = function(To,delta,lambdax,nu){
  num = 0
  denom = 0
  for (i in(1:length(To))){
    for (j in(1:length(To))){
      if (j != i){
        if ( (To[i]>To[j]) & (risk(To[j],lambda_x[i],nu)<risk(To[j],lambda_x[j],nu)) & (delta[j]==1)) {num = 1}
        if ( (To[i]>To[j]) &  (delta[j]==1)) {denom = 1}
      }
    }
  }
  return(num/denom)}