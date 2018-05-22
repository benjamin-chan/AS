---
title: "Comorbidities and Disease Manifestations in Ankylosing Spondylitis (BAD AS)"
date: "2018-05-22 08:54:09"
author: Benjamin Chan (chanb@ohsu.edu)
output:
  html_document:
    toc: true
    theme: simplex
---
See [`script.bat`](../scripts), 
which is executed before the [`postprocess.bat`](../scripts) script, 
which produced this document.


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
|1   |MPCD       |       1223|
|89  |Marketscan |       5205|
|181 |Medicare   |       6690|

Table of **prevalence %**


|outcomeCategory            |disease                                   |timeWindow                  |MPCD AS cohort   |Marketscan AS cohort |Medicare AS cohort |
|:--------------------------|:-----------------------------------------|:---------------------------|:----------------|:--------------------|:------------------|
|Cancer                     |Hematologic Cancer                        |12 months                   |1.3 (0.8-2.1)    |1.3 (1.0-1.6)        |5.3 (4.8-5.8)      |
|Cancer                     |Hematologic Cancer                        |24 months                   |1.9 (1.2-2.8)    |1.6 (1.3-2.0)        |6.5 (5.9-7.1)      |
|Cancer                     |Hematologic Cancer                        |36 months                   |2.0 (1.3-2.9)    |1.8 (1.5-2.2)        |7.4 (6.8-8.0)      |
|Cancer                     |Hematologic Cancer                        |AS cohort entry to exposure |1.5 (0.9-2.3)    |1.1 (0.8-1.4)        |5.3 (4.8-5.8)      |
|Cancer                     |Non Melanoma Skin Cancer                  |12 months                   |0                |1.4 (1.1-1.8)        |6.3 (5.7-6.9)      |
|Cancer                     |Non Melanoma Skin Cancer                  |24 months                   |0                |2.8 (2.4-3.3)        |9.9 (9.2-10.6)     |
|Cancer                     |Non Melanoma Skin Cancer                  |36 months                   |0                |3.5 (3.1-4.1)        |11.9 (11.2-12.7)   |
|Cancer                     |Non Melanoma Skin Cancer                  |AS cohort entry to exposure |0                |1.8 (1.4-2.2)        |6.2 (5.6-6.8)      |
|Cancer                     |Solid Cancer                              |12 months                   |9.8 (8.2-11.6)   |8.0 (7.3-8.8)        |32.9 (31.8-34.1)   |
|Cancer                     |Solid Cancer                              |24 months                   |13.2 (11.4-15.2) |9.8 (9.0-10.6)       |40.6 (39.4-41.7)   |
|Cancer                     |Solid Cancer                              |36 months                   |14.6 (12.7-16.7) |11.1 (10.2-11.9)     |45.1 (43.9-46.3)   |
|Cancer                     |Solid Cancer                              |AS cohort entry to exposure |8.6 (7.1-10.3)   |7.8 (7.1-8.6)        |35.4 (34.2-36.5)   |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |12 months                   |4.7 (3.6-6.0)    |3.1 (2.6-3.5)        |16.4 (15.6-17.3)   |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |24 months                   |6.2 (5.0-7.7)    |3.9 (3.4-4.4)        |21.6 (20.7-22.6)   |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |36 months                   |7.0 (5.7-8.6)    |4.4 (3.8-5.0)        |25.0 (24.0-26.1)   |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |AS cohort entry to exposure |3.9 (2.9-5.1)    |2.9 (2.5-3.4)        |18.9 (18.0-19.8)   |
|Cardiac disease            |Conduction Block                          |12 months                   |1.6 (1.0-2.4)    |2.9 (2.5-3.4)        |15.2 (14.4-16.1)   |
|Cardiac disease            |Conduction Block                          |24 months                   |2.2 (1.5-3.1)    |3.8 (3.3-4.4)        |20.9 (19.9-21.9)   |
|Cardiac disease            |Conduction Block                          |36 months                   |2.5 (1.8-3.5)    |4.5 (3.9-5.1)        |24.9 (23.9-26.0)   |
|Cardiac disease            |Conduction Block                          |AS cohort entry to exposure |1.4 (0.8-2.2)    |2.3 (1.9-2.7)        |16.8 (16.0-17.8)   |
|Cardiac disease            |Myocardial infarction                     |12 months                   |1.1 (0.7-1.9)    |1.3 (1.1-1.7)        |6.0 (5.5-6.6)      |
|Cardiac disease            |Myocardial infarction                     |24 months                   |2.0 (1.3-2.9)    |1.7 (1.4-2.1)        |8.6 (8.0-9.3)      |
|Cardiac disease            |Myocardial infarction                     |36 months                   |2.1 (1.4-3.1)    |2.0 (1.6-2.4)        |10.7 (10.0-11.5)   |
|Cardiac disease            |Myocardial infarction                     |AS cohort entry to exposure |1.0 (0.5-1.7)    |0.8 (0.6-1.1)        |6.3 (5.8-6.9)      |
|Infection                  |Hospitalized infection                    |12 months                   |12.8 (11.0-14.7) |15.9 (14.9-16.9)     |65.5 (64.4-66.7)   |
|Infection                  |Hospitalized infection                    |24 months                   |16.2 (14.2-18.3) |20.5 (19.4-21.6)     |85.9 (85.1-86.8)   |
|Infection                  |Hospitalized infection                    |36 months                   |17.4 (15.4-19.6) |22.6 (21.5-23.8)     |99.1 (98.9-99.3)   |
|Infection                  |Hospitalized infection                    |AS cohort entry to exposure |9.1 (7.6-10.8)   |12.2 (11.3-13.1)     |63.6 (62.4-64.7)   |
|Infection                  |Opportunistic infection                   |12 months                   |2.6 (1.8-3.6)    |2.3 (2.0-2.8)        |8.3 (7.6-8.9)      |
|Infection                  |Opportunistic infection                   |24 months                   |3.4 (2.5-4.6)    |3.3 (2.8-3.8)        |12.2 (11.4-13.0)   |
|Infection                  |Opportunistic infection                   |36 months                   |3.9 (2.9-5.1)    |4.0 (3.5-4.5)        |15.1 (14.2-15.9)   |
|Infection                  |Opportunistic infection                   |AS cohort entry to exposure |2.1 (1.4-3.1)    |1.8 (1.5-2.2)        |10.2 (9.5-10.9)    |
|Inflammatory bowel disease |Crohn’s Disease                           |12 months                   |10.5 (8.8-12.3)  |8.2 (7.5-9.0)        |16.2 (15.3-17.1)   |
|Inflammatory bowel disease |Crohn’s Disease                           |24 months                   |12.4 (10.7-14.4) |9.9 (9.1-10.7)       |18.3 (17.4-19.2)   |
|Inflammatory bowel disease |Crohn’s Disease                           |36 months                   |13.6 (11.7-15.6) |10.5 (9.6-11.3)      |19.4 (18.5-20.4)   |
|Inflammatory bowel disease |Crohn’s Disease                           |AS cohort entry to exposure |7.9 (6.5-9.5)    |7.2 (6.5-7.9)        |16.8 (15.9-17.7)   |
|Inflammatory bowel disease |Ulcerative Colitis                        |12 months                   |6.1 (4.8-7.5)    |6.0 (5.4-6.7)        |9.0 (8.3-9.7)      |
|Inflammatory bowel disease |Ulcerative Colitis                        |24 months                   |7.5 (6.1-9.1)    |7.1 (6.4-7.8)        |11.4 (10.7-12.2)   |
|Inflammatory bowel disease |Ulcerative Colitis                        |36 months                   |8.0 (6.6-9.6)    |7.5 (6.8-8.2)        |12.9 (12.1-13.7)   |
|Inflammatory bowel disease |Ulcerative Colitis                        |AS cohort entry to exposure |4.8 (3.7-6.1)    |5.2 (4.6-5.9)        |11.4 (10.7-12.2)   |
|Kidney disease             |Amyloidosis                               |12 months                   |0.1 (0.0-0.4)    |0.1 (0.0-0.2)        |0.2 (0.1-0.4)      |
|Kidney disease             |Amyloidosis                               |24 months                   |0.2 (0.0-0.5)    |0.1 (0.0-0.2)        |0.3 (0.2-0.5)      |
|Kidney disease             |Amyloidosis                               |36 months                   |0.2 (0.1-0.7)    |0.1 (0.0-0.2)        |0.4 (0.2-0.5)      |
|Kidney disease             |Amyloidosis                               |AS cohort entry to exposure |0.1 (0.0-0.4)    |0.1 (0.0-0.2)        |0.3 (0.2-0.4)      |
|Kidney disease             |IgA nephropathy                           |12 months                   |0.2 (0.1-0.7)    |0.3 (0.2-0.5)        |0.8 (0.6-1.0)      |
|Kidney disease             |IgA nephropathy                           |24 months                   |0.4 (0.2-0.9)    |0.4 (0.2-0.6)        |1.1 (0.9-1.4)      |
|Kidney disease             |IgA nephropathy                           |36 months                   |0.6 (0.3-1.1)    |0.4 (0.3-0.6)        |1.4 (1.2-1.7)      |
|Kidney disease             |IgA nephropathy                           |AS cohort entry to exposure |0.2 (0.0-0.5)    |0.3 (0.2-0.5)        |1.0 (0.8-1.3)      |
|Kidney disease             |Nephrotic syndrome                        |12 months                   |0.0 (0.0-0.2)    |0.0 (0.0-0.1)        |0.5 (0.4-0.7)      |
|Kidney disease             |Nephrotic syndrome                        |24 months                   |0.2 (0.0-0.5)    |0.1 (0.0-0.2)        |0.7 (0.5-0.9)      |
|Kidney disease             |Nephrotic syndrome                        |36 months                   |0.2 (0.0-0.5)    |0.2 (0.1-0.3)        |0.8 (0.6-1.1)      |
|Kidney disease             |Nephrotic syndrome                        |AS cohort entry to exposure |0.0 (0.0-0.2)    |0.1 (0.0-0.2)        |0.6 (0.4-0.8)      |
|Lung disease               |Apical Pulmonary fibrosis                 |12 months                   |0.0 (0.0-0.2)    |0.0 (0.0-0.1)        |0.0 (0.0-0.1)      |
|Lung disease               |Apical Pulmonary fibrosis                 |24 months                   |0.1 (0.0-0.4)    |0.0 (0.0-0.1)        |0.1 (0.0-0.2)      |
|Lung disease               |Apical Pulmonary fibrosis                 |36 months                   |0.1 (0.0-0.4)    |0.0 (0.0-0.1)        |0.1 (0.0-0.2)      |
|Lung disease               |Apical Pulmonary fibrosis                 |AS cohort entry to exposure |0.0 (0.0-0.2)    |0.0 (0.0-0.1)        |0.0 (0.0-0.1)      |
|Lung disease               |Interstitial lung disease                 |12 months                   |0.2 (0.0-0.5)    |0.3 (0.2-0.5)        |2.2 (1.9-2.6)      |
|Lung disease               |Interstitial lung disease                 |24 months                   |0.3 (0.1-0.8)    |0.4 (0.2-0.6)        |3.1 (2.7-3.6)      |
|Lung disease               |Interstitial lung disease                 |36 months                   |0.3 (0.1-0.8)    |0.4 (0.2-0.6)        |3.7 (3.3-4.2)      |
|Lung disease               |Interstitial lung disease                 |AS cohort entry to exposure |0.2 (0.0-0.5)    |0.2 (0.1-0.4)        |2.6 (2.2-3.0)      |
|Lung disease               |Restrictive lung disease                  |12 months                   |3.1 (2.2-4.2)    |3.1 (2.7-3.6)        |10.8 (10.1-11.5)   |
|Lung disease               |Restrictive lung disease                  |24 months                   |5.6 (4.4-7.0)    |4.2 (3.7-4.7)        |16.0 (15.2-16.9)   |
|Lung disease               |Restrictive lung disease                  |36 months                   |6.1 (4.9-7.6)    |4.8 (4.2-5.4)        |19.8 (18.8-20.7)   |
|Lung disease               |Restrictive lung disease                  |AS cohort entry to exposure |2.1 (1.4-3.1)    |3.0 (2.6-3.5)        |13.8 (13.0-14.7)   |
|Neurological Disease       |Cauda Equina syndrome                     |12 months                   |0.3 (0.1-0.8)    |0.1 (0.0-0.2)        |0.7 (0.5-0.9)      |
|Neurological Disease       |Cauda Equina syndrome                     |24 months                   |0.4 (0.2-0.9)    |0.1 (0.1-0.3)        |0.9 (0.7-1.1)      |
|Neurological Disease       |Cauda Equina syndrome                     |36 months                   |0.4 (0.2-0.9)    |0.2 (0.1-0.3)        |0.9 (0.7-1.2)      |
|Neurological Disease       |Cauda Equina syndrome                     |AS cohort entry to exposure |0.2 (0.1-0.7)    |0.1 (0.1-0.3)        |0.7 (0.5-0.9)      |
|Neurological Disease       |Spinal Cord compression                   |12 months                   |0.4 (0.2-0.9)    |0.6 (0.4-0.8)        |2.9 (2.5-3.3)      |
|Neurological Disease       |Spinal Cord compression                   |24 months                   |0.7 (0.3-1.2)    |0.9 (0.7-1.2)        |3.5 (3.0-3.9)      |
|Neurological Disease       |Spinal Cord compression                   |36 months                   |0.9 (0.5-1.6)    |1.0 (0.8-1.3)        |3.9 (3.4-4.3)      |
|Neurological Disease       |Spinal Cord compression                   |AS cohort entry to exposure |0.2 (0.1-0.7)    |0.4 (0.3-0.6)        |3.1 (2.7-3.5)      |
|Osteoporotic fracture      |Clinical vertebral fracture               |12 months                   |1.2 (0.7-2.0)    |0.7 (0.5-0.9)        |2.1 (1.8-2.5)      |
|Osteoporotic fracture      |Clinical vertebral fracture               |24 months                   |1.6 (1.0-2.4)    |1.0 (0.7-1.3)        |3.5 (3.1-3.9)      |
|Osteoporotic fracture      |Clinical vertebral fracture               |36 months                   |1.9 (1.2-2.8)    |1.2 (0.9-1.5)        |4.6 (4.1-5.1)      |
|Osteoporotic fracture      |Clinical vertebral fracture               |AS cohort entry to exposure |0.9 (0.5-1.6)    |0.7 (0.5-1.0)        |2.7 (2.4-3.1)      |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |12 months                   |1.8 (1.2-2.7)    |0.8 (0.6-1.1)        |2.7 (2.4-3.1)      |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |24 months                   |3.5 (2.6-4.7)    |1.6 (1.3-2.0)        |5.1 (4.6-5.6)      |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |36 months                   |3.9 (2.9-5.1)    |2.0 (1.6-2.4)        |6.7 (6.1-7.3)      |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |AS cohort entry to exposure |2.6 (1.8-3.6)    |1.4 (1.1-1.8)        |4.1 (3.6-4.6)      |
|PsO/PsA                    |Psoriasis                                 |12 months                   |6.1 (4.9-7.6)    |6.2 (5.6-6.9)        |12.8 (12.0-13.6)   |
|PsO/PsA                    |Psoriasis                                 |24 months                   |8.8 (7.3-10.5)   |8.4 (7.6-9.1)        |17.0 (16.1-17.9)   |
|PsO/PsA                    |Psoriasis                                 |36 months                   |9.8 (8.2-11.6)   |9.6 (8.8-10.4)       |19.5 (18.6-20.5)   |
|PsO/PsA                    |Psoriasis                                 |AS cohort entry to exposure |5.9 (4.7-7.3)    |5.4 (4.8-6.1)        |16.6 (15.7-17.5)   |
|PsO/PsA                    |Psoriatic arthritis                       |12 months                   |9.0 (7.5-10.7)   |9.3 (8.6-10.2)       |16.8 (16.0-17.8)   |
|PsO/PsA                    |Psoriatic arthritis                       |24 months                   |11.4 (9.7-13.2)  |11.7 (10.8-12.6)     |19.8 (18.9-20.8)   |
|PsO/PsA                    |Psoriatic arthritis                       |36 months                   |12.7 (10.9-14.6) |12.7 (11.8-13.6)     |21.4 (20.4-22.4)   |
|PsO/PsA                    |Psoriatic arthritis                       |AS cohort entry to exposure |6.2 (5.0-7.7)    |6.7 (6.1-7.4)        |16.3 (15.5-17.2)   |
|Uveitis                    |Uveitis                                   |12 months                   |17.3 (15.2-19.4) |17.5 (16.5-18.5)     |13.6 (12.8-14.4)   |
|Uveitis                    |Uveitis                                   |24 months                   |20.9 (18.7-23.3) |21.1 (20.0-22.2)     |17.9 (17.0-18.8)   |
|Uveitis                    |Uveitis                                   |36 months                   |23.0 (20.7-25.4) |22.9 (21.7-24.0)     |20.9 (19.9-21.9)   |
|Uveitis                    |Uveitis                                   |AS cohort entry to exposure |15.2 (13.3-17.3) |17.2 (16.2-18.3)     |16.5 (15.7-17.4)   |


