---
title: "Comorbidities and Disease Manifestations in Ankylosing Spondylitis (BAD AS)"
date: "2017-10-03 14:45:38"
author: Benjamin Chan (chanb@ohsu.edu)
output:
  html_document:
    toc: true
    theme: simplex
---
# Preamble

Set working directory.



Load libraries.


```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

Reproducibility steps.


```
## R version 3.3.3 (2017-03-06)
## Platform: x86_64-w64-mingw32/x64 (64-bit)
## Running under: Windows 7 x64 (build 7601) Service Pack 1
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  base     
## 
## other attached packages:
## [1] epitools_0.5-8   svglite_1.2.0    ggplot2_2.2.1    dplyr_0.5.0     
## [5] magrittr_1.5     rmarkdown_1.4    knitr_1.15.1     checkpoint_0.4.0
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.10     digest_0.6.12    rprojroot_1.2    assertthat_0.1  
##  [5] plyr_1.8.4       grid_3.3.3       R6_2.2.0         gtable_0.2.0    
##  [9] DBI_0.6          backports_1.0.5  scales_0.4.1     evaluate_0.10   
## [13] gdtools_0.1.4    stringi_1.1.3    lazyeval_0.2.0   tools_3.3.3     
## [17] stringr_1.2.0    munsell_0.4.3    colorspace_1.3-2 htmltools_0.3.5 
## [21] methods_3.3.3    tibble_1.2
```

Source user-defined functions.


```
##         ../lib/bindCompare.R ../lib/compareIncidenceRates.R ../lib/incCI.R
## value   ?                    ?                              ?             
## visible FALSE                FALSE                          FALSE         
##         ../lib/plotPrev.R ../lib/prevCI.R
## value   ?                 ?              
## visible FALSE             FALSE
```


## References


```
## 
## To cite R in publications use:
## 
##   R Core Team (2017). R: A language and environment for
##   statistical computing. R Foundation for Statistical Computing,
##   Vienna, Austria. URL https://www.R-project.org/.
## 
## A BibTeX entry for LaTeX users is
## 
##   @Manual{,
##     title = {R: A Language and Environment for Statistical Computing},
##     author = {{R Core Team}},
##     organization = {R Foundation for Statistical Computing},
##     address = {Vienna, Austria},
##     year = {2017},
##     url = {https://www.R-project.org/},
##   }
## 
## We have invested a lot of time and effort in creating R, please
## cite it when using it for data analysis. See also
## 'citation("pkgname")' for citing R packages.
```

```
## 
## To cite package 'epitools' in publications use:
## 
##   Tomas J. Aragon (2017). epitools: Epidemiology Tools. R package
##   version 0.5-8. https://CRAN.R-project.org/package=epitools
## 
## A BibTeX entry for LaTeX users is
## 
##   @Manual{,
##     title = {epitools: Epidemiology Tools},
##     author = {Tomas J. Aragon},
##     year = {2017},
##     note = {R package version 0.5-8},
##     url = {https://CRAN.R-project.org/package=epitools},
##   }
```
# Summarize prevalence, AS cohort

```
From: Curtis, Jeffrey R [mailto:jrcurtis@uabmc.edu] 
Sent: Thursday, May 11, 2017 10:59 AM
Subject: Table 1 Distribution of Characteristics of AS cohort by data source 1 year baseline

Here is table shell for table 1 for AS cohort. All covariates are measured in
baseline, although I think that we should have additional rows added for all
13 outcomes of interest, using all available leftward data (not just
baseline). So for example, someone who had history of uveitis, or cancer,
would appear as rows in this table.

