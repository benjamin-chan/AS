---
title: "Comorbidities and Disease Manifestations in Ankylosing Spondylitis (BAD AS)"
date: "2017-08-02 08:55:03"
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
##         ../lib/bindCompare.R ../lib/compareIncidenceRates.R
## value   ?                    ?                             
## visible FALSE                FALSE                         
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
|45  |MPCD       |NSAID or no exposure |       2083|          2593|
|113 |MPCD       |TNF                  |       1107|          1279|
|169 |Marketscan |DMARD                |       1799|          2045|
|245 |Marketscan |NSAID or no exposure |       8025|         10589|
|329 |Marketscan |TNF                  |       4797|          5779|
|405 |Medicare   |DMARD                |       4231|          5193|
|489 |Medicare   |NSAID or no exposure |      17983|         26122|
|573 |Medicare   |TNF                  |       4866|          5929|

Table of **prevalence %**


|outcomeCategory            |disease                                   |timeWindow | MPCD TNF| MPCD DMARD| MPCD NSAID or no exposure| Marketscan TNF| Marketscan DMARD| Marketscan NSAID or no exposure| Medicare TNF| Medicare DMARD| Medicare NSAID or no exposure|
|:--------------------------|:-----------------------------------------|:----------|--------:|----------:|-------------------------:|--------------:|----------------:|-------------------------------:|------------:|--------------:|-----------------------------:|
|Cancer                     |Hematologic Cancer                        |12 months  |      0.3|        0.2|                       0.4|            0.2|              0.6|                             0.5|          0.8|            2.0|                           2.1|
|Cancer                     |Non Melanoma Skin Cancer                  |12 months  |       NA|         NA|                        NA|            0.2|              0.1|                             0.2|          0.9|            0.9|                           1.5|
|Cancer                     |Solid Cancer                              |12 months  |      2.1|        1.5|                       3.5|            0.8|              2.9|                             2.5|          6.6|            9.0|                          12.1|
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |12 months  |      1.8|        1.0|                       1.5|            0.5|              0.6|                             0.7|          2.5|            3.4|                           4.5|
|Cardiac disease            |Conduction Block                          |12 months  |      0.2|         NA|                       0.7|            0.5|              0.9|                             0.9|          2.2|            2.8|                           4.5|
|Cardiac disease            |Myocardial infarction                     |12 months  |       NA|         NA|                       0.0|            0.2|              0.1|                             0.6|          0.3|            0.6|                           1.0|
|Infection                  |Hospitalized infection                    |12 months  |      0.1|         NA|                       0.2|            2.9|              3.5|                             5.6|          7.2|           11.2|                          15.4|
|Infection                  |Opportunistic infection                   |12 months  |      1.3|        1.0|                       0.8|            0.7|              0.8|                             0.5|          3.3|            3.1|                           2.1|
|Inflammatory bowel disease |Crohn’s Disease                           |12 months  |      5.8|        3.7|                       3.1|            3.7|              2.7|                             1.9|          8.4|            6.4|                           4.0|
|Inflammatory bowel disease |Ulcerative Colitis                        |12 months  |      2.9|        2.5|                       1.6|            2.2|              1.5|                             1.1|          4.2|            3.8|                           2.3|
|Kidney disease             |Amyloidosis                               |12 months  |       NA|         NA|                       0.0|            0.0|               NA|                             0.0|          0.1|            0.0|                           0.1|
|Kidney disease             |IgA nephropathy                           |12 months  |      0.3|        0.2|                       0.1|            0.1|              0.1|                             0.0|          0.2|            0.3|                           0.2|
|Kidney disease             |Nephrotic syndrome                        |12 months  |       NA|         NA|                        NA|             NA|              0.0|                             0.0|          0.2|            0.3|                           0.2|
|Lung disease               |Apical Pulmonary fibrosis                 |12 months  |       NA|         NA|                        NA|             NA|               NA|                             0.0|          0.0|            0.1|                           0.0|
|Lung disease               |Interstitial lung disease                 |12 months  |       NA|         NA|                        NA|            0.1|              0.0|                             0.1|          0.1|            0.3|                           0.1|
|Lung disease               |Restrictive lung disease                  |12 months  |      0.7|        0.4|                       1.2|            0.7|              0.8|                             1.0|          6.5|            9.4|                           9.7|
|Neurological Disease       |Cauda Equina syndrome                     |12 months  |       NA|         NA|                       0.1|            0.0|              0.1|                             0.0|          0.1|            0.0|                           0.2|
|Neurological Disease       |Spinal Cord compression                   |12 months  |      0.2|         NA|                       0.3|            0.1|              0.2|                             0.2|          0.5|            0.7|                           1.2|
|PsO/PsA                    |Psoriasis                                 |12 months  |      4.1|        1.2|                       1.8|            0.8|              0.9|                             0.5|          5.0|            3.5|                           1.8|
|PsO/PsA                    |Psoriatic arthritis                       |12 months  |      6.4|        5.4|                       2.2|            2.2|              2.1|                             0.6|         11.0|            8.5|                           3.2|
|Uveitis                    |Uveitis                                   |12 months  |      7.2|        5.8|                       5.2|            1.9|              1.5|                             1.6|          8.0|            5.3|                           4.1|
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
|22  |MPCD       |NSAID or no exposure |  2093|
|43  |MPCD       |TNF                  |  1108|
|64  |Marketscan |DMARD                |  1813|
|85  |Marketscan |NSAID or no exposure |  8122|
|106 |Marketscan |TNF                  |  4824|
|127 |Medicare   |DMARD                |  4304|
|148 |Medicare   |NSAID or no exposure | 18431|
|169 |Medicare   |TNF                  |  4937|