## By exposure

Read prevalence data.
See `queryPrevalentComorbidities.sas`.


|    |database   |exposure    | denomPatid| denomIndexExp|
|:---|:----------|:-----------|----------:|-------------:|
|1   |MPCD       |DMARD       |        145|           165|
|61  |MPCD       |NSAID       |        265|           355|
|125 |MPCD       |No exposure |        512|           512|
|213 |MPCD       |TNF         |        575|           670|
|285 |Marketscan |DMARD       |        710|           777|
|373 |Marketscan |NSAID       |       1293|          1733|
|457 |Marketscan |No exposure |       1699|          1699|
|549 |Marketscan |TNF         |       2864|          3453|
|641 |Medicare   |DMARD       |       1432|          1688|
|733 |Medicare   |NSAID       |       2755|          4147|
|825 |Medicare   |No exposure |       2489|          2489|
|917 |Medicare   |TNF         |       2660|          3268|

Table of **prevalence %**


```
## Warning in qbeta(alpha/2, numer + 0.5, denom - numer + 0.5): NaNs produced
```

```
## Warning in qbeta(1 - alpha/2, numer + 0.5, denom - numer + 0.5): NaNs
## produced
```

```
## Warning in qbeta(alpha/2, numer + 0.5, denom - numer + 0.5): NaNs produced
```

```
## Warning in qbeta(1 - alpha/2, numer + 0.5, denom - numer + 0.5): NaNs
## produced
```



