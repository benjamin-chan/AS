---
title: "Comorbidities and Disease Manifestations in Ankylosing Spondylitis (BAD AS)"
date: "2017-05-25 08:07:19"
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



Plot using `plotPrev()`.

* MPCD [PNG](../figures/queryPrevalentComorbiditiesMPCD.png), [SVG](../figures/queryPrevalentComorbiditiesMPCD.svg)
* Marketscan [PNG](../figures/queryPrevalentComorbiditiesMarketscan.png), [SVG](../figures/queryPrevalentComorbiditiesMarketscan.svg)
* Medicare [PNG](../figures/queryPrevalentComorbiditiesMedicare.png), [SVG](../figures/queryPrevalentComorbiditiesMedicare.svg)



Table of **prevalence per 1,000**


|outcomeCategory            |disease                                   | MPCD NSAID or no exposure| MPCD DMARD| MPCD TNF| Marketscan NSAID or no exposure| Marketscan DMARD| Marketscan TNF| Medicare NSAID or no exposure| Medicare DMARD| Medicare TNF|
|:--------------------------|:-----------------------------------------|-------------------------:|----------:|--------:|-------------------------------:|----------------:|--------------:|-----------------------------:|--------------:|------------:|
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |                     20.05|       8.32|    14.86|                           28.14|            21.03|          18.34|                        116.64|         108.61|        80.11|
|Cardiac disease            |Conduction Block                          |                      8.10|       8.32|     3.91|                           24.65|            24.45|          16.96|                        105.08|          85.88|        67.97|
|Cardiac disease            |Myocardial infarction                     |                      4.63|         NA|     3.13|                            5.19|             4.89|           5.19|                         23.62|          18.87|        17.03|
|Inflammatory bowel disease |Crohn’s Disease                           |                     29.31|      41.58|    60.99|                           32.58|            47.92|          63.85|                         58.46|          88.20|       103.56|
|Inflammatory bowel disease |Ulcerative Colitis                        |                     20.05|      31.19|    36.75|                           26.16|            29.83|          48.97|                         48.69|          71.63|        73.54|
|Kidney disease             |Amyloidosis                               |                      0.39|         NA|       NA|                            0.28|             0.49|           0.35|                          1.88|           0.58|         1.01|
|Kidney disease             |IgA nephropathy                           |                      0.77|       2.08|     0.78|                            1.32|             1.96|           2.25|                          6.01|           9.05|         6.75|
|Kidney disease             |Nephrotic syndrome                        |                      0.00|       0.00|     0.00|                            0.57|             0.98|           1.38|                          3.10|           4.81|         2.36|
|Lung disease               |Apical Pulmonary fibrosis                 |                      0.00|         NA|       NA|                            0.19|               NA|           0.17|                          0.50|           0.58|         0.17|
|Lung disease               |Interstitial lung disease                 |                      0.39|         NA|     1.56|                            1.42|             2.44|           0.69|                          2.37|           4.81|         3.37|
|Lung disease               |Restrictive lung disease                  |                     15.81|       6.24|    10.16|                           46.75|            44.50|          38.76|                        179.70|         201.42|       155.34|
|Neurological Disease       |Cauda Equina syndrome                     |                      1.16|         NA|       NA|                            0.94|             2.44|           0.52|                          3.18|           3.27|         2.19|
|Neurological Disease       |Spinal Cord compression                   |                      2.70|         NA|     0.78|                            5.29|             4.89|           2.77|                         23.81|          19.83|        16.70|
|PsO/PsA                    |Psoriasis                                 |                     26.61|      24.95|    41.44|                           23.42|            38.14|          50.87|                         57.92|          79.92|        99.34|
|PsO/PsA                    |Psoriatic arthritis                       |                     24.30|      47.82|    65.68|                           28.61|            61.61|          85.31|                         53.94|         101.29|       138.98|
|Uveitis                    |Uveitis                                   |                     73.66|      85.24|   113.37|                          112.00|           110.02|         133.76|                         80.09|         100.52|       134.42|
