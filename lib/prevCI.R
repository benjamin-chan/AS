# Confidence interval for prevalence
# Use the Jeffreys interval
# https://stats.stackexchange.com/a/28347/53863
# https://en.wikipedia.org/wiki/Binomial_proportion_confidence_interval#Jeffreys_interval
# Returns a data frame
# prevCI(c(1, 16, 120), rep(3000, 3))
prevCI <- function (numer, denom, alpha = 0.05) {
  data.frame(p = numer / denom,
             alpha = alpha,
             lower = qbeta(alpha / 2, numer + 0.5, denom - numer + 0.5), 
             upper = qbeta(1 - alpha / 2, numer + 0.5, denom - numer + 0.5))
}