|outcomeCategory            |disease                                   |timeWindow                  |MPCD TNF         |MPCD DMARD       |MPCD NSAID       |MPCD No exposure |Marketscan TNF   |Marketscan DMARD |Marketscan NSAID |Marketscan No exposure |Medicare TNF     |Medicare DMARD   |Medicare NSAID   |Medicare No exposure |
|:--------------------------|:-----------------------------------------|:---------------------------|:----------------|:----------------|:----------------|:----------------|:----------------|:----------------|:----------------|:----------------------|:----------------|:----------------|:----------------|:--------------------|
|Cancer                     |Hematologic Cancer                        |12 months                   |0.6 (0.2-1.4)    |0.6 (0.1-2.8)    |0.3 (0.0-1.3)    |2.3 (1.3-3.9)    |0.2 (0.1-0.4)    |2.1 (1.2-3.2)    |1.2 (0.8-1.8)    |2.6 (1.9-3.4)          |0.8 (0.5-1.1)    |5.0 (4.1-6.2)    |4.7 (4.1-5.4)    |10.4 (9.3-11.7)      |
|Cancer                     |Hematologic Cancer                        |24 months                   |0.7 (0.3-1.6)    |0.6 (0.1-2.8)    |0.3 (0.0-1.3)    |3.3 (2.0-5.1)    |0.5 (0.3-0.7)    |2.8 (1.8-4.2)    |1.6 (1.1-2.2)    |2.9 (2.2-3.8)          |1.3 (1.0-1.8)    |6.5 (5.4-7.7)    |5.4 (4.8-6.2)    |12.0 (10.7-13.3)     |
|Cancer                     |Hematologic Cancer                        |36 months                   |0.7 (0.3-1.6)    |0.6 (0.1-2.8)    |0.3 (0.0-1.3)    |3.5 (2.2-5.4)    |0.5 (0.3-0.7)    |3.0 (1.9-4.3)    |1.7 (1.1-2.4)    |3.2 (2.5-4.2)          |1.7 (1.3-2.2)    |7.0 (5.8-8.3)    |6.1 (5.4-6.9)    |13.2 (11.9-14.6)     |
|Cancer                     |Hematologic Cancer                        |AS cohort entry to exposure |0.6 (0.2-1.4)    |0.6 (0.1-2.8)    |0.3 (0.0-1.3)    |0.2 (0.0-0.9)    |0.1 (0.1-0.3)    |1.5 (0.8-2.6)    |1.5 (1.0-2.2)    |0.6 (0.3-1.1)          |0.9 (0.6-1.2)    |4.3 (3.4-5.3)    |5.1 (4.5-5.8)    |2.2 (1.7-2.8)        |
|Cancer                     |Non Melanoma Skin Cancer                  |12 months                   |0                |0                |0                |0                |0.9 (0.6-1.2)    |1.3 (0.7-2.3)    |2.5 (1.8-3.3)    |2.5 (1.8-3.3)          |2.2 (1.7-2.7)    |4.0 (3.1-5.0)    |5.8 (5.1-6.5)    |13.5 (12.2-14.9)     |
|Cancer                     |Non Melanoma Skin Cancer                  |24 months                   |0                |0                |0                |0                |1.7 (1.3-2.2)    |2.8 (1.8-4.2)    |3.7 (2.9-4.7)    |4.5 (3.6-5.6)          |3.5 (3.0-4.2)    |7.0 (5.8-8.3)    |9.0 (8.2-9.9)    |20.5 (18.9-22.1)     |
|Cancer                     |Non Melanoma Skin Cancer                  |36 months                   |0                |0                |0                |0                |2.1 (1.6-2.6)    |3.5 (2.4-4.9)    |4.2 (3.3-5.2)    |5.5 (4.5-6.7)          |4.7 (4.0-5.4)    |9.4 (8.1-10.9)   |11.6 (10.7-12.6) |23.7 (22.0-25.4)     |
|Cancer                     |Non Melanoma Skin Cancer                  |AS cohort entry to exposure |0                |0                |0                |0                |0.8 (0.5-1.1)    |0.8 (0.3-1.6)    |2.7 (2.0-3.5)    |0.0 (0.0-0.1)          |2.1 (1.7-2.6)    |3.3 (2.5-4.2)    |5.7 (5.0-6.4)    |0.3 (0.1-0.6)        |
|Cancer                     |Solid Cancer                              |12 months                   |4.9 (3.5-6.8)    |4.2 (1.9-8.1)    |7.9 (5.4-11.0)   |16.0 (13.0-19.4) |3.0 (2.5-3.6)    |10.9 (8.9-13.3)  |10.2 (8.9-11.7)  |14.5 (12.9-16.3)       |10.3 (9.3-11.4)  |23.6 (21.7-25.7) |28.3 (27.0-29.7) |63.4 (61.5-65.3)     |
|Cancer                     |Solid Cancer                              |24 months                   |6.1 (4.5-8.1)    |7.9 (4.5-12.7)   |9.9 (7.1-13.3)   |22.3 (18.8-26.0) |4.2 (3.6-4.9)    |13.3 (11.0-15.8) |12.6 (11.1-14.3) |17.4 (15.6-19.2)       |12.9 (11.8-14.1) |30.5 (28.3-32.7) |34.5 (33.0-35.9) |76.4 (74.7-78.1)     |
|Cancer                     |Solid Cancer                              |36 months                   |6.6 (4.9-8.6)    |7.9 (4.5-12.7)   |10.1 (7.3-13.6)  |24.8 (21.2-28.7) |4.5 (3.9-5.3)    |14.8 (12.4-17.4) |13.3 (11.8-15.0) |19.3 (17.5-21.2)       |14.8 (13.6-16.1) |34.5 (32.3-36.8) |38.5 (37.1-40.0) |82.6 (81.1-84.1)     |
|Cancer                     |Solid Cancer                              |AS cohort entry to exposure |2.8 (1.8-4.3)    |3.6 (1.5-7.3)    |7.9 (5.4-11.0)   |2.7 (1.6-4.4)    |2.3 (1.9-2.9)    |7.6 (5.9-9.6)    |8.8 (7.5-10.2)   |2.8 (2.1-3.7)          |8.9 (8.0-9.9)    |20.1 (18.3-22.1) |29.5 (28.2-30.9) |7.8 (6.8-8.9)        |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |12 months                   |3.3 (2.1-4.8)    |1.8 (0.5-4.8)    |0.6 (0.1-1.8)    |7.6 (5.6-10.2)   |1.4 (1.0-1.8)    |2.3 (1.4-3.6)    |2.1 (1.5-2.8)    |6.2 (5.1-7.4)          |5.3 (4.6-6.1)    |11.4 (9.9-13.0)  |11.8 (10.8-12.8) |32.3 (30.5-34.2)     |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |24 months                   |4.0 (2.7-5.7)    |1.8 (0.5-4.8)    |1.4 (0.5-3.1)    |9.8 (7.4-12.6)   |1.7 (1.3-2.2)    |3.6 (2.5-5.1)    |2.7 (2.0-3.5)    |7.7 (6.5-9.0)          |7.3 (6.5-8.2)    |17.1 (15.3-18.9) |15.5 (14.4-16.6) |41.0 (39.1-43.0)     |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |36 months                   |4.2 (2.9-5.9)    |2.4 (0.8-5.7)    |1.4 (0.5-3.1)    |11.1 (8.6-14.1)  |2.0 (1.6-2.5)    |4.4 (3.1-6.0)    |2.8 (2.1-3.7)    |8.4 (7.2-9.8)          |8.4 (7.5-9.4)    |19.9 (18.1-21.9) |18.2 (17.1-19.4) |45.2 (43.3-47.2)     |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |AS cohort entry to exposure |2.7 (1.7-4.1)    |1.2 (0.3-3.8)    |0.8 (0.2-2.2)    |0.8 (0.3-1.8)    |1.1 (0.8-1.5)    |1.7 (0.9-2.8)    |2.5 (1.9-3.4)    |1.0 (0.6-1.6)          |5.3 (4.5-6.1)    |9.5 (8.2-11.0)   |14.3 (13.2-15.3) |4.3 (3.5-5.1)        |
|Cardiac disease            |Conduction Block                          |12 months                   |0.4 (0.1-1.2)    |0                |2.0 (0.9-3.8)    |3.1 (1.9-4.9)    |1.2 (0.9-1.6)    |3.0 (1.9-4.3)    |2.7 (2.0-3.6)    |6.4 (5.3-7.6)          |4.4 (3.8-5.2)    |9.2 (7.9-10.6)   |10.2 (9.3-11.1)  |31.4 (29.6-33.3)     |
|Cardiac disease            |Conduction Block                          |24 months                   |0.4 (0.1-1.2)    |0                |2.3 (1.1-4.2)    |4.1 (2.6-6.1)    |1.7 (1.3-2.2)    |3.9 (2.7-5.4)    |4.0 (3.1-5.0)    |8.2 (6.9-9.6)          |6.4 (5.6-7.3)    |13.5 (11.9-15.2) |15.2 (14.1-16.3) |41.1 (39.1-43.0)     |
|Cardiac disease            |Conduction Block                          |36 months                   |0.4 (0.1-1.2)    |0                |2.5 (1.3-4.6)    |4.9 (3.3-7.0)    |2.1 (1.6-2.6)    |4.1 (2.9-5.7)    |4.4 (3.5-5.5)    |9.1 (7.8-10.5)         |8.0 (7.1-9.0)    |16.6 (14.9-18.4) |18.5 (17.4-19.7) |47.3 (45.4-49.3)     |
|Cardiac disease            |Conduction Block                          |AS cohort entry to exposure |0.1 (0.0-0.7)    |0                |0.6 (0.1-1.8)    |0.8 (0.3-1.8)    |0.9 (0.6-1.2)    |1.7 (0.9-2.8)    |2.3 (1.6-3.0)    |2.4 (1.7-3.2)          |4.0 (3.4-4.7)    |7.7 (6.5-9.0)    |14.2 (13.1-15.2) |6.0 (5.1-7.0)        |
|Cardiac disease            |Myocardial infarction                     |12 months                   |0.6 (0.2-1.4)    |0                |0.3 (0.0-1.3)    |2.3 (1.3-3.9)    |0.3 (0.2-0.6)    |0.4 (0.1-1.0)    |1.1 (0.7-1.7)    |3.0 (2.3-3.9)          |0.9 (0.6-1.3)    |2.8 (2.1-3.7)    |2.5 (2.1-3.0)    |13.4 (12.1-14.8)     |
|Cardiac disease            |Myocardial infarction                     |24 months                   |1.0 (0.5-2.0)    |0                |0.8 (0.2-2.2)    |4.1 (2.6-6.1)    |0.6 (0.4-0.9)    |0.8 (0.3-1.6)    |1.4 (0.9-2.0)    |3.6 (2.8-4.6)          |1.9 (1.5-2.4)    |5.1 (4.1-6.2)    |4.8 (4.2-5.5)    |18.1 (16.6-19.6)     |
|Cardiac disease            |Myocardial infarction                     |36 months                   |1.0 (0.5-2.0)    |0                |0.8 (0.2-2.2)    |4.3 (2.8-6.3)    |0.6 (0.4-0.9)    |1.0 (0.5-1.9)    |1.8 (1.3-2.6)    |3.9 (3.1-4.9)          |2.7 (2.2-3.3)    |7.4 (6.2-8.7)    |6.2 (5.5-7.0)    |21.3 (19.7-22.9)     |
|Cardiac disease            |Myocardial infarction                     |AS cohort entry to exposure |0.4 (0.1-1.2)    |0                |0.0 (0.0-0.7)    |0.2 (0.0-0.9)    |0.5 (0.3-0.7)    |0.6 (0.2-1.4)    |1.0 (0.6-1.6)    |1.2 (0.8-1.8)          |1.8 (1.4-2.3)    |3.2 (2.4-4.1)    |4.1 (3.5-4.7)    |3.7 (3.0-4.5)        |
|Infection                  |Hospitalized infection                    |12 months                   |1.9 (1.1-3.2)    |3.6 (1.5-7.3)    |2.0 (0.9-3.8)    |27.0 (23.2-30.9) |5.9 (5.2-6.7)    |12.7 (10.5-15.2) |13.7 (12.2-15.4) |30.7 (28.5-32.9)       |16.6 (15.3-17.9) |42.5 (40.1-44.8) |41.3 (39.8-42.8) |130.9 (NaN-NaN)      |
|Infection                  |Hospitalized infection                    |24 months                   |3.3 (2.1-4.8)    |6.7 (3.6-11.2)   |3.7 (2.1-6.0)    |33.8 (29.8-38.0) |8.5 (7.6-9.4)    |18.3 (15.7-21.1) |17.6 (15.9-19.4) |36.7 (34.5-39.0)       |28.3 (26.8-29.9) |62.7 (60.4-65.0) |58.4 (56.9-59.9) |162.0 (NaN-NaN)      |
|Infection                  |Hospitalized infection                    |36 months                   |3.6 (2.4-5.2)    |8.5 (4.9-13.5)   |3.9 (2.3-6.4)    |35.7 (31.7-40.0) |9.6 (8.7-10.6)   |19.4 (16.8-22.3) |19.3 (17.5-21.2) |39.6 (37.3-42.0)       |34.6 (33.0-36.3) |76.5 (74.5-78.5) |69.2 (67.7-70.6) |178.3 (NaN-NaN)      |
|Infection                  |Hospitalized infection                    |AS cohort entry to exposure |2.1 (1.2-3.4)    |4.2 (1.9-8.1)    |3.1 (1.7-5.3)    |12.5 (9.8-15.6)  |5.6 (4.9-6.4)    |11.3 (9.2-13.7)  |14.8 (13.2-16.6) |13.2 (11.6-14.9)       |20.6 (19.2-22.0) |48.9 (46.5-51.3) |59.5 (58.0-61.0) |41.4 (39.5-43.4)     |
|Infection                  |Opportunistic infection                   |12 months                   |2.5 (1.5-3.9)    |3.0 (1.2-6.5)    |1.4 (0.5-3.1)    |3.1 (1.9-4.9)    |2.0 (1.5-2.5)    |4.0 (2.8-5.5)    |2.4 (1.7-3.2)    |3.5 (2.7-4.5)          |4.9 (4.2-5.7)    |8.5 (7.3-9.9)    |6.1 (5.4-6.8)    |13.7 (12.4-15.1)     |
|Infection                  |Opportunistic infection                   |24 months                   |3.3 (2.1-4.8)    |5.5 (2.7-9.7)    |1.7 (0.7-3.5)    |3.7 (2.3-5.6)    |2.6 (2.1-3.2)    |5.8 (4.3-7.6)    |2.9 (2.2-3.8)    |4.8 (3.8-5.9)          |7.3 (6.5-8.3)    |12.6 (11.0-14.2) |9.9 (9.0-10.8)   |19.3 (17.8-20.9)     |
|Infection                  |Opportunistic infection                   |36 months                   |3.4 (2.2-5.0)    |7.9 (4.5-12.7)   |2.0 (0.9-3.8)    |4.5 (2.9-6.5)    |2.9 (2.4-3.5)    |6.3 (4.8-8.2)    |3.3 (2.6-4.3)    |5.6 (4.6-6.8)          |8.8 (7.8-9.8)    |14.9 (13.2-16.6) |12.8 (11.8-13.9) |23.1 (21.5-24.8)     |
|Infection                  |Opportunistic infection                   |AS cohort entry to exposure |1.5 (0.8-2.6)    |1.8 (0.5-4.8)    |2.0 (0.9-3.8)    |0.2 (0.0-0.9)    |1.7 (1.3-2.2)    |2.8 (1.8-4.2)    |2.0 (1.4-2.8)    |0.2 (0.0-0.5)          |5.9 (5.1-6.7)    |9.5 (8.2-10.9)   |9.2 (8.4-10.1)   |1.3 (0.9-1.8)        |
|Inflammatory bowel disease |Crohn’s Disease                           |12 months                   |11.0 (8.8-13.6)  |11.5 (7.3-17.0)  |5.6 (3.6-8.4)    |13.3 (10.6-16.4) |9.3 (8.3-10.3)   |10.2 (8.2-12.4)  |5.1 (4.2-6.3)    |11.5 (10.0-13.1)       |15.2 (14.0-16.5) |20.3 (18.4-22.2) |9.7 (8.9-10.7)   |24.9 (23.2-26.6)     |
|Inflammatory bowel disease |Crohn’s Disease                           |24 months                   |12.2 (9.9-14.9)  |12.7 (8.3-18.4)  |6.5 (4.3-9.4)    |15.0 (12.1-18.3) |10.5 (9.5-11.5)  |11.3 (9.2-13.7)  |5.9 (4.9-7.1)    |13.5 (11.9-15.2)       |16.5 (15.2-17.8) |22.0 (20.1-24.0) |11.3 (10.4-12.3) |27.4 (25.7-29.2)     |
|Inflammatory bowel disease |Crohn’s Disease                           |36 months                   |12.7 (10.3-15.4) |12.7 (8.3-18.4)  |6.8 (4.5-9.7)    |16.2 (13.2-19.6) |10.8 (9.8-11.9)  |11.8 (9.7-14.3)  |6.2 (5.2-7.4)    |14.1 (12.5-15.8)       |17.0 (15.7-18.3) |22.9 (20.9-24.9) |12.0 (11.1-13.0) |28.8 (27.1-30.6)     |
|Inflammatory bowel disease |Crohn’s Disease                           |AS cohort entry to exposure |9.7 (7.6-12.1)   |8.5 (4.9-13.5)   |5.1 (3.1-7.7)    |3.7 (2.3-5.6)    |7.5 (6.6-8.4)    |8.9 (7.0-11.0)   |4.7 (3.8-5.7)    |4.6 (3.7-5.7)          |14.0 (12.9-15.3) |19.0 (17.1-20.9) |11.9 (10.9-12.9) |7.8 (6.8-8.9)        |
|Inflammatory bowel disease |Ulcerative Colitis                        |12 months                   |5.8 (4.2-7.8)    |6.7 (3.6-11.2)   |3.1 (1.7-5.3)    |7.2 (5.2-9.7)    |6.1 (5.3-6.9)    |6.8 (5.2-8.8)    |3.3 (2.5-4.2)    |9.8 (8.4-11.3)         |7.0 (6.2-7.9)    |11.1 (9.6-12.6)  |5.2 (4.5-5.9)    |13.5 (12.2-14.9)     |
|Inflammatory bowel disease |Ulcerative Colitis                        |24 months                   |6.7 (5.0-8.8)    |7.9 (4.5-12.7)   |3.7 (2.1-6.0)    |8.4 (6.2-11.0)   |6.9 (6.1-7.7)    |8.1 (6.3-10.2)   |3.6 (2.8-4.6)    |10.9 (9.5-12.5)        |8.8 (7.9-9.8)    |13.2 (11.6-14.8) |6.7 (6.0-7.5)    |16.6 (15.2-18.1)     |
|Inflammatory bowel disease |Ulcerative Colitis                        |36 months                   |7.0 (5.3-9.1)    |7.9 (4.5-12.7)   |3.7 (2.1-6.0)    |8.6 (6.4-11.3)   |7.4 (6.5-8.3)    |8.6 (6.8-10.8)   |3.9 (3.1-4.9)    |11.4 (10.0-13.0)       |9.6 (8.6-10.7)   |14.2 (12.6-15.9) |7.9 (7.1-8.7)    |18.7 (17.2-20.2)     |
|Inflammatory bowel disease |Ulcerative Colitis                        |AS cohort entry to exposure |4.0 (2.7-5.7)    |4.2 (1.9-8.1)    |4.2 (2.5-6.7)    |1.8 (0.9-3.2)    |4.3 (3.7-5.1)    |3.6 (2.5-5.1)    |2.6 (1.9-3.4)    |2.4 (1.8-3.2)          |7.0 (6.2-7.9)    |11.8 (10.3-13.4) |7.8 (7.0-8.7)    |2.5 (1.9-3.1)        |
|Kidney disease             |Amyloidosis                               |12 months                   |0                |0                |0                |0.2 (0.0-0.9)    |0.1 (0.0-0.2)    |0.0 (0.0-0.3)    |0.1 (0.0-0.3)    |0.1 (0.0-0.4)          |0.2 (0.1-0.4)    |0.1 (0.0-0.4)    |0.2 (0.1-0.3)    |0.5 (0.3-0.8)        |
|Kidney disease             |Amyloidosis                               |24 months                   |0                |0                |0                |0.4 (0.1-1.2)    |0.1 (0.0-0.3)    |0.1 (0.0-0.6)    |0.1 (0.0-0.3)    |0.1 (0.0-0.4)          |0.3 (0.2-0.6)    |0.1 (0.0-0.4)    |0.2 (0.1-0.3)    |0.5 (0.3-0.9)        |
|Kidney disease             |Amyloidosis                               |36 months                   |0                |0                |0                |0.6 (0.2-1.6)    |0.1 (0.0-0.3)    |0.1 (0.0-0.6)    |0.1 (0.0-0.3)    |0.1 (0.0-0.4)          |0.3 (0.2-0.6)    |0.1 (0.0-0.4)    |0.2 (0.1-0.4)    |0.6 (0.4-1.0)        |
|Kidney disease             |Amyloidosis                               |AS cohort entry to exposure |0                |0                |0                |0.0 (0.0-0.5)    |0.0 (0.0-0.1)    |0.0 (0.0-0.3)    |0.0 (0.0-0.1)    |0.0 (0.0-0.1)          |0.2 (0.1-0.4)    |0.1 (0.0-0.4)    |0.2 (0.1-0.4)    |0.0 (0.0-0.2)        |
|Kidney disease             |IgA nephropathy                           |12 months                   |0.6 (0.2-1.4)    |0.6 (0.1-2.8)    |0.3 (0.0-1.3)    |0.0 (0.0-0.5)    |0.2 (0.1-0.4)    |0.1 (0.0-0.6)    |0.1 (0.0-0.3)    |0.5 (0.3-1.0)          |0.2 (0.1-0.4)    |0.6 (0.3-1.0)    |0.4 (0.2-0.6)    |1.4 (1.0-1.9)        |
|Kidney disease             |IgA nephropathy                           |24 months                   |0.6 (0.2-1.4)    |0.6 (0.1-2.8)    |0.8 (0.2-2.2)    |0.2 (0.0-0.9)    |0.3 (0.1-0.5)    |0.1 (0.0-0.6)    |0.1 (0.0-0.3)    |0.6 (0.3-1.0)          |0.5 (0.3-0.7)    |0.9 (0.6-1.5)    |0.5 (0.3-0.7)    |2.0 (1.5-2.7)        |
|Kidney disease             |IgA nephropathy                           |36 months                   |0.6 (0.2-1.4)    |0.6 (0.1-2.8)    |0.8 (0.2-2.2)    |0.6 (0.2-1.6)    |0.3 (0.1-0.5)    |0.1 (0.0-0.6)    |0.1 (0.0-0.4)    |0.6 (0.3-1.0)          |0.7 (0.4-1.0)    |1.2 (0.7-1.8)    |0.7 (0.5-1.0)    |2.5 (1.9-3.2)        |
|Kidney disease             |IgA nephropathy                           |AS cohort entry to exposure |0.1 (0.0-0.7)    |0.6 (0.1-2.8)    |0.3 (0.0-1.3)    |0.0 (0.0-0.5)    |0.1 (0.1-0.3)    |0.1 (0.0-0.6)    |0.1 (0.0-0.3)    |0.1 (0.0-0.4)          |0.5 (0.3-0.8)    |0.7 (0.3-1.1)    |1.0 (0.7-1.4)    |0.2 (0.1-0.4)        |
|Kidney disease             |Nephrotic syndrome                        |12 months                   |0.3 (0.1-1.0)    |0.6 (0.1-2.8)    |0                |0.0 (0.0-0.5)    |0.1 (0.0-0.3)    |0.1 (0.0-0.6)    |0.1 (0.0-0.3)    |0.1 (0.0-0.3)          |0.4 (0.2-0.6)    |0.7 (0.4-1.2)    |0.4 (0.2-0.6)    |1.1 (0.8-1.6)        |
|Kidney disease             |Nephrotic syndrome                        |24 months                   |0.3 (0.1-1.0)    |0.6 (0.1-2.8)    |0                |0.2 (0.0-0.9)    |0.2 (0.1-0.4)    |0.3 (0.1-0.8)    |0.1 (0.0-0.4)    |0.1 (0.0-0.4)          |0.7 (0.4-1.0)    |1.1 (0.7-1.7)    |0.5 (0.3-0.7)    |1.3 (0.9-1.8)        |
|Kidney disease             |Nephrotic syndrome                        |36 months                   |0.3 (0.1-1.0)    |0.6 (0.1-2.8)    |0                |0.2 (0.0-0.9)    |0.2 (0.1-0.4)    |0.4 (0.1-1.0)    |0.2 (0.0-0.5)    |0.1 (0.0-0.4)          |0.8 (0.5-1.1)    |1.2 (0.7-1.8)    |0.5 (0.3-0.7)    |1.5 (1.1-2.0)        |
|Kidney disease             |Nephrotic syndrome                        |AS cohort entry to exposure |0.0 (0.0-0.4)    |0.0 (0.0-1.5)    |0                |0.0 (0.0-0.5)    |0.1 (0.0-0.2)    |0.0 (0.0-0.3)    |0.0 (0.0-0.1)    |0.0 (0.0-0.1)          |0.2 (0.1-0.5)    |0.5 (0.2-0.9)    |0.4 (0.2-0.6)    |0.0 (0.0-0.2)        |
|Lung disease               |Apical Pulmonary fibrosis                 |12 months                   |0                |0                |0                |0.0 (0.0-0.5)    |0.0 (0.0-0.1)    |0                |0                |0.1 (0.0-0.4)          |0                |0.1 (0.0-0.4)    |0.1 (0.0-0.2)    |0.1 (0.0-0.3)        |
|Lung disease               |Apical Pulmonary fibrosis                 |24 months                   |0                |0                |0                |0.2 (0.0-0.9)    |0.0 (0.0-0.1)    |0                |0                |0.1 (0.0-0.4)          |0                |0.1 (0.0-0.4)    |0.1 (0.0-0.2)    |0.1 (0.0-0.3)        |
|Lung disease               |Apical Pulmonary fibrosis                 |36 months                   |0                |0                |0                |0.2 (0.0-0.9)    |0.0 (0.0-0.1)    |0                |0                |0.1 (0.0-0.4)          |0                |0.1 (0.0-0.4)    |0.1 (0.0-0.2)    |0.1 (0.0-0.3)        |
|Lung disease               |Apical Pulmonary fibrosis                 |AS cohort entry to exposure |0                |0                |0                |0.0 (0.0-0.5)    |0.0 (0.0-0.1)    |0                |0                |0.0 (0.0-0.1)          |0                |0.1 (0.0-0.4)    |0.1 (0.0-0.2)    |0.0 (0.0-0.2)        |
|Lung disease               |Interstitial lung disease                 |12 months                   |0                |0                |0                |0.4 (0.1-1.2)    |0.2 (0.1-0.4)    |0.4 (0.1-1.0)    |0.1 (0.0-0.4)    |0.5 (0.3-1.0)          |0.8 (0.5-1.1)    |3.4 (2.6-4.3)    |1.5 (1.2-1.9)    |3.9 (3.2-4.8)        |
|Lung disease               |Interstitial lung disease                 |24 months                   |0                |0                |0                |0.8 (0.3-1.8)    |0.2 (0.1-0.4)    |0.5 (0.2-1.2)    |0.2 (0.0-0.5)    |0.6 (0.3-1.0)          |1.3 (0.9-1.7)    |5.1 (4.1-6.2)    |2.1 (1.7-2.6)    |5.3 (4.4-6.2)        |
|Lung disease               |Interstitial lung disease                 |36 months                   |0                |0                |0                |0.8 (0.3-1.8)    |0.2 (0.1-0.4)    |0.5 (0.2-1.2)    |0.2 (0.0-0.5)    |0.6 (0.3-1.1)          |1.7 (1.3-2.2)    |5.9 (4.9-7.1)    |2.6 (2.1-3.1)    |5.9 (5.0-6.9)        |
|Lung disease               |Interstitial lung disease                 |AS cohort entry to exposure |0                |0                |0                |0.2 (0.0-0.9)    |0.1 (0.0-0.3)    |0.3 (0.1-0.8)    |0.1 (0.0-0.4)    |0.2 (0.1-0.6)          |1.1 (0.8-1.5)    |3.6 (2.7-4.5)    |2.4 (2.0-2.9)    |1.0 (0.7-1.5)        |
|Lung disease               |Restrictive lung disease                  |12 months                   |1.3 (0.7-2.4)    |1.2 (0.3-3.8)    |2.5 (1.3-4.6)    |6.1 (4.2-8.4)    |1.4 (1.1-1.9)    |1.9 (1.1-3.1)    |2.1 (1.5-2.8)    |6.2 (5.1-7.4)          |4.4 (3.8-5.2)    |10.4 (9.0-12.0)  |8.1 (7.3-8.9)    |19.0 (17.5-20.6)     |
|Lung disease               |Restrictive lung disease                  |24 months                   |2.2 (1.3-3.6)    |1.8 (0.5-4.8)    |3.9 (2.3-6.4)    |9.6 (7.2-12.3)   |2.1 (1.6-2.6)    |2.8 (1.8-4.2)    |2.5 (1.9-3.4)    |7.7 (6.5-9.1)          |7.5 (6.7-8.5)    |14.9 (13.3-16.7) |12.7 (11.7-13.7) |26.8 (25.1-28.6)     |
|Lung disease               |Restrictive lung disease                  |36 months                   |2.5 (1.5-3.9)    |2.4 (0.8-5.7)    |4.5 (2.7-7.0)    |10.5 (8.1-13.4)  |2.4 (1.9-2.9)    |4.2 (3.0-5.8)    |2.9 (2.2-3.8)    |8.8 (7.5-10.2)         |9.0 (8.1-10.0)   |18.4 (16.6-20.3) |15.6 (14.5-16.7) |31.8 (30.0-33.7)     |
|Lung disease               |Restrictive lung disease                  |AS cohort entry to exposure |1.5 (0.8-2.6)    |1.2 (0.3-3.8)    |2.8 (1.5-4.9)    |2.0 (1.0-3.4)    |1.0 (0.7-1.4)    |2.3 (1.4-3.6)    |2.2 (1.6-3.0)    |1.7 (1.2-2.4)          |5.6 (4.9-6.5)    |11.5 (10.0-13.1) |12.2 (11.2-13.2) |2.2 (1.7-2.8)        |
|Neurological Disease       |Cauda Equina syndrome                     |12 months                   |0                |0                |0                |0.8 (0.3-1.8)    |0.0 (0.0-0.1)    |0.4 (0.1-1.0)    |0                |0.2 (0.1-0.6)          |0.2 (0.1-0.5)    |0.1 (0.0-0.3)    |0.2 (0.1-0.4)    |1.4 (1.0-1.9)        |
|Neurological Disease       |Cauda Equina syndrome                     |24 months                   |0                |0                |0                |1.0 (0.4-2.1)    |0.0 (0.0-0.1)    |0.4 (0.1-1.0)    |0                |0.3 (0.1-0.6)          |0.4 (0.2-0.7)    |0.1 (0.0-0.3)    |0.4 (0.2-0.6)    |1.7 (1.2-2.3)        |
|Neurological Disease       |Cauda Equina syndrome                     |36 months                   |0                |0                |0                |1.0 (0.4-2.1)    |0.1 (0.0-0.2)    |0.4 (0.1-1.0)    |0                |0.3 (0.1-0.6)          |0.4 (0.2-0.7)    |0.2 (0.1-0.5)    |0.4 (0.2-0.6)    |1.8 (1.3-2.3)        |
|Neurological Disease       |Cauda Equina syndrome                     |AS cohort entry to exposure |0                |0                |0                |0.6 (0.2-1.6)    |0.0 (0.0-0.1)    |0.0 (0.0-0.3)    |0                |0.1 (0.0-0.3)          |0.1 (0.0-0.2)    |0.4 (0.2-0.8)    |0.5 (0.3-0.7)    |0.4 (0.2-0.7)        |
|Neurological Disease       |Spinal Cord compression                   |12 months                   |0.3 (0.1-1.0)    |0                |0.8 (0.2-2.2)    |0.6 (0.2-1.6)    |0.3 (0.1-0.5)    |0.5 (0.2-1.2)    |1.4 (1.0-2.1)    |1.2 (0.7-1.8)          |0.5 (0.3-0.7)    |1.2 (0.8-1.9)    |1.4 (1.1-1.8)    |5.4 (4.6-6.4)        |
|Neurological Disease       |Spinal Cord compression                   |24 months                   |0.3 (0.1-1.0)    |0                |1.1 (0.4-2.7)    |0.8 (0.3-1.8)    |0.4 (0.2-0.7)    |1.2 (0.6-2.1)    |2.0 (1.4-2.8)    |1.5 (1.0-2.2)          |0.7 (0.4-1.0)    |1.9 (1.3-2.6)    |2.0 (1.6-2.4)    |6.3 (5.4-7.3)        |
|Neurological Disease       |Spinal Cord compression                   |36 months                   |0.3 (0.1-1.0)    |0                |1.1 (0.4-2.7)    |1.2 (0.5-2.4)    |0.7 (0.5-1.0)    |1.3 (0.7-2.3)    |2.1 (1.5-2.8)    |1.6 (1.1-2.3)          |0.9 (0.7-1.3)    |2.0 (1.4-2.8)    |2.3 (1.9-2.8)    |6.7 (5.8-7.7)        |
|Neurological Disease       |Spinal Cord compression                   |AS cohort entry to exposure |0.0 (0.0-0.4)    |0                |0.8 (0.2-2.2)    |0.2 (0.0-0.9)    |0.1 (0.0-0.2)    |0.3 (0.1-0.8)    |0.9 (0.6-1.5)    |0.4 (0.1-0.7)          |0.7 (0.5-1.0)    |1.8 (1.2-2.5)    |2.3 (1.9-2.8)    |0.8 (0.5-1.2)        |
|Osteoporotic fracture      |Clinical vertebral fracture               |12 months                   |1.3 (0.7-2.4)    |0.6 (0.1-2.8)    |0                |2.1 (1.1-3.7)    |0.4 (0.2-0.7)    |0.6 (0.2-1.4)    |1.0 (0.6-1.6)    |0.8 (0.5-1.3)          |1.6 (1.2-2.0)    |1.8 (1.3-2.6)    |3.4 (2.9-4.0)    |2.6 (2.0-3.2)        |
|Osteoporotic fracture      |Clinical vertebral fracture               |24 months                   |1.5 (0.8-2.6)    |0.6 (0.1-2.8)    |0                |2.7 (1.6-4.4)    |0.7 (0.4-1.0)    |0.8 (0.3-1.6)    |1.2 (0.8-1.8)    |1.4 (0.9-2.0)          |3.0 (2.5-3.7)    |3.1 (2.3-4.0)    |5.1 (4.5-5.8)    |4.2 (3.5-5.1)        |
|Osteoporotic fracture      |Clinical vertebral fracture               |36 months                   |1.5 (0.8-2.6)    |0.6 (0.1-2.8)    |0                |2.9 (1.7-4.7)    |0.7 (0.5-1.0)    |1.0 (0.5-1.9)    |1.4 (0.9-2.0)    |1.5 (1.0-2.2)          |3.5 (2.9-4.2)    |4.1 (3.3-5.2)    |5.7 (5.1-6.5)    |5.5 (4.7-6.5)        |
|Osteoporotic fracture      |Clinical vertebral fracture               |AS cohort entry to exposure |0.9 (0.4-1.8)    |0.6 (0.1-2.8)    |0                |0.2 (0.0-0.9)    |0.2 (0.1-0.4)    |0.4 (0.1-1.0)    |0.5 (0.3-0.9)    |0.1 (0.0-0.3)          |2.0 (1.5-2.5)    |2.4 (1.8-3.2)    |4.7 (4.1-5.4)    |0.2 (0.1-0.4)        |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |12 months                   |1.6 (0.9-2.8)    |1.2 (0.3-3.8)    |2.5 (1.3-4.6)    |2.7 (1.6-4.4)    |0.8 (0.5-1.1)    |0.8 (0.3-1.6)    |1.4 (0.9-2.0)    |1.0 (0.6-1.6)          |2.2 (1.8-2.8)    |2.9 (2.2-3.8)    |3.5 (3.0-4.1)    |2.7 (2.1-3.3)        |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |24 months                   |2.1 (1.2-3.4)    |2.4 (0.8-5.7)    |2.8 (1.5-4.9)    |4.9 (3.3-7.0)    |1.7 (1.3-2.1)    |1.5 (0.8-2.6)    |1.8 (1.2-2.5)    |1.6 (1.1-2.3)          |4.1 (3.4-4.8)    |5.6 (4.6-6.8)    |5.5 (4.9-6.2)    |4.6 (3.8-5.5)        |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |36 months                   |2.1 (1.2-3.4)    |3.6 (1.5-7.3)    |3.1 (1.7-5.3)    |5.1 (3.4-7.2)    |1.9 (1.5-2.4)    |1.9 (1.1-3.1)    |2.1 (1.5-2.8)    |1.9 (1.4-2.7)          |5.3 (4.5-6.1)    |7.0 (5.9-8.3)    |7.0 (6.2-7.8)    |5.9 (5.0-6.8)        |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |AS cohort entry to exposure |0.9 (0.4-1.8)    |0.6 (0.1-2.8)    |2.0 (0.9-3.8)    |0.4 (0.1-1.2)    |0.6 (0.4-0.9)    |0.9 (0.4-1.8)    |1.5 (1.0-2.2)    |0.0 (0.0-0.1)          |3.5 (2.9-4.1)    |4.7 (3.7-5.8)    |6.8 (6.0-7.5)    |0.1 (0.0-0.3)        |
|PsO/PsA                    |Psoriasis                                 |12 months                   |8.2 (6.3-10.5)   |4.2 (1.9-8.1)    |4.2 (2.5-6.7)    |6.6 (4.7-9.0)    |7.3 (6.5-8.2)    |9.4 (7.5-11.6)   |5.4 (4.4-6.6)    |7.4 (6.2-8.7)          |12.7 (11.6-13.9) |14.9 (13.2-16.6) |9.1 (8.3-10.0)   |17.7 (16.3-19.3)     |
|PsO/PsA                    |Psoriasis                                 |24 months                   |10.0 (7.9-12.4)  |6.7 (3.6-11.2)   |4.8 (2.9-7.4)    |9.6 (7.2-12.3)   |9.3 (8.4-10.3)   |11.2 (9.1-13.6)  |6.9 (5.7-8.1)    |9.0 (7.7-10.4)         |15.9 (14.7-17.2) |19.6 (17.8-21.6) |12.2 (11.2-13.2) |23.0 (21.4-24.7)     |
|PsO/PsA                    |Psoriasis                                 |36 months                   |10.7 (8.6-13.3)  |8.5 (4.9-13.5)   |5.4 (3.4-8.1)    |10.2 (7.8-13.0)  |10.5 (9.5-11.5)  |12.9 (10.7-15.4) |8.0 (6.8-9.3)    |10.2 (8.8-11.7)        |17.4 (16.1-18.7) |22.9 (20.9-24.9) |14.0 (12.9-15.0) |25.2 (23.6-27.0)     |
|PsO/PsA                    |Psoriasis                                 |AS cohort entry to exposure |5.5 (4.0-7.4)    |3.6 (1.5-7.3)    |5.1 (3.1-7.7)    |1.6 (0.7-2.9)    |5.2 (4.5-6.0)    |6.3 (4.8-8.2)    |4.7 (3.8-5.7)    |1.6 (1.1-2.3)          |12.0 (10.9-13.1) |14.9 (13.2-16.6) |12.4 (11.4-13.4) |2.7 (2.1-3.4)        |
|PsO/PsA                    |Psoriatic arthritis                       |12 months                   |12.4 (10.1-15.0) |15.8 (10.8-21.9) |4.5 (2.7-7.0)    |9.2 (6.9-11.9)   |11.8 (10.8-13.0) |16.9 (14.4-19.6) |6.4 (5.3-7.6)    |8.7 (7.4-10.1)         |19.1 (17.8-20.5) |25.0 (23.0-27.1) |8.3 (7.5-9.2)    |18.9 (17.4-20.5)     |
|PsO/PsA                    |Psoriatic arthritis                       |24 months                   |14.6 (12.1-17.5) |18.2 (12.9-24.6) |5.6 (3.6-8.4)    |10.9 (8.5-13.9)  |13.8 (12.7-15.0) |19.7 (17.0-22.6) |7.7 (6.5-9.0)    |10.5 (9.1-12.1)        |21.6 (20.2-23.0) |28.3 (26.1-30.4) |10.0 (9.1-10.9)  |21.7 (20.1-23.3)     |
|PsO/PsA                    |Psoriatic arthritis                       |36 months                   |15.4 (12.8-18.3) |18.8 (13.4-25.3) |6.2 (4.0-9.1)    |12.5 (9.8-15.6)  |14.4 (13.2-15.6) |20.2 (17.5-23.1) |8.3 (7.0-9.6)    |11.6 (10.1-13.2)       |23.1 (21.7-24.6) |30.5 (28.3-32.7) |10.9 (9.9-11.8)  |23.3 (21.6-25.0)     |
|PsO/PsA                    |Psoriatic arthritis                       |AS cohort entry to exposure |10.4 (8.3-12.9)  |12.7 (8.3-18.4)  |3.9 (2.3-6.4)    |2.9 (1.7-4.7)    |9.7 (8.7-10.7)   |11.2 (9.1-13.6)  |6.0 (5.0-7.2)    |2.5 (1.9-3.4)          |18.9 (17.6-20.3) |23.3 (21.4-25.4) |12.8 (11.8-13.8) |4.5 (3.7-5.3)        |
|Uveitis                    |Uveitis                                   |12 months                   |16.1 (13.5-19.0) |21.2 (15.5-27.9) |18.3 (14.6-22.6) |18.9 (15.7-22.5) |13.0 (11.9-14.1) |17.9 (15.3-20.7) |19.0 (17.2-20.9) |26.2 (24.1-28.3)       |12.5 (11.4-13.7) |15.3 (13.7-17.1) |11.6 (10.7-12.6) |17.4 (15.9-18.9)     |
|Uveitis                    |Uveitis                                   |24 months                   |18.1 (15.3-21.1) |24.2 (18.2-31.2) |20.3 (16.4-24.7) |23.0 (19.6-26.8) |15.0 (13.8-16.2) |21.4 (18.6-24.3) |22.3 (20.4-24.3) |30.3 (28.1-32.5)       |15.6 (14.4-16.9) |18.9 (17.1-20.8) |15.9 (14.8-17.1) |22.1 (20.5-23.8)     |
|Uveitis                    |Uveitis                                   |36 months                   |18.8 (16.0-21.9) |25.5 (19.3-32.5) |20.6 (16.6-25.0) |25.2 (21.6-29.1) |16.0 (14.8-17.3) |22.5 (19.7-25.6) |23.7 (21.7-25.7) |31.8 (29.7-34.1)       |17.9 (16.6-19.2) |21.4 (19.5-23.4) |18.3 (17.2-19.5) |24.9 (23.2-26.6)     |
|Uveitis                    |Uveitis                                   |AS cohort entry to exposure |13.4 (11.0-16.2) |17.0 (11.8-23.2) |16.1 (12.5-20.1) |4.9 (3.3-7.0)    |10.9 (9.9-11.9)  |13.3 (11.0-15.8) |15.5 (13.9-17.3) |5.6 (4.6-6.8)          |13.7 (12.5-14.9) |17.3 (15.6-19.2) |16.9 (15.8-18.1) |2.3 (1.8-2.9)        |
# Summarize prevalence, non-AS cohort