This would be the same format for Aim II that provides the corresponding
information with each column representing the exposure episodes.
```


## Overall for the AS cohort

Read prevalence data.
See `queryPrevalentComorbidities.sas`.


|    |database   | denomPatid|
|:---|:----------|----------:|
|1   |MPCD       |       3000|
|89  |Marketscan |      11982|
|181 |Medicare   |      22584|

Table of **prevalence %**


|outcomeCategory            |disease                                   |timeWindow |MPCD AS cohort |Marketscan AS cohort |Medicare AS cohort |
|:--------------------------|:-----------------------------------------|:----------|:--------------|:--------------------|:------------------|
|Cancer                     |Hematologic Cancer                        |12 months  |0.5 (0.3-0.8)  |0.6 (0.4-0.7)        |1.6 (1.4-1.7)      |
|Cancer                     |Non Melanoma Skin Cancer                  |12 months  |0              |0.6 (0.5-0.8)        |1.9 (1.7-2.0)      |
|Cancer                     |Solid Cancer                              |12 months  |4.0 (3.3-4.7)  |3.5 (3.2-3.8)        |9.8 (9.4-10.2)     |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |12 months  |1.9 (1.5-2.4)  |1.3 (1.1-1.5)        |4.9 (4.6-5.2)      |
|Cardiac disease            |Conduction Block                          |12 months  |0.6 (0.4-1.0)  |1.3 (1.1-1.5)        |4.5 (4.2-4.8)      |
|Cardiac disease            |Myocardial infarction                     |12 months  |0.5 (0.3-0.8)  |0.6 (0.5-0.7)        |1.8 (1.6-2.0)      |
|Infection                  |Hospitalized infection                    |12 months  |5.2 (4.4-6.0)  |6.9 (6.5-7.4)        |19.4 (18.9-19.9)   |
|Infection                  |Opportunistic infection                   |12 months  |1.1 (0.7-1.5)  |1.0 (0.9-1.2)        |2.4 (2.2-2.7)      |
|Inflammatory bowel disease |Crohn’s Disease                           |12 months  |4.3 (3.6-5.0)  |3.6 (3.3-3.9)        |4.8 (4.5-5.1)      |
|Inflammatory bowel disease |Ulcerative Colitis                        |12 months  |2.5 (2.0-3.1)  |2.6 (2.3-2.9)        |2.7 (2.5-2.9)      |
|Kidney disease             |Amyloidosis                               |12 months  |0.0 (0.0-0.2)  |0.0 (0.0-0.1)        |0.1 (0.0-0.1)      |
|Kidney disease             |IgA nephropathy                           |12 months  |0.1 (0.0-0.3)  |0.1 (0.1-0.2)        |0.2 (0.2-0.3)      |
|Kidney disease             |Nephrotic syndrome                        |12 months  |0.0 (0.0-0.1)  |0.0 (0.0-0.1)        |0.2 (0.1-0.2)      |
|Lung disease               |Apical Pulmonary fibrosis                 |12 months  |0.0 (0.0-0.1)  |0.0 (0.0-0.1)        |0.0 (0.0-0.0)      |
|Lung disease               |Interstitial lung disease                 |12 months  |0.1 (0.0-0.2)  |0.1 (0.1-0.2)        |0.7 (0.6-0.8)      |
|Lung disease               |Restrictive lung disease                  |12 months  |1.3 (0.9-1.7)  |1.4 (1.2-1.6)        |3.2 (3.0-3.4)      |
|Neurological Disease       |Cauda Equina syndrome                     |12 months  |0.1 (0.0-0.3)  |0.1 (0.0-0.1)        |0.2 (0.2-0.3)      |
|Neurological Disease       |Spinal Cord compression                   |12 months  |0.2 (0.1-0.4)  |0.2 (0.2-0.3)        |0.9 (0.7-1.0)      |
|Osteoporotic fracture      |Clinical vertebral fracture               |12 months  |2.4 (1.9-3.0)  |2.2 (2.0-2.5)        |7.3 (7.0-7.7)      |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |12 months  |2.9 (2.4-3.6)  |1.9 (1.6-2.1)        |4.5 (4.2-4.8)      |
|PsO/PsA                    |Psoriasis                                 |12 months  |2.5 (2.0-3.1)  |2.7 (2.4-3.0)        |3.8 (3.5-4.0)      |
|PsO/PsA                    |Psoriatic arthritis                       |12 months  |3.7 (3.0-4.4)  |4.1 (3.7-4.4)        |5.0 (4.7-5.3)      |
|Uveitis                    |Uveitis                                   |12 months  |7.0 (6.2-8.0)  |7.6 (7.1-8.1)        |4.0 (3.8-4.3)      |


## By exposure

Read prevalence data.
See `queryPrevalentComorbidities.sas`.


|    |database   |exposure    | denomPatid| denomIndexExp|
|:---|:----------|:-----------|----------:|-------------:|
|1   |MPCD       |DMARD       |        421|           481|
|61  |MPCD       |NSAID       |        763|          1000|
|121 |MPCD       |No exposure |       1593|          1593|
|201 |MPCD       |TNF         |       1107|          1279|
|273 |Marketscan |DMARD       |       1799|          2045|
|361 |Marketscan |NSAID       |       3644|          4893|
|437 |Marketscan |No exposure |       5696|          5696|
|521 |Marketscan |TNF         |       4797|          5779|
|613 |Medicare   |DMARD       |       4231|          5193|
|705 |Medicare   |NSAID       |       8602|         12847|
|789 |Medicare   |No exposure |      13275|         13275|
|873 |Medicare   |TNF         |       4866|          5929|

Table of **prevalence %**


|outcomeCategory            |disease                                   |timeWindow |MPCD TNF       |MPCD DMARD    |MPCD NSAID    |MPCD No exposure |Marketscan TNF |Marketscan DMARD |Marketscan NSAID |Marketscan No exposure |Medicare TNF    |Medicare DMARD   |Medicare NSAID   |Medicare No exposure |
|:--------------------------|:-----------------------------------------|:----------|:--------------|:-------------|:-------------|:----------------|:--------------|:----------------|:----------------|:----------------------|:---------------|:----------------|:----------------|:--------------------|
|Cancer                     |Hematologic Cancer                        |12 months  |0.3 (0.1-0.7)  |0.2 (0.0-1.0) |0.1 (0.0-0.5) |0.8 (0.4-1.3)    |0.1 (0.1-0.3)  |0.8 (0.5-1.2)    |0.4 (0.3-0.6)    |0.8 (0.6-1.0)          |0.4 (0.3-0.6)   |1.6 (1.3-2.0)    |1.5 (1.3-1.7)    |2.0 (1.7-2.2)        |
|Cancer                     |Non Melanoma Skin Cancer                  |12 months  |0              |0             |0             |0                |0.5 (0.4-0.7)  |0.5 (0.3-0.9)    |0.9 (0.6-1.2)    |0.7 (0.5-1.0)          |1.2 (1.0-1.5)   |1.3 (1.0-1.6)    |1.9 (1.6-2.1)    |2.5 (2.3-2.8)        |
|Cancer                     |Solid Cancer                              |12 months  |2.6 (1.8-3.6)  |1.5 (0.7-2.8) |2.8 (1.9-4.0) |5.1 (4.1-6.3)    |1.8 (1.5-2.1)  |4.2 (3.4-5.1)    |3.6 (3.1-4.2)    |4.3 (3.8-4.9)          |5.7 (5.1-6.3)   |7.7 (7.0-8.4)    |9.1 (8.6-9.6)    |11.9 (11.4-12.5)     |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |12 months  |1.7 (1.1-2.5)  |0.6 (0.2-1.7) |0.2 (0.0-0.6) |2.4 (1.8-3.3)    |0.8 (0.6-1.1)  |0.9 (0.5-1.4)    |0.7 (0.5-1.0)    |1.8 (1.5-2.2)          |2.9 (2.5-3.4)   |3.7 (3.2-4.2)    |3.8 (3.5-4.1)    |6.1 (5.7-6.5)        |
|Cardiac disease            |Conduction Block                          |12 months  |0.2 (0.1-0.6)  |0             |0.7 (0.3-1.4) |1.0 (0.6-1.6)    |0.7 (0.5-1.0)  |1.1 (0.7-1.7)    |1.0 (0.7-1.3)    |1.9 (1.6-2.3)          |2.4 (2.1-2.9)   |3.0 (2.5-3.5)    |3.3 (3.0-3.6)    |5.9 (5.5-6.3)        |
|Cardiac disease            |Myocardial infarction                     |12 months  |0.3 (0.1-0.7)  |0             |0.1 (0.0-0.5) |0.8 (0.4-1.3)    |0.2 (0.1-0.3)  |0.1 (0.0-0.4)    |0.4 (0.2-0.6)    |0.9 (0.7-1.2)          |0.5 (0.3-0.7)   |0.9 (0.7-1.2)    |0.8 (0.7-1.0)    |2.5 (2.3-2.8)        |
|Infection                  |Hospitalized infection                    |12 months  |1.0 (0.6-1.7)  |1.2 (0.5-2.6) |0.7 (0.3-1.4) |8.7 (7.4-10.1)   |3.5 (3.1-4.0)  |4.8 (4.0-5.8)    |4.9 (4.3-5.5)    |9.1 (8.4-9.9)          |9.1 (8.4-9.9)   |13.8 (12.9-14.8) |13.3 (12.7-13.9) |24.5 (23.8-25.3)     |
|Infection                  |Opportunistic infection                   |12 months  |1.3 (0.8-2.1)  |1.0 (0.4-2.3) |0.5 (0.2-1.1) |1.0 (0.6-1.6)    |1.2 (0.9-1.5)  |1.5 (1.1-2.1)    |0.8 (0.6-1.1)    |1.1 (0.8-1.3)          |2.7 (2.3-3.2)   |2.8 (2.4-3.2)    |2.0 (1.7-2.2)    |2.6 (2.3-2.8)        |
|Inflammatory bowel disease |Crohn’s Disease                           |12 months  |5.8 (4.6-7.2)  |4.0 (2.5-6.0) |2.0 (1.3-3.0) |4.3 (3.4-5.3)    |5.5 (5.0-6.1)  |3.9 (3.1-4.8)    |1.8 (1.5-2.2)    |3.4 (3.0-3.9)          |8.4 (7.7-9.1)   |6.6 (5.9-7.3)    |3.1 (2.9-3.5)    |4.7 (4.3-5.0)        |
|Inflammatory bowel disease |Ulcerative Colitis                        |12 months  |3.0 (2.2-4.1)  |2.3 (1.2-3.9) |1.1 (0.6-1.9) |2.3 (1.7-3.2)    |3.6 (3.2-4.1)  |2.6 (2.0-3.3)    |1.2 (0.9-1.5)    |2.9 (2.5-3.4)          |3.9 (3.4-4.4)   |3.6 (3.1-4.1)    |1.7 (1.5-1.9)    |2.5 (2.3-2.8)        |
|Kidney disease             |Amyloidosis                               |12 months  |0              |0             |0             |0.1 (0.0-0.3)    |0.0 (0.0-0.1)  |0.0 (0.0-0.1)    |0.0 (0.0-0.1)    |0.0 (0.0-0.1)          |0.1 (0.0-0.2)   |0.0 (0.0-0.1)    |0.1 (0.0-0.1)    |0.1 (0.0-0.2)        |
|Kidney disease             |IgA nephropathy                           |12 months  |0.3 (0.1-0.7)  |0.2 (0.0-1.0) |0.1 (0.0-0.5) |0.0 (0.0-0.2)    |0.1 (0.1-0.2)  |0.0 (0.0-0.2)    |0.0 (0.0-0.1)    |0.2 (0.1-0.3)          |0.1 (0.1-0.2)   |0.2 (0.1-0.3)    |0.1 (0.1-0.2)    |0.3 (0.2-0.4)        |
|Kidney disease             |Nephrotic syndrome                        |12 months  |0.2 (0.0-0.5)  |0.2 (0.0-1.0) |0             |0.0 (0.0-0.2)    |0.1 (0.0-0.2)  |0.0 (0.0-0.2)    |0.0 (0.0-0.1)    |0.0 (0.0-0.1)          |0.2 (0.1-0.3)   |0.2 (0.1-0.4)    |0.1 (0.1-0.2)    |0.2 (0.1-0.3)        |
|Lung disease               |Apical Pulmonary fibrosis                 |12 months  |0              |0             |0             |0.0 (0.0-0.2)    |0.0 (0.0-0.1)  |0                |0                |0.0 (0.0-0.1)          |0               |0.0 (0.0-0.1)    |0.0 (0.0-0.1)    |0.0 (0.0-0.0)        |
|Lung disease               |Interstitial lung disease                 |12 months  |0              |0             |0             |0.1 (0.0-0.4)    |0.1 (0.0-0.2)  |0.1 (0.0-0.4)    |0.0 (0.0-0.1)    |0.2 (0.1-0.3)          |0.4 (0.3-0.6)   |1.1 (0.8-1.4)    |0.5 (0.4-0.6)    |0.7 (0.6-0.9)        |
|Lung disease               |Restrictive lung disease                  |12 months  |0.7 (0.3-1.3)  |0.4 (0.1-1.3) |0.9 (0.4-1.6) |1.9 (1.4-2.7)    |0.9 (0.7-1.1)  |0.7 (0.4-1.2)    |0.7 (0.5-1.0)    |1.8 (1.5-2.2)          |2.4 (2.1-2.9)   |3.4 (2.9-3.9)    |2.6 (2.3-2.9)    |3.6 (3.3-3.9)        |
|Neurological Disease       |Cauda Equina syndrome                     |12 months  |0              |0             |0             |0.3 (0.1-0.6)    |0.0 (0.0-0.0)  |0.1 (0.0-0.4)    |0                |0.1 (0.0-0.2)          |0.1 (0.1-0.3)   |0.0 (0.0-0.1)    |0.1 (0.0-0.1)    |0.3 (0.2-0.4)        |
|Neurological Disease       |Spinal Cord compression                   |12 months  |0.2 (0.0-0.5)  |0             |0.3 (0.1-0.8) |0.2 (0.1-0.5)    |0.2 (0.1-0.3)  |0.2 (0.1-0.5)    |0.5 (0.3-0.7)    |0.4 (0.2-0.5)          |0.3 (0.1-0.4)   |0.4 (0.3-0.6)    |0.5 (0.4-0.6)    |1.0 (0.9-1.2)        |
|Osteoporotic fracture      |Clinical vertebral fracture               |12 months  |1.3 (0.8-2.1)  |0.4 (0.1-1.3) |0             |0                |0.6 (0.4-0.8)  |0.8 (0.5-1.3)    |0                |0                      |1.8 (1.5-2.2)   |2.7 (2.3-3.1)    |0                |0                    |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |12 months  |2.0 (1.4-2.9)  |0.8 (0.3-2.0) |0             |0                |1.0 (0.8-1.3)  |1.0 (0.6-1.5)    |0                |0                      |2.9 (2.5-3.4)   |3.0 (2.6-3.5)    |0                |0                    |
|PsO/PsA                    |Psoriasis                                 |12 months  |4.3 (3.3-5.5)  |1.5 (0.7-2.8) |1.5 (0.9-2.4) |2.1 (1.5-2.9)    |4.4 (3.9-4.9)  |3.6 (2.8-4.4)    |1.9 (1.6-2.3)    |2.2 (1.8-2.6)          |7.0 (6.4-7.7)   |4.8 (4.3-5.4)    |2.9 (2.7-3.2)    |3.3 (3.0-3.6)        |
|PsO/PsA                    |Psoriatic arthritis                       |12 months  |6.5 (5.2-7.9)  |5.4 (3.6-7.7) |1.6 (1.0-2.5) |3.0 (2.2-3.9)    |7.1 (6.4-7.8)  |6.4 (5.4-7.5)    |2.3 (1.9-2.7)    |2.6 (2.2-3.0)          |10.5 (9.8-11.3) |8.1 (7.4-8.9)    |2.7 (2.4-3.0)    |3.5 (3.2-3.9)        |
|Uveitis                    |Uveitis                                   |12 months  |8.4 (7.0-10.1) |7.3 (5.2-9.9) |6.5 (5.1-8.2) |6.1 (5.0-7.3)    |7.8 (7.1-8.5)  |6.8 (5.8-7.9)    |6.7 (6.0-7.5)    |7.8 (7.1-8.5)          |6.9 (6.3-7.5)   |5.0 (4.4-5.6)    |3.8 (3.4-4.1)    |3.3 (3.0-3.6)        |
# Summarize prevalence, non-AS cohort

See `background/table shells.docx`, page 5, 
*Table XX: Prevalence of comorbidities by disease cohort and data source using all available prior data*,
right-hand columns for *Non-AS cohort*

Read prevalence data.
See `queryPrevalentComorbiditiesControl.sas`.


|   |database |cohort | denomPatid| denomControlCohort|
|:--|:--------|:------|----------:|------------------:|
|1  |MPCD     |Non-AS |    1139225|            1139225|
|93 |Medicare |Non-AS |    1844703|            1844703|

Table of **prevalence %**


|outcomeCategory            |disease                                   |timeWindow |MPCD Non-AS cohort |Medicare Non-AS cohort |
|:--------------------------|:-----------------------------------------|:----------|:------------------|:----------------------|
|Cancer                     |Hematologic Cancer                        |12 months  |0.6 (0.6-0.6)      |1.2 (1.2-1.2)          |
|Cancer                     |Non Melanoma Skin Cancer                  |12 months  |0.0 (0.0-0.0)      |0.7 (0.7-0.8)          |
|Cancer                     |Solid Cancer                              |12 months  |3.9 (3.8-3.9)      |8.8 (8.8-8.9)          |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |12 months  |0.9 (0.9-0.9)      |2.7 (2.6-2.7)          |
|Cardiac disease            |Conduction Block                          |12 months  |0.7 (0.7-0.7)      |2.3 (2.2-2.3)          |
|Cardiac disease            |Myocardial infarction                     |12 months  |0.2 (0.2-0.2)      |1.0 (1.0-1.0)          |
|Infection                  |Hospitalized infection                    |12 months  |2.2 (2.2-2.3)      |8.9 (8.8-8.9)          |
|Infection                  |Opportunistic infection                   |12 months  |0.4 (0.4-0.4)      |0.9 (0.8-0.9)          |
|Inflammatory bowel disease |Crohn’s Disease                           |12 months  |2.2 (2.1-2.2)      |0.3 (0.3-0.4)          |
|Inflammatory bowel disease |Ulcerative Colitis                        |12 months  |2.0 (2.0-2.0)      |0.4 (0.4-0.4)          |
|Kidney disease             |Amyloidosis                               |12 months  |0.0 (0.0-0.0)      |0.0 (0.0-0.0)          |
|Kidney disease             |IgA nephropathy                           |12 months  |0.1 (0.1-0.1)      |0.1 (0.1-0.1)          |
|Kidney disease             |Nephrotic syndrome                        |12 months  |0.0 (0.0-0.0)      |0.1 (0.1-0.1)          |
|Lung disease               |Apical Pulmonary fibrosis                 |12 months  |0.0 (0.0-0.0)      |0.0 (0.0-0.0)          |
|Lung disease               |Interstitial lung disease                 |12 months  |0.0 (0.0-0.0)      |0.0 (0.0-0.0)          |
|Lung disease               |Restrictive lung disease                  |12 months  |0.7 (0.6-0.7)      |1.3 (1.2-1.3)          |
|Neurological Disease       |Cauda Equina syndrome                     |12 months  |0.0 (0.0-0.0)      |0.0 (0.0-0.0)          |
|Neurological Disease       |Spinal Cord compression                   |12 months  |0.0 (0.0-0.0)      |0.1 (0.1-0.1)          |
|Osteoporotic fracture      |Clinical vertebral fracture               |12 months  |0.5 (0.4-0.5)      |1.1 (1.1-1.1)          |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |12 months  |1.2 (1.2-1.2)      |2.5 (2.5-2.6)          |
|PsO/PsA                    |Psoriasis                                 |12 months  |4.6 (4.6-4.7)      |1.0 (1.0-1.0)          |
|PsO/PsA                    |Psoriatic arthritis                       |12 months  |1.0 (1.0-1.1)      |0.2 (0.2-0.2)          |
|Uveitis                    |Uveitis                                   |12 months  |0.2 (0.2-0.2)      |0.2 (0.2-0.2)          |
# Summarize incidence

```
From: Curtis, Jeffrey R [mailto:jrcurtis@uabmc.edu] 
Sent: Thursday, May 11, 2017 10:59 AM
Subject: Table 1 Distribution of Characteristics of AS cohort by data source 1 year baseline

