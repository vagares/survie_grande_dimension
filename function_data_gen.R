
library(mvtnorm)    
library(pracma)


data_gen = function(n=200,p=100,a=0,rho=0.7,sr=0.5,b=1,beta0=0,
                    m1 =10.5,m0 = 10,nu=1,tau = 0.2 ){
  # n sample size
  # p number of covariates
  # a mean of covariates
  # rho parameter of covariance matrice
  # sr proportion of active variables
  # m1 the  median survival for an increase of one unit in an active covariate
  # m0 the desired baseline median survival
  # beta0 parameter beta0
  # b coefficients of active variables
  # tau censoring rate
  b = log((m0/m1)^nu)
  p_a = round(sr * p)
  p_na= p - p_a
  cov_a = diag(1,p_a)
  for (i in (1:p_a)){
    for (j in (1:p_a)){
      cov_a[i,j] = rho^(abs(j-i))
  }}
  cov_na = diag(1,p_na)
  for (i in (1:p_na)){
    for (j in (1:p_na)){
      cov_na[i,j] = rho^(abs((j-i)))
    }}
  X_a = rmvnorm(n, mean=rep(a,p_a), sigma = cov_a)
  X_na = rmvnorm(n, mean=rep(a,p_na), sigma = cov_na)
  X = cbind(X_a,X_na)
  
  lambda_x = exp(beta0)*exp(X_a[,1:p_a]%*%rep(b,p_a))
  U = runif(n)

  T = (-log(U)/lambda_x)^(1/nu)
  
  beta = c(rep(b,p_a),rep(0,p_na))
  mu = rep(a,p)
  cov1 = cbind(cov_a,matrix(0,p_a,p_na))
  cov2 = cbind(matrix(0,p_na,p_a),cov_na)
  cov = rbind(cov1,cov2)
  maxu= max(lambda_x)
  cens_int = function(theta){
    
  cens = function(u){
      term1 = (1/(u*sqrt(2*pi)*sqrt(t(beta)%*%cov%*%beta)))
      term2 = as.numeric(exp(-(log(u)-beta0-p_a*a*b)^2/(2*t(beta)%*%cov%*%beta)))
      return(1/(theta*nu*u^(1/nu))*as.numeric(gammainc( u*theta^nu,1/nu)[1])*term1*term2)}
 
  return(integrate(Vectorize(cens),lower =0.01,upper =maxu,subdivisions=100,stop.on.error = FALSE)$value - tau)}
  
  theta = uniroot(cens_int,interval = c(0.01,15))$root
  # comment fixer le max pour ne pas qu'il y ait d'erreur ?
  # car dans gammainc(x,a)[1]) on doit avoir que abs(-x + alog(x))<700
  C = runif(n,0,theta)
  To=pmin(T,C)
  delta=as.integer(T==To)
  
  return(list(To=To,delta=delta,X=X))
}