See `background/table shells.docx`, page 5, 
*Table XX: Prevalence of comorbidities by disease cohort and data source using all available prior data*,
right-hand columns for *Non-AS cohort*

Read prevalence data.
See `queryPrevalentComorbiditiesControl.sas`.


|   |database |cohort | denomPatid| denomControlCohort|
|:--|:--------|:------|----------:|------------------:|
|1  |MPCD     |Non-AS |    1139225|            1139225|
|93 |Medicare |Non-AS |    1854650|            1854650|

Table of **prevalence %**


|outcomeCategory            |disease                                   |timeWindow |MPCD Non-AS cohort |Medicare Non-AS cohort |
|:--------------------------|:-----------------------------------------|:----------|:------------------|:----------------------|
|Cancer                     |Hematologic Cancer                        |12 months  |0.6 (0.6-0.6)      |1.2 (1.2-1.2)          |
|Cancer                     |Non Melanoma Skin Cancer                  |12 months  |0.0 (0.0-0.0)      |0.7 (0.7-0.7)          |
|Cancer                     |Solid Cancer                              |12 months  |3.9 (3.8-3.9)      |8.8 (8.7-8.8)          |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |12 months  |0.9 (0.9-0.9)      |2.7 (2.6-2.7)          |
|Cardiac disease            |Conduction Block                          |12 months  |0.7 (0.7-0.7)      |2.2 (2.2-2.3)          |
|Cardiac disease            |Myocardial infarction                     |12 months  |0.2 (0.2-0.2)      |1.0 (1.0-1.0)          |
|Infection                  |Hospitalized infection                    |12 months  |2.2 (2.2-2.3)      |8.8 (8.8-8.9)          |
|Infection                  |Opportunistic infection                   |12 months  |0.4 (0.4-0.4)      |0.9 (0.8-0.9)          |
|Inflammatory bowel disease |Crohn’s Disease                           |12 months  |2.2 (2.1-2.2)      |0.3 (0.3-0.3)          |
|Inflammatory bowel disease |Ulcerative Colitis                        |12 months  |2.0 (2.0-2.0)      |0.4 (0.4-0.4)          |
|Kidney disease             |Amyloidosis                               |12 months  |0.0 (0.0-0.0)      |0.0 (0.0-0.0)          |
|Kidney disease             |IgA nephropathy                           |12 months  |0.1 (0.1-0.1)      |0.1 (0.1-0.1)          |
|Kidney disease             |Nephrotic syndrome                        |12 months  |0.0 (0.0-0.0)      |0.1 (0.1-0.1)          |
|Lung disease               |Apical Pulmonary fibrosis                 |12 months  |0.0 (0.0-0.0)      |0.0 (0.0-0.0)          |
|Lung disease               |Interstitial lung disease                 |12 months  |0.1 (0.1-0.1)      |0.0 (0.0-0.0)          |
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



