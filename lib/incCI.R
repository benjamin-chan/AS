# Confidence interval for crude incidence rate
# Use the exact Poisson interval
# https://stats.stackexchange.com/a/15373/53863
# http://ms.mcmaster.ca/peter/s743/poissonalpha.html
# Returns a data frame
# incCI(c(1, 16, 120), rep(3000, 3))
incCI <- function (events, persontime, alpha = 0.05) {
  data.frame(rate = events / persontime,
             alpha = alpha,
             lower = qchisq(alpha / 2, 2 * events) / 2 / persontime, 
             upper = qchisq(1 - alpha / 2, 2 * (events + 1)) / 2 / persontime)
}
