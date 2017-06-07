---
title: "Comorbidities and Disease Manifestations in Ankylosing Spondylitis (BAD AS)"
date: "2017-06-07 07:27:31"
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
##         ../lib/compareIncidenceRates.R ../lib/plotPrev.R
## value   ?                              ?                
## visible FALSE                          FALSE
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
|37  |MPCD       |NSAID or no exposure |       2083|          2593|
|101 |MPCD       |TNF                  |       1107|          1279|
|149 |Marketscan |DMARD                |       1799|          2045|
|209 |Marketscan |NSAID or no exposure |       8025|         10589|
|273 |Marketscan |TNF                  |       4797|          5779|
|337 |Medicare   |DMARD                |       4231|          5193|
|401 |Medicare   |NSAID or no exposure |      17983|         26122|
|465 |Medicare   |TNF                  |       4866|          5929|

Table of **prevalence %**


|outcomeCategory            |disease                                   | MPCD TNF| MPCD DMARD| MPCD NSAID or no exposure| Marketscan TNF| Marketscan DMARD| Marketscan NSAID or no exposure| Medicare TNF| Medicare DMARD| Medicare NSAID or no exposure|
|:--------------------------|:-----------------------------------------|--------:|----------:|-------------------------:|--------------:|----------------:|-------------------------------:|------------:|--------------:|-----------------------------:|
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |      1.3|        0.4|                       0.1|            0.9|              0.9|                             0.7|          4.8|            5.8|                           3.9|
|Cardiac disease            |Conduction Block                          |      0.2|         NA|                       0.1|            0.9|              1.2|                             0.6|          3.9|            4.6|                           3.5|
|Cardiac disease            |Myocardial infarction                     |      0.2|         NA|                       0.0|            0.3|              0.2|                             0.2|          1.0|            1.0|                           0.6|
|Inflammatory bowel disease |Crohn’s Disease                           |      5.0|        2.9|                       0.7|            4.8|              3.4|                             0.9|          8.3|            6.5|                           2.1|
|Inflammatory bowel disease |Ulcerative Colitis                        |      2.1|        1.5|                       0.6|            3.3|              1.6|                             0.6|          5.1|            4.6|                           1.6|
|Kidney disease             |Amyloidosis                               |       NA|         NA|                       0.0|            0.0|              0.0|                             0.0|          0.1|            0.1|                           0.1|
|Kidney disease             |IgA nephropathy                           |      0.1|        0.2|                       0.1|            0.1|              0.1|                             0.0|          0.4|            0.4|                           0.3|
|Kidney disease             |Nephrotic syndrome                        |      0.0|        0.0|                       0.0|            0.1|              0.0|                             0.0|          0.1|            0.2|                           0.1|
|Lung disease               |Apical Pulmonary fibrosis                 |       NA|         NA|                       0.0|            0.0|               NA|                             0.0|          0.0|            0.1|                           0.0|
|Lung disease               |Interstitial lung disease                 |       NA|         NA|                       0.0|            0.1|              0.1|                             0.0|          0.2|            0.3|                           0.1|
|Lung disease               |Restrictive lung disease                  |      0.7|        0.4|                       0.4|            2.1|              2.3|                             1.1|          9.0|           11.4|                           6.2|
|Neurological Disease       |Cauda Equina syndrome                     |       NA|         NA|                       0.0|            0.0|              0.1|                             0.0|          0.1|            0.2|                           0.1|
|Neurological Disease       |Spinal Cord compression                   |      0.0|         NA|                       0.1|            0.1|              0.2|                             0.2|          1.0|            1.1|                           0.7|
|PsO/PsA                    |Psoriasis                                 |      2.7|        1.0|                       0.6|            3.3|              2.2|                             0.8|          7.0|            5.1|                           2.0|
|PsO/PsA                    |Psoriatic arthritis                       |      5.2|        2.9|                       0.5|            6.5|              4.0|                             1.1|         11.4|            7.7|                           2.3|
|Uveitis                    |Uveitis                                   |      6.7|        5.2|                       2.0|            8.6|              5.4|                             3.1|          9.8|            6.6|                           3.6|
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