|type                  |outcomeCategory            |disease                                   |
|:---------------------|:--------------------------|:-----------------------------------------|
|Comorbidity           |Cancer                     |Hematologic Cancer                        |
|Comorbidity           |Cancer                     |Non Melanoma Skin Cancer                  |
|Comorbidity           |Cancer                     |Solid Cancer                              |
|Comorbidity           |Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |
|Comorbidity           |Cardiac disease            |Conduction Block                          |
|Comorbidity           |Cardiac disease            |Myocardial infarction                     |
|Comorbidity           |Infection                  |Hospitalized infection                    |
|Comorbidity           |Infection                  |Opportunistic infection                   |
|Disease manifestation |Inflammatory bowel disease |Crohn’s Disease                           |
|Disease manifestation |Inflammatory bowel disease |Ulcerative Colitis                        |
|Comorbidity           |Kidney disease             |Amyloidosis                               |
|Comorbidity           |Kidney disease             |IgA nephropathy                           |
|Comorbidity           |Kidney disease             |Nephrotic syndrome                        |
|Comorbidity           |Lung disease               |Apical Pulmonary fibrosis                 |
|Comorbidity           |Lung disease               |Interstitial lung disease                 |
|Comorbidity           |Lung disease               |Restrictive lung disease                  |
|Comorbidity           |Neurological Disease       |Cauda Equina syndrome                     |
|Comorbidity           |Neurological Disease       |Spinal Cord compression                   |
|Comorbidity           |Osteoporotic fracture      |Clinical vertebral fracture               |
|Comorbidity           |Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |
|Disease manifestation |PsO/PsA                    |Psoriasis                                 |
|Disease manifestation |PsO/PsA                    |Psoriatic arthritis                       |
|Disease manifestation |Uveitis                    |Uveitis                                   |

