### generate multivariate binary data by direct conversion
### from multivariate normals   

rmvbin <- function (n, margprob,
                      commonprob=diag(margprob),
                      bincorr=diag(length(margprob)),
                      sigma=diag(length(margprob)),                      
                      colnames=NULL, simulvals=NULL) {

  if(missing(sigma))
    {
      if(!missing(commonprob))
        {
          if (missing(margprob))
            margprob <- diag(commonprob)
          sigma <- commonprob2sigma(commonprob, simulvals)
        }
      else if(!missing(bincorr))
        {
          commonprob <- bincorr2commonprob(margprob, bincorr)
          sigma <- commonprob2sigma(commonprob, simulvals)
        }
    }
  else if (any(eigen(sigma)$values<0))
    stop ("Sigma is not positive definite.")
  
  retval <- rmvnorm(n, qnorm(margprob, sd = sqrt(diag(sigma))), as.matrix(sigma))
  retval <- ra2ba(retval)
  dimnames(retval) <- list(NULL, colnames)
  retval
}
