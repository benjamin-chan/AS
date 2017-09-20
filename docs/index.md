---
title: "Comorbidities and Disease Manifestations in Ankylosing Spondylitis (BAD AS)"
date: "2017-09-20 08:47:27"
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


```
## Error in eval(expr, envir, enclos): object 'denomIndexExp' not found
```

Table of **prevalence %**


|outcomeCategory            |disease                                   |timeWindow | MPCD AS cohort| Marketscan AS cohort| Medicare AS cohort|
|:--------------------------|:-----------------------------------------|:----------|--------------:|--------------------:|------------------:|
|Cancer                     |Hematologic Cancer                        |12 months  |            0.5|                  0.6|                1.6|
|Cancer                     |Non Melanoma Skin Cancer                  |12 months  |             NA|                  0.6|                1.9|
|Cancer                     |Solid Cancer                              |12 months  |            4.0|                  3.5|                9.8|
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |12 months  |            1.9|                  1.3|                4.9|
|Cardiac disease            |Conduction Block                          |12 months  |            0.6|                  1.3|                4.5|
|Cardiac disease            |Myocardial infarction                     |12 months  |            0.5|                  0.6|                1.8|
|Infection                  |Hospitalized infection                    |12 months  |            5.2|                  6.9|               19.4|
|Infection                  |Opportunistic infection                   |12 months  |            1.1|                  1.0|                2.4|
|Inflammatory bowel disease |Crohn’s Disease                           |12 months  |            4.3|                  3.6|                4.8|
|Inflammatory bowel disease |Ulcerative Colitis                        |12 months  |            2.5|                  2.6|                2.7|
|Kidney disease             |Amyloidosis                               |12 months  |            0.0|                  0.0|                0.1|
|Kidney disease             |IgA nephropathy                           |12 months  |            0.1|                  0.1|                0.2|
|Kidney disease             |Nephrotic syndrome                        |12 months  |            0.0|                  0.0|                0.2|
|Lung disease               |Apical Pulmonary fibrosis                 |12 months  |            0.0|                  0.0|                0.0|
|Lung disease               |Interstitial lung disease                 |12 months  |            0.1|                  0.1|                0.7|
|Lung disease               |Restrictive lung disease                  |12 months  |            1.3|                  1.4|                3.2|
|Neurological Disease       |Cauda Equina syndrome                     |12 months  |            0.1|                  0.1|                0.2|
|Neurological Disease       |Spinal Cord compression                   |12 months  |            0.2|                  0.2|                0.9|
|Osteoporotic fracture      |Clinical vertebral fracture               |12 months  |            2.4|                  2.2|                7.3|
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |12 months  |            2.9|                  1.9|                4.5|
|PsO/PsA                    |Psoriasis                                 |12 months  |            2.5|                  2.7|                3.8|
|PsO/PsA                    |Psoriatic arthritis                       |12 months  |            3.7|                  4.1|                5.0|
|Uveitis                    |Uveitis                                   |12 months  |            7.0|                  7.6|                4.0|


## By exposure

Read prevalence data.
See `queryPrevalentComorbidities.sas`.


|    |database   |exposure             | denomPatid| denomIndexExp|
|:---|:----------|:--------------------|----------:|-------------:|
|1   |MPCD       |DMARD                |        421|           481|
|61  |MPCD       |NSAID or no exposure |       2083|          2593|
|149 |MPCD       |TNF                  |       1107|          1279|
|221 |Marketscan |DMARD                |       1799|          2045|
|309 |Marketscan |NSAID or no exposure |       8025|         10589|
|401 |Marketscan |TNF                  |       4797|          5779|
|493 |Medicare   |DMARD                |       4231|          5193|
|585 |Medicare   |NSAID or no exposure |      17983|         26122|
|677 |Medicare   |TNF                  |       4866|          5929|

Table of **prevalence %**


