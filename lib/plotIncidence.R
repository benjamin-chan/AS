plotIncidence <- function(df, filename) {
  dodge <- 0.5
  G <- 
    df %>% 
    mutate(x = factor(database, levels = c("MPCD", "Marketscan", "Medicare"))) %>% 
    mutate(facet = sprintf("%s\n%s", outcomeCategory, disease)) %>% 
    ggplot(aes(x = x, y = incidenceRate, color = exposure)) +
    geom_errorbar(aes(ymin = lower, ymax = upper), 
                  width = dodge / 2, 
                  position = position_dodge(width = dodge)) +
    geom_point(position = position_dodge(width = dodge)) +
    scale_x_discrete("") +
    scale_y_log10("Incidence rate (per 100 person-years)", 
                  breaks = c(0.01, 0.1, 1, 10), 
                  limits = c(1e-4, 20)) +
    scale_color_brewer("Exposure", palette = "Set1") +
    facet_wrap( ~ facet) +
    theme(legend.position = "top",
          panel.grid.major.x = element_blank(),
          panel.grid.minor.y = element_blank())
  ggsave(paste0("../figures/", filename, ".png"), dpi = 300)
  ggsave(paste0("../figures/", filename, ".svg"), dpi = 300)
}
