compareIncidenceRates <- function (db, exp, cat, dis) {
  require(magrittr)
  require(dplyr)
  require(epitools)
  midp.exact <-
    df %>% 
    filter(grepl(db, database)) %>% 
    filter(grepl(exp[1], exposure) | grepl(exp[2], exposure)) %>% 
    filter(grepl(cat, outcomeCategory)) %>% 
    filter(grepl(dis, disease)) %>% 
    select(c(incidence, personYears)) %>% 
    as.matrix %>% 
    rate2by2.test %>% 
    .[["p.value"]] %>% 
    .[2, 1]
  data.frame(database = db, outcomeCategory = cat, disease = dis,
             comparison = sprintf("%s vs %s", exp[1], exp[2]),
             pValue = as.numeric(midp.exact)) %>% 
    mutate(database = as.character(database),
           outcomeCategory = as.character(outcomeCategory),
           disease = as.character(disease),
           comparison = as.character(comparison))
}
