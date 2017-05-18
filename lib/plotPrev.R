plotPrev <- function (db) {
  df %>% 
    filter(database == db) %>% 
    filter(exposure != "None") %>% 
    mutate(months = as.integer(substr(timeWindow, 1, 2))) %>% 
    mutate(disease = sprintf("%s\n%s", outcomeCategory, Disease)) %>% 
    ggplot +
    labs(title = db) +
    aes(x = months, y = prevPer1000, fill = outcomeCategory) +
    geom_bar(stat = "identity") +
    geom_line() +
    facet_grid(disease ~ exposure) +
    scale_fill_brewer(palette = "Set1") +
    scale_x_continuous("Time window (months)", breaks = seq(12, 36, 12)) +
    scale_y_sqrt("Prevalence (per 1,000)") +
    theme_bw() +
    theme(legend.position = "none",
          plot.title = element_text(hjust = 0.5))
}
