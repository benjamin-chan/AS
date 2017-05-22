plotPrev <- function (db) {
  df %>% 
    filter(database == db) %>% 
    filter(exposure != "None") %>% 
    mutate(timeWindow = gsub("(\\wto\\windex)|(nths)", "", timeWindow)) %>% 
    mutate(disease = sprintf("%s\n%s", outcomeCategory, disease)) %>% 
    ggplot +
    labs(title = db) +
    aes(x = timeWindow, y = prevPer1000, fill = outcomeCategory) +
    geom_bar(stat = "identity") +
    facet_grid(disease ~ exposure) +
    scale_fill_brewer(palette = "Set1") +
    scale_x_discrete("Time window") +
    scale_y_sqrt("Prevalence (per 1,000)") +
    theme_bw() +
    theme(legend.position = "none",
          panel.grid.major.x = element_blank(),
          panel.grid.minor = element_blank(),
          plot.title = element_text(hjust = 0.5))
}
