covariateBalance <- function (type, var, lab) {
  require(magrittr)
  require(dplyr)
  require(ggplot2)
  df <- df %>% setNames(gsub(var, "y", names(df)))
  if (type == "dichotomous") {
    tab <- 
      df %>% 
      group_by(exposure, psDecile) %>% 
      summarize(denom = length(ps), min = min(ps), max = max(ps),
                numer = sum(y)) %>% 
      mutate(y = numer / denom)
    lim <- c(0, 1)
  } else if (type == "continuous") {
    tab <- 
      df %>% 
      group_by(exposure, psDecile) %>% 
      summarize(denom = length(ps), min = min(ps), max = max(ps),
                y = mean(y, na.rm = TRUE))
    lim <- df %>% ungroup() %>% summarize(min = min(y), max = max(y)) %>% as.numeric
  }
  G <- 
    tab %>% 
    group_by(exposure) %>% 
    mutate(size = denom / sum(denom)) %>% 
    ggplot +
    aes(x = factor(psDecile), y = y, color = exposure, group = exposure) +
    geom_point(aes(size = size), alpha = 1/2) +
    geom_line() +
    labs(title = sprintf("Covariate balance: %s", lab)) +
    scale_x_discrete("TNF propensity score decile") +
    scale_y_continuous(lab) +
    scale_color_brewer("", palette = "Set1") +
    scale_size_continuous("Within group %", guide = "none") +
    theme(legend.position = "bottom",
          plot.title = element_text(hjust = 0.5))
  list(type = type,
       variable = var,
       label = lab,
       table = tab,
       ggObject = G)
}