Table of **incidence per 100 person-years**


|type                  |outcomeCategory            |disease                                   |MPCD TNF         |MPCD DMARD       |MPCD NSAID       |MPCD No exposure   |Marketscan TNF   |Marketscan DMARD |Marketscan NSAID |Marketscan No exposure |Medicare TNF        |Medicare DMARD      |Medicare NSAID      |Medicare No exposure |
|:---------------------|:--------------------------|:-----------------------------------------|:----------------|:----------------|:----------------|:------------------|:----------------|:----------------|:----------------|:----------------------|:-------------------|:-------------------|:-------------------|:--------------------|
|Comorbidity           |Cancer                     |Hematologic Cancer                        |0.20 (0.04-0.58) |0.23 (0.01-1.31) |0.00 (0.00-0.47) |0.81 (0.45-1.33)   |0.16 (0.08-0.29) |0.77 (0.42-1.30) |0.30 (0.16-0.52) |0.84 (0.60-1.14)       |0.40 (0.30-0.52)    |0.82 (0.65-1.03)    |0.60 (0.50-0.72)    |1.47 (1.30-1.65)     |
|Comorbidity           |Cancer                     |Non Melanoma Skin Cancer                  |1.28 (0.77-2.00) |0.71 (0.15-2.07) |0.52 (0.14-1.32) |1.19 (0.75-1.81)   |0.87 (0.66-1.13) |1.16 (0.72-1.78) |1.01 (0.73-1.36) |1.00 (0.74-1.33)       |1.86 (1.64-2.11)    |2.22 (1.92-2.55)    |2.61 (2.39-2.85)    |3.19 (2.94-3.46)     |
|Comorbidity           |Cancer                     |Solid Cancer                              |2.12 (1.44-3.00) |1.67 (0.67-3.44) |2.25 (1.31-3.61) |5.42 (4.38-6.63)   |1.63 (1.34-1.97) |3.56 (2.73-4.57) |2.66 (2.19-3.21) |4.95 (4.33-5.63)       |2.92 (2.63-3.23)    |4.29 (3.86-4.76)    |4.40 (4.10-4.73)    |9.38 (8.92-9.85)     |
|Comorbidity           |Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |1.08 (0.62-1.75) |0.00 (0.00-0.86) |0.52 (0.14-1.33) |2.21 (1.58-3.01)   |0.68 (0.49-0.91) |0.99 (0.59-1.57) |0.71 (0.48-1.01) |1.74 (1.39-2.16)       |1.68 (1.47-1.92)    |2.48 (2.16-2.84)    |2.15 (1.94-2.37)    |4.69 (4.38-5.02)     |
|Comorbidity           |Cardiac disease            |Conduction Block                          |0.27 (0.07-0.68) |0.00 (0.00-0.86) |0.52 (0.14-1.33) |1.03 (0.62-1.60)   |0.65 (0.47-0.87) |0.72 (0.38-1.23) |1.06 (0.77-1.42) |2.09 (1.70-2.54)       |1.76 (1.54-2.01)    |2.26 (1.96-2.60)    |2.48 (2.26-2.72)    |4.79 (4.47-5.12)     |
|Comorbidity           |Cardiac disease            |Myocardial infarction                     |0.33 (0.11-0.78) |0.00 (0.00-0.86) |0.39 (0.08-1.13) |0.70 (0.37-1.19)   |0.21 (0.11-0.35) |0.27 (0.09-0.64) |0.30 (0.16-0.52) |0.92 (0.67-1.23)       |0.69 (0.55-0.84)    |1.18 (0.96-1.42)    |1.02 (0.89-1.17)    |2.07 (1.87-2.29)     |
|Comorbidity           |Infection                  |Hospitalized infection                    |3.35 (2.48-4.43) |2.62 (1.31-4.68) |2.10 (1.20-3.41) |10.46 (8.96-12.13) |5.82 (5.24-6.45) |7.26 (6.04-8.64) |6.11 (5.38-6.91) |11.84 (10.85-12.90)    |11.24 (10.63-11.87) |15.30 (14.43-16.21) |14.59 (14.01-15.18) |24.18 (23.39-24.98)  |
|Comorbidity           |Infection                  |Opportunistic infection                   |0.60 (0.27-1.14) |0.47 (0.06-1.70) |0.26 (0.03-0.93) |0.32 (0.12-0.70)   |0.61 (0.44-0.83) |0.94 (0.55-1.51) |0.40 (0.23-0.64) |0.63 (0.43-0.90)       |1.19 (1.02-1.40)    |1.46 (1.22-1.73)    |1.43 (1.27-1.61)    |1.66 (1.48-1.86)     |
|Comorbidity           |Kidney disease             |Amyloidosis                               |0.00 (0.00-0.25) |0.00 (0.00-0.86) |0.00 (0.00-0.47) |0.16 (0.03-0.47)   |0.03 (0.00-0.11) |0.00 (0.00-0.20) |0.00 (0.00-0.09) |0.00 (0.00-0.07)       |0.05 (0.02-0.11)    |0.01 (0.00-0.06)    |0.03 (0.01-0.06)    |0.06 (0.03-0.10)     |
|Comorbidity           |Kidney disease             |IgA nephropathy                           |0.20 (0.04-0.58) |0.00 (0.00-0.86) |0.13 (0.00-0.72) |0.05 (0.00-0.30)   |0.10 (0.04-0.21) |0.00 (0.00-0.20) |0.02 (0.00-0.13) |0.12 (0.04-0.27)       |0.16 (0.10-0.24)    |0.11 (0.05-0.20)    |0.09 (0.05-0.14)    |0.21 (0.15-0.29)     |
|Comorbidity           |Kidney disease             |Nephrotic syndrome                        |0.13 (0.02-0.48) |0.00 (0.00-0.86) |0.00 (0.00-0.47) |0.00 (0.00-0.20)   |0.03 (0.00-0.11) |0.11 (0.01-0.40) |0.05 (0.01-0.17) |0.04 (0.00-0.15)       |0.13 (0.08-0.21)    |0.12 (0.06-0.22)    |0.05 (0.02-0.09)    |0.11 (0.07-0.17)     |
|Comorbidity           |Lung disease               |Apical Pulmonary fibrosis                 |0.00 (0.00-0.25) |0.00 (0.00-0.86) |0.00 (0.00-0.47) |0.05 (0.00-0.30)   |0.00 (0.00-0.05) |0.00 (0.00-0.20) |0.00 (0.00-0.09) |0.02 (0.00-0.11)       |0.00 (0.00-0.03)    |0.00 (0.00-0.04)    |0.02 (0.00-0.04)    |0.01 (0.00-0.04)     |
|Comorbidity           |Lung disease               |Interstitial lung disease                 |0.00 (0.00-0.25) |0.00 (0.00-0.86) |0.00 (0.00-0.47) |0.16 (0.03-0.47)   |0.07 (0.02-0.17) |0.05 (0.00-0.31) |0.00 (0.00-0.09) |0.12 (0.04-0.27)       |0.36 (0.26-0.47)    |0.70 (0.53-0.89)    |0.26 (0.20-0.35)    |0.60 (0.49-0.72)     |
|Comorbidity           |Lung disease               |Restrictive lung disease                  |0.74 (0.37-1.33) |0.00 (0.00-0.87) |1.04 (0.45-2.05) |2.19 (1.56-2.98)   |0.71 (0.52-0.94) |0.78 (0.43-1.31) |0.56 (0.36-0.84) |1.92 (1.55-2.35)       |1.90 (1.67-2.15)    |2.34 (2.03-2.68)    |1.77 (1.59-1.97)    |3.06 (2.81-3.33)     |
|Comorbidity           |Neurological Disease       |Cauda Equina syndrome                     |0.00 (0.00-0.25) |0.00 (0.00-0.86) |0.00 (0.00-0.47) |0.21 (0.06-0.55)   |0.03 (0.00-0.11) |0.05 (0.00-0.31) |0.00 (0.00-0.09) |0.02 (0.00-0.11)       |0.08 (0.04-0.15)    |0.01 (0.00-0.06)    |0.04 (0.02-0.08)    |0.14 (0.09-0.21)     |
|Comorbidity           |Neurological Disease       |Spinal Cord compression                   |0.07 (0.00-0.37) |0.00 (0.00-0.86) |0.26 (0.03-0.93) |0.21 (0.06-0.55)   |0.18 (0.09-0.31) |0.22 (0.06-0.56) |0.33 (0.18-0.55) |0.28 (0.16-0.48)       |0.20 (0.13-0.29)    |0.26 (0.17-0.39)    |0.30 (0.23-0.39)    |0.51 (0.41-0.62)     |
|Comorbidity           |Osteoporotic fracture      |Clinical vertebral fracture               |0.74 (0.37-1.32) |0.24 (0.01-1.31) |0.39 (0.08-1.13) |2.31 (1.67-3.12)   |0.43 (0.29-0.62) |0.66 (0.34-1.15) |0.85 (0.60-1.18) |3.67 (3.15-4.26)       |1.63 (1.42-1.87)    |2.19 (1.89-2.52)    |2.29 (2.07-2.51)    |5.75 (5.40-6.11)     |
|Comorbidity           |Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |1.28 (0.77-2.00) |0.94 (0.26-2.41) |2.11 (1.20-3.42) |3.79 (2.94-4.81)   |1.21 (0.96-1.51) |1.16 (0.72-1.78) |1.37 (1.04-1.77) |2.14 (1.74-2.59)       |2.49 (2.23-2.78)    |3.12 (2.75-3.51)    |3.10 (2.85-3.37)    |4.04 (3.75-4.34)     |
|Disease manifestation |Inflammatory bowel disease |Crohn’s Disease                           |3.79 (2.85-4.94) |1.93 (0.83-3.81) |1.71 (0.91-2.92) |3.43 (2.63-4.39)   |3.61 (3.15-4.10) |2.35 (1.69-3.19) |0.88 (0.62-1.21) |3.44 (2.94-4.01)       |2.48 (2.21-2.77)    |1.89 (1.61-2.20)    |0.98 (0.85-1.13)    |3.18 (2.93-3.45)     |
|Disease manifestation |Inflammatory bowel disease |Ulcerative Colitis                        |2.19 (1.50-3.10) |0.95 (0.26-2.43) |0.65 (0.21-1.53) |1.97 (1.38-2.73)   |2.18 (1.84-2.57) |2.31 (1.66-3.14) |0.61 (0.40-0.90) |2.59 (2.16-3.09)       |1.60 (1.39-1.83)    |1.36 (1.12-1.62)    |0.82 (0.70-0.96)    |1.78 (1.59-1.98)     |
|Disease manifestation |PsO/PsA                    |Psoriasis                                 |3.17 (2.32-4.22) |0.96 (0.26-2.45) |1.31 (0.63-2.41) |1.69 (1.15-2.40)   |3.09 (2.67-3.55) |2.69 (1.99-3.57) |1.32 (1.00-1.72) |1.94 (1.57-2.37)       |3.05 (2.75-3.37)    |2.46 (2.14-2.82)    |1.40 (1.23-1.57)    |2.27 (2.06-2.50)     |
|Disease manifestation |PsO/PsA                    |Psoriatic arthritis                       |4.52 (3.48-5.77) |3.68 (2.06-6.06) |0.78 (0.29-1.70) |2.24 (1.61-3.03)   |4.40 (3.90-4.96) |5.39 (4.35-6.60) |1.32 (1.00-1.72) |2.29 (1.88-2.76)       |3.81 (3.47-4.17)    |3.13 (2.77-3.54)    |0.98 (0.84-1.13)    |2.09 (1.89-2.31)     |
|Disease manifestation |Uveitis                    |Uveitis                                   |4.16 (3.16-5.38) |5.82 (3.69-8.73) |4.60 (3.19-6.43) |4.98 (3.99-6.14)   |4.66 (4.14-5.23) |5.14 (4.12-6.33) |4.65 (4.01-5.36) |6.68 (5.96-7.46)       |3.10 (2.80-3.43)    |1.99 (1.71-2.32)    |1.87 (1.68-2.08)    |2.15 (1.94-2.37)     |


