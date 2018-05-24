compareIncidenceRates <- function (db, exp, cat, dis) {
  require(magrittr)
  require(dplyr)
  require(epitools)
  obj <-
    df %>% 
    filter(grepl(db, database)) %>% 
    filter(grepl(exp[1], exposure) | grepl(exp[2], exposure)) %>% 
    filter(grepl(cat, outcomeCategory)) %>% 
    filter(grepl(dis, disease)) %>% 
    select(c(nEvents, personYears)) %>% 
    as.matrix %>% 
    rate2by2.test
  pValue <- obj %>% .[["p.value"]] %>% .[2, 1] %>% as.numeric
  tab <- obj %>% .[["x"]]
  data.frame(database = db, outcomeCategory = cat, disease = dis,
             comparison = sprintf("%s vs %s", exp[1], exp[2]),
             rate1 = tab[2, 1] / tab[2, 2] * 100,
             rate2 = tab[1, 1] / tab[1, 2] * 100,
             pValue = pValue) %>% 
    mutate(database = as.character(database),
           outcomeCategory = as.character(outcomeCategory),
           disease = as.character(disease),
           comparison = as.character(comparison))
}