Here is table shell for table 1 for AS cohort. All covariates are measured in
baseline, although I think that we should have additional rows added for all
13 outcomes of interest, using all available leftward data (not just
baseline). So for example, someone who had history of uveitis, or cancer,
would appear as rows in this table.

This would be the same format for Aim II that provides the corresponding
information with each column representing the exposure episodes.
```

Read incidence data.
See `queryIncidenceOutcomes.sas`.


|    |database   |exposure    |     n|
|:---|:----------|:-----------|-----:|
|1   |MPCD       |DMARD       |   481|
|24  |MPCD       |NSAID       |  1000|
|47  |MPCD       |No exposure |  1593|
|70  |MPCD       |TNF         |  1279|
|93  |Marketscan |DMARD       |  2045|
|116 |Marketscan |NSAID       |  4893|
|139 |Marketscan |No exposure |  5696|
|162 |Marketscan |TNF         |  5779|
|185 |Medicare   |DMARD       |  5193|
|208 |Medicare   |NSAID       | 12847|
|231 |Medicare   |No exposure | 13275|
|254 |Medicare   |TNF         |  5929|

**Do not process outcomes that are in-progress**


```r
excludedOutcomes <- c("Hematologic Cancer", 
                      "Non Melanoma Skin Cancer", 
                      "Solid Cancer")