## TNF vs NSAID


```
## Saving 7 x 7 in image
## Saving 7 x 7 in image
## Saving 7 x 7 in image
```

```
## Warning: Transformation introduced infinite values in continuous y-axis

## Warning: Transformation introduced infinite values in continuous y-axis

## Warning: Transformation introduced infinite values in continuous y-axis
```

```
## Saving 7 x 7 in image
```

```
## Warning: Transformation introduced infinite values in continuous y-axis

## Warning: Transformation introduced infinite values in continuous y-axis

## Warning: Transformation introduced infinite values in continuous y-axis
```

```
## Saving 7 x 7 in image
```

```
## Warning: Transformation introduced infinite values in continuous y-axis

## Warning: Transformation introduced infinite values in continuous y-axis

## Warning: Transformation introduced infinite values in continuous y-axis
```

```
## Warning: Removed 1 rows containing missing values (geom_errorbar).
```

```
## Saving 7 x 7 in image
```

```
## Warning: Transformation introduced infinite values in continuous y-axis
```

```
## Warning: Transformation introduced infinite values in continuous y-axis

## Warning: Transformation introduced infinite values in continuous y-axis
```

```
## Warning: Removed 1 rows containing missing values (geom_errorbar).
```


## **TNF** versus **No exposure**

**MPCD**



**Marketscan**



**Medicare**



## **TNF** versus **NSAID**

**MPCD**



**Marketscan**



**Medicare**



## **TNF** versus **DMARD**

**MPCD**



**Marketscan**



**Medicare**