|outcomeCategory            |disease                                   |timeWindow | MPCD TNF| MPCD DMARD| MPCD NSAID or no exposure| Marketscan TNF| Marketscan DMARD| Marketscan NSAID or no exposure| Medicare TNF| Medicare DMARD| Medicare NSAID or no exposure|
|:--------------------------|:-----------------------------------------|:----------|--------:|----------:|-------------------------:|--------------:|----------------:|-------------------------------:|------------:|--------------:|-----------------------------:|
|Cancer                     |Hematologic Cancer                        |12 months  |      0.3|        0.2|                       0.5|            0.1|              0.8|                             0.6|          0.4|            1.6|                           1.7|
|Cancer                     |Non Melanoma Skin Cancer                  |12 months  |       NA|         NA|                        NA|            0.5|              0.5|                             0.8|          1.2|            1.3|                           2.2|
|Cancer                     |Solid Cancer                              |12 months  |      2.6|        1.5|                       4.2|            1.8|              4.2|                             4.0|          5.7|            7.7|                          10.5|
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |12 months  |      1.7|        0.6|                       1.6|            0.8|              0.9|                             1.3|          2.9|            3.7|                           5.0|
|Cardiac disease            |Conduction Block                          |12 months  |      0.2|         NA|                       0.9|            0.7|              1.1|                             1.5|          2.4|            3.0|                           4.6|
|Cardiac disease            |Myocardial infarction                     |12 months  |      0.3|         NA|                       0.5|            0.2|              0.1|                             0.7|          0.5|            0.9|                           1.7|
|Infection                  |Hospitalized infection                    |12 months  |      1.0|        1.2|                       5.6|            3.5|              4.8|                             7.2|          9.1|           13.8|                          19.0|
|Infection                  |Opportunistic infection                   |12 months  |      1.3|        1.0|                       0.8|            1.2|              1.5|                             1.0|          2.7|            2.8|                           2.3|
|Inflammatory bowel disease |Crohn’s Disease                           |12 months  |      5.8|        4.0|                       3.4|            5.5|              3.9|                             2.7|          8.4|            6.6|                           3.9|
|Inflammatory bowel disease |Ulcerative Colitis                        |12 months  |      3.0|        2.3|                       1.9|            3.6|              2.6|                             2.1|          3.9|            3.6|                           2.1|
|Kidney disease             |Amyloidosis                               |12 months  |       NA|         NA|                       0.0|            0.0|              0.0|                             0.0|          0.1|            0.0|                           0.1|
|Kidney disease             |IgA nephropathy                           |12 months  |      0.3|        0.2|                       0.0|            0.1|              0.0|                             0.1|          0.1|            0.2|                           0.2|
|Kidney disease             |Nephrotic syndrome                        |12 months  |      0.2|        0.2|                       0.0|            0.1|              0.0|                             0.0|          0.2|            0.2|                           0.2|
|Lung disease               |Apical Pulmonary fibrosis                 |12 months  |       NA|         NA|                       0.0|            0.0|               NA|                             0.0|           NA|            0.0|                           0.0|
|Lung disease               |Interstitial lung disease                 |12 months  |       NA|         NA|                       0.1|            0.1|              0.1|                             0.1|          0.4|            1.1|                           0.6|
|Lung disease               |Restrictive lung disease                  |12 months  |      0.7|        0.4|                       1.5|            0.9|              0.7|                             1.3|          2.4|            3.4|                           3.1|
|Neurological Disease       |Cauda Equina syndrome                     |12 months  |       NA|         NA|                       0.2|            0.0|              0.1|                             0.0|          0.1|            0.0|                           0.2|
|Neurological Disease       |Spinal Cord compression                   |12 months  |      0.2|         NA|                       0.2|            0.2|              0.2|                             0.4|          0.3|            0.4|                           0.7|
|Osteoporotic fracture      |Clinical vertebral fracture               |12 months  |      1.3|        0.4|                       2.7|            0.6|              0.8|                             2.7|          1.8|            2.7|                           7.1|
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |12 months  |      2.0|        0.8|                       3.3|            1.0|              1.0|                             2.1|          2.9|            3.0|                           4.7|
|PsO/PsA                    |Psoriasis                                 |12 months  |      4.3|        1.5|                       1.9|            4.4|              3.6|                             2.1|          7.0|            4.8|                           3.1|
|PsO/PsA                    |Psoriatic arthritis                       |12 months  |      6.5|        5.4|                       2.4|            7.1|              6.4|                             2.4|         10.5|            8.1|                           3.1|
|Uveitis                    |Uveitis                                   |12 months  |      8.4|        7.3|                       6.2|            7.8|              6.8|                             7.3|          6.9|            5.0|                           3.5|
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


