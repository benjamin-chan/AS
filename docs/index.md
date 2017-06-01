---
title: "Comorbidities and Disease Manifestations in Ankylosing Spondylitis (BAD AS)"
date: "2017-06-01 12:54:40"
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
## [1] svglite_1.2.0    ggplot2_2.2.1    dplyr_0.5.0      magrittr_1.5    
## [5] rmarkdown_1.4    knitr_1.15.1     checkpoint_0.4.0
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
##         ../lib/plotPrev.R
## value   ?                
## visible FALSE
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
# Summarize prevalence

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

Read prevalence data.
See `queryPrevalentComorbidities.sas`.


|    |database   |exposure             | denomPatid| denomIndexExp|
|:---|:----------|:--------------------|----------:|-------------:|
|1   |MPCD       |DMARD                |        421|           481|
|41  |MPCD       |NSAID or no exposure |       2083|          2593|
|105 |MPCD       |TNF                  |       1107|          1279|
|157 |Marketscan |DMARD                |       1799|          2045|
|217 |Marketscan |NSAID or no exposure |       8025|         10589|
|281 |Marketscan |TNF                  |       4797|          5779|
|345 |Medicare   |DMARD                |       4231|          5193|
|409 |Medicare   |NSAID or no exposure |      17983|         26122|
|473 |Medicare   |TNF                  |       4866|          5929|

Table of **prevalence %**


|outcomeCategory            |disease                                   | MPCD TNF| MPCD DMARD| MPCD NSAID or no exposure| Marketscan TNF| Marketscan DMARD| Marketscan NSAID or no exposure| Medicare TNF| Medicare DMARD| Medicare NSAID or no exposure|
|:--------------------------|:-----------------------------------------|--------:|----------:|-------------------------:|--------------:|----------------:|-------------------------------:|------------:|--------------:|-----------------------------:|
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |     1.49|       0.83|                      2.01|           1.83|             2.10|                            2.81|         8.01|          10.86|                         11.66|
|Cardiac disease            |Conduction Block                          |     0.39|       0.83|                      0.81|           1.70|             2.44|                            2.46|         6.80|           8.59|                         10.51|
|Cardiac disease            |Myocardial infarction                     |     0.31|         NA|                      0.46|           0.52|             0.49|                            0.52|         1.70|           1.89|                          2.36|
|Inflammatory bowel disease |Crohn’s Disease                           |     6.10|       4.16|                      2.93|           6.39|             4.79|                            3.26|        10.36|           8.82|                          5.85|
|Inflammatory bowel disease |Ulcerative Colitis                        |     3.67|       3.12|                      2.01|           4.90|             2.98|                            2.62|         7.35|           7.16|                          4.87|
|Kidney disease             |Amyloidosis                               |       NA|         NA|                      0.04|           0.03|             0.05|                            0.03|         0.10|           0.06|                          0.19|
|Kidney disease             |IgA nephropathy                           |     0.08|       0.21|                      0.08|           0.22|             0.20|                            0.13|         0.67|           0.91|                          0.60|
|Kidney disease             |Nephrotic syndrome                        |     0.00|       0.00|                      0.00|           0.14|             0.10|                            0.06|         0.24|           0.48|                          0.31|
|Lung disease               |Apical Pulmonary fibrosis                 |       NA|         NA|                      0.00|           0.02|               NA|                            0.02|         0.02|           0.06|                          0.05|
|Lung disease               |Interstitial lung disease                 |     0.16|         NA|                      0.04|           0.07|             0.24|                            0.14|         0.34|           0.48|                          0.24|
|Lung disease               |Restrictive lung disease                  |     1.02|       0.62|                      1.58|           3.88|             4.45|                            4.67|        15.53|          20.14|                         17.97|
|Neurological Disease       |Cauda Equina syndrome                     |       NA|         NA|                      0.12|           0.05|             0.24|                            0.09|         0.22|           0.33|                          0.32|
|Neurological Disease       |Spinal Cord compression                   |     0.08|         NA|                      0.27|           0.28|             0.49|                            0.53|         1.67|           1.98|                          2.38|
|PsO/PsA                    |Psoriasis                                 |     4.14|       2.49|                      2.66|           5.09|             3.81|                            2.34|         9.93|           7.99|                          5.79|
|PsO/PsA                    |Psoriatic arthritis                       |     6.57|       4.78|                      2.43|           8.53|             6.16|                            2.86|        13.90|          10.13|                          5.39|
|Uveitis                    |Uveitis                                   |    11.34|       8.52|                      7.37|          13.38|            11.00|                           11.20|        13.44|          10.05|                          8.01|
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