Table of **incidence per 100 person-years**


|outcomeCategory            |disease                                   | MPCD TNF| MPCD DMARD| MPCD NSAID or no exposure| Marketscan TNF| Marketscan DMARD| Marketscan NSAID or no exposure| Medicare TNF| Medicare DMARD| Medicare NSAID or no exposure|
|:--------------------------|:-----------------------------------------|--------:|----------:|-------------------------:|--------------:|----------------:|-------------------------------:|------------:|--------------:|-----------------------------:|
|Cancer                     |Hematologic Cancer                        |      0.2|        0.2|                       0.4|            0.2|              0.4|                             0.5|          0.6|            1.3|                           1.3|
|Cancer                     |Non Melanoma Skin Cancer                  |      0.0|        0.0|                       0.0|            0.3|              0.3|                             0.2|          1.0|            1.3|                           1.6|
|Cancer                     |Solid Cancer                              |      1.8|        1.9|                       3.7|            0.9|              2.7|                             2.7|          4.0|            6.5|                           8.0|
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |      1.3|        0.5|                       1.6|            0.6|              0.5|                             0.8|          1.9|            2.5|                           3.4|
|Cardiac disease            |Conduction Block                          |      0.3|        0.0|                       0.6|            0.5|              0.5|                             0.9|          2.0|            2.6|                           3.8|
|Cardiac disease            |Myocardial infarction                     |      0.0|        0.0|                       0.0|            0.2|              0.2|                             0.6|          0.4|            0.7|                           0.9|
|Infection                  |Hospitalized infection                    |      0.1|        0.0|                       0.2|            2.6|              3.3|                             5.4|          7.1|            9.2|                          12.7|
|Infection                  |Opportunistic infection                   |      0.9|        1.2|                       0.5|            0.3|              0.7|                             0.3|          1.8|            2.1|                           1.7|
|Inflammatory bowel disease |Crohn’s Disease                           |      4.6|        3.1|                       2.6|            2.8|              2.4|                             1.4|          3.6|            3.4|                           2.3|
|Inflammatory bowel disease |Ulcerative Colitis                        |      2.5|        0.7|                       1.3|            1.5|              1.4|                             0.8|          2.2|            2.2|                           1.5|
|Kidney disease             |Amyloidosis                               |      0.0|        0.0|                       0.0|            0.0|              0.0|                             0.0|          0.1|            0.0|                           0.1|
|Kidney disease             |IgA nephropathy                           |      0.2|        0.0|                       0.1|            0.0|              0.1|                             0.0|          0.2|            0.1|                           0.2|
|Kidney disease             |Nephrotic syndrome                        |      0.0|        0.0|                       0.0|            0.0|              0.1|                             0.0|          0.2|            0.1|                           0.1|
|Lung disease               |Apical Pulmonary fibrosis                 |      0.0|        0.0|                       0.0|            0.0|              0.0|                             0.0|          0.0|            0.0|                           0.0|
|Lung disease               |Interstitial lung disease                 |      0.0|        0.0|                       0.0|            0.0|              0.1|                             0.1|          0.1|            0.2|                           0.1|
|Lung disease               |Restrictive lung disease                  |      0.9|        0.0|                       1.5|            0.6|              0.6|                             0.9|          5.3|            6.9|                           7.8|
|Neurological Disease       |Cauda Equina syndrome                     |      0.0|        0.0|                       0.1|            0.0|              0.1|                             0.0|          0.1|            0.1|                           0.1|
|Neurological Disease       |Spinal Cord compression                   |      0.1|        0.0|                       0.3|            0.1|              0.2|                             0.1|          0.4|            0.4|                           0.7|
|PsO/PsA                    |Psoriasis                                 |      3.4|        1.0|                       1.5|            0.8|              0.6|                             0.4|          2.5|            2.0|                           1.1|
|PsO/PsA                    |Psoriatic arthritis                       |      5.1|        5.1|                       1.6|            1.7|              1.9|                             0.5|          5.0|            4.3|                           1.7|
|Uveitis                    |Uveitis                                   |      4.4|        5.2|                       3.9|            0.9|              1.2|                             0.8|          4.1|            3.1|                           2.5|