|outcomeCategory            |disease                                   |timeWindow | MPCD Non-AS cohort| Medicare Non-AS cohort|
|:--------------------------|:-----------------------------------------|:----------|------------------:|----------------------:|
|Cancer                     |Hematologic Cancer                        |12 months  |                0.6|                    1.2|
|Cancer                     |Non Melanoma Skin Cancer                  |12 months  |                0.0|                    0.7|
|Cancer                     |Solid Cancer                              |12 months  |                3.9|                    8.8|
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |12 months  |                0.9|                    2.7|
|Cardiac disease            |Conduction Block                          |12 months  |                0.7|                    2.3|
|Cardiac disease            |Myocardial infarction                     |12 months  |                0.2|                    1.0|
|Infection                  |Hospitalized infection                    |12 months  |                2.2|                    8.9|
|Infection                  |Opportunistic infection                   |12 months  |                0.4|                    0.9|
|Inflammatory bowel disease |Crohn’s Disease                           |12 months  |                2.2|                    0.3|
|Inflammatory bowel disease |Ulcerative Colitis                        |12 months  |                2.0|                    0.4|
|Kidney disease             |Amyloidosis                               |12 months  |                0.0|                    0.0|
|Kidney disease             |IgA nephropathy                           |12 months  |                0.1|                    0.1|
|Kidney disease             |Nephrotic syndrome                        |12 months  |                0.0|                    0.1|
|Lung disease               |Apical Pulmonary fibrosis                 |12 months  |                0.0|                    0.0|
|Lung disease               |Interstitial lung disease                 |12 months  |                0.0|                    0.0|
|Lung disease               |Restrictive lung disease                  |12 months  |                0.7|                    1.3|
|Neurological Disease       |Cauda Equina syndrome                     |12 months  |                0.0|                    0.0|
|Neurological Disease       |Spinal Cord compression                   |12 months  |                0.0|                    0.1|
|Osteoporotic fracture      |Clinical vertebral fracture               |12 months  |                0.5|                    1.1|
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |12 months  |                1.2|                    2.5|
|PsO/PsA                    |Psoriasis                                 |12 months  |                4.6|                    1.0|
|PsO/PsA                    |Psoriatic arthritis                       |12 months  |                1.0|                    0.2|
|Uveitis                    |Uveitis                                   |12 months  |                0.2|                    0.2|
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
|24  |MPCD       |NSAID or no exposure |  2093|
|47  |MPCD       |TNF                  |  1108|
|70  |Marketscan |DMARD                |  1813|
|93  |Marketscan |NSAID or no exposure |  8122|
|116 |Marketscan |TNF                  |  4824|
|139 |Medicare   |DMARD                |  4304|
|162 |Medicare   |NSAID or no exposure | 18431|
|185 |Medicare   |TNF                  |  4937|

Table of **incidence per 100 person-years**


