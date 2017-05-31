---
title: "Comorbidities and Disease Manifestations in Ankylosing Spondylitis (BAD AS)"
date: "2017-05-31 09:24:00"
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
# Plot prevalence

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

Plot using `plotPrev()`.

* MPCD [PNG](../figures/queryPrevalentComorbiditiesMPCD.png), [SVG](../figures/queryPrevalentComorbiditiesMPCD.svg)
* Marketscan [PNG](../figures/queryPrevalentComorbiditiesMarketscan.png), [SVG](../figures/queryPrevalentComorbiditiesMarketscan.svg)
* Medicare [PNG](../figures/queryPrevalentComorbiditiesMedicare.png), [SVG](../figures/queryPrevalentComorbiditiesMedicare.svg)



Table of **prevalence per 1,000**


|outcomeCategory            |disease                                   | MPCD TNF| MPCD DMARD| MPCD NSAID or no exposure| Marketscan TNF| Marketscan DMARD| Marketscan NSAID or no exposure| Medicare TNF| Medicare DMARD| Medicare NSAID or no exposure|
|:--------------------------|:-----------------------------------------|--------:|----------:|-------------------------:|--------------:|----------------:|-------------------------------:|------------:|--------------:|-----------------------------:|
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |    14.86|       8.32|                     20.05|          18.34|            21.03|                           28.14|        80.11|         108.61|                        116.64|
|Cardiac disease            |Conduction Block                          |     3.91|       8.32|                      8.10|          16.96|            24.45|                           24.65|        67.97|          85.88|                        105.08|
|Cardiac disease            |Myocardial infarction                     |     3.13|         NA|                      4.63|           5.19|             4.89|                            5.19|        17.03|          18.87|                         23.62|
|Inflammatory bowel disease |Crohn’s Disease                           |    60.99|      41.58|                     29.31|          63.85|            47.92|                           32.58|       103.56|          88.20|                         58.46|
|Inflammatory bowel disease |Ulcerative Colitis                        |    36.75|      31.19|                     20.05|          48.97|            29.83|                           26.16|        73.54|          71.63|                         48.69|
|Kidney disease             |Amyloidosis                               |       NA|         NA|                      0.39|           0.35|             0.49|                            0.28|         1.01|           0.58|                          1.88|
|Kidney disease             |IgA nephropathy                           |     0.78|       2.08|                      0.77|           2.25|             1.96|                            1.32|         6.75|           9.05|                          6.01|
|Kidney disease             |Nephrotic syndrome                        |     0.00|       0.00|                      0.00|           1.38|             0.98|                            0.57|         2.36|           4.81|                          3.10|
|Lung disease               |Apical Pulmonary fibrosis                 |       NA|         NA|                      0.00|           0.17|               NA|                            0.19|         0.17|           0.58|                          0.50|
|Lung disease               |Interstitial lung disease                 |     1.56|         NA|                      0.39|           0.69|             2.44|                            1.42|         3.37|           4.81|                          2.37|
|Lung disease               |Restrictive lung disease                  |    10.16|       6.24|                     15.81|          38.76|            44.50|                           46.75|       155.34|         201.42|                        179.70|
|Neurological Disease       |Cauda Equina syndrome                     |       NA|         NA|                      1.16|           0.52|             2.44|                            0.94|         2.19|           3.27|                          3.18|
|Neurological Disease       |Spinal Cord compression                   |     0.78|         NA|                      2.70|           2.77|             4.89|                            5.29|        16.70|          19.83|                         23.81|
|PsO/PsA                    |Psoriasis                                 |    41.44|      24.95|                     26.61|          50.87|            38.14|                           23.42|        99.34|          79.92|                         57.92|
|PsO/PsA                    |Psoriatic arthritis                       |    65.68|      47.82|                     24.30|          85.31|            61.61|                           28.61|       138.98|         101.29|                         53.94|
|Uveitis                    |Uveitis                                   |   113.37|      85.24|                     73.66|         133.76|           110.02|                          112.00|       134.42|         100.52|                         80.09|