## **TNF** versus **NSAID or no exposure**

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

Build tables for Atul's 2017 ACR abstract.
Collects code chunks from `summarizePrevalence.Rmd` and `summarizeIncidence.Rmd`.

* Title
  * **Do TNF Inhibitors Reduce the Incidence of Cardiac, Pulmonary and Neurologic Comorbidities in Ankylosing Spondylitis? An Analysis of Three Large US Claims Databases.**
* Authors
  * Atul Deodhar, Kevin Winthrop, Benjamin Chan, Sarah Siegel, Jeffery Stark, Robert Suruki, Rhonda Bohn, Huifeng Yun, Lang Chen, Jeffery Curtis


## Prevalence


|outcomeCategory            |disease                                   |timeWindow                                       | MPCD TNF| MPCD DMARD| MPCD NSAID or no exposure| Marketscan TNF| Marketscan DMARD| Marketscan NSAID or no exposure| Medicare TNF| Medicare DMARD| Medicare NSAID or no exposure|
|:--------------------------|:-----------------------------------------|:------------------------------------------------|--------:|----------:|-------------------------:|--------------:|----------------:|-------------------------------:|------------:|--------------:|-----------------------------:|
|Cancer                     |Hematologic Cancer                        |12-month (6-month baseline to 6-month follow-up) |      0.3|        0.2|                       0.4|            0.2|              0.6|                             0.5|          0.8|            2.0|                           2.1|
|Cancer                     |Non Melanoma Skin Cancer                  |12-month (6-month baseline to 6-month follow-up) |      0.0|        0.0|                       0.0|            0.2|              0.1|                             0.2|          0.9|            0.9|                           1.5|
|Cancer                     |Solid Cancer                              |12-month (6-month baseline to 6-month follow-up) |      2.1|        1.5|                       3.5|            0.8|              2.9|                             2.5|          6.6|            9.0|                          12.1|
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |12-month (6-month baseline to 6-month follow-up) |      1.8|        1.0|                       1.5|            0.5|              0.6|                             0.7|          2.5|            3.4|                           4.5|
|Cardiac disease            |Conduction Block                          |12-month (6-month baseline to 6-month follow-up) |      0.2|        0.0|                       0.7|            0.5|              0.9|                             0.9|          2.2|            2.8|                           4.5|
|Cardiac disease            |Myocardial infarction                     |12-month (6-month baseline to 6-month follow-up) |      0.0|        0.0|                       0.0|            0.2|              0.1|                             0.6|          0.3|            0.6|                           1.0|
|Infection                  |Hospitalized infection                    |12-month (6-month baseline to 6-month follow-up) |      0.1|        0.0|                       0.2|            2.9|              3.5|                             5.6|          7.2|           11.2|                          15.4|
|Infection                  |Opportunistic infection                   |12-month (6-month baseline to 6-month follow-up) |      1.3|        1.0|                       0.8|            0.7|              0.8|                             0.5|          3.3|            3.1|                           2.1|
|Inflammatory bowel disease |Crohn’s Disease                           |12-month (6-month baseline to 6-month follow-up) |      5.8|        3.7|                       3.1|            3.7|              2.7|                             1.9|          8.4|            6.4|                           4.0|
|Inflammatory bowel disease |Ulcerative Colitis                        |12-month (6-month baseline to 6-month follow-up) |      2.9|        2.5|                       1.6|            2.2|              1.5|                             1.1|          4.2|            3.8|                           2.3|
|Kidney disease             |Amyloidosis                               |12-month (6-month baseline to 6-month follow-up) |      0.0|        0.0|                       0.0|            0.0|              0.0|                             0.0|          0.1|            0.0|                           0.1|
|Kidney disease             |IgA nephropathy                           |12-month (6-month baseline to 6-month follow-up) |      0.3|        0.2|                       0.1|            0.1|              0.1|                             0.0|          0.2|            0.3|                           0.2|
|Kidney disease             |Nephrotic syndrome                        |12-month (6-month baseline to 6-month follow-up) |      0.0|        0.0|                       0.0|            0.0|              0.0|                             0.0|          0.2|            0.3|                           0.2|
|Lung disease               |Apical Pulmonary fibrosis                 |12-month (6-month baseline to 6-month follow-up) |      0.0|        0.0|                       0.0|            0.0|              0.0|                             0.0|          0.0|            0.1|                           0.0|
|Lung disease               |Interstitial lung disease                 |12-month (6-month baseline to 6-month follow-up) |      0.0|        0.0|                       0.0|            0.1|              0.0|                             0.1|          0.1|            0.3|                           0.1|
|Lung disease               |Restrictive lung disease                  |12-month (6-month baseline to 6-month follow-up) |      0.7|        0.4|                       1.2|            0.7|              0.8|                             1.0|          6.5|            9.4|                           9.7|
|Neurological Disease       |Cauda Equina syndrome                     |12-month (6-month baseline to 6-month follow-up) |      0.0|        0.0|                       0.1|            0.0|              0.1|                             0.0|          0.1|            0.0|                           0.2|
|Neurological Disease       |Spinal Cord compression                   |12-month (6-month baseline to 6-month follow-up) |      0.2|        0.0|                       0.3|            0.1|              0.2|                             0.2|          0.5|            0.7|                           1.2|
|PsO/PsA                    |Psoriasis                                 |12-month (6-month baseline to 6-month follow-up) |      4.1|        1.2|                       1.8|            0.8|              0.9|                             0.5|          5.0|            3.5|                           1.8|
|PsO/PsA                    |Psoriatic arthritis                       |12-month (6-month baseline to 6-month follow-up) |      6.4|        5.4|                       2.2|            2.2|              2.1|                             0.6|         11.0|            8.5|                           3.2|
|Uveitis                    |Uveitis                                   |12-month (6-month baseline to 6-month follow-up) |      7.2|        5.8|                       5.2|            1.9|              1.5|                             1.6|          8.0|            5.3|                           4.1|