|outcomeCategory            |disease                                   | MPCD TNF| MPCD DMARD| MPCD NSAID or no exposure| Marketscan TNF| Marketscan DMARD| Marketscan NSAID or no exposure| Medicare TNF| Medicare DMARD| Medicare NSAID or no exposure|
|:--------------------------|:-----------------------------------------|--------:|----------:|-------------------------:|--------------:|----------------:|-------------------------------:|------------:|--------------:|-----------------------------:|
|Cancer                     |Hematologic Cancer                        |      0.2|        0.2|                       0.6|            0.2|              0.8|                             0.6|          0.4|            1.0|                           1.1|
|Cancer                     |Non Melanoma Skin Cancer                  |      0.0|        0.0|                       0.0|            0.8|              1.1|                             0.9|          1.3|            1.5|                           2.0|
|Cancer                     |Solid Cancer                              |      2.2|        1.9|                       4.5|            1.8|              4.5|                             4.0|          3.3|            5.3|                           7.0|
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |      1.1|        0.2|                       1.7|            0.7|              1.0|                             1.3|          1.8|            2.8|                           3.4|
|Cardiac disease            |Conduction Block                          |      0.3|        0.0|                       0.9|            0.7|              0.8|                             1.6|          1.9|            2.5|                           3.6|
|Cardiac disease            |Myocardial infarction                     |      0.3|        0.0|                       0.6|            0.2|              0.3|                             0.6|          0.7|            1.2|                           1.5|
|Infection                  |Hospitalized infection                    |      1.1|        0.9|                       6.4|            3.1|              4.2|                             6.7|          8.8|           11.7|                          15.9|
|Infection                  |Opportunistic infection                   |      0.9|        1.4|                       0.5|            0.9|              1.3|                             0.8|          1.7|            2.1|                           2.0|
|Inflammatory bowel disease |Crohn’s Disease                           |      4.5|        3.6|                       2.9|            4.3|              3.6|                             2.3|          3.6|            3.4|                           2.2|
|Inflammatory bowel disease |Ulcerative Colitis                        |      2.4|        0.9|                       1.6|            2.6|              2.4|                             1.7|          2.0|            1.8|                           1.3|
|Kidney disease             |Amyloidosis                               |      0.0|        0.0|                       0.1|            0.0|              0.0|                             0.0|          0.1|            0.0|                           0.0|
|Kidney disease             |IgA nephropathy                           |      0.2|        0.0|                       0.1|            0.1|              0.0|                             0.1|          0.2|            0.1|                           0.1|
|Kidney disease             |Nephrotic syndrome                        |      0.1|        0.0|                       0.0|            0.0|              0.1|                             0.0|          0.1|            0.1|                           0.1|
|Lung disease               |Apical Pulmonary fibrosis                 |      0.0|        0.0|                       0.0|            0.0|              0.0|                             0.0|          0.0|            0.0|                           0.0|
|Lung disease               |Interstitial lung disease                 |      0.0|        0.0|                       0.1|            0.1|              0.1|                             0.1|          0.4|            0.8|                           0.4|
|Lung disease               |Restrictive lung disease                  |      0.8|        0.0|                       1.8|            0.7|              0.8|                             1.3|          2.0|            2.5|                           2.4|
|Neurological Disease       |Cauda Equina syndrome                     |      0.0|        0.0|                       0.2|            0.0|              0.1|                             0.0|          0.1|            0.0|                           0.1|
|Neurological Disease       |Spinal Cord compression                   |      0.1|        0.0|                       0.3|            0.2|              0.2|                             0.3|          0.2|            0.3|                           0.4|
|Osteoporotic fracture      |Clinical vertebral fracture               |      0.9|        0.2|                       1.7|            0.4|              0.7|                             2.3|          1.7|            2.4|                           4.0|
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |      1.3|        0.9|                       3.3|            1.2|              1.1|                             1.8|          2.6|            3.3|                           3.6|
|PsO/PsA                    |Psoriasis                                 |      3.4|        1.0|                       1.6|            3.4|              3.1|                             1.7|          3.5|            3.2|                           1.9|
|PsO/PsA                    |Psoriatic arthritis                       |      5.1|        5.1|                       1.8|            5.2|              6.4|                             1.9|          4.6|            4.0|                           1.6|
|Uveitis                    |Uveitis                                   |      5.0|        6.5|                       4.9|            5.6|              6.6|                             5.8|          3.7|            2.8|                           2.1|

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

**Do TNF Inhibitors Reduce the Incidence of Cardiac, Pulmonary and Neurologic Comorbidities in Ankylosing Spondylitis? An Analysis of Three Large US Claims Databases.**
Atul Deodhar, Kevin Winthrop, Benjamin Chan, Sarah Siegel, Jeffery Stark, Robert Suruki, Rhonda Bohn, Huifeng Yun, Lang Chen, Jeffery Curtis

Build tables for Atul's 2017 ACR abstract.
Collects code chunks from `summarizePrevalence.Rmd` and `summarizeIncidence.Rmd`.


## Prevalence, unadjusted

Prevalence is **12-month (6-month baseline to 6-month follow-up)**.


