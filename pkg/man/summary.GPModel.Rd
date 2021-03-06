% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/GPModel.R
\name{summary.GPModel}
\alias{summary.GPModel}
\title{Summary for a \code{GPModel}}
\usage{
\method{summary}{GPModel}(object, ...)
}
\arguments{
\item{object}{a \code{GPModel}}

\item{...}{(not used, ignore this, simply here that there is no CRAN warning)}
}
\value{
Summary of a (fitted) \code{GPModel}
}
\description{
Summary for a \code{GPModel}
}
\examples{
## SEE ALSO THE HELP OF 'fitGPModel' FOR MORE EXAMPLES
library(gpboost)

\dontrun{
#--------------------Grouped random effects model: single-level random effect----------------
n <- 100 # number of samples
m <- 25 # number of categories / levels for grouping variable
group <- rep(1,n) # grouping variable
for(i in 1:m) group[((i-1)*n/m+1):(i*n/m)] <- i
# Create random effects model
gp_model <- GPModel(group_data = group)

# Simulate data
sigma2_1 <- 1^2 # random effect variance
sigma2 <- 0.5^2 # error variance
# incidence matrix relating grouped random effects to samples
Z1 <- model.matrix(rep(1,n) ~ factor(group) - 1)
set.seed(1)
b1 <- sqrt(sigma2_1) * rnorm(m) # simulate random effects
eps <- Z1 \%*\% b1
xi <- sqrt(sigma2) * rnorm(n) # simulate error term
y <- eps + xi # observed data
# Fit model
fit(gp_model, y = y, std_dev = TRUE)
summary(gp_model)
# Alternatively, define and fit model directly using fitGPModel
gp_model <- fitGPModel(group_data = group, y = y, std_dev = TRUE)
summary(gp_model)


#--------------------Gaussian process model----------------
n <- 200 # number of samples
set.seed(1)
coords <- cbind(runif(n),runif(n)) # locations (=features) for Gaussian process
# Create Gaussian process model
gp_model <- GPModel(gp_coords = coords, cov_function = "exponential")

# Simulate data
sigma2_1 <- 1^2 # marginal variance of GP
rho <- 0.1 # range parameter
sigma2 <- 0.5^2 # error variance
D <- as.matrix(dist(coords))
Sigma = sigma2_1*exp(-D/rho)+diag(1E-20,n)
C = t(chol(Sigma))
b_1=rnorm(n) # simulate random effect
eps <- C \%*\% b_1
xi <- sqrt(sigma2) * rnorm(n) # simulate error term
y <- eps + xi
# Fit model
fit(gp_model, y = y, std_dev = TRUE)
summary(gp_model)
# Alternatively, define and fit model directly using fitGPModel
gp_model <- fitGPModel(gp_coords = coords, cov_function = "exponential",
                        y = y, std_dev = TRUE)
summary(gp_model)
}

}