## Incidence


|outcomeCategory            |disease                                   | MPCD TNF| MPCD NSAID or no exposure|MPCD p-value | Marketscan TNF| Marketscan NSAID or no exposure|Marketscan p-value | Medicare TNF| Medicare NSAID or no exposure|Medicare p-value |
|:--------------------------|:-----------------------------------------|--------:|-------------------------:|:------------|--------------:|-------------------------------:|:------------------|------------:|-----------------------------:|:----------------|
|Cancer                     |Hematologic Cancer                        |      0.2|                       0.4|NS           |            0.2|                             0.5|0.005              |          0.6|                           1.3|<0.001           |
|Cancer                     |Non Melanoma Skin Cancer                  |      0.0|                       0.0|NS           |            0.3|                             0.2|NS                 |          1.0|                           1.6|<0.001           |
|Cancer                     |Solid Cancer                              |      1.8|                       3.7|<0.001       |            0.9|                             2.7|<0.001             |          4.0|                           8.0|<0.001           |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |      1.3|                       1.6|NS           |            0.6|                             0.8|NS                 |          1.9|                           3.4|<0.001           |
|Cardiac disease            |Conduction Block                          |      0.3|                       0.6|NS           |            0.5|                             0.9|0.002              |          2.0|                           3.8|<0.001           |
|Cardiac disease            |Myocardial infarction                     |      0.0|                       0.0|NS           |            0.2|                             0.6|<0.001             |          0.4|                           0.9|<0.001           |
|Infection                  |Hospitalized infection                    |      0.1|                       0.2|NS           |            2.6|                             5.4|<0.001             |          7.1|                          12.7|<0.001           |
|Infection                  |Opportunistic infection                   |      0.9|                       0.5|NS           |            0.3|                             0.3|NS                 |          1.8|                           1.7|NS               |
|Inflammatory bowel disease |Crohn.s Disease                           |      4.6|                       2.6|<0.001       |            2.8|                             1.4|<0.001             |          3.6|                           2.3|<0.001           |
|Inflammatory bowel disease |Ulcerative Colitis                        |      2.5|                       1.3|0.006        |            1.5|                             0.8|<0.001             |          2.2|                           1.5|<0.001           |
|Lung disease               |Restrictive lung disease                  |      0.9|                       1.5|NS           |            0.6|                             0.9|0.017              |          5.3|                           7.8|<0.001           |
|Neurological Disease       |Spinal Cord compression                   |      0.1|                       0.3|NS           |            0.1|                             0.1|NS                 |          0.4|                           0.7|<0.001           |
|PsO/PsA                    |Psoriasis                                 |      3.4|                       1.5|<0.001       |            0.8|                             0.4|<0.001             |          2.5|                           1.1|<0.001           |
|Uveitis                    |Uveitis                                   |      4.4|                       3.9|NS           |            0.9|                             0.8|NS                 |          4.1|                           2.5|<0.001           |



