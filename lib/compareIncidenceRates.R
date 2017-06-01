compareIncidenceRates <- function (db, exp, cat, dis) {
  require(magrittr)
  require(dplyr)
  require(epitools)
  midp.exact <-
    df %>% 
    filter(database == db) %>% 
    filter(exposure %in% exp) %>% 
    filter(outcomeCategory == cat) %>% 
    filter(disease == dis) %>% 
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