|outcomeCategory            |disease                                   | MPCD TNF | MPCD DMARD | MPCD NSAID or no exposure | Marketscan TNF | Marketscan DMARD | Marketscan NSAID or no exposure | Medicare TNF | Medicare DMARD | Medicare NSAID or no exposure |
|:--------------------------|:-----------------------------------------|:--------:|:----------:|:-------------------------:|:--------------:|:----------------:|:-------------------------------:|:------------:|:--------------:|:-----------------------------:|
|Cancer                     |Hematologic Cancer                        |   0.3    |    0.2     |            0.5            |      0.1       |       0.8        |               0.6               |     0.4      |      1.6       |              1.7              |
|Cancer                     |Non Melanoma Skin Cancer                  |   0.0    |    0.0     |            0.0            |      0.5       |       0.5        |               0.8               |     1.2      |      1.3       |              2.2              |
|Cancer                     |Solid Cancer                              |   2.6    |    1.5     |            4.2            |      1.8       |       4.2        |               4.0               |     5.7      |      7.7       |             10.5              |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |   1.7    |    0.6     |            1.6            |      0.8       |       0.9        |               1.3               |     2.9      |      3.7       |              5.0              |
|Cardiac disease            |Conduction Block                          |   0.2    |    0.0     |            0.9            |      0.7       |       1.1        |               1.5               |     2.4      |      3.0       |              4.6              |
|Cardiac disease            |Myocardial infarction                     |   0.3    |    0.0     |            0.5            |      0.2       |       0.1        |               0.7               |     0.5      |      0.9       |              1.7              |
|Infection                  |Hospitalized infection                    |   1.0    |    1.2     |            5.6            |      3.5       |       4.8        |               7.2               |     9.1      |      13.8      |             19.0              |
|Infection                  |Opportunistic infection                   |   1.3    |    1.0     |            0.8            |      1.2       |       1.5        |               1.0               |     2.7      |      2.8       |              2.3              |
|Inflammatory bowel disease |Crohn’s Disease                           |   5.8    |    4.0     |            3.4            |      5.5       |       3.9        |               2.7               |     8.4      |      6.6       |              3.9              |
|Inflammatory bowel disease |Ulcerative Colitis                        |   3.0    |    2.3     |            1.9            |      3.6       |       2.6        |               2.1               |     3.9      |      3.6       |              2.1              |
|Kidney disease             |Amyloidosis                               |   0.0    |    0.0     |            0.0            |      0.0       |       0.0        |               0.0               |     0.1      |      0.0       |              0.1              |
|Kidney disease             |IgA nephropathy                           |   0.3    |    0.2     |            0.0            |      0.1       |       0.0        |               0.1               |     0.1      |      0.2       |              0.2              |
|Kidney disease             |Nephrotic syndrome                        |   0.2    |    0.2     |            0.0            |      0.1       |       0.0        |               0.0               |     0.2      |      0.2       |              0.2              |
|Lung disease               |Apical Pulmonary fibrosis                 |   0.0    |    0.0     |            0.0            |      0.0       |       0.0        |               0.0               |     0.0      |      0.0       |              0.0              |
|Lung disease               |Interstitial lung disease                 |   0.0    |    0.0     |            0.1            |      0.1       |       0.1        |               0.1               |     0.4      |      1.1       |              0.6              |
|Lung disease               |Restrictive lung disease                  |   0.7    |    0.4     |            1.5            |      0.9       |       0.7        |               1.3               |     2.4      |      3.4       |              3.1              |
|Neurological Disease       |Cauda Equina syndrome                     |   0.0    |    0.0     |            0.2            |      0.0       |       0.1        |               0.0               |     0.1      |      0.0       |              0.2              |
|Neurological Disease       |Spinal Cord compression                   |   0.2    |    0.0     |            0.2            |      0.2       |       0.2        |               0.4               |     0.3      |      0.4       |              0.7              |
|Osteoporotic fracture      |Clinical vertebral fracture               |   1.3    |    0.4     |            2.7            |      0.6       |       0.8        |               2.7               |     1.8      |      2.7       |              7.1              |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |   2.0    |    0.8     |            3.3            |      1.0       |       1.0        |               2.1               |     2.9      |      3.0       |              4.7              |
|PsO/PsA                    |Psoriasis                                 |   4.3    |    1.5     |            1.9            |      4.4       |       3.6        |               2.1               |     7.0      |      4.8       |              3.1              |
|PsO/PsA                    |Psoriatic arthritis                       |   6.5    |    5.4     |            2.4            |      7.1       |       6.4        |               2.4               |     10.5     |      8.1       |              3.1              |
|Uveitis                    |Uveitis                                   |   8.4    |    7.3     |            6.2            |      7.8       |       6.8        |               7.3               |     6.9      |      5.0       |              3.5              |


## Incidence, unadjusted



**TNF vs NSAID or no exposure**