|    |database   |exposure             |     n|
|:---|:----------|:--------------------|-----:|
|1   |MPCD       |DMARD                |   423|
|17  |MPCD       |NSAID or no exposure |  2093|
|33  |MPCD       |TNF                  |  1108|
|49  |Marketscan |DMARD                |  1813|
|65  |Marketscan |NSAID or no exposure |  8122|
|81  |Marketscan |TNF                  |  4824|
|97  |Medicare   |DMARD                |  4304|
|113 |Medicare   |NSAID or no exposure | 18431|
|129 |Medicare   |TNF                  |  4937|

Table of **incidence per 100 person-years**


|outcomeCategory            |disease                                   | MPCD TNF| MPCD DMARD| MPCD NSAID or no exposure| Marketscan TNF| Marketscan DMARD| Marketscan NSAID or no exposure| Medicare TNF| Medicare DMARD| Medicare NSAID or no exposure|
|:--------------------------|:-----------------------------------------|--------:|----------:|-------------------------:|--------------:|----------------:|-------------------------------:|------------:|--------------:|-----------------------------:|
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |      1.3|        0.5|                       1.9|            1.2|              1.5|                             2.1|          3.2|            4.7|                           6.0|
|Cardiac disease            |Conduction Block                          |      0.3|        0.0|                       0.9|            1.1|              1.4|                             2.4|          2.9|            4.2|                           5.9|
|Cardiac disease            |Myocardial infarction                     |      0.3|        0.0|                       0.6|            0.2|              0.3|                             0.6|          0.7|            1.2|                           1.5|
|Inflammatory bowel disease |Crohn’s Disease                           |      4.7|        3.6|                       3.0|            4.8|              4.1|                             2.6|          3.9|            3.7|                           2.5|
|Inflammatory bowel disease |Ulcerative Colitis                        |      2.5|        0.9|                       1.6|            3.1|              3.2|                             2.1|          2.4|            2.6|                           1.8|
|Kidney disease             |Amyloidosis                               |      0.0|        0.0|                       0.1|            0.0|              0.0|                             0.0|          0.1|            0.0|                           0.1|
|Kidney disease             |IgA nephropathy                           |      0.2|        0.0|                       0.1|            0.1|              0.1|                             0.1|          0.3|            0.2|                           0.3|
|Kidney disease             |Nephrotic syndrome                        |      0.1|        0.0|                       0.0|            0.1|              0.1|                             0.1|          0.2|            0.1|                           0.1|
|Lung disease               |Apical Pulmonary fibrosis                 |      0.0|        0.0|                       0.0|            0.0|              0.0|                             0.0|          0.0|            0.0|                           0.0|
|Lung disease               |Interstitial lung disease                 |      0.0|        0.0|                       0.1|            0.1|              0.1|                             0.1|          0.1|            0.2|                           0.1|
|Lung disease               |Restrictive lung disease                  |      0.9|        0.0|                       2.0|            1.9|              2.4|                             3.2|          5.9|            7.7|                           8.7|
|Neurological Disease       |Cauda Equina syndrome                     |      0.0|        0.0|                       0.2|            0.0|              0.1|                             0.1|          0.1|            0.1|                           0.1|
|Neurological Disease       |Spinal Cord compression                   |      0.1|        0.0|                       0.3|            0.3|              0.4|                             0.5|          0.4|            0.5|                           0.8|
|PsO/PsA                    |Psoriasis                                 |      3.5|        1.0|                       1.6|            3.8|              3.3|                             1.8|          3.8|            3.4|                           2.1|
|PsO/PsA                    |Psoriatic arthritis                       |      5.3|        5.1|                       1.8|            6.1|              7.1|                             2.2|          5.4|            4.6|                           1.9|
|Uveitis                    |Uveitis                                   |      5.0|        6.5|                       4.9|            7.6|              8.6|                             8.0|          5.0|            3.8|                           3.0|

## **TNF** versus **NSAID or no exposure**



**MPCD**


