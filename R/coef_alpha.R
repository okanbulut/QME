#' Coefficient Alpha
#' 
#' This function computes coefficient alpha using the covariance matrix.
#' 
#' 
#' @param x is a data frame or matrix consisting of keyed item responses (0s and 1s).
#' @return This function returns the value of coefficient alpha, the 
#' lower and upper limits of Feldt's (1965) method, and standard error of
#' measurement for coefficient alpha.
#' 
#' @examples
#' library(QME)
#' data(math,math_key)
#' out = QMEtest(math, math_key)
#' x = getKeyedTestNoID(out)
#' coef_alpha(x)


coef_alpha = function(x, ...){
  
  # create covariance matrix of the data frame
  cov_matrix = cov(x, ...)
  

  # collect the number of rows from the covariance matrix
  k = nrow(cov_matrix)

  # collect the number of examinees
  n = nrow(x)
  
  # Compute Coefficient alpha
  alpha = k / (k - 1) *(1 - (sum(diag(cov_matrix)) / sum(cov_matrix) ))

  # Compute CI based on Feldt's (1965) method
  df_1 = n - 1
  df_2 = (n - 1) * (k - 1)

  lower_limit = 1 - ((1 - alpha) * qf(0.975, df_1, df_2))
  upper_limit = 1 - ((1 - alpha) * qf(0.0255, df_1, df_2))

  # Compute standard error measurement
  tot_var = sum(cov_matrix)
  sem = sqrt(tot_var * (1 - alpha))

  return(c(alpha = alpha, ll = lower_limit, ul = upper_limit, sem = sem))
}


