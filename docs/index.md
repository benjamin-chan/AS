---
title: "Comorbidities and Disease Manifestations in Ankylosing Spondylitis (BAD AS)"
date: "2017-06-01 16:47:57"
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
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |     1.34|       0.47|                      1.94|           1.19|             1.52|                            2.07|         3.23|           4.67|                          5.95|
|Cardiac disease            |Conduction Block                          |     0.33|       0.00|                      0.91|           1.14|             1.35|                            2.44|         2.94|           4.22|                          5.93|
|Cardiac disease            |Myocardial infarction                     |     0.33|       0.00|                      0.61|           0.21|             0.28|                            0.64|         0.69|           1.21|                          1.55|
|Inflammatory bowel disease |Crohn’s Disease                           |     4.69|       3.61|                      2.96|           4.77|             4.13|                            2.64|         3.89|           3.75|                          2.50|
|Inflammatory bowel disease |Ulcerative Colitis                        |     2.54|       0.95|                      1.62|           3.06|             3.16|                            2.06|         2.44|           2.60|                          1.77|
|Kidney disease             |Amyloidosis                               |     0.00|       0.00|                      0.11|           0.03|             0.00|                            0.00|         0.07|           0.03|                          0.06|
|Kidney disease             |IgA nephropathy                           |     0.20|       0.00|                      0.11|           0.13|             0.11|                            0.10|         0.26|           0.18|                          0.28|
|Kidney disease             |Nephrotic syndrome                        |     0.13|       0.00|                      0.00|           0.06|             0.11|                            0.05|         0.19|           0.13|                          0.13|
|Lung disease               |Apical Pulmonary fibrosis                 |     0.00|       0.00|                      0.04|           0.00|             0.00|                            0.01|         0.00|           0.04|                          0.02|
|Lung disease               |Interstitial lung disease                 |     0.00|       0.00|                      0.11|           0.07|             0.11|                            0.09|         0.08|           0.22|                          0.11|
|Lung disease               |Restrictive lung disease                  |     0.94|       0.00|                      2.00|           1.90|             2.40|                            3.25|         5.88|           7.68|                          8.70|
|Neurological Disease       |Cauda Equina syndrome                     |     0.00|       0.00|                      0.15|           0.03|             0.06|                            0.06|         0.10|           0.06|                          0.12|
|Neurological Disease       |Spinal Cord compression                   |     0.07|       0.00|                      0.30|           0.25|             0.39|                            0.50|         0.43|           0.51|                          0.79|
|PsO/PsA                    |Psoriasis                                 |     3.50|       0.95|                      1.62|           3.78|             3.34|                            1.81|         3.78|           3.41|                          2.07|
|PsO/PsA                    |Psoriatic arthritis                       |     5.27|       5.13|                      1.84|           6.10|             7.13|                            2.19|         5.43|           4.62|                          1.88|
|Uveitis                    |Uveitis                                   |     4.95|       6.55|                      4.86|           7.58|             8.57|                            8.03|         5.04|           3.77|                          2.96|

## **TNF** versus **NSAID or no exposure**

**MPCD**


|database |outcomeCategory            |disease                                   |comparison                  | rate1| rate2| pValue|
|:--------|:--------------------------|:-----------------------------------------|:---------------------------|-----:|-----:|------:|
|MPCD     |Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |TNF vs NSAID or no exposure | 1.343| 1.940|  0.162|
|MPCD     |Cardiac disease            |Conduction Block                          |TNF vs NSAID or no exposure | 0.333| 0.914|  0.028|
|MPCD     |Cardiac disease            |Myocardial infarction                     |TNF vs NSAID or no exposure | 0.333| 0.606|  0.244|
|MPCD     |Inflammatory bowel disease |Crohn.s Disease                           |TNF vs NSAID or no exposure | 4.692| 2.956|  0.006|
|MPCD     |Inflammatory bowel disease |Ulcerative Colitis                        |TNF vs NSAID or no exposure | 2.536| 1.621|  0.050|
|MPCD     |Kidney disease             |Amyloidosis                               |TNF vs NSAID or no exposure | 0.000| 0.113|  0.260|
|MPCD     |Kidney disease             |IgA nephropathy                           |TNF vs NSAID or no exposure | 0.200| 0.113|  0.508|
|MPCD     |Kidney disease             |Nephrotic syndrome                        |TNF vs NSAID or no exposure | 0.133| 0.000|  0.131|
|MPCD     |Lung disease               |Apical Pulmonary fibrosis                 |TNF vs NSAID or no exposure | 0.000| 0.038|  0.638|
|MPCD     |Lung disease               |Interstitial lung disease                 |TNF vs NSAID or no exposure | 0.000| 0.113|  0.260|
|MPCD     |Lung disease               |Restrictive lung disease                  |TNF vs NSAID or no exposure | 0.942| 2.002|  0.008|
|MPCD     |Neurological Disease       |Cauda Equina syndrome                     |TNF vs NSAID or no exposure | 0.000| 0.151|  0.165|
|MPCD     |Neurological Disease       |Spinal Cord compression                   |TNF vs NSAID or no exposure | 0.066| 0.302|  0.124|
|MPCD     |PsO/PsA                    |Psoriasis                                 |TNF vs NSAID or no exposure | 3.505| 1.618|  0.000|
|MPCD     |PsO/PsA                    |Psoriatic arthritis                       |TNF vs NSAID or no exposure | 5.275| 1.842|  0.000|
|MPCD     |Uveitis                    |Uveitis                                   |TNF vs NSAID or no exposure | 4.951| 4.859|  0.896|