|outcomeCategory            |disease                                   | MPCD TNF | MPCD NSAID or no exposure | MPCD p-value | Marketscan TNF | Marketscan NSAID or no exposure | Marketscan p-value | Medicare TNF | Medicare NSAID or no exposure | Medicare p-value |
|:--------------------------|:-----------------------------------------|:--------:|:-------------------------:|:------------:|:--------------:|:-------------------------------:|:------------------:|:------------:|:-----------------------------:|:----------------:|
|Cancer                     |Hematologic Cancer                        |   0.2    |            0.6            |      NS      |      0.2       |               0.6               |       <0.001       |     0.4      |              1.1              |      <0.001      |
|Cancer                     |Non Melanoma Skin Cancer                  |   0.0    |            0.0            |      NS      |      0.8       |               0.9               |         NS         |     1.3      |              2.0              |      <0.001      |
|Cancer                     |Solid Cancer                              |   2.2    |            4.5            |    <0.001    |      1.8       |               4.0               |       <0.001       |     3.3      |              7.0              |      <0.001      |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |   1.1    |            1.7            |      NS      |      0.7       |               1.3               |       <0.001       |     1.8      |              3.4              |      <0.001      |
|Cardiac disease            |Conduction Block                          |   0.3    |            0.9            |    0.016     |      0.7       |               1.6               |       <0.001       |     1.9      |              3.6              |      <0.001      |
|Cardiac disease            |Myocardial infarction                     |   0.3    |            0.6            |      NS      |      0.2       |               0.6               |       <0.001       |     0.7      |              1.5              |      <0.001      |
|Infection                  |Hospitalized infection                    |   1.1    |            6.4            |    <0.001    |      3.1       |               6.7               |       <0.001       |     8.8      |             15.9              |      <0.001      |
|Infection                  |Opportunistic infection                   |   0.9    |            0.5            |      NS      |      0.9       |               0.8               |         NS         |     1.7      |              2.0              |        NS        |
|Inflammatory bowel disease |Crohn.s Disease                           |   4.5    |            2.9            |    0.012     |      4.3       |               2.3               |       <0.001       |     3.6      |              2.2              |      <0.001      |
|Inflammatory bowel disease |Ulcerative Colitis                        |   2.4    |            1.6            |      NS      |      2.6       |               1.7               |       <0.001       |     2.0      |              1.3              |      <0.001      |
|Kidney disease             |Amyloidosis                               |   0.0    |            0.1            |      NS      |      0.0       |               0.0               |         NS         |     0.1      |              0.0              |        NS        |
|Kidney disease             |IgA nephropathy                           |   0.2    |            0.1            |      NS      |      0.1       |               0.1               |         NS         |     0.2      |              0.1              |        NS        |
|Kidney disease             |Nephrotic syndrome                        |   0.1    |            0.0            |      NS      |      0.0       |               0.0               |         NS         |     0.1      |              0.1              |        NS        |
|Lung disease               |Apical Pulmonary fibrosis                 |   0.0    |            0.0            |      NS      |      0.0       |               0.0               |         NS         |     0.0      |              0.0              |        NS        |
|Lung disease               |Interstitial lung disease                 |   0.0    |            0.1            |      NS      |      0.1       |               0.1               |         NS         |     0.4      |              0.4              |        NS        |
|Lung disease               |Restrictive lung disease                  |   0.8    |            1.8            |    0.007     |      0.7       |               1.3               |       0.001        |     2.0      |              2.4              |      0.005       |
|Neurological Disease       |Cauda Equina syndrome                     |   0.0    |            0.2            |      NS      |      0.0       |               0.0               |         NS         |     0.1      |              0.1              |        NS        |
|Neurological Disease       |Spinal Cord compression                   |   0.1    |            0.3            |      NS      |      0.2       |               0.3               |         NS         |     0.2      |              0.4              |      <0.001      |
|Osteoporotic fracture      |Clinical vertebral fracture               |   0.9    |            1.7            |    0.023     |      0.4       |               2.3               |       <0.001       |     1.7      |              4.0              |      <0.001      |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |   1.3    |            3.3            |    <0.001    |      1.2       |               1.8               |       0.006        |     2.6      |              3.6              |      <0.001      |
|PsO/PsA                    |Psoriasis                                 |   3.4    |            1.6            |    <0.001    |      3.4       |               1.7               |       <0.001       |     3.5      |              1.9              |      <0.001      |
|PsO/PsA                    |Psoriatic arthritis                       |   5.1    |            1.8            |    <0.001    |      5.2       |               1.9               |       <0.001       |     4.6      |              1.6              |      <0.001      |
|Uveitis                    |Uveitis                                   |   5.0    |            4.9            |      NS      |      5.6       |               5.8               |         NS         |     3.7      |              2.1              |      <0.001      |

\newline

**TNF vs DMARD**