|database |outcomeCategory            |disease                                   |comparison                  | rate1| rate2| pValue|
|:--------|:--------------------------|:-----------------------------------------|:---------------------------|-----:|-----:|------:|
|MPCD     |Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |TNF vs NSAID or no exposure |   1.3|   1.9|  0.162|
|MPCD     |Cardiac disease            |Conduction Block                          |TNF vs NSAID or no exposure |   0.3|   0.9|  0.028|
|MPCD     |Cardiac disease            |Myocardial infarction                     |TNF vs NSAID or no exposure |   0.3|   0.6|  0.244|
|MPCD     |Inflammatory bowel disease |Crohn.s Disease                           |TNF vs NSAID or no exposure |   4.7|   3.0|  0.006|
|MPCD     |Inflammatory bowel disease |Ulcerative Colitis                        |TNF vs NSAID or no exposure |   2.5|   1.6|  0.050|
|MPCD     |Kidney disease             |Amyloidosis                               |TNF vs NSAID or no exposure |   0.0|   0.1|  0.260|
|MPCD     |Kidney disease             |IgA nephropathy                           |TNF vs NSAID or no exposure |   0.2|   0.1|  0.508|
|MPCD     |Kidney disease             |Nephrotic syndrome                        |TNF vs NSAID or no exposure |   0.1|   0.0|  0.131|
|MPCD     |Lung disease               |Apical Pulmonary fibrosis                 |TNF vs NSAID or no exposure |   0.0|   0.0|  0.638|
|MPCD     |Lung disease               |Interstitial lung disease                 |TNF vs NSAID or no exposure |   0.0|   0.1|  0.260|
|MPCD     |Lung disease               |Restrictive lung disease                  |TNF vs NSAID or no exposure |   0.9|   2.0|  0.008|
|MPCD     |Neurological Disease       |Cauda Equina syndrome                     |TNF vs NSAID or no exposure |   0.0|   0.2|  0.165|
|MPCD     |Neurological Disease       |Spinal Cord compression                   |TNF vs NSAID or no exposure |   0.1|   0.3|  0.124|
|MPCD     |PsO/PsA                    |Psoriasis                                 |TNF vs NSAID or no exposure |   3.5|   1.6|  0.000|
|MPCD     |PsO/PsA                    |Psoriatic arthritis                       |TNF vs NSAID or no exposure |   5.3|   1.8|  0.000|
|MPCD     |Uveitis                    |Uveitis                                   |TNF vs NSAID or no exposure |   5.0|   4.9|  0.896|

**Marketscan**


|database   |outcomeCategory            |disease                                   |comparison                  | rate1| rate2| pValue|
|:----------|:--------------------------|:-----------------------------------------|:---------------------------|-----:|-----:|------:|
|Marketscan |Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |TNF vs NSAID or no exposure |   1.2|   2.1|  0.000|
|Marketscan |Cardiac disease            |Conduction Block                          |TNF vs NSAID or no exposure |   1.1|   2.4|  0.000|
|Marketscan |Cardiac disease            |Myocardial infarction                     |TNF vs NSAID or no exposure |   0.2|   0.6|  0.000|
|Marketscan |Inflammatory bowel disease |Crohn.s Disease                           |TNF vs NSAID or no exposure |   4.8|   2.6|  0.000|
|Marketscan |Inflammatory bowel disease |Ulcerative Colitis                        |TNF vs NSAID or no exposure |   3.1|   2.1|  0.000|
|Marketscan |Kidney disease             |Amyloidosis                               |TNF vs NSAID or no exposure |   0.0|   0.0|  0.177|
|Marketscan |Kidney disease             |IgA nephropathy                           |TNF vs NSAID or no exposure |   0.1|   0.1|  0.505|
|Marketscan |Kidney disease             |Nephrotic syndrome                        |TNF vs NSAID or no exposure |   0.1|   0.1|  0.881|
|Marketscan |Lung disease               |Apical Pulmonary fibrosis                 |TNF vs NSAID or no exposure |   0.0|   0.0|  0.579|
|Marketscan |Lung disease               |Interstitial lung disease                 |TNF vs NSAID or no exposure |   0.1|   0.1|  0.809|
|Marketscan |Lung disease               |Restrictive lung disease                  |TNF vs NSAID or no exposure |   1.9|   3.2|  0.000|
|Marketscan |Neurological Disease       |Cauda Equina syndrome                     |TNF vs NSAID or no exposure |   0.0|   0.1|  0.359|
|Marketscan |Neurological Disease       |Spinal Cord compression                   |TNF vs NSAID or no exposure |   0.3|   0.5|  0.013|
|Marketscan |PsO/PsA                    |Psoriasis                                 |TNF vs NSAID or no exposure |   3.8|   1.8|  0.000|
|Marketscan |PsO/PsA                    |Psoriatic arthritis                       |TNF vs NSAID or no exposure |   6.1|   2.2|  0.000|
|Marketscan |Uveitis                    |Uveitis                                   |TNF vs NSAID or no exposure |   7.6|   8.0|  0.329|