**Marketscan**


|database   |outcomeCategory            |disease                                   |comparison                  | rate1| rate2| pValue|
|:----------|:--------------------------|:-----------------------------------------|:---------------------------|-----:|-----:|------:|
|Marketscan |Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |TNF vs NSAID or no exposure | 1.192| 2.071|  0.000|
|Marketscan |Cardiac disease            |Conduction Block                          |TNF vs NSAID or no exposure | 1.144| 2.441|  0.000|
|Marketscan |Cardiac disease            |Myocardial infarction                     |TNF vs NSAID or no exposure | 0.208| 0.641|  0.000|
|Marketscan |Inflammatory bowel disease |Crohn.s Disease                           |TNF vs NSAID or no exposure | 4.765| 2.640|  0.000|
|Marketscan |Inflammatory bowel disease |Ulcerative Colitis                        |TNF vs NSAID or no exposure | 3.056| 2.063|  0.000|
|Marketscan |Kidney disease             |Amyloidosis                               |TNF vs NSAID or no exposure | 0.030| 0.000|  0.177|
|Marketscan |Kidney disease             |IgA nephropathy                           |TNF vs NSAID or no exposure | 0.134| 0.097|  0.505|
|Marketscan |Kidney disease             |Nephrotic syndrome                        |TNF vs NSAID or no exposure | 0.059| 0.054|  0.881|
|Marketscan |Lung disease               |Apical Pulmonary fibrosis                 |TNF vs NSAID or no exposure | 0.000| 0.011|  0.579|
|Marketscan |Lung disease               |Interstitial lung disease                 |TNF vs NSAID or no exposure | 0.074| 0.086|  0.809|
|Marketscan |Lung disease               |Restrictive lung disease                  |TNF vs NSAID or no exposure | 1.897| 3.246|  0.000|
|Marketscan |Neurological Disease       |Cauda Equina syndrome                     |TNF vs NSAID or no exposure | 0.030| 0.065|  0.359|
|Marketscan |Neurological Disease       |Spinal Cord compression                   |TNF vs NSAID or no exposure | 0.253| 0.499|  0.013|
|Marketscan |PsO/PsA                    |Psoriasis                                 |TNF vs NSAID or no exposure | 3.782| 1.813|  0.000|
|Marketscan |PsO/PsA                    |Psoriatic arthritis                       |TNF vs NSAID or no exposure | 6.103| 2.190|  0.000|
|Marketscan |Uveitis                    |Uveitis                                   |TNF vs NSAID or no exposure | 7.576| 8.034|  0.329|

**Medicare**


|database |outcomeCategory            |disease                                   |comparison                  | rate1| rate2| pValue|
|:--------|:--------------------------|:-----------------------------------------|:---------------------------|-----:|-----:|------:|
|Medicare |Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |TNF vs NSAID or no exposure | 3.227| 5.950|  0.000|
|Medicare |Cardiac disease            |Conduction Block                          |TNF vs NSAID or no exposure | 2.940| 5.933|  0.000|
|Medicare |Cardiac disease            |Myocardial infarction                     |TNF vs NSAID or no exposure | 0.691| 1.547|  0.000|
|Medicare |Inflammatory bowel disease |Crohn.s Disease                           |TNF vs NSAID or no exposure | 3.893| 2.500|  0.000|
|Medicare |Inflammatory bowel disease |Ulcerative Colitis                        |TNF vs NSAID or no exposure | 2.438| 1.773|  0.000|
|Medicare |Kidney disease             |Amyloidosis                               |TNF vs NSAID or no exposure | 0.066| 0.061|  0.818|
|Medicare |Kidney disease             |IgA nephropathy                           |TNF vs NSAID or no exposure | 0.259| 0.284|  0.643|
|Medicare |Kidney disease             |Nephrotic syndrome                        |TNF vs NSAID or no exposure | 0.192| 0.130|  0.114|
|Medicare |Lung disease               |Apical Pulmonary fibrosis                 |TNF vs NSAID or no exposure | 0.000| 0.023|  0.069|
|Medicare |Lung disease               |Interstitial lung disease                 |TNF vs NSAID or no exposure | 0.081| 0.107|  0.418|
|Medicare |Lung disease               |Restrictive lung disease                  |TNF vs NSAID or no exposure | 5.877| 8.702|  0.000|
|Medicare |Neurological Disease       |Cauda Equina syndrome                     |TNF vs NSAID or no exposure | 0.096| 0.120|  0.484|
|Medicare |Neurological Disease       |Spinal Cord compression                   |TNF vs NSAID or no exposure | 0.430| 0.794|  0.000|
|Medicare |PsO/PsA                    |Psoriasis                                 |TNF vs NSAID or no exposure | 3.784| 2.071|  0.000|
|Medicare |PsO/PsA                    |Psoriatic arthritis                       |TNF vs NSAID or no exposure | 5.428| 1.879|  0.000|
|Medicare |Uveitis                    |Uveitis                                   |TNF vs NSAID or no exposure | 5.041| 2.964|  0.000|