|outcomeCategory            |disease                                   | MPCD TNF | MPCD DMARD | MPCD p-value | Marketscan TNF | Marketscan DMARD | Marketscan p-value | Medicare TNF | Medicare DMARD | Medicare p-value |
|:--------------------------|:-----------------------------------------|:--------:|:----------:|:------------:|:--------------:|:----------------:|:------------------:|:------------:|:--------------:|:----------------:|
|Cancer                     |Hematologic Cancer                        |   0.2    |    0.2     |      NS      |      0.2       |       0.8        |       <0.001       |     0.4      |      1.0       |      <0.001      |
|Cancer                     |Non Melanoma Skin Cancer                  |   0.0    |    0.0     |      NS      |      0.8       |       1.1        |         NS         |     1.3      |      1.5       |        NS        |
|Cancer                     |Solid Cancer                              |   2.2    |    1.9     |      NS      |      1.8       |       4.5        |       <0.001       |     3.3      |      5.3       |      <0.001      |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |   1.1    |    0.2     |      NS      |      0.7       |       1.0        |         NS         |     1.8      |      2.8       |      <0.001      |
|Cardiac disease            |Conduction Block                          |   0.3    |    0.0     |      NS      |      0.7       |       0.8        |         NS         |     1.9      |      2.5       |      0.003       |
|Cardiac disease            |Myocardial infarction                     |   0.3    |    0.0     |      NS      |      0.2       |       0.3        |         NS         |     0.7      |      1.2       |      <0.001      |
|Infection                  |Hospitalized infection                    |   1.1    |    0.9     |      NS      |      3.1       |       4.2        |       0.027        |     8.8      |      11.7      |      <0.001      |
|Infection                  |Opportunistic infection                   |   0.9    |    1.4     |      NS      |      0.9       |       1.3        |         NS         |     1.7      |      2.1       |      0.022       |
|Inflammatory bowel disease |Crohn.s Disease                           |   4.5    |    3.6     |      NS      |      4.3       |       3.6        |         NS         |     3.6      |      3.4       |        NS        |
|Inflammatory bowel disease |Ulcerative Colitis                        |   2.4    |    0.9     |      NS      |      2.6       |       2.4        |         NS         |     2.0      |      1.8       |        NS        |
|Kidney disease             |Amyloidosis                               |   0.0    |    0.0     |      NS      |      0.0       |       0.0        |         NS         |     0.1      |      0.0       |        NS        |
|Kidney disease             |IgA nephropathy                           |   0.2    |    0.0     |      NS      |      0.1       |       0.0        |         NS         |     0.2      |      0.1       |        NS        |
|Kidney disease             |Nephrotic syndrome                        |   0.1    |    0.0     |      NS      |      0.0       |       0.1        |         NS         |     0.1      |      0.1       |        NS        |
|Lung disease               |Apical Pulmonary fibrosis                 |   0.0    |    0.0     |      NS      |      0.0       |       0.0        |         NS         |     0.0      |      0.0       |        NS        |
|Lung disease               |Interstitial lung disease                 |   0.0    |    0.0     |      NS      |      0.1       |       0.1        |         NS         |     0.4      |      0.8       |      <0.001      |
|Lung disease               |Restrictive lung disease                  |   0.8    |    0.0     |    0.048     |      0.7       |       0.8        |         NS         |     2.0      |      2.5       |      0.017       |
|Neurological Disease       |Cauda Equina syndrome                     |   0.0    |    0.0     |      NS      |      0.0       |       0.1        |         NS         |     0.1      |      0.0       |      0.014       |
|Neurological Disease       |Spinal Cord compression                   |   0.1    |    0.0     |      NS      |      0.2       |       0.2        |         NS         |     0.2      |      0.3       |        NS        |
|Osteoporotic fracture      |Clinical vertebral fracture               |   0.9    |    0.2     |      NS      |      0.4       |       0.7        |         NS         |     1.7      |      2.4       |      0.002       |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |   1.3    |    0.9     |      NS      |      1.2       |       1.1        |         NS         |     2.6      |      3.3       |      0.003       |
|PsO/PsA                    |Psoriasis                                 |   3.4    |    1.0     |    0.005     |      3.4       |       3.1        |         NS         |     3.5      |      3.2       |        NS        |
|PsO/PsA                    |Psoriatic arthritis                       |   5.1    |    5.1     |      NS      |      5.2       |       6.4        |         NS         |     4.6      |      4.0       |      0.038       |
|Uveitis                    |Uveitis                                   |   5.0    |    6.5     |      NS      |      5.6       |       6.6        |         NS         |     3.7      |      2.8       |      <0.001      |