**Medicare**


|database |outcomeCategory            |disease                                   |comparison                  | rate1| rate2| pValue|
|:--------|:--------------------------|:-----------------------------------------|:---------------------------|-----:|-----:|------:|
|Medicare |Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |TNF vs NSAID or no exposure |   3.2|   6.0|  0.000|
|Medicare |Cardiac disease            |Conduction Block                          |TNF vs NSAID or no exposure |   2.9|   5.9|  0.000|
|Medicare |Cardiac disease            |Myocardial infarction                     |TNF vs NSAID or no exposure |   0.7|   1.5|  0.000|
|Medicare |Inflammatory bowel disease |Crohn.s Disease                           |TNF vs NSAID or no exposure |   3.9|   2.5|  0.000|
|Medicare |Inflammatory bowel disease |Ulcerative Colitis                        |TNF vs NSAID or no exposure |   2.4|   1.8|  0.000|
|Medicare |Kidney disease             |Amyloidosis                               |TNF vs NSAID or no exposure |   0.1|   0.1|  0.818|
|Medicare |Kidney disease             |IgA nephropathy                           |TNF vs NSAID or no exposure |   0.3|   0.3|  0.643|
|Medicare |Kidney disease             |Nephrotic syndrome                        |TNF vs NSAID or no exposure |   0.2|   0.1|  0.114|
|Medicare |Lung disease               |Apical Pulmonary fibrosis                 |TNF vs NSAID or no exposure |   0.0|   0.0|  0.069|
|Medicare |Lung disease               |Interstitial lung disease                 |TNF vs NSAID or no exposure |   0.1|   0.1|  0.418|
|Medicare |Lung disease               |Restrictive lung disease                  |TNF vs NSAID or no exposure |   5.9|   8.7|  0.000|
|Medicare |Neurological Disease       |Cauda Equina syndrome                     |TNF vs NSAID or no exposure |   0.1|   0.1|  0.484|
|Medicare |Neurological Disease       |Spinal Cord compression                   |TNF vs NSAID or no exposure |   0.4|   0.8|  0.000|
|Medicare |PsO/PsA                    |Psoriasis                                 |TNF vs NSAID or no exposure |   3.8|   2.1|  0.000|
|Medicare |PsO/PsA                    |Psoriatic arthritis                       |TNF vs NSAID or no exposure |   5.4|   1.9|  0.000|
|Medicare |Uveitis                    |Uveitis                                   |TNF vs NSAID or no exposure |   5.0|   3.0|  0.000|

## **TNF** versus **DMARD**



**MPCD**


|database |outcomeCategory            |disease                                   |comparison   | rate1| rate2| pValue|
|:--------|:--------------------------|:-----------------------------------------|:------------|-----:|-----:|------:|
|MPCD     |Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |TNF vs DMARD |   1.3|   0.5|  0.132|
|MPCD     |Cardiac disease            |Conduction Block                          |TNF vs DMARD |   0.3|   0.0|  0.286|
|MPCD     |Cardiac disease            |Myocardial infarction                     |TNF vs DMARD |   0.3|   0.0|  0.286|
|MPCD     |Inflammatory bowel disease |Crohn.s Disease                           |TNF vs DMARD |   4.7|   3.6|  0.365|
|MPCD     |Inflammatory bowel disease |Ulcerative Colitis                        |TNF vs DMARD |   2.5|   0.9|  0.041|
|MPCD     |Kidney disease             |Amyloidosis                               |TNF vs DMARD |   0.0|   0.0|  1.000|
|MPCD     |Kidney disease             |IgA nephropathy                           |TNF vs DMARD |   0.2|   0.0|  0.472|
|MPCD     |Kidney disease             |Nephrotic syndrome                        |TNF vs DMARD |   0.1|   0.0|  0.606|
|MPCD     |Lung disease               |Apical Pulmonary fibrosis                 |TNF vs DMARD |   0.0|   0.0|  1.000|
|MPCD     |Lung disease               |Interstitial lung disease                 |TNF vs DMARD |   0.0|   0.0|  1.000|
|MPCD     |Lung disease               |Restrictive lung disease                  |TNF vs DMARD |   0.9|   0.0|  0.029|
|MPCD     |Neurological Disease       |Cauda Equina syndrome                     |TNF vs DMARD |   0.0|   0.0|  1.000|
|MPCD     |Neurological Disease       |Spinal Cord compression                   |TNF vs DMARD |   0.1|   0.0|  0.779|
|MPCD     |PsO/PsA                    |Psoriasis                                 |TNF vs DMARD |   3.5|   1.0|  0.003|
|MPCD     |PsO/PsA                    |Psoriatic arthritis                       |TNF vs DMARD |   5.3|   5.1|  0.931|
|MPCD     |Uveitis                    |Uveitis                                   |TNF vs DMARD |   5.0|   6.5|  0.228|