|   |database |exposure             |    n|
|:--|:--------|:--------------------|----:|
|1  |MPCD     |DMARD                |  423|
|17 |MPCD     |NSAID or no exposure | 2093|
|33 |MPCD     |TNF                  | 1108|

Table of **incidence per 100 person-years**


|outcomeCategory            |disease                                   | MPCD TNF| MPCD DMARD| MPCD NSAID or no exposure| Marketscan TNF| Marketscan DMARD| Marketscan NSAID or no exposure| Medicare TNF| Medicare DMARD| Medicare NSAID or no exposure|
|:--------------------------|:-----------------------------------------|--------:|----------:|-------------------------:|--------------:|----------------:|-------------------------------:|------------:|--------------:|-----------------------------:|
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |     1.34|       0.47|                      1.94|             NA|               NA|                              NA|           NA|             NA|                            NA|
|Cardiac disease            |Conduction Block                          |     0.33|       0.00|                      0.91|             NA|               NA|                              NA|           NA|             NA|                            NA|
|Cardiac disease            |Myocardial infarction                     |     0.33|       0.00|                      0.61|             NA|               NA|                              NA|           NA|             NA|                            NA|
|Inflammatory bowel disease |Crohn’s Disease                           |     4.69|       3.61|                      2.96|             NA|               NA|                              NA|           NA|             NA|                            NA|
|Inflammatory bowel disease |Ulcerative Colitis                        |     2.54|       0.95|                      1.62|             NA|               NA|                              NA|           NA|             NA|                            NA|
|Kidney disease             |Amyloidosis                               |     0.00|       0.00|                      0.11|             NA|               NA|                              NA|           NA|             NA|                            NA|
|Kidney disease             |IgA nephropathy                           |     0.20|       0.00|                      0.11|             NA|               NA|                              NA|           NA|             NA|                            NA|
|Kidney disease             |Nephrotic syndrome                        |     0.13|       0.00|                      0.00|             NA|               NA|                              NA|           NA|             NA|                            NA|
|Lung disease               |Apical Pulmonary fibrosis                 |     0.00|       0.00|                      0.04|             NA|               NA|                              NA|           NA|             NA|                            NA|
|Lung disease               |Interstitial lung disease                 |     0.00|       0.00|                      0.11|             NA|               NA|                              NA|           NA|             NA|                            NA|
|Lung disease               |Restrictive lung disease                  |     0.94|       0.00|                      2.00|             NA|               NA|                              NA|           NA|             NA|                            NA|
|Neurological Disease       |Cauda Equina syndrome                     |     0.00|       0.00|                      0.15|             NA|               NA|                              NA|           NA|             NA|                            NA|
|Neurological Disease       |Spinal Cord compression                   |     0.07|       0.00|                      0.30|             NA|               NA|                              NA|           NA|             NA|                            NA|
|PsO/PsA                    |Psoriasis                                 |     3.50|       0.95|                      1.62|             NA|               NA|                              NA|           NA|             NA|                            NA|
|PsO/PsA                    |Psoriatic arthritis                       |     5.27|       5.13|                      1.84|             NA|               NA|                              NA|           NA|             NA|                            NA|
|Uveitis                    |Uveitis                                   |     4.95|       6.55|                      4.86|             NA|               NA|                              NA|           NA|             NA|                            NA|