df <-
  df %>% 
  filter(!(disease %in% excludedOutcomes))
```

Table of **incidence per 100 person-years**


|outcomeCategory            |disease                                   |MPCD TNF         |MPCD DMARD       |MPCD NSAID       |MPCD No exposure   |Marketscan TNF   |Marketscan DMARD |Marketscan NSAID |Marketscan No exposure |Medicare TNF        |Medicare DMARD      |Medicare NSAID      |Medicare No exposure |
|:--------------------------|:-----------------------------------------|:----------------|:----------------|:----------------|:------------------|:----------------|:----------------|:----------------|:----------------------|:-------------------|:-------------------|:-------------------|:--------------------|
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |1.28 (0.77-1.99) |0.23 (0.01-1.30) |0.52 (0.14-1.33) |2.21 (1.58-3.01)   |0.80 (0.60-1.04) |0.99 (0.59-1.57) |0.80 (0.55-1.11) |1.74 (1.39-2.16)       |1.93 (1.70-2.19)    |2.85 (2.51-3.23)    |3.05 (2.81-3.31)    |4.69 (4.38-5.02)     |
|Cardiac disease            |Conduction Block                          |0.27 (0.07-0.68) |0.00 (0.00-0.86) |0.52 (0.14-1.33) |1.03 (0.62-1.60)   |0.72 (0.53-0.95) |0.83 (0.46-1.36) |1.20 (0.89-1.57) |2.09 (1.70-2.54)       |1.91 (1.69-2.17)    |2.50 (2.18-2.85)    |3.00 (2.76-3.25)    |4.79 (4.47-5.12)     |
|Cardiac disease            |Myocardial infarction                     |0.33 (0.11-0.78) |0.00 (0.00-0.86) |0.39 (0.08-1.13) |0.70 (0.37-1.19)   |0.21 (0.11-0.35) |0.27 (0.09-0.64) |0.30 (0.16-0.52) |0.92 (0.67-1.23)       |0.70 (0.57-0.86)    |1.17 (0.96-1.42)    |1.06 (0.92-1.22)    |2.07 (1.87-2.29)     |
|Infection                  |Hospitalized infection                    |3.35 (2.48-4.43) |2.62 (1.31-4.68) |2.10 (1.20-3.41) |10.46 (8.96-12.13) |5.82 (5.24-6.45) |7.15 (5.94-8.53) |6.06 (5.33-6.87) |11.84 (10.85-12.90)    |11.24 (10.63-11.87) |14.94 (14.07-15.84) |14.52 (13.95-15.12) |24.18 (23.39-24.98)  |
|Infection                  |Opportunistic infection                   |0.60 (0.27-1.14) |0.47 (0.06-1.70) |0.26 (0.03-0.93) |0.32 (0.12-0.70)   |0.66 (0.48-0.88) |0.94 (0.55-1.51) |0.40 (0.23-0.63) |0.63 (0.43-0.90)       |1.24 (1.06-1.45)    |1.53 (1.29-1.81)    |1.49 (1.32-1.67)    |1.66 (1.48-1.86)     |
|Inflammatory bowel disease |Crohn’s Disease                           |4.82 (3.75-6.11) |3.61 (2.02-5.95) |1.96 (1.10-3.23) |3.43 (2.63-4.39)   |4.77 (4.25-5.33) |3.82 (2.96-4.85) |1.60 (1.24-2.03) |3.44 (2.94-4.01)       |4.14 (3.79-4.52)    |3.81 (3.41-4.24)    |2.03 (1.83-2.24)    |3.18 (2.93-3.45)     |
|Inflammatory bowel disease |Ulcerative Colitis                        |2.54 (1.79-3.49) |0.94 (0.26-2.42) |0.91 (0.37-1.87) |1.97 (1.38-2.73)   |2.76 (2.38-3.20) |2.65 (1.94-3.52) |0.89 (0.63-1.22) |2.59 (2.16-3.09)       |2.10 (1.86-2.37)    |2.01 (1.72-2.32)    |1.18 (1.03-1.34)    |1.78 (1.59-1.98)     |
|Kidney disease             |Amyloidosis                               |0.00 (0.00-0.25) |0.00 (0.00-0.86) |0.00 (0.00-0.47) |0.16 (0.03-0.47)   |0.03 (0.00-0.11) |0.00 (0.00-0.20) |0.00 (0.00-0.09) |0.00 (0.00-0.07)       |0.07 (0.03-0.13)    |0.02 (0.00-0.08)    |0.04 (0.01-0.07)    |0.06 (0.03-0.10)     |
|Kidney disease             |IgA nephropathy                           |0.20 (0.04-0.58) |0.00 (0.00-0.86) |0.13 (0.00-0.72) |0.05 (0.00-0.30)   |0.12 (0.05-0.23) |0.00 (0.00-0.20) |0.02 (0.00-0.13) |0.12 (0.04-0.27)       |0.16 (0.10-0.24)    |0.12 (0.06-0.21)    |0.09 (0.05-0.14)    |0.21 (0.15-0.29)     |
|Kidney disease             |Nephrotic syndrome                        |0.13 (0.02-0.48) |0.00 (0.00-0.86) |0.00 (0.00-0.47) |0.00 (0.00-0.20)   |0.06 (0.02-0.15) |0.11 (0.01-0.40) |0.05 (0.01-0.17) |0.04 (0.00-0.15)       |0.15 (0.09-0.23)    |0.13 (0.07-0.23)    |0.06 (0.03-0.10)    |0.11 (0.07-0.17)     |
|Lung disease               |Apical Pulmonary fibrosis                 |0.00 (0.00-0.25) |0.00 (0.00-0.86) |0.00 (0.00-0.47) |0.05 (0.00-0.30)   |0.00 (0.00-0.05) |0.00 (0.00-0.20) |0.00 (0.00-0.09) |0.02 (0.00-0.11)       |0.00 (0.00-0.03)    |0.02 (0.00-0.08)    |0.02 (0.00-0.04)    |0.01 (0.00-0.04)     |
|Lung disease               |Interstitial lung disease                 |0.00 (0.00-0.25) |0.00 (0.00-0.86) |0.00 (0.00-0.47) |0.16 (0.03-0.47)   |0.07 (0.02-0.17) |0.16 (0.03-0.48) |0.00 (0.00-0.09) |0.12 (0.04-0.27)       |0.40 (0.30-0.52)    |0.90 (0.72-1.12)    |0.42 (0.33-0.52)    |0.60 (0.49-0.72)     |
|Lung disease               |Restrictive lung disease                  |0.81 (0.42-1.41) |0.00 (0.00-0.86) |1.16 (0.53-2.21) |2.19 (1.56-2.98)   |0.76 (0.57-1.00) |0.83 (0.46-1.37) |0.65 (0.43-0.95) |1.92 (1.55-2.35)       |2.04 (1.81-2.30)    |2.56 (2.24-2.92)    |2.07 (1.87-2.28)    |3.06 (2.81-3.33)     |
|Neurological Disease       |Cauda Equina syndrome                     |0.00 (0.00-0.25) |0.00 (0.00-0.86) |0.00 (0.00-0.47) |0.21 (0.06-0.55)   |0.03 (0.00-0.11) |0.05 (0.00-0.31) |0.00 (0.00-0.09) |0.02 (0.00-0.11)       |0.09 (0.05-0.15)    |0.01 (0.00-0.06)    |0.06 (0.03-0.11)    |0.14 (0.09-0.21)     |
|Neurological Disease       |Spinal Cord compression                   |0.07 (0.00-0.37) |0.00 (0.00-0.86) |0.26 (0.03-0.93) |0.21 (0.06-0.55)   |0.18 (0.09-0.31) |0.22 (0.06-0.56) |0.33 (0.18-0.55) |0.28 (0.16-0.48)       |0.20 (0.13-0.29)    |0.27 (0.18-0.40)    |0.33 (0.25-0.42)    |0.51 (0.41-0.62)     |
|Osteoporotic fracture      |Clinical vertebral fracture               |1.62 (1.04-2.40) |0.70 (0.14-2.05) |2.31 (1.37-3.65) |1.50 (1.00-2.17)   |2.91 (2.51-3.36) |3.31 (2.50-4.28) |3.78 (3.21-4.42) |3.20 (2.71-3.74)       |1.78 (1.56-2.02)    |2.56 (2.24-2.92)    |3.10 (2.86-3.36)    |2.86 (2.63-3.12)     |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |2.90 (2.10-3.91) |2.37 (1.13-4.35) |3.51 (2.32-5.11) |2.34 (1.70-3.14)   |2.96 (2.55-3.41) |3.45 (2.64-4.45) |3.32 (2.79-3.93) |3.78 (3.25-4.37)       |2.05 (1.81-2.31)    |2.44 (2.13-2.79)    |2.99 (2.75-3.25)    |2.94 (2.70-3.20)     |
|PsO/PsA                    |Psoriasis                                 |3.50 (2.61-4.60) |0.95 (0.26-2.43) |1.30 (0.62-2.39) |1.69 (1.15-2.40)   |3.77 (3.31-4.27) |3.13 (2.36-4.06) |1.64 (1.28-2.07) |1.94 (1.57-2.37)       |3.87 (3.54-4.23)    |3.39 (3.01-3.80)    |2.05 (1.85-2.26)    |2.27 (2.06-2.50)     |
|PsO/PsA                    |Psoriatic arthritis                       |5.68 (4.51-7.06) |5.11 (3.16-7.81) |1.03 (0.45-2.04) |2.24 (1.61-3.03)   |6.04 (5.45-6.68) |6.98 (5.79-8.34) |1.86 (1.47-2.31) |2.29 (1.88-2.76)       |5.28 (4.88-5.70)    |4.55 (4.11-5.03)    |1.51 (1.34-1.70)    |2.09 (1.89-2.31)     |
|Uveitis                    |Uveitis                                   |5.48 (4.33-6.84) |6.53 (4.27-9.57) |5.31 (3.79-7.23) |4.98 (3.99-6.14)   |5.94 (5.36-6.58) |6.59 (5.44-7.92) |5.81 (5.10-6.60) |6.68 (5.96-7.46)       |4.02 (3.68-4.39)    |2.94 (2.59-3.32)    |2.63 (2.40-2.87)    |2.15 (1.94-2.37)     |

## **TNF** versus **No exposure**

**MPCD**


```
## Error in table.margins(x): x is not an array
```

**Marketscan**


```
## Error in table.margins(x): x is not an array
```

**Medicare**


```
## Error in table.margins(x): x is not an array
```

## **TNF** versus **NSAID**

**MPCD**


```
## Error in table.margins(x): x is not an array
```

**Marketscan**


```
## Error in table.margins(x): x is not an array
```

**Medicare**


```
## Error in table.margins(x): x is not an array
```

## **TNF** versus **DMARD**

**MPCD**


```
## Error in table.margins(x): x is not an array
```

**Marketscan**


```
## Error in table.margins(x): x is not an array
```

**Medicare**


```
## Error in table.margins(x): x is not an array
```
# ACR 2017 abstract

**Do TNF Inhibitors Reduce the Incidence of Cardiac, Pulmonary and Neurologic Comorbidities in Ankylosing Spondylitis? An Analysis of Three Large US Claims Databases.**
Atul Deodhar, Kevin Winthrop, Benjamin Chan, Sarah Siegel, Jeffery Stark, Robert Suruki, Rhonda Bohn, Huifeng Yun, Lang Chen, Jeffery Curtis

Build tables for Atul's 2017 ACR abstract.
Collects code chunks from `summarizePrevalence.Rmd` and `summarizeIncidence.Rmd`.


## Prevalence, unadjusted

Prevalence is **12-month (6-month baseline to 6-month follow-up)**.


|outcomeCategory            |disease                                   | MPCD TNF | MPCD DMARD | MPCD NSAID or no exposure | Marketscan TNF | Marketscan DMARD | Marketscan NSAID or no exposure | Medicare TNF | Medicare DMARD | Medicare NSAID or no exposure |
|:--------------------------|:-----------------------------------------|:--------:|:----------:|:-------------------------:|:--------------:|:----------------:|:-------------------------------:|:------------:|:--------------:|:-----------------------------:|
|Cancer                     |Hematologic Cancer                        |   0.3    |    0.2     |             0             |      0.1       |       0.8        |                0                |     0.4      |      1.6       |               0               |
|Cancer                     |Non Melanoma Skin Cancer                  |   0.0    |    0.0     |             0             |      0.5       |       0.5        |                0                |     1.2      |      1.3       |               0               |
|Cancer                     |Solid Cancer                              |   2.6    |    1.5     |             0             |      1.8       |       4.2        |                0                |     5.7      |      7.7       |               0               |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |   1.7    |    0.6     |             0             |      0.8       |       0.9        |                0                |     2.9      |      3.7       |               0               |
|Cardiac disease            |Conduction Block                          |   0.2    |    0.0     |             0             |      0.7       |       1.1        |                0                |     2.4      |      3.0       |               0               |
|Cardiac disease            |Myocardial infarction                     |   0.3    |    0.0     |             0             |      0.2       |       0.1        |                0                |     0.5      |      0.9       |               0               |
|Infection                  |Hospitalized infection                    |   1.0    |    1.2     |             0             |      3.5       |       4.8        |                0                |     9.1      |      13.8      |               0               |
|Infection                  |Opportunistic infection                   |   1.3    |    1.0     |             0             |      1.2       |       1.5        |                0                |     2.7      |      2.8       |               0               |
|Inflammatory bowel disease |Crohn’s Disease                           |   5.8    |    4.0     |             0             |      5.5       |       3.9        |                0                |     8.4      |      6.6       |               0               |
|Inflammatory bowel disease |Ulcerative Colitis                        |   3.0    |    2.3     |             0             |      3.6       |       2.6        |                0                |     3.9      |      3.6       |               0               |
|Kidney disease             |Amyloidosis                               |   0.0    |    0.0     |             0             |      0.0       |       0.0        |                0                |     0.1      |      0.0       |               0               |
|Kidney disease             |IgA nephropathy                           |   0.3    |    0.2     |             0             |      0.1       |       0.0        |                0                |     0.1      |      0.2       |               0               |
|Kidney disease             |Nephrotic syndrome                        |   0.2    |    0.2     |             0             |      0.1       |       0.0        |                0                |     0.2      |      0.2       |               0               |
|Lung disease               |Apical Pulmonary fibrosis                 |   0.0    |    0.0     |             0             |      0.0       |       0.0        |                0                |     0.0      |      0.0       |               0               |
|Lung disease               |Interstitial lung disease                 |   0.0    |    0.0     |             0             |      0.1       |       0.1        |                0                |     0.4      |      1.1       |               0               |
|Lung disease               |Restrictive lung disease                  |   0.7    |    0.4     |             0             |      0.9       |       0.7        |                0                |     2.4      |      3.4       |               0               |
|Neurological Disease       |Cauda Equina syndrome                     |   0.0    |    0.0     |             0             |      0.0       |       0.1        |                0                |     0.1      |      0.0       |               0               |
|Neurological Disease       |Spinal Cord compression                   |   0.2    |    0.0     |             0             |      0.2       |       0.2        |                0                |     0.3      |      0.4       |               0               |
|Osteoporotic fracture      |Clinical vertebral fracture               |   1.3    |    0.4     |             0             |      0.6       |       0.8        |                0                |     1.8      |      2.7       |               0               |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |   2.0    |    0.8     |             0             |      1.0       |       1.0        |                0                |     2.9      |      3.0       |               0               |
|PsO/PsA                    |Psoriasis                                 |   4.3    |    1.5     |             0             |      4.4       |       3.6        |                0                |     7.0      |      4.8       |               0               |
|PsO/PsA                    |Psoriatic arthritis                       |   6.5    |    5.4     |             0             |      7.1       |       6.4        |                0                |     10.5     |      8.1       |               0               |
|Uveitis                    |Uveitis                                   |   8.4    |    7.3     |             0             |      7.8       |       6.8        |                0                |     6.9      |      5.0       |               0               |


## Incidence, unadjusted



**TNF vs NSAID or no exposure**


```
## Error in table.margins(x): x is not an array
```

```
## Error in inc[is.na(inc)] <- 0: object 'inc' not found
```

```
## Error in eval(expr, envir, enclos): object 'inc' not found
```

\newline

**TNF vs DMARD**


|outcomeCategory            |disease                                   | MPCD TNF | MPCD DMARD | MPCD p-value | Marketscan TNF | Marketscan DMARD | Marketscan p-value | Medicare TNF | Medicare DMARD | Medicare p-value |
|:--------------------------|:-----------------------------------------|:--------:|:----------:|:------------:|:--------------:|:----------------:|:------------------:|:------------:|:--------------:|:----------------:|
|Cancer                     |Hematologic Cancer                        |   0.2    |    0.2     |      NS      |      0.2       |       1.0        |       <0.001       |     0.5      |      1.2       |      <0.001      |
|Cancer                     |Non Melanoma Skin Cancer                  |   0.0    |    0.0     |      NS      |      0.8       |       1.1        |         NS         |     1.4      |      1.5       |        NS        |
|Cancer                     |Solid Cancer                              |   2.2    |    2.1     |      NS      |      1.9       |       4.7        |       <0.001       |     3.6      |      5.9       |      <0.001      |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |   1.3    |    0.2     |    0.050     |      0.8       |       1.0        |         NS         |     1.9      |      2.8       |      <0.001      |
|Cardiac disease            |Conduction Block                          |   0.3    |    0.0     |      NS      |      0.7       |       0.8        |         NS         |     1.9      |      2.5       |      0.004       |
|Cardiac disease            |Myocardial infarction                     |   0.3    |    0.0     |      NS      |      0.2       |       0.3        |         NS         |     0.7      |      1.2       |      <0.001      |
|Infection                  |Hospitalized infection                    |   3.4    |    2.6     |      NS      |      5.8       |       7.1        |         NS         |     11.2     |      14.9      |      <0.001      |
|Infection                  |Opportunistic infection                   |   0.6    |    0.5     |      NS      |      0.7       |       0.9        |         NS         |     1.2      |      1.5       |        NS        |
|Inflammatory bowel disease |Crohn.s Disease                           |   4.8    |    3.6     |      NS      |      4.8       |       3.8        |         NS         |     4.1      |      3.8       |        NS        |
|Inflammatory bowel disease |Ulcerative Colitis                        |   2.5    |    0.9     |    0.041     |      2.8       |       2.6        |         NS         |     2.1      |      2.0       |        NS        |
|Kidney disease             |Amyloidosis                               |   0.0    |    0.0     |      NS      |      0.0       |       0.0        |         NS         |     0.1      |      0.0       |        NS        |
|Kidney disease             |IgA nephropathy                           |   0.2    |    0.0     |      NS      |      0.1       |       0.0        |         NS         |     0.2      |      0.1       |        NS        |
|Kidney disease             |Nephrotic syndrome                        |   0.1    |    0.0     |      NS      |      0.1       |       0.1        |         NS         |     0.1      |      0.1       |        NS        |
|Lung disease               |Apical Pulmonary fibrosis                 |   0.0    |    0.0     |      NS      |      0.0       |       0.0        |         NS         |     0.0      |      0.0       |        NS        |
|Lung disease               |Interstitial lung disease                 |   0.0    |    0.0     |      NS      |      0.1       |       0.2        |         NS         |     0.4      |      0.9       |      <0.001      |
|Lung disease               |Restrictive lung disease                  |   0.8    |    0.0     |    0.048     |      0.8       |       0.8        |         NS         |     2.0      |      2.6       |      0.013       |
|Neurological Disease       |Cauda Equina syndrome                     |   0.0    |    0.0     |      NS      |      0.0       |       0.1        |         NS         |     0.1      |      0.0       |      0.013       |
|Neurological Disease       |Spinal Cord compression                   |   0.1    |    0.0     |      NS      |      0.2       |       0.2        |         NS         |     0.2      |      0.3       |        NS        |
|Osteoporotic fracture      |Clinical vertebral fracture               |   1.6    |    0.7     |      NS      |      2.9       |       3.3        |         NS         |     1.8      |      2.6       |      <0.001      |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |   2.9    |    2.4     |      NS      |      3.0       |       3.5        |         NS         |     2.0      |      2.4       |        NS        |
|PsO/PsA                    |Psoriasis                                 |   3.5    |    0.9     |    0.003     |      3.8       |       3.1        |         NS         |     3.9      |      3.4       |        NS        |
|PsO/PsA                    |Psoriatic arthritis                       |   5.7    |    5.1     |      NS      |      6.0       |       7.0        |         NS         |     5.3      |      4.6       |      0.020       |
|Uveitis                    |Uveitis                                   |   5.5    |    6.5     |      NS      |      5.9       |       6.6        |         NS         |     4.0      |      2.9       |      <0.001      |