**Marketscan**


|database   |outcomeCategory            |disease                                   |comparison   | rate1| rate2| pValue|
|:----------|:--------------------------|:-----------------------------------------|:------------|-----:|-----:|------:|
|Marketscan |Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |TNF vs DMARD |   1.2|   1.5|  0.279|
|Marketscan |Cardiac disease            |Conduction Block                          |TNF vs DMARD |   1.1|   1.4|  0.473|
|Marketscan |Cardiac disease            |Myocardial infarction                     |TNF vs DMARD |   0.2|   0.3|  0.568|
|Marketscan |Inflammatory bowel disease |Crohn.s Disease                           |TNF vs DMARD |   4.8|   4.1|  0.276|
|Marketscan |Inflammatory bowel disease |Ulcerative Colitis                        |TNF vs DMARD |   3.1|   3.2|  0.816|
|Marketscan |Kidney disease             |Amyloidosis                               |TNF vs DMARD |   0.0|   0.0|  0.623|
|Marketscan |Kidney disease             |IgA nephropathy                           |TNF vs DMARD |   0.1|   0.1|  0.873|
|Marketscan |Kidney disease             |Nephrotic syndrome                        |TNF vs DMARD |   0.1|   0.1|  0.484|
|Marketscan |Lung disease               |Apical Pulmonary fibrosis                 |TNF vs DMARD |   0.0|   0.0|  1.000|
|Marketscan |Lung disease               |Interstitial lung disease                 |TNF vs DMARD |   0.1|   0.1|  0.620|
|Marketscan |Lung disease               |Restrictive lung disease                  |TNF vs DMARD |   1.9|   2.4|  0.190|
|Marketscan |Neurological Disease       |Cauda Equina syndrome                     |TNF vs DMARD |   0.0|   0.1|  0.624|
|Marketscan |Neurological Disease       |Spinal Cord compression                   |TNF vs DMARD |   0.3|   0.4|  0.341|
|Marketscan |PsO/PsA                    |Psoriasis                                 |TNF vs DMARD |   3.8|   3.3|  0.397|
|Marketscan |PsO/PsA                    |Psoriatic arthritis                       |TNF vs DMARD |   6.1|   7.1|  0.139|
|Marketscan |Uveitis                    |Uveitis                                   |TNF vs DMARD |   7.6|   8.6|  0.200|

**Medicare**


|database |outcomeCategory            |disease                                   |comparison   | rate1| rate2| pValue|
|:--------|:--------------------------|:-----------------------------------------|:------------|-----:|-----:|------:|
|Medicare |Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |TNF vs DMARD |   3.2|   4.7|  0.000|
|Medicare |Cardiac disease            |Conduction Block                          |TNF vs DMARD |   2.9|   4.2|  0.000|
|Medicare |Cardiac disease            |Myocardial infarction                     |TNF vs DMARD |   0.7|   1.2|  0.000|
|Medicare |Inflammatory bowel disease |Crohn.s Disease                           |TNF vs DMARD |   3.9|   3.7|  0.605|
|Medicare |Inflammatory bowel disease |Ulcerative Colitis                        |TNF vs DMARD |   2.4|   2.6|  0.472|
|Medicare |Kidney disease             |Amyloidosis                               |TNF vs DMARD |   0.1|   0.0|  0.309|
|Medicare |Kidney disease             |IgA nephropathy                           |TNF vs DMARD |   0.3|   0.2|  0.209|
|Medicare |Kidney disease             |Nephrotic syndrome                        |TNF vs DMARD |   0.2|   0.1|  0.295|
|Medicare |Lung disease               |Apical Pulmonary fibrosis                 |TNF vs DMARD |   0.0|   0.0|  0.025|
|Medicare |Lung disease               |Interstitial lung disease                 |TNF vs DMARD |   0.1|   0.2|  0.007|
|Medicare |Lung disease               |Restrictive lung disease                  |TNF vs DMARD |   5.9|   7.7|  0.000|
|Medicare |Neurological Disease       |Cauda Equina syndrome                     |TNF vs DMARD |   0.1|   0.1|  0.303|
|Medicare |Neurological Disease       |Spinal Cord compression                   |TNF vs DMARD |   0.4|   0.5|  0.373|
|Medicare |PsO/PsA                    |Psoriasis                                 |TNF vs DMARD |   3.8|   3.4|  0.161|
|Medicare |PsO/PsA                    |Psoriatic arthritis                       |TNF vs DMARD |   5.4|   4.6|  0.012|
|Medicare |Uveitis                    |Uveitis                                   |TNF vs DMARD |   5.0|   3.8|  0.000|
# ACR 2017 abstract