|outcomeCategory            |disease                                   | MPCD TNF| MPCD DMARD|MPCD p-value | Marketscan TNF| Marketscan DMARD|Marketscan p-value | Medicare TNF| Medicare DMARD|Medicare p-value |
|:--------------------------|:-----------------------------------------|--------:|----------:|:------------|--------------:|----------------:|:------------------|------------:|--------------:|:----------------|
|Cancer                     |Hematologic Cancer                        |      0.2|        0.2|NS           |            0.2|              0.4|NS                 |          0.6|            1.3|<0.001           |
|Cancer                     |Non Melanoma Skin Cancer                  |      0.0|        0.0|NS           |            0.3|              0.3|NS                 |          1.0|            1.3|0.037            |
|Cancer                     |Solid Cancer                              |      1.8|        1.9|NS           |            0.9|              2.7|<0.001             |          4.0|            6.5|<0.001           |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |      1.3|        0.5|NS           |            0.6|              0.5|NS                 |          1.9|            2.5|0.003            |
|Cardiac disease            |Conduction Block                          |      0.3|        0.0|NS           |            0.5|              0.5|NS                 |          2.0|            2.6|0.004            |
|Cardiac disease            |Myocardial infarction                     |      0.0|        0.0|NS           |            0.2|              0.2|NS                 |          0.4|            0.7|0.002            |
|Infection                  |Hospitalized infection                    |      0.1|        0.0|NS           |            2.6|              3.3|NS                 |          7.1|            9.2|<0.001           |
|Infection                  |Opportunistic infection                   |      0.9|        1.2|NS           |            0.3|              0.7|0.044              |          1.8|            2.1|NS               |
|Inflammatory bowel disease |Crohn.s Disease                           |      4.6|        3.1|NS           |            2.8|              2.4|NS                 |          3.6|            3.4|NS               |
|Inflammatory bowel disease |Ulcerative Colitis                        |      2.5|        0.7|0.018        |            1.5|              1.4|NS                 |          2.2|            2.2|NS               |
|Lung disease               |Restrictive lung disease                  |      0.9|        0.0|0.029        |            0.6|              0.6|NS                 |          5.3|            6.9|<0.001           |
|Neurological Disease       |Spinal Cord compression                   |      0.1|        0.0|NS           |            0.1|              0.2|NS                 |          0.4|            0.4|NS               |
|PsO/PsA                    |Psoriasis                                 |      3.4|        1.0|0.005        |            0.8|              0.6|NS                 |          2.5|            2.0|0.011            |
|Uveitis                    |Uveitis                                   |      4.4|        5.2|NS           |            0.9|              1.2|NS                 |          4.1|            3.1|<0.001           |