Build tables for Atul's 2017 ACR abstract.
Collects code chunks from `summarizePrevalence.Rmd` and `summarizeIncidence.Rmd`.

* Title
  * **Do TNF Inhibitors Reduce the Incidence of Cardiac, Pulmonary and Neurologic Comorbidities in Ankylosing Spondylitis? An Analysis of Three Large US Claims Databases.**
* Authors
  * Atul Deodhar, Kevin Winthrop, Benjamin Chan, Sarah Siegel, Jeffery Stark, Robert Suruki, Rhonda Bohn, Huifeng Yun, Lang Chen, Jeffery Curtis


## Prevalence


|outcomeCategory            |disease                                   | MPCD TNF| MPCD DMARD| MPCD NSAID or no exposure| Marketscan TNF| Marketscan DMARD| Marketscan NSAID or no exposure| Medicare TNF| Medicare DMARD| Medicare NSAID or no exposure|
|:--------------------------|:-----------------------------------------|--------:|----------:|-------------------------:|--------------:|----------------:|-------------------------------:|------------:|--------------:|-----------------------------:|
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |      1.3|        0.4|                       0.1|            0.9|              0.9|                             0.7|          4.8|            5.8|                           3.9|
|Cardiac disease            |Conduction Block                          |      0.2|        0.0|                       0.1|            0.9|              1.2|                             0.6|          3.9|            4.6|                           3.5|
|Cardiac disease            |Myocardial infarction                     |      0.2|        0.0|                       0.0|            0.3|              0.2|                             0.2|          1.0|            1.0|                           0.6|
|Inflammatory bowel disease |Crohn’s Disease                           |      5.0|        2.9|                       0.7|            4.8|              3.4|                             0.9|          8.3|            6.5|                           2.1|
|Inflammatory bowel disease |Ulcerative Colitis                        |      2.1|        1.5|                       0.6|            3.3|              1.6|                             0.6|          5.1|            4.6|                           1.6|
|Kidney disease             |Amyloidosis                               |      0.0|        0.0|                       0.0|            0.0|              0.0|                             0.0|          0.1|            0.1|                           0.1|
|Kidney disease             |IgA nephropathy                           |      0.1|        0.2|                       0.1|            0.1|              0.1|                             0.0|          0.4|            0.4|                           0.3|
|Kidney disease             |Nephrotic syndrome                        |      0.0|        0.0|                       0.0|            0.1|              0.0|                             0.0|          0.1|            0.2|                           0.1|
|Lung disease               |Apical Pulmonary fibrosis                 |      0.0|        0.0|                       0.0|            0.0|              0.0|                             0.0|          0.0|            0.1|                           0.0|
|Lung disease               |Interstitial lung disease                 |      0.0|        0.0|                       0.0|            0.1|              0.1|                             0.0|          0.2|            0.3|                           0.1|
|Lung disease               |Restrictive lung disease                  |      0.7|        0.4|                       0.4|            2.1|              2.3|                             1.1|          9.0|           11.4|                           6.2|
|Neurological Disease       |Cauda Equina syndrome                     |      0.0|        0.0|                       0.0|            0.0|              0.1|                             0.0|          0.1|            0.2|                           0.1|
|Neurological Disease       |Spinal Cord compression                   |      0.0|        0.0|                       0.1|            0.1|              0.2|                             0.2|          1.0|            1.1|                           0.7|
|PsO/PsA                    |Psoriasis                                 |      2.7|        1.0|                       0.6|            3.3|              2.2|                             0.8|          7.0|            5.1|                           2.0|
|PsO/PsA                    |Psoriatic arthritis                       |      5.2|        2.9|                       0.5|            6.5|              4.0|                             1.1|         11.4|            7.7|                           2.3|
|Uveitis                    |Uveitis                                   |      6.7|        5.2|                       2.0|            8.6|              5.4|                             3.1|          9.8|            6.6|                           3.6|


## Incidence


|outcomeCategory            |disease                                   | MPCD TNF| MPCD NSAID or no exposure| MPCD p-value| Marketscan TNF| Marketscan NSAID or no exposure| Marketscan p-value| Medicare TNF| Medicare NSAID or no exposure| Medicare p-value|
|:--------------------------|:-----------------------------------------|--------:|-------------------------:|------------:|--------------:|-------------------------------:|------------------:|------------:|-----------------------------:|----------------:|
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |      1.3|                       1.9|        0.162|            1.2|                             2.1|              0.000|          3.2|                           6.0|                0|
|Cardiac disease            |Conduction Block                          |      0.3|                       0.9|        0.028|            1.1|                             2.4|              0.000|          2.9|                           5.9|                0|
|Cardiac disease            |Myocardial infarction                     |      0.3|                       0.6|        0.244|            0.2|                             0.6|              0.000|          0.7|                           1.5|                0|
|Inflammatory bowel disease |Crohn.s Disease                           |      4.7|                       3.0|        0.006|            4.8|                             2.6|              0.000|          3.9|                           2.5|                0|
|Inflammatory bowel disease |Ulcerative Colitis                        |      2.5|                       1.6|        0.050|            3.1|                             2.1|              0.000|          2.4|                           1.8|                0|
|Lung disease               |Restrictive lung disease                  |      0.9|                       2.0|        0.008|            1.9|                             3.2|              0.000|          5.9|                           8.7|                0|
|Neurological Disease       |Spinal Cord compression                   |      0.1|                       0.3|        0.124|            0.3|                             0.5|              0.013|          0.4|                           0.8|                0|
|PsO/PsA                    |Psoriasis                                 |      3.5|                       1.6|        0.000|            3.8|                             1.8|              0.000|          3.8|                           2.1|                0|
|Uveitis                    |Uveitis                                   |      5.0|                       4.9|        0.896|            7.6|                             8.0|              0.329|          5.0|                           3.0|                0|



|outcomeCategory            |disease                                   | MPCD TNF| MPCD DMARD| MPCD p-value| Marketscan TNF| Marketscan DMARD| Marketscan p-value| Medicare TNF| Medicare DMARD| Medicare p-value|
|:--------------------------|:-----------------------------------------|--------:|----------:|------------:|--------------:|----------------:|------------------:|------------:|--------------:|----------------:|
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |      1.3|        0.5|        0.132|            1.2|              1.5|              0.279|          3.2|            4.7|            0.000|
|Cardiac disease            |Conduction Block                          |      0.3|        0.0|        0.286|            1.1|              1.4|              0.473|          2.9|            4.2|            0.000|
|Cardiac disease            |Myocardial infarction                     |      0.3|        0.0|        0.286|            0.2|              0.3|              0.568|          0.7|            1.2|            0.000|
|Inflammatory bowel disease |Crohn.s Disease                           |      4.7|        3.6|        0.365|            4.8|              4.1|              0.276|          3.9|            3.7|            0.605|
|Inflammatory bowel disease |Ulcerative Colitis                        |      2.5|        0.9|        0.041|            3.1|              3.2|              0.816|          2.4|            2.6|            0.472|
|Lung disease               |Restrictive lung disease                  |      0.9|        0.0|        0.029|            1.9|              2.4|              0.190|          5.9|            7.7|            0.000|
|Neurological Disease       |Spinal Cord compression                   |      0.1|        0.0|        0.779|            0.3|              0.4|              0.341|          0.4|            0.5|            0.373|
|PsO/PsA                    |Psoriasis                                 |      3.5|        1.0|        0.003|            3.8|              3.3|              0.397|          3.8|            3.4|            0.161|
|Uveitis                    |Uveitis                                   |      5.0|        6.5|        0.228|            7.6|              8.6|              0.200|          5.0|            3.8|            0.000|
