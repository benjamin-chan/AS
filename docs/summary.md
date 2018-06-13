---
title: "Comorbidities and Disease Manifestations in Ankylosing Spondylitis (BAD AS)"
date: "2018-06-13 10:32:04"
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
|85  |Marketscan |       5205|
|173 |Medicare   |       2666|

Table of **prevalence %**


|outcomeCategory            |disease                                   |timeWindow                  |MPCD AS cohort  |Marketscan AS cohort |Medicare AS cohort |
|:--------------------------|:-----------------------------------------|:---------------------------|:---------------|:--------------------|:------------------|
|Cancer                     |Hematologic Cancer                        |12 months                   |0.2 (0.1-0.7)   |0.3 (0.2-0.5)        |1.4 (1.0-1.8)      |
|Cancer                     |Hematologic Cancer                        |24 months                   |0.5 (0.2-1.0)   |0.5 (0.3-0.7)        |2.0 (1.5-2.6)      |
|Cancer                     |Hematologic Cancer                        |36 months                   |0.7 (0.3-1.2)   |0.5 (0.4-0.8)        |2.3 (1.8-3.0)      |
|Cancer                     |Hematologic Cancer                        |AS cohort entry to exposure |0.7 (0.3-1.2)   |0.2 (0.1-0.4)        |1.4 (1.0-1.9)      |
|Cancer                     |Non Melanoma Skin Cancer                  |12 months                   |0               |0.6 (0.4-0.8)        |1.8 (1.4-2.4)      |
|Cancer                     |Non Melanoma Skin Cancer                  |24 months                   |0               |1.1 (0.9-1.4)        |2.8 (2.2-3.5)      |
|Cancer                     |Non Melanoma Skin Cancer                  |36 months                   |0               |1.5 (1.2-1.8)        |4.0 (3.3-4.8)      |
|Cancer                     |Non Melanoma Skin Cancer                  |AS cohort entry to exposure |0               |0.7 (0.5-0.9)        |1.5 (1.1-2.0)      |
|Cancer                     |Solid Cancer                              |12 months                   |3.0 (2.2-4.1)   |2.6 (2.2-3.1)        |13.5 (12.2-14.8)   |
|Cancer                     |Solid Cancer                              |24 months                   |4.7 (3.6-6.0)   |3.5 (3.0-4.0)        |16.3 (14.9-17.7)   |
|Cancer                     |Solid Cancer                              |36 months                   |5.6 (4.4-7.0)   |3.9 (3.4-4.5)        |18.8 (17.4-20.3)   |
|Cancer                     |Solid Cancer                              |AS cohort entry to exposure |2.6 (1.8-3.6)   |2.7 (2.3-3.2)        |13.7 (12.4-15.0)   |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |12 months                   |1.8 (1.2-2.7)   |1.1 (0.8-1.4)        |6.0 (5.1-7.0)      |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |24 months                   |2.1 (1.4-3.1)   |1.3 (1.0-1.7)        |8.3 (7.3-9.3)      |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |36 months                   |2.5 (1.8-3.5)   |1.5 (1.2-1.8)        |10.1 (9.0-11.3)    |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |AS cohort entry to exposure |1.4 (0.8-2.2)   |1.0 (0.8-1.3)        |6.2 (5.4-7.2)      |
|Cardiac disease            |Conduction Block                          |12 months                   |0.4 (0.2-0.9)   |0.8 (0.6-1.1)        |4.2 (3.5-5.0)      |
|Cardiac disease            |Conduction Block                          |24 months                   |0.7 (0.4-1.3)   |1.3 (1.0-1.6)        |6.9 (6.0-7.9)      |
|Cardiac disease            |Conduction Block                          |36 months                   |0.7 (0.4-1.3)   |1.6 (1.2-1.9)        |8.7 (7.6-9.8)      |
|Cardiac disease            |Conduction Block                          |AS cohort entry to exposure |0.4 (0.2-0.9)   |0.7 (0.5-1.0)        |5.2 (4.4-6.1)      |
|Cardiac disease            |Myocardial infarction                     |12 months                   |0.1 (0.0-0.4)   |0.2 (0.1-0.3)        |1.1 (0.7-1.5)      |
|Cardiac disease            |Myocardial infarction                     |24 months                   |0.3 (0.1-0.8)   |0.3 (0.2-0.5)        |2.0 (1.5-2.5)      |
|Cardiac disease            |Myocardial infarction                     |36 months                   |0.3 (0.1-0.8)   |0.5 (0.3-0.7)        |2.6 (2.1-3.3)      |
|Cardiac disease            |Myocardial infarction                     |AS cohort entry to exposure |0.2 (0.0-0.5)   |0.2 (0.1-0.4)        |1.3 (0.9-1.8)      |
|Infection                  |Hospitalized infection                    |12 months                   |0.7 (0.3-1.2)   |2.6 (2.2-3.1)        |7.9 (6.9-9.0)      |
|Infection                  |Hospitalized infection                    |24 months                   |1.6 (1.0-2.5)   |4.6 (4.0-5.2)        |14.9 (13.6-16.3)   |
|Infection                  |Hospitalized infection                    |36 months                   |2.2 (1.5-3.1)   |5.4 (4.8-6.1)        |20.3 (18.8-21.9)   |
|Infection                  |Hospitalized infection                    |AS cohort entry to exposure |1.4 (0.8-2.2)   |3.2 (2.8-3.7)        |10.2 (9.1-11.4)    |
|Infection                  |Opportunistic infection                   |12 months                   |0.9 (0.5-1.6)   |1.0 (0.7-1.3)        |2.1 (1.6-2.7)      |
|Infection                  |Opportunistic infection                   |24 months                   |1.3 (0.8-2.1)   |1.3 (1.1-1.7)        |3.4 (2.7-4.1)      |
|Infection                  |Opportunistic infection                   |36 months                   |1.6 (1.0-2.5)   |1.7 (1.3-2.0)        |4.3 (3.6-5.1)      |
|Infection                  |Opportunistic infection                   |AS cohort entry to exposure |0.7 (0.4-1.3)   |0.8 (0.6-1.0)        |2.5 (2.0-3.2)      |
|Inflammatory bowel disease |Crohn’s Disease                           |12 months                   |3.2 (2.3-4.3)   |3.5 (3.0-4.0)        |3.3 (2.6-4.0)      |
|Inflammatory bowel disease |Crohn’s Disease                           |24 months                   |4.7 (3.6-6.0)   |4.4 (3.9-5.0)        |4.1 (3.4-4.8)      |
|Inflammatory bowel disease |Crohn’s Disease                           |36 months                   |5.3 (4.2-6.7)   |4.7 (4.2-5.3)        |4.5 (3.8-5.3)      |
|Inflammatory bowel disease |Crohn’s Disease                           |AS cohort entry to exposure |2.8 (2.0-3.8)   |3.2 (2.7-3.7)        |3.6 (3.0-4.4)      |
|Inflammatory bowel disease |Ulcerative Colitis                        |12 months                   |2.6 (1.8-3.6)   |2.3 (1.9-2.7)        |2.2 (1.7-2.8)      |
|Inflammatory bowel disease |Ulcerative Colitis                        |24 months                   |3.0 (2.2-4.1)   |3.0 (2.5-3.5)        |3.2 (2.6-3.9)      |
|Inflammatory bowel disease |Ulcerative Colitis                        |36 months                   |3.3 (2.4-4.4)   |3.1 (2.7-3.6)        |3.8 (3.1-4.6)      |
|Inflammatory bowel disease |Ulcerative Colitis                        |AS cohort entry to exposure |2.5 (1.7-3.4)   |2.2 (1.8-2.6)        |2.9 (2.3-3.6)      |
|Kidney disease             |Amyloidosis                               |12 months                   |0.1 (0.0-0.4)   |0.0 (0.0-0.1)        |0.1 (0.0-0.2)      |
|Kidney disease             |Amyloidosis                               |24 months                   |0.2 (0.0-0.5)   |0.1 (0.0-0.2)        |0.2 (0.1-0.4)      |
|Kidney disease             |Amyloidosis                               |36 months                   |0.2 (0.1-0.7)   |0.1 (0.0-0.2)        |0.2 (0.1-0.5)      |
|Kidney disease             |Amyloidosis                               |AS cohort entry to exposure |0.1 (0.0-0.4)   |0.0 (0.0-0.1)        |0.1 (0.0-0.2)      |
|Kidney disease             |IgA nephropathy                           |12 months                   |0.3 (0.1-0.8)   |0.2 (0.1-0.3)        |0.0 (0.0-0.1)      |
|Kidney disease             |IgA nephropathy                           |24 months                   |0.3 (0.1-0.8)   |0.2 (0.1-0.3)        |0.1 (0.0-0.2)      |
|Kidney disease             |IgA nephropathy                           |36 months                   |0.5 (0.2-1.0)   |0.2 (0.1-0.4)        |0.2 (0.1-0.5)      |
|Kidney disease             |IgA nephropathy                           |AS cohort entry to exposure |0.2 (0.0-0.5)   |0.1 (0.1-0.3)        |0.2 (0.1-0.4)      |
|Kidney disease             |Nephrotic syndrome                        |12 months                   |0.1 (0.0-0.4)   |0.0 (0.0-0.1)        |0.3 (0.1-0.5)      |
|Kidney disease             |Nephrotic syndrome                        |24 months                   |0.2 (0.0-0.5)   |0.1 (0.0-0.2)        |0.3 (0.1-0.6)      |
|Kidney disease             |Nephrotic syndrome                        |36 months                   |0.2 (0.0-0.5)   |0.1 (0.0-0.2)        |0.3 (0.1-0.6)      |
|Kidney disease             |Nephrotic syndrome                        |AS cohort entry to exposure |0.0 (0.0-0.2)   |0.1 (0.0-0.2)        |0.2 (0.1-0.4)      |
|Lung disease               |Apical Pulmonary fibrosis                 |12 months                   |0.0 (0.0-0.2)   |0                    |0                  |
|Lung disease               |Apical Pulmonary fibrosis                 |24 months                   |0.1 (0.0-0.4)   |0                    |0                  |
|Lung disease               |Apical Pulmonary fibrosis                 |36 months                   |0.1 (0.0-0.4)   |0                    |0                  |
|Lung disease               |Apical Pulmonary fibrosis                 |AS cohort entry to exposure |0.0 (0.0-0.2)   |0                    |0                  |
|Lung disease               |Interstitial lung disease                 |12 months                   |0               |0.1 (0.0-0.2)        |0.3 (0.2-0.6)      |
|Lung disease               |Interstitial lung disease                 |24 months                   |0               |0.1 (0.0-0.2)        |0.6 (0.4-1.0)      |
|Lung disease               |Interstitial lung disease                 |36 months                   |0               |0.1 (0.1-0.3)        |0.9 (0.6-1.3)      |
|Lung disease               |Interstitial lung disease                 |AS cohort entry to exposure |0               |0.0 (0.0-0.1)        |0.4 (0.2-0.7)      |
|Lung disease               |Restrictive lung disease                  |12 months                   |0.8 (0.4-1.4)   |0.8 (0.6-1.1)        |3.5 (2.8-4.2)      |
|Lung disease               |Restrictive lung disease                  |24 months                   |1.6 (1.0-2.4)   |1.3 (1.0-1.6)        |5.6 (4.8-6.5)      |
|Lung disease               |Restrictive lung disease                  |36 months                   |1.8 (1.2-2.7)   |1.5 (1.2-1.8)        |7.1 (6.1-8.1)      |
|Lung disease               |Restrictive lung disease                  |AS cohort entry to exposure |0.9 (0.5-1.6)   |0.8 (0.6-1.0)        |4.1 (3.4-4.8)      |
|Neurological Disease       |Cauda Equina syndrome                     |12 months                   |0.1 (0.0-0.4)   |0.0 (0.0-0.1)        |0.2 (0.1-0.5)      |
|Neurological Disease       |Cauda Equina syndrome                     |24 months                   |0.2 (0.0-0.5)   |0.1 (0.0-0.2)        |0.2 (0.1-0.5)      |
|Neurological Disease       |Cauda Equina syndrome                     |36 months                   |0.2 (0.0-0.5)   |0.1 (0.0-0.2)        |0.3 (0.2-0.6)      |
|Neurological Disease       |Cauda Equina syndrome                     |AS cohort entry to exposure |0.2 (0.0-0.5)   |0.1 (0.0-0.2)        |0.2 (0.1-0.5)      |
|Neurological Disease       |Spinal Cord compression                   |12 months                   |0.1 (0.0-0.4)   |0.1 (0.0-0.2)        |0.2 (0.1-0.4)      |
|Neurological Disease       |Spinal Cord compression                   |24 months                   |0.2 (0.1-0.7)   |0.2 (0.1-0.4)        |0.3 (0.1-0.6)      |
|Neurological Disease       |Spinal Cord compression                   |36 months                   |0.3 (0.1-0.8)   |0.3 (0.2-0.5)        |0.4 (0.2-0.7)      |
|Neurological Disease       |Spinal Cord compression                   |AS cohort entry to exposure |0.1 (0.0-0.4)   |0.1 (0.0-0.2)        |0.3 (0.1-0.5)      |
|Osteoporotic fracture      |Clinical vertebral fracture               |12 months                   |1.2 (0.7-2.0)   |0.7 (0.5-0.9)        |2.6 (2.0-3.2)      |
|Osteoporotic fracture      |Clinical vertebral fracture               |24 months                   |1.6 (1.0-2.5)   |1.0 (0.7-1.3)        |4.2 (3.5-5.1)      |
|Osteoporotic fracture      |Clinical vertebral fracture               |36 months                   |2.0 (1.3-2.9)   |1.2 (0.9-1.5)        |5.9 (5.1-6.9)      |
|Osteoporotic fracture      |Clinical vertebral fracture               |AS cohort entry to exposure |0.9 (0.5-1.6)   |0.8 (0.6-1.0)        |3.4 (2.7-4.1)      |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |12 months                   |1.8 (1.2-2.7)   |0.9 (0.6-1.1)        |3.5 (2.8-4.2)      |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |24 months                   |3.5 (2.6-4.7)   |1.7 (1.3-2.0)        |6.0 (5.1-6.9)      |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |36 months                   |3.9 (2.9-5.1)   |2.1 (1.7-2.5)        |8.0 (7.0-9.1)      |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |AS cohort entry to exposure |2.6 (1.8-3.6)   |1.4 (1.1-1.8)        |5.1 (4.3-6.0)      |
|PsO/PsA                    |Psoriasis                                 |12 months                   |2.0 (1.3-2.9)   |3.1 (2.6-3.5)        |2.8 (2.2-3.5)      |
|PsO/PsA                    |Psoriasis                                 |24 months                   |2.9 (2.0-3.9)   |4.1 (3.6-4.7)        |3.9 (3.2-4.7)      |
|PsO/PsA                    |Psoriasis                                 |36 months                   |3.5 (2.6-4.7)   |4.7 (4.1-5.3)        |4.5 (3.8-5.4)      |
|PsO/PsA                    |Psoriasis                                 |AS cohort entry to exposure |1.9 (1.2-2.8)   |2.3 (1.9-2.8)        |3.2 (2.6-3.9)      |
|PsO/PsA                    |Psoriatic arthritis                       |12 months                   |3.3 (2.4-4.4)   |3.9 (3.4-4.5)        |4.7 (3.9-5.5)      |
|PsO/PsA                    |Psoriatic arthritis                       |24 months                   |4.3 (3.3-5.6)   |5.3 (4.7-5.9)        |5.7 (4.9-6.7)      |
|PsO/PsA                    |Psoriatic arthritis                       |36 months                   |5.3 (4.2-6.7)   |5.7 (5.1-6.4)        |6.3 (5.5-7.3)      |
|PsO/PsA                    |Psoriatic arthritis                       |AS cohort entry to exposure |2.8 (2.0-3.8)   |3.0 (2.6-3.5)        |4.5 (3.8-5.3)      |
|Uveitis                    |Uveitis                                   |12 months                   |8.1 (6.7-9.7)   |8.2 (7.5-9.0)        |5.3 (4.5-6.2)      |
|Uveitis                    |Uveitis                                   |24 months                   |10.5 (8.9-12.4) |10.3 (9.5-11.2)      |6.9 (6.0-8.0)      |
|Uveitis                    |Uveitis                                   |36 months                   |11.2 (9.5-13.1) |11.3 (10.5-12.2)     |7.7 (6.8-8.8)      |
|Uveitis                    |Uveitis                                   |AS cohort entry to exposure |8.6 (7.1-10.3)  |8.7 (8.0-9.5)        |6.0 (5.1-7.0)      |


## By exposure

Read prevalence data.
See `queryPrevalentComorbidities.sas`.


|    |database   |exposure    | denomPatid| denomIndexExp|
|:---|:----------|:-----------|----------:|-------------:|
|1   |MPCD       |DMARD       |        145|           165|
|57  |MPCD       |NSAID       |        265|           355|
|113 |MPCD       |No exposure |        512|           512|
|197 |MPCD       |TNF         |        575|           670|
|269 |Marketscan |DMARD       |        710|           777|
|345 |Marketscan |NSAID       |       1293|          1733|
|425 |Marketscan |No exposure |       1699|          1699|
|513 |Marketscan |TNF         |       2864|          3453|
|601 |Medicare   |DMARD       |        550|           642|
|689 |Medicare   |NSAID       |       1108|          1629|
|777 |Medicare   |No exposure |       1244|          1244|
|865 |Medicare   |TNF         |        702|           810|

Table of **prevalence %**


|outcomeCategory            |disease                                   |timeWindow                  |MPCD TNF       |MPCD DMARD     |MPCD NSAID     |MPCD No exposure |Marketscan TNF |Marketscan DMARD |Marketscan NSAID |Marketscan No exposure |Medicare TNF     |Medicare DMARD   |Medicare NSAID   |Medicare No exposure |
|:--------------------------|:-----------------------------------------|:---------------------------|:--------------|:--------------|:--------------|:----------------|:--------------|:----------------|:----------------|:----------------------|:----------------|:----------------|:----------------|:--------------------|
|Cancer                     |Hematologic Cancer                        |12 months                   |0.1 (0.0-0.7)  |0.6 (0.1-2.8)  |0              |0.4 (0.1-1.2)    |0.1 (0.0-0.2)  |0.8 (0.3-1.6)    |0.2 (0.1-0.5)    |0.5 (0.2-0.9)          |0.6 (0.2-1.3)    |2.3 (1.4-3.7)    |2.6 (1.9-3.5)    |1.1 (0.6-1.8)        |
|Cancer                     |Hematologic Cancer                        |24 months                   |0.3 (0.1-1.0)  |0.6 (0.1-2.8)  |0              |0.6 (0.2-1.6)    |0.2 (0.1-0.4)  |0.9 (0.4-1.8)    |0.4 (0.2-0.8)    |0.5 (0.3-1.0)          |1.6 (0.9-2.7)    |2.8 (1.7-4.3)    |2.8 (2.1-3.7)    |1.7 (1.1-2.5)        |
|Cancer                     |Hematologic Cancer                        |36 months                   |0.3 (0.1-1.0)  |0.6 (0.1-2.8)  |0              |1.0 (0.4-2.1)    |0.2 (0.1-0.4)  |0.9 (0.4-1.8)    |0.4 (0.2-0.8)    |0.6 (0.3-1.1)          |2.1 (1.3-3.3)    |2.8 (1.7-4.3)    |3.1 (2.3-4.0)    |2.0 (1.3-2.9)        |
|Cancer                     |Hematologic Cancer                        |AS cohort entry to exposure |0.1 (0.0-0.7)  |0.6 (0.1-2.8)  |0              |0.0 (0.0-0.5)    |0.1 (0.0-0.2)  |0.5 (0.2-1.2)    |0.4 (0.2-0.8)    |0.0 (0.0-0.1)          |0.5 (0.2-1.2)    |1.9 (1.0-3.1)    |3.2 (2.4-4.1)    |0.2 (0.0-0.5)        |
|Cancer                     |Non Melanoma Skin Cancer                  |12 months                   |0              |0              |0              |0                |0.5 (0.3-0.8)  |0.5 (0.2-1.2)    |0.6 (0.3-1.1)    |0.9 (0.5-1.4)          |2.3 (1.5-3.6)    |2.3 (1.4-3.7)    |3.2 (2.4-4.1)    |2.2 (1.5-3.1)        |
|Cancer                     |Non Melanoma Skin Cancer                  |24 months                   |0              |0              |0              |0                |1.2 (0.8-1.6)  |1.4 (0.8-2.4)    |1.1 (0.7-1.7)    |1.2 (0.7-1.8)          |4.1 (2.9-5.6)    |4.2 (2.9-6.0)    |5.0 (4.1-6.2)    |3.1 (2.3-4.2)        |
|Cancer                     |Non Melanoma Skin Cancer                  |36 months                   |0              |0              |0              |0                |1.4 (1.0-1.8)  |1.8 (1.0-2.9)    |1.2 (0.8-1.8)    |1.3 (0.8-1.9)          |5.3 (3.9-7.0)    |6.2 (4.6-8.3)    |6.8 (5.6-8.0)    |4.3 (3.2-5.5)        |
|Cancer                     |Non Melanoma Skin Cancer                  |AS cohort entry to exposure |0              |0              |0              |0                |0.6 (0.4-0.9)  |0.6 (0.2-1.4)    |1.0 (0.6-1.6)    |0.1 (0.0-0.3)          |2.0 (1.2-3.1)    |2.2 (1.3-3.5)    |3.6 (2.8-4.6)    |0.0 (0.0-0.2)        |
|Cancer                     |Solid Cancer                              |12 months                   |2.2 (1.3-3.6)  |3.6 (1.5-7.3)  |2.0 (0.9-3.8)  |5.3 (3.6-7.5)    |2.1 (1.6-2.6)  |5.3 (3.9-7.0)    |3.6 (2.8-4.6)    |2.6 (2.0-3.5)          |12.6 (10.4-15.0) |13.9 (11.4-16.7) |15.4 (13.7-17.2) |16.1 (14.1-18.2)     |
|Cancer                     |Solid Cancer                              |24 months                   |3.1 (2.0-4.7)  |4.8 (2.3-8.9)  |2.8 (1.5-4.9)  |7.4 (5.4-9.9)    |2.7 (2.2-3.3)  |5.5 (4.1-7.3)    |4.8 (3.9-5.9)    |3.5 (2.7-4.5)          |15.1 (12.7-17.6) |17.8 (14.9-20.9) |18.9 (17.1-20.9) |18.6 (16.6-20.9)     |
|Cancer                     |Solid Cancer                              |36 months                   |3.4 (2.2-5.0)  |4.8 (2.3-8.9)  |3.1 (1.7-5.3)  |8.8 (6.6-11.5)   |2.9 (2.4-3.5)  |6.2 (4.6-8.0)    |5.0 (4.1-6.1)    |3.9 (3.0-4.9)          |16.5 (14.1-19.2) |20.1 (17.1-23.3) |21.2 (19.2-23.2) |21.1 (18.9-23.5)     |
|Cancer                     |Solid Cancer                              |AS cohort entry to exposure |1.8 (1.0-3.0)  |3.0 (1.2-6.5)  |2.0 (0.9-3.8)  |0.8 (0.3-1.8)    |1.4 (1.1-1.9)  |4.5 (3.2-6.1)    |3.6 (2.8-4.5)    |0.1 (0.0-0.3)          |9.1 (7.3-11.3)   |11.8 (9.5-14.5)  |16.9 (15.1-18.8) |1.1 (0.6-1.8)        |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |12 months                   |1.9 (1.1-3.2)  |1.2 (0.3-3.8)  |0.3 (0.0-1.3)  |2.5 (1.4-4.2)    |0.8 (0.6-1.2)  |0.9 (0.4-1.8)    |0.5 (0.2-0.9)    |1.4 (0.9-2.0)          |6.2 (4.7-8.0)    |4.8 (3.4-6.7)    |7.5 (6.3-8.8)    |7.3 (6.0-8.9)        |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |24 months                   |2.2 (1.3-3.6)  |1.2 (0.3-3.8)  |0.3 (0.0-1.3)  |2.9 (1.7-4.7)    |1.0 (0.7-1.4)  |1.4 (0.8-2.4)    |0.7 (0.4-1.2)    |1.6 (1.1-2.3)          |8.8 (7.0-10.9)   |8.3 (6.3-10.6)   |10.1 (8.7-11.7)  |9.6 (8.1-11.4)       |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |36 months                   |2.2 (1.3-3.6)  |1.2 (0.3-3.8)  |0.3 (0.0-1.3)  |3.5 (2.2-5.4)    |1.2 (0.9-1.6)  |1.9 (1.1-3.1)    |0.7 (0.4-1.2)    |1.8 (1.2-2.5)          |10.0 (8.1-12.2)  |9.3 (7.3-11.8)   |11.9 (10.4-13.5) |11.2 (9.5-13.0)      |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |AS cohort entry to exposure |1.5 (0.8-2.6)  |0.0 (0.0-1.5)  |0.0 (0.0-0.7)  |0.2 (0.0-0.9)    |0.7 (0.5-1.0)  |0.8 (0.3-1.6)    |0.6 (0.3-1.0)    |0.2 (0.0-0.5)          |4.7 (3.4-6.3)    |5.0 (3.5-6.9)    |9.2 (7.9-10.7)   |0.2 (0.1-0.6)        |
|Cardiac disease            |Conduction Block                          |12 months                   |0.1 (0.0-0.7)  |0              |0.8 (0.2-2.2)  |1.0 (0.4-2.1)    |0.7 (0.4-1.0)  |1.0 (0.5-1.9)    |1.3 (0.8-1.9)    |1.4 (0.9-2.0)          |5.9 (4.5-7.7)    |5.0 (3.5-6.9)    |4.9 (3.9-6.0)    |4.8 (3.7-6.1)        |
|Cardiac disease            |Conduction Block                          |24 months                   |0.1 (0.0-0.7)  |0              |0.8 (0.2-2.2)  |1.6 (0.7-2.9)    |1.0 (0.7-1.4)  |1.8 (1.0-2.9)    |1.7 (1.1-2.4)    |1.9 (1.3-2.6)          |7.8 (6.1-9.8)    |7.2 (5.4-9.4)    |6.7 (5.6-8.0)    |7.6 (6.2-9.1)        |
|Cardiac disease            |Conduction Block                          |36 months                   |0.1 (0.0-0.7)  |0              |0.8 (0.2-2.2)  |1.6 (0.7-2.9)    |1.2 (0.9-1.6)  |1.8 (1.0-2.9)    |2.0 (1.4-2.7)    |2.1 (1.5-2.9)          |9.1 (7.3-11.3)   |8.9 (6.9-11.3)   |7.9 (6.7-9.3)    |9.3 (7.8-11.0)       |
|Cardiac disease            |Conduction Block                          |AS cohort entry to exposure |0.0 (0.0-0.4)  |0              |0.3 (0.0-1.3)  |0.0 (0.0-0.5)    |0.6 (0.3-0.8)  |0.9 (0.4-1.8)    |0.9 (0.6-1.5)    |0.0 (0.0-0.1)          |3.7 (2.6-5.2)    |3.9 (2.6-5.6)    |7.6 (6.4-9.0)    |0.0 (0.0-0.2)        |
|Cardiac disease            |Myocardial infarction                     |12 months                   |0.0 (0.0-0.4)  |0              |0              |0.2 (0.0-0.9)    |0.1 (0.1-0.3)  |0.0 (0.0-0.3)    |0.1 (0.0-0.4)    |0.1 (0.0-0.3)          |1.4 (0.7-2.3)    |1.2 (0.6-2.3)    |1.2 (0.8-1.9)    |1.3 (0.8-2.0)        |
|Cardiac disease            |Myocardial infarction                     |24 months                   |0.3 (0.1-1.0)  |0              |0              |0.8 (0.3-1.8)    |0.4 (0.2-0.6)  |0.1 (0.0-0.6)    |0.3 (0.1-0.6)    |0.3 (0.1-0.6)          |2.1 (1.3-3.3)    |2.0 (1.1-3.3)    |1.8 (1.2-2.5)    |2.5 (1.7-3.5)        |
|Cardiac disease            |Myocardial infarction                     |36 months                   |0.3 (0.1-1.0)  |0              |0              |0.8 (0.3-1.8)    |0.4 (0.2-0.6)  |0.3 (0.1-0.8)    |0.4 (0.2-0.8)    |0.4 (0.1-0.7)          |2.5 (1.6-3.7)    |2.5 (1.5-3.9)    |2.5 (1.8-3.3)    |3.4 (2.5-4.5)        |
|Cardiac disease            |Myocardial infarction                     |AS cohort entry to exposure |0.0 (0.0-0.4)  |0              |0              |0.0 (0.0-0.5)    |0.1 (0.0-0.3)  |0.1 (0.0-0.6)    |0.2 (0.1-0.5)    |0.0 (0.0-0.1)          |1.4 (0.7-2.3)    |1.2 (0.6-2.3)    |2.2 (1.6-3.0)    |0.0 (0.0-0.2)        |
|Infection                  |Hospitalized infection                    |12 months                   |0.6 (0.2-1.4)  |1.2 (0.3-3.8)  |0.3 (0.0-1.3)  |1.0 (0.4-2.1)    |3.0 (2.5-3.6)  |3.3 (2.2-4.8)    |2.8 (2.1-3.6)    |2.1 (1.5-2.9)          |9.0 (7.2-11.1)   |11.8 (9.5-14.5)  |12.2 (10.7-13.9) |8.9 (7.4-10.6)       |
|Infection                  |Hospitalized infection                    |24 months                   |1.0 (0.5-2.0)  |3.0 (1.2-6.5)  |0.3 (0.0-1.3)  |2.5 (1.4-4.2)    |4.5 (3.9-5.2)  |5.0 (3.6-6.7)    |3.8 (2.9-4.7)    |3.6 (2.8-4.6)          |15.6 (13.2-18.2) |18.2 (15.4-21.3) |18.4 (16.5-20.3) |16.1 (14.1-18.2)     |
|Infection                  |Hospitalized infection                    |36 months                   |1.3 (0.7-2.4)  |4.2 (1.9-8.1)  |0.3 (0.0-1.3)  |3.1 (1.9-4.9)    |5.1 (4.4-5.9)  |5.4 (4.0-7.2)    |4.3 (3.4-5.4)    |4.4 (3.5-5.4)          |19.1 (16.5-22.0) |22.3 (19.2-25.6) |22.7 (20.7-24.7) |21.4 (19.2-23.7)     |
|Infection                  |Hospitalized infection                    |AS cohort entry to exposure |0.6 (0.2-1.4)  |1.8 (0.5-4.8)  |0.0 (0.0-0.7)  |0.0 (0.0-0.5)    |2.3 (1.8-2.8)  |2.8 (1.8-4.2)    |3.4 (2.6-4.3)    |0.0 (0.0-0.1)          |6.9 (5.3-8.8)    |14.2 (11.6-17.0) |19.0 (17.2-21.0) |0.0 (0.0-0.2)        |
|Infection                  |Opportunistic infection                   |12 months                   |0.9 (0.4-1.8)  |0.6 (0.1-2.8)  |0.0 (0.0-0.7)  |0.4 (0.1-1.2)    |1.1 (0.8-1.5)  |1.4 (0.8-2.4)    |0.8 (0.5-1.3)    |0.6 (0.3-1.0)          |4.2 (3.0-5.7)    |2.2 (1.3-3.5)    |2.0 (1.4-2.7)    |1.5 (1.0-2.3)        |
|Infection                  |Opportunistic infection                   |24 months                   |1.5 (0.8-2.6)  |2.4 (0.8-5.7)  |0.0 (0.0-0.7)  |0.8 (0.3-1.8)    |1.5 (1.1-1.9)  |2.2 (1.3-3.4)    |1.2 (0.7-1.7)    |0.8 (0.5-1.3)          |5.2 (3.8-6.9)    |3.7 (2.5-5.4)    |3.4 (2.6-4.4)    |2.4 (1.7-3.4)        |
|Infection                  |Opportunistic infection                   |36 months                   |1.6 (0.9-2.8)  |4.8 (2.3-8.9)  |0.0 (0.0-0.7)  |1.2 (0.5-2.4)    |1.7 (1.3-2.1)  |2.6 (1.6-3.9)    |1.4 (0.9-2.0)    |1.0 (0.6-1.6)          |6.0 (4.6-7.8)    |4.2 (2.9-6.0)    |4.8 (3.8-5.9)    |3.1 (2.2-4.1)        |
|Infection                  |Opportunistic infection                   |AS cohort entry to exposure |0.3 (0.1-1.0)  |0.6 (0.1-2.8)  |0.6 (0.1-1.8)  |0.0 (0.0-0.5)    |0.8 (0.6-1.2)  |1.2 (0.6-2.1)    |0.8 (0.5-1.3)    |0.0 (0.0-0.1)          |3.8 (2.7-5.3)    |3.7 (2.5-5.4)    |3.6 (2.7-4.5)    |0.1 (0.0-0.4)        |
|Inflammatory bowel disease |Crohn’s Disease                           |12 months                   |5.1 (3.6-6.9)  |4.2 (1.9-8.1)  |1.1 (0.4-2.7)  |2.7 (1.6-4.4)    |5.0 (4.3-5.7)  |4.0 (2.8-5.5)    |2.4 (1.7-3.2)    |3.1 (2.3-4.0)          |5.1 (3.7-6.7)    |3.3 (2.1-4.9)    |1.3 (0.8-1.9)    |3.2 (2.3-4.3)        |
|Inflammatory bowel disease |Crohn’s Disease                           |24 months                   |5.7 (4.1-7.6)  |5.5 (2.7-9.7)  |1.7 (0.7-3.5)  |3.7 (2.3-5.6)    |5.6 (4.9-6.4)  |4.2 (3.0-5.8)    |2.8 (2.1-3.6)    |4.0 (3.1-5.0)          |5.7 (4.2-7.4)    |3.7 (2.5-5.4)    |1.8 (1.2-2.5)    |4.0 (3.0-5.2)        |
|Inflammatory bowel disease |Crohn’s Disease                           |36 months                   |6.1 (4.5-8.1)  |5.5 (2.7-9.7)  |2.0 (0.9-3.8)  |4.5 (2.9-6.5)    |5.8 (5.1-6.6)  |4.5 (3.2-6.1)    |3.1 (2.3-3.9)    |4.4 (3.5-5.4)          |5.8 (4.3-7.6)    |3.9 (2.6-5.6)    |1.9 (1.3-2.7)    |4.3 (3.2-5.5)        |
|Inflammatory bowel disease |Crohn’s Disease                           |AS cohort entry to exposure |4.2 (2.9-5.9)  |4.2 (1.9-8.1)  |1.4 (0.5-3.1)  |0.6 (0.2-1.6)    |4.0 (3.4-4.7)  |3.1 (2.0-4.5)    |2.5 (1.9-3.4)    |0.8 (0.4-1.3)          |4.1 (2.9-5.6)    |3.0 (1.9-4.5)    |2.2 (1.6-3.0)    |0.6 (0.3-1.1)        |
|Inflammatory bowel disease |Ulcerative Colitis                        |12 months                   |2.4 (1.4-3.8)  |2.4 (0.8-5.7)  |1.1 (0.4-2.7)  |1.6 (0.7-2.9)    |3.0 (2.4-3.6)  |1.5 (0.8-2.6)    |1.5 (1.0-2.2)    |2.5 (1.9-3.4)          |4.4 (3.2-6.0)    |3.7 (2.5-5.4)    |1.3 (0.8-1.9)    |2.2 (1.5-3.1)        |
|Inflammatory bowel disease |Ulcerative Colitis                        |24 months                   |2.7 (1.7-4.1)  |2.4 (0.8-5.7)  |1.4 (0.5-3.1)  |2.0 (1.0-3.4)    |3.5 (3.0-4.2)  |2.1 (1.2-3.2)    |1.7 (1.1-2.4)    |3.3 (2.5-4.2)          |5.4 (4.0-7.2)    |5.1 (3.6-7.1)    |1.7 (1.1-2.4)    |2.9 (2.1-3.9)        |
|Inflammatory bowel disease |Ulcerative Colitis                        |36 months                   |2.7 (1.7-4.1)  |2.4 (0.8-5.7)  |1.4 (0.5-3.1)  |2.3 (1.3-3.9)    |3.8 (3.2-4.5)  |2.3 (1.4-3.6)    |1.9 (1.3-2.6)    |3.4 (2.6-4.4)          |5.7 (4.2-7.4)    |5.1 (3.6-7.1)    |2.1 (1.5-2.9)    |3.4 (2.5-4.5)        |
|Inflammatory bowel disease |Ulcerative Colitis                        |AS cohort entry to exposure |2.2 (1.3-3.6)  |1.2 (0.3-3.8)  |1.7 (0.7-3.5)  |0.0 (0.0-0.5)    |1.9 (1.5-2.4)  |0.6 (0.2-1.4)    |1.1 (0.7-1.7)    |0.4 (0.2-0.8)          |3.2 (2.2-4.6)    |3.6 (2.3-5.2)    |2.2 (1.6-3.0)    |0.3 (0.1-0.8)        |
|Kidney disease             |Amyloidosis                               |12 months                   |0              |0              |0              |0.2 (0.0-0.9)    |0.0 (0.0-0.1)  |0                |0                |0.1 (0.0-0.3)          |0                |0.3 (0.1-1.0)    |0.1 (0.0-0.3)    |0.1 (0.0-0.4)        |
|Kidney disease             |Amyloidosis                               |24 months                   |0              |0              |0              |0.4 (0.1-1.2)    |0.1 (0.0-0.2)  |0                |0                |0.1 (0.0-0.3)          |0                |0.3 (0.1-1.0)    |0.1 (0.0-0.3)    |0.2 (0.0-0.5)        |
|Kidney disease             |Amyloidosis                               |36 months                   |0              |0              |0              |0.6 (0.2-1.6)    |0.1 (0.0-0.2)  |0                |0                |0.1 (0.0-0.3)          |0                |0.3 (0.1-1.0)    |0.1 (0.0-0.3)    |0.2 (0.1-0.6)        |
|Kidney disease             |Amyloidosis                               |AS cohort entry to exposure |0              |0              |0              |0.0 (0.0-0.5)    |0.0 (0.0-0.1)  |0                |0                |0.0 (0.0-0.1)          |0                |0.3 (0.1-1.0)    |0.1 (0.0-0.4)    |0.0 (0.0-0.2)        |
|Kidney disease             |IgA nephropathy                           |12 months                   |0.3 (0.1-1.0)  |0.6 (0.1-2.8)  |0.3 (0.0-1.3)  |0.0 (0.0-0.5)    |0.1 (0.1-0.3)  |0                |0.0 (0.0-0.1)    |0.2 (0.0-0.5)          |0.1 (0.0-0.6)    |0.0 (0.0-0.4)    |0.1 (0.0-0.3)    |0.0 (0.0-0.2)        |
|Kidney disease             |IgA nephropathy                           |24 months                   |0.3 (0.1-1.0)  |0.6 (0.1-2.8)  |0.6 (0.1-1.8)  |0.0 (0.0-0.5)    |0.2 (0.1-0.4)  |0                |0.0 (0.0-0.1)    |0.2 (0.1-0.6)          |0.2 (0.1-0.8)    |0.2 (0.0-0.7)    |0.1 (0.0-0.3)    |0.1 (0.0-0.4)        |
|Kidney disease             |IgA nephropathy                           |36 months                   |0.3 (0.1-1.0)  |0.6 (0.1-2.8)  |0.6 (0.1-1.8)  |0.4 (0.1-1.2)    |0.2 (0.1-0.4)  |0                |0.1 (0.0-0.3)    |0.2 (0.1-0.6)          |0.4 (0.1-1.0)    |0.2 (0.0-0.7)    |0.1 (0.0-0.4)    |0.1 (0.0-0.4)        |
|Kidney disease             |IgA nephropathy                           |AS cohort entry to exposure |0.1 (0.0-0.7)  |0.6 (0.1-2.8)  |0.3 (0.0-1.3)  |0.0 (0.0-0.5)    |0.1 (0.1-0.3)  |0                |0.0 (0.0-0.1)    |0.0 (0.0-0.1)          |0.0 (0.0-0.3)    |0.5 (0.1-1.2)    |0.2 (0.1-0.6)    |0.0 (0.0-0.2)        |
|Kidney disease             |Nephrotic syndrome                        |12 months                   |0.3 (0.1-1.0)  |0              |0              |0.0 (0.0-0.5)    |0.1 (0.0-0.2)  |0.0 (0.0-0.3)    |0.0 (0.0-0.1)    |0.1 (0.0-0.4)          |0.1 (0.0-0.6)    |0.6 (0.2-1.5)    |0.2 (0.1-0.5)    |0.3 (0.1-0.8)        |
|Kidney disease             |Nephrotic syndrome                        |24 months                   |0.3 (0.1-1.0)  |0              |0              |0.2 (0.0-0.9)    |0.1 (0.1-0.3)  |0.0 (0.0-0.3)    |0.1 (0.0-0.3)    |0.1 (0.0-0.4)          |0.1 (0.0-0.6)    |0.8 (0.3-1.7)    |0.2 (0.1-0.5)    |0.4 (0.2-0.9)        |
|Kidney disease             |Nephrotic syndrome                        |36 months                   |0.3 (0.1-1.0)  |0              |0              |0.2 (0.0-0.9)    |0.1 (0.1-0.3)  |0.1 (0.0-0.6)    |0.1 (0.0-0.3)    |0.1 (0.0-0.4)          |0.1 (0.0-0.6)    |0.8 (0.3-1.7)    |0.2 (0.1-0.5)    |0.4 (0.2-0.9)        |
|Kidney disease             |Nephrotic syndrome                        |AS cohort entry to exposure |0.0 (0.0-0.4)  |0              |0              |0.0 (0.0-0.5)    |0.1 (0.0-0.2)  |0.0 (0.0-0.3)    |0.0 (0.0-0.1)    |0.0 (0.0-0.1)          |0.0 (0.0-0.3)    |0.3 (0.1-1.0)    |0.2 (0.1-0.5)    |0.0 (0.0-0.2)        |
|Lung disease               |Apical Pulmonary fibrosis                 |12 months                   |0              |0              |0              |0.0 (0.0-0.5)    |0              |0                |0                |0                      |0                |0                |0                |0                    |
|Lung disease               |Apical Pulmonary fibrosis                 |24 months                   |0              |0              |0              |0.2 (0.0-0.9)    |0              |0                |0                |0                      |0                |0                |0                |0                    |
|Lung disease               |Apical Pulmonary fibrosis                 |36 months                   |0              |0              |0              |0.2 (0.0-0.9)    |0              |0                |0                |0                      |0                |0                |0                |0                    |
|Lung disease               |Apical Pulmonary fibrosis                 |AS cohort entry to exposure |0              |0              |0              |0.0 (0.0-0.5)    |0              |0                |0                |0                      |0                |0                |0                |0                    |
|Lung disease               |Interstitial lung disease                 |12 months                   |0              |0              |0              |0                |0.1 (0.1-0.3)  |0.3 (0.1-0.8)    |0.1 (0.0-0.3)    |0.0 (0.0-0.1)          |0.2 (0.1-0.8)    |0.5 (0.1-1.2)    |0.2 (0.1-0.6)    |0.4 (0.2-0.9)        |
|Lung disease               |Interstitial lung disease                 |24 months                   |0              |0              |0              |0                |0.1 (0.1-0.3)  |0.3 (0.1-0.8)    |0.1 (0.0-0.4)    |0.0 (0.0-0.1)          |1.2 (0.6-2.2)    |1.2 (0.6-2.3)    |0.4 (0.2-0.8)    |0.7 (0.4-1.3)        |
|Lung disease               |Interstitial lung disease                 |36 months                   |0              |0              |0              |0                |0.1 (0.1-0.3)  |0.3 (0.1-0.8)    |0.1 (0.0-0.4)    |0.1 (0.0-0.3)          |1.9 (1.1-3.0)    |1.9 (1.0-3.1)    |0.6 (0.3-1.1)    |0.8 (0.4-1.4)        |
|Lung disease               |Interstitial lung disease                 |AS cohort entry to exposure |0              |0              |0              |0                |0.1 (0.0-0.2)  |0.1 (0.0-0.6)    |0.1 (0.0-0.4)    |0.0 (0.0-0.1)          |0.5 (0.2-1.2)    |0.9 (0.4-1.9)    |0.7 (0.4-1.2)    |0.0 (0.0-0.2)        |
|Lung disease               |Restrictive lung disease                  |12 months                   |0.6 (0.2-1.4)  |0.0 (0.0-1.5)  |1.1 (0.4-2.7)  |1.8 (0.9-3.2)    |0.8 (0.5-1.1)  |0.6 (0.2-1.4)    |0.6 (0.3-1.0)    |0.9 (0.6-1.5)          |3.5 (2.4-4.9)    |4.2 (2.9-6.0)    |3.7 (2.8-4.7)    |3.1 (2.3-4.2)        |
|Lung disease               |Restrictive lung disease                  |24 months                   |1.0 (0.5-2.0)  |0.0 (0.0-1.5)  |2.0 (0.9-3.8)  |2.1 (1.1-3.7)    |1.1 (0.8-1.5)  |1.3 (0.7-2.3)    |0.8 (0.4-1.2)    |1.4 (0.9-2.0)          |6.0 (4.6-7.8)    |5.5 (3.9-7.4)    |5.6 (4.5-6.8)    |4.4 (3.4-5.7)        |
|Lung disease               |Restrictive lung disease                  |36 months                   |1.2 (0.6-2.2)  |0.6 (0.1-2.8)  |2.5 (1.3-4.6)  |2.3 (1.3-3.9)    |1.2 (0.9-1.6)  |2.1 (1.2-3.2)    |0.9 (0.6-1.5)    |1.6 (1.1-2.3)          |6.8 (5.2-8.7)    |7.3 (5.5-9.5)    |6.9 (5.7-8.2)    |6.0 (4.8-7.5)        |
|Lung disease               |Restrictive lung disease                  |AS cohort entry to exposure |0.6 (0.2-1.4)  |0.0 (0.0-1.5)  |0.3 (0.0-1.3)  |0.2 (0.0-0.9)    |0.6 (0.4-0.9)  |0.9 (0.4-1.8)    |0.8 (0.4-1.2)    |0.0 (0.0-0.1)          |3.6 (2.5-5.0)    |4.2 (2.9-6.0)    |6.1 (5.1-7.4)    |0.0 (0.0-0.2)        |
|Neurological Disease       |Cauda Equina syndrome                     |12 months                   |0              |0              |0              |0.2 (0.0-0.9)    |0.0 (0.0-0.1)  |0                |0                |0.1 (0.0-0.3)          |0.1 (0.0-0.6)    |0.0 (0.0-0.4)    |0.1 (0.0-0.4)    |0.5 (0.2-1.0)        |
|Neurological Disease       |Cauda Equina syndrome                     |24 months                   |0              |0              |0              |0.4 (0.1-1.2)    |0.0 (0.0-0.1)  |0                |0                |0.1 (0.0-0.4)          |0.1 (0.0-0.6)    |0.0 (0.0-0.4)    |0.1 (0.0-0.4)    |0.5 (0.2-1.0)        |
|Neurological Disease       |Cauda Equina syndrome                     |36 months                   |0              |0              |0              |0.4 (0.1-1.2)    |0.0 (0.0-0.1)  |0                |0                |0.1 (0.0-0.4)          |0.2 (0.1-0.8)    |0.2 (0.0-0.7)    |0.2 (0.1-0.5)    |0.6 (0.3-1.2)        |
|Neurological Disease       |Cauda Equina syndrome                     |AS cohort entry to exposure |0              |0              |0              |0.0 (0.0-0.5)    |0.0 (0.0-0.1)  |0                |0                |0.1 (0.0-0.3)          |0.1 (0.0-0.6)    |0.0 (0.0-0.4)    |0.3 (0.1-0.7)    |0.1 (0.0-0.4)        |
|Neurological Disease       |Spinal Cord compression                   |12 months                   |0.1 (0.0-0.7)  |0              |0.6 (0.1-1.8)  |0.0 (0.0-0.5)    |0.2 (0.1-0.4)  |0.3 (0.1-0.8)    |0.4 (0.2-0.8)    |0.0 (0.0-0.1)          |0.1 (0.0-0.6)    |0.3 (0.1-1.0)    |0.3 (0.1-0.7)    |0.2 (0.1-0.6)        |
|Neurological Disease       |Spinal Cord compression                   |24 months                   |0.1 (0.0-0.7)  |0              |0.8 (0.2-2.2)  |0.0 (0.0-0.5)    |0.3 (0.2-0.6)  |0.3 (0.1-0.8)    |0.8 (0.4-1.2)    |0.2 (0.0-0.5)          |0.2 (0.1-0.8)    |0.6 (0.2-1.5)    |0.4 (0.2-0.8)    |0.2 (0.1-0.6)        |
|Neurological Disease       |Spinal Cord compression                   |36 months                   |0.1 (0.0-0.7)  |0              |0.8 (0.2-2.2)  |0.2 (0.0-0.9)    |0.5 (0.3-0.7)  |0.4 (0.1-1.0)    |0.8 (0.5-1.3)    |0.2 (0.1-0.6)          |0.2 (0.1-0.8)    |0.6 (0.2-1.5)    |0.6 (0.3-1.1)    |0.4 (0.2-0.9)        |
|Neurological Disease       |Spinal Cord compression                   |AS cohort entry to exposure |0.0 (0.0-0.4)  |0              |0.3 (0.0-1.3)  |0.0 (0.0-0.5)    |0.1 (0.0-0.2)  |0.1 (0.0-0.6)    |0.1 (0.0-0.4)    |0.0 (0.0-0.1)          |0.1 (0.0-0.6)    |0.2 (0.0-0.7)    |0.3 (0.1-0.7)    |0.0 (0.0-0.2)        |
|Osteoporotic fracture      |Clinical vertebral fracture               |12 months                   |1.3 (0.7-2.4)  |0.6 (0.1-2.8)  |0              |2.1 (1.1-3.7)    |0.4 (0.2-0.7)  |0.6 (0.2-1.4)    |1.0 (0.6-1.6)    |0.8 (0.5-1.3)          |2.1 (1.3-3.3)    |2.8 (1.7-4.3)    |4.6 (3.7-5.7)    |3.3 (2.4-4.4)        |
|Osteoporotic fracture      |Clinical vertebral fracture               |24 months                   |1.5 (0.8-2.6)  |0.6 (0.1-2.8)  |0              |2.9 (1.7-4.7)    |0.7 (0.4-1.0)  |0.8 (0.3-1.6)    |1.2 (0.8-1.8)    |1.4 (0.9-2.0)          |3.2 (2.2-4.6)    |4.5 (3.1-6.3)    |6.6 (5.4-7.8)    |5.2 (4.1-6.6)        |
|Osteoporotic fracture      |Clinical vertebral fracture               |36 months                   |1.5 (0.8-2.6)  |0.6 (0.1-2.8)  |0              |3.1 (1.9-4.9)    |0.7 (0.5-1.0)  |1.0 (0.5-1.9)    |1.4 (0.9-2.0)    |1.5 (1.0-2.2)          |4.0 (2.8-5.5)    |6.1 (4.4-8.1)    |7.3 (6.1-8.6)    |7.1 (5.7-8.6)        |
|Osteoporotic fracture      |Clinical vertebral fracture               |AS cohort entry to exposure |0.9 (0.4-1.8)  |0.6 (0.1-2.8)  |0              |0.2 (0.0-0.9)    |0.2 (0.1-0.4)  |0.4 (0.1-1.0)    |0.5 (0.3-0.9)    |0.1 (0.0-0.3)          |1.9 (1.1-3.0)    |3.1 (2.0-4.7)    |5.7 (4.7-6.9)    |0.2 (0.1-0.6)        |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |12 months                   |1.6 (0.9-2.8)  |1.2 (0.3-3.8)  |2.5 (1.3-4.6)  |2.7 (1.6-4.4)    |0.8 (0.5-1.1)  |0.8 (0.3-1.6)    |1.4 (0.9-2.0)    |1.1 (0.7-1.7)          |3.5 (2.4-4.9)    |3.3 (2.1-4.9)    |4.2 (3.3-5.3)    |3.7 (2.8-4.9)        |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |24 months                   |2.1 (1.2-3.4)  |2.4 (0.8-5.7)  |2.8 (1.5-4.9)  |4.9 (3.3-7.0)    |1.7 (1.3-2.1)  |1.5 (0.8-2.6)    |1.8 (1.2-2.5)    |1.8 (1.2-2.5)          |5.8 (4.3-7.6)    |6.5 (4.8-8.7)    |6.3 (5.2-7.5)    |6.0 (4.8-7.5)        |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |36 months                   |2.1 (1.2-3.4)  |3.6 (1.5-7.3)  |3.1 (1.7-5.3)  |5.1 (3.4-7.2)    |1.9 (1.5-2.4)  |1.9 (1.1-3.1)    |2.1 (1.5-2.8)    |2.1 (1.5-2.9)          |7.4 (5.8-9.4)    |7.8 (5.9-10.1)   |8.0 (6.8-9.4)    |7.9 (6.5-9.5)        |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |AS cohort entry to exposure |0.9 (0.4-1.8)  |0.6 (0.1-2.8)  |2.0 (0.9-3.8)  |0.4 (0.1-1.2)    |0.6 (0.4-0.9)  |0.9 (0.4-1.8)    |1.5 (1.0-2.2)    |0.0 (0.0-0.1)          |3.3 (2.3-4.7)    |5.5 (3.9-7.4)    |8.2 (6.9-9.6)    |0.1 (0.0-0.4)        |
|PsO/PsA                    |Psoriasis                                 |12 months                   |3.6 (2.4-5.2)  |1.8 (0.5-4.8)  |0.8 (0.2-2.2)  |2.0 (1.0-3.4)    |3.7 (3.1-4.4)  |3.3 (2.2-4.8)    |2.4 (1.8-3.2)    |2.9 (2.2-3.8)          |4.6 (3.3-6.2)    |3.3 (2.1-4.9)    |2.2 (1.6-3.0)    |2.3 (1.6-3.3)        |
|PsO/PsA                    |Psoriasis                                 |24 months                   |4.5 (3.1-6.2)  |1.8 (0.5-4.8)  |0.8 (0.2-2.2)  |2.5 (1.4-4.2)    |4.9 (4.2-5.6)  |4.2 (3.0-5.8)    |3.2 (2.4-4.1)    |3.4 (2.6-4.4)          |5.6 (4.1-7.3)    |4.0 (2.7-5.8)    |3.1 (2.4-4.1)    |3.4 (2.5-4.5)        |
|PsO/PsA                    |Psoriasis                                 |36 months                   |4.6 (3.2-6.4)  |3.0 (1.2-6.5)  |0.8 (0.2-2.2)  |2.7 (1.6-4.4)    |5.6 (4.9-6.4)  |4.8 (3.4-6.4)    |3.6 (2.8-4.6)    |3.6 (2.8-4.6)          |5.9 (4.5-7.7)    |4.8 (3.4-6.7)    |3.9 (3.1-5.0)    |3.6 (2.7-4.8)        |
|PsO/PsA                    |Psoriasis                                 |AS cohort entry to exposure |2.2 (1.3-3.6)  |1.8 (0.5-4.8)  |0.8 (0.2-2.2)  |0.6 (0.2-1.6)    |2.6 (2.1-3.2)  |2.8 (1.8-4.2)    |2.3 (1.7-3.1)    |0.8 (0.4-1.3)          |3.2 (2.2-4.6)    |3.7 (2.5-5.4)    |3.7 (2.9-4.8)    |0.3 (0.1-0.8)        |
|PsO/PsA                    |Psoriatic arthritis                       |12 months                   |5.4 (3.9-7.3)  |3.0 (1.2-6.5)  |0.8 (0.2-2.2)  |2.9 (1.7-4.7)    |5.8 (5.1-6.7)  |5.9 (4.4-7.7)    |2.2 (1.6-3.0)    |2.6 (2.0-3.5)          |7.3 (5.6-9.2)    |6.2 (4.6-8.3)    |2.5 (1.8-3.4)    |3.9 (3.0-5.1)        |
|PsO/PsA                    |Psoriatic arthritis                       |24 months                   |6.9 (5.1-9.0)  |4.2 (1.9-8.1)  |0.8 (0.2-2.2)  |3.5 (2.2-5.4)    |7.0 (6.2-7.9)  |6.8 (5.2-8.8)    |2.4 (1.7-3.2)    |3.4 (2.6-4.3)          |8.9 (7.1-11.0)   |7.3 (5.5-9.5)    |3.4 (2.6-4.3)    |4.6 (3.5-5.9)        |
|PsO/PsA                    |Psoriatic arthritis                       |36 months                   |7.5 (5.7-9.6)  |4.8 (2.3-8.9)  |1.1 (0.4-2.7)  |4.3 (2.8-6.3)    |7.4 (6.5-8.3)  |6.9 (5.3-8.9)    |2.5 (1.9-3.4)    |3.6 (2.8-4.6)          |9.4 (7.5-11.5)   |8.3 (6.3-10.6)   |3.6 (2.8-4.6)    |4.9 (3.8-6.2)        |
|PsO/PsA                    |Psoriatic arthritis                       |AS cohort entry to exposure |4.6 (3.2-6.4)  |3.0 (1.2-6.5)  |0.8 (0.2-2.2)  |1.2 (0.5-2.4)    |4.7 (4.1-5.5)  |3.7 (2.6-5.2)    |2.8 (2.1-3.6)    |1.1 (0.7-1.6)          |5.8 (4.3-7.6)    |7.0 (5.2-9.2)    |3.6 (2.8-4.6)    |1.0 (0.5-1.6)        |
|Uveitis                    |Uveitis                                   |12 months                   |8.4 (6.4-10.6) |6.7 (3.6-11.2) |7.6 (5.2-10.7) |7.8 (5.7-10.4)   |7.5 (6.7-8.4)  |7.2 (5.5-9.2)    |7.2 (6.0-8.4)    |9.7 (8.4-11.2)         |7.0 (5.4-9.0)    |5.3 (3.8-7.2)    |4.2 (3.3-5.2)    |4.8 (3.7-6.1)        |
|Uveitis                    |Uveitis                                   |24 months                   |9.3 (7.2-11.6) |7.9 (4.5-12.7) |8.7 (6.1-12.0) |10.4 (7.9-13.2)  |9.0 (8.1-10.0) |8.9 (7.0-11.0)   |9.2 (7.9-10.6)   |11.6 (10.1-13.2)       |8.4 (6.6-10.5)   |6.1 (4.4-8.1)    |5.3 (4.3-6.4)    |6.4 (5.2-7.9)        |
|Uveitis                    |Uveitis                                   |36 months                   |9.6 (7.5-12.0) |8.5 (4.9-13.5) |8.7 (6.1-12.0) |10.5 (8.1-13.4)  |9.8 (8.9-10.8) |9.5 (7.6-11.7)   |9.5 (8.2-11.0)   |12.3 (10.8-13.9)       |9.6 (7.7-11.8)   |6.9 (5.1-9.0)    |5.9 (4.8-7.1)    |6.8 (5.5-8.3)        |
|Uveitis                    |Uveitis                                   |AS cohort entry to exposure |6.7 (5.0-8.8)  |6.1 (3.2-10.5) |6.8 (4.5-9.7)  |1.8 (0.9-3.2)    |6.1 (5.3-6.9)  |5.9 (4.4-7.7)    |7.5 (6.3-8.8)    |2.4 (1.8-3.2)          |6.8 (5.2-8.7)    |5.1 (3.6-7.1)    |6.0 (4.9-7.2)    |0.6 (0.3-1.2)        |
# Summarize prevalence, non-AS cohort

See `background/table shells.docx`, page 5, 
*Table XX: Prevalence of comorbidities by disease cohort and data source using all available prior data*,
right-hand columns for *Non-AS cohort*

Read prevalence data.
See `queryPrevalentComorbiditiesControl.sas`.


|   |database |cohort | denomPatid| denomControlCohort|
|:--|:--------|:------|----------:|------------------:|
|1  |MPCD     |Non-AS |    1139225|            1139225|
|93 |Medicare |Non-AS |    1447192|            1447192|

Table of **prevalence %**


|outcomeCategory            |disease                                   |timeWindow |MPCD Non-AS cohort |Medicare Non-AS cohort |
|:--------------------------|:-----------------------------------------|:----------|:------------------|:----------------------|
|Cancer                     |Hematologic Cancer                        |12 months  |0.6 (0.6-0.6)      |1.3 (1.3-1.3)          |
|Cancer                     |Non Melanoma Skin Cancer                  |12 months  |0.0 (0.0-0.0)      |0.9 (0.8-0.9)          |
|Cancer                     |Solid Cancer                              |12 months  |3.9 (3.8-3.9)      |10.0 (10.0-10.1)       |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |12 months  |0.9 (0.9-0.9)      |3.2 (3.2-3.2)          |
|Cardiac disease            |Conduction Block                          |12 months  |0.7 (0.7-0.7)      |2.6 (2.6-2.6)          |
|Cardiac disease            |Myocardial infarction                     |12 months  |0.2 (0.2-0.2)      |1.1 (1.1-1.1)          |
|Infection                  |Hospitalized infection                    |12 months  |2.2 (2.2-2.3)      |8.8 (8.8-8.9)          |
|Infection                  |Opportunistic infection                   |12 months  |0.4 (0.4-0.4)      |0.8 (0.8-0.8)          |
|Inflammatory bowel disease |Crohn’s Disease                           |12 months  |2.2 (2.1-2.2)      |0.3 (0.3-0.3)          |
|Inflammatory bowel disease |Ulcerative Colitis                        |12 months  |2.0 (2.0-2.0)      |0.4 (0.4-0.4)          |
|Kidney disease             |Amyloidosis                               |12 months  |0.0 (0.0-0.0)      |0.0 (0.0-0.0)          |
|Kidney disease             |IgA nephropathy                           |12 months  |0.1 (0.1-0.1)      |0.1 (0.1-0.1)          |
|Kidney disease             |Nephrotic syndrome                        |12 months  |0.0 (0.0-0.0)      |0.0 (0.0-0.0)          |
|Lung disease               |Apical Pulmonary fibrosis                 |12 months  |0.0 (0.0-0.0)      |0.0 (0.0-0.0)          |
|Lung disease               |Interstitial lung disease                 |12 months  |0.1 (0.1-0.1)      |0.0 (0.0-0.0)          |
|Lung disease               |Restrictive lung disease                  |12 months  |0.7 (0.6-0.7)      |1.3 (1.3-1.3)          |
|Neurological Disease       |Cauda Equina syndrome                     |12 months  |0.0 (0.0-0.0)      |0.0 (0.0-0.0)          |
|Neurological Disease       |Spinal Cord compression                   |12 months  |0.0 (0.0-0.0)      |0.1 (0.1-0.1)          |
|Osteoporotic fracture      |Clinical vertebral fracture               |12 months  |0.5 (0.4-0.5)      |1.3 (1.2-1.3)          |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |12 months  |1.2 (1.2-1.2)      |2.9 (2.8-2.9)          |
|PsO/PsA                    |Psoriasis                                 |12 months  |4.6 (4.6-4.7)      |1.0 (1.0-1.0)          |
|PsO/PsA                    |Psoriatic arthritis                       |12 months  |1.0 (1.0-1.1)      |0.1 (0.1-0.1)          |
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

Read crude incidence data.
See `modelIncidenceOutcomes.sas`.


|database   |exposure             | nPatid|
|:----------|:--------------------|------:|
|Marketscan |DMARD                |    710|
|Marketscan |NSAID or no exposure |   2651|
|Marketscan |TNF                  |   2819|
|Medicare   |DMARD                |    537|
|Medicare   |NSAID or no exposure |   1920|
|Medicare   |TNF                  |    702|
|MPCD       |DMARD                |    139|
|MPCD       |NSAID or no exposure |    663|
|MPCD       |TNF                  |    537|

\newline


|    |type                  |outcomeCategory            |disease                                   |
|:---|:---------------------|:--------------------------|:-----------------------------------------|
|1   |Comorbidity           |Cancer                     |Hematologic Cancer                        |
|10  |Comorbidity           |Cancer                     |Non Melanoma Skin Cancer                  |
|19  |Comorbidity           |Cancer                     |Solid Cancer                              |
|28  |Comorbidity           |Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |
|37  |Comorbidity           |Cardiac disease            |Conduction Block                          |
|46  |Comorbidity           |Cardiac disease            |Myocardial infarction                     |
|55  |Comorbidity           |Infection                  |Hospitalized infection                    |
|64  |Comorbidity           |Infection                  |Opportunistic infection                   |
|73  |Disease manifestation |Inflammatory bowel disease |Crohn’s Disease                           |
|82  |Disease manifestation |Inflammatory bowel disease |Ulcerative Colitis                        |
|91  |Comorbidity           |Kidney disease             |Amyloidosis                               |
|100 |Comorbidity           |Kidney disease             |IgA nephropathy                           |
|109 |Comorbidity           |Kidney disease             |Nephrotic syndrome                        |
|118 |Comorbidity           |Lung disease               |Apical Pulmonary fibrosis                 |
|127 |Comorbidity           |Lung disease               |Interstitial lung disease                 |
|136 |Comorbidity           |Lung disease               |Restrictive lung disease                  |
|145 |Comorbidity           |Neurological Disease       |Cauda Equina syndrome                     |
|154 |Comorbidity           |Neurological Disease       |Spinal Cord compression                   |
|163 |Comorbidity           |Osteoporotic fracture      |Clinical vertebral fracture               |
|172 |Comorbidity           |Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |
|181 |Disease manifestation |PsO/PsA                    |Psoriasis                                 |
|190 |Disease manifestation |PsO/PsA                    |Psoriatic arthritis                       |
|199 |Disease manifestation |Uveitis                    |Uveitis                                   |

Table of **incidence per 100 person-years**


|type                  |outcomeCategory            |disease                                   |MPCD TNF         |MPCD DMARD       |MPCD NSAID or no exposure |Marketscan TNF   |Marketscan DMARD |Marketscan NSAID or no exposure |Medicare TNF     |Medicare DMARD    |Medicare NSAID or no exposure |
|:---------------------|:--------------------------|:-----------------------------------------|:----------------|:----------------|:-------------------------|:----------------|:----------------|:-------------------------------|:----------------|:-----------------|:-----------------------------|
|Comorbidity           |Cancer                     |Hematologic Cancer                        |0.14 (0.00-0.79) |0.00 (0.00-2.44) |0.47 (0.13-1.19)          |0.12 (0.04-0.29) |0.70 (0.23-1.63) |0.41 (0.22-0.70)                |0.79 (0.49-1.20) |0.52 (0.24-0.99)  |0.47 (0.32-0.65)              |
|Comorbidity           |Cancer                     |Non Melanoma Skin Cancer                  |1.43 (0.69-2.64) |1.33 (0.16-4.82) |1.17 (0.56-2.16)          |0.93 (0.65-1.28) |1.54 (0.77-2.76) |0.75 (0.48-1.12)                |3.27 (2.60-4.06) |2.79 (2.04-3.72)  |3.22 (2.81-3.69)              |
|Comorbidity           |Cancer                     |Solid Cancer                              |1.46 (0.70-2.68) |2.05 (0.42-5.98) |3.78 (2.57-5.36)          |1.35 (1.01-1.77) |2.22 (1.24-3.67) |2.41 (1.90-3.03)                |3.34 (2.63-4.18) |4.37 (3.34-5.61)  |5.44 (4.86-6.08)              |
|Comorbidity           |Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |0.71 (0.23-1.66) |0.66 (0.02-3.70) |1.31 (0.65-2.35)          |0.48 (0.29-0.74) |0.84 (0.31-1.84) |0.63 (0.38-0.97)                |2.35 (1.78-3.04) |1.94 (1.32-2.76)  |2.93 (2.52-3.38)              |
|Comorbidity           |Cardiac disease            |Conduction Block                          |0.28 (0.03-1.02) |0.00 (0.00-2.44) |1.06 (0.48-2.01)          |0.55 (0.35-0.83) |0.56 (0.15-1.43) |1.07 (0.74-1.50)                |2.08 (1.55-2.73) |2.26 (1.59-3.12)  |2.73 (2.34-3.16)              |
|Comorbidity           |Cardiac disease            |Myocardial infarction                     |0.43 (0.09-1.24) |0.00 (0.00-2.44) |0.00 (0.00-0.43)          |0.20 (0.09-0.39) |0.14 (0.00-0.77) |0.22 (0.09-0.45)                |0.79 (0.49-1.21) |0.87 (0.48-1.43)  |0.96 (0.75-1.22)              |
|Comorbidity           |Infection                  |Hospitalized infection                    |3.05 (1.89-4.66) |0.67 (0.02-3.71) |2.01 (1.17-3.21)          |5.36 (4.65-6.14) |6.14 (4.43-8.30) |4.75 (4.01-5.59)                |8.43 (7.26-9.73) |9.85 (8.33-11.58) |9.18 (8.43-9.97)              |
|Comorbidity           |Infection                  |Opportunistic infection                   |0.85 (0.31-1.85) |2.05 (0.42-5.99) |0.47 (0.13-1.20)          |1.54 (1.18-1.97) |2.26 (1.29-3.67) |1.01 (0.69-1.43)                |1.67 (1.21-2.25) |1.74 (1.16-2.50)  |1.98 (1.66-2.35)              |
|Comorbidity           |Kidney disease             |Amyloidosis                               |0.00 (0.00-0.52) |0.00 (0.00-2.44) |0.35 (0.07-1.02)          |0.02 (0.00-0.14) |0.00 (0.00-0.51) |0.00 (0.00-0.11)                |0.04 (0.00-0.20) |0.00 (0.00-0.21)  |0.06 (0.02-0.14)              |
|Comorbidity           |Kidney disease             |IgA nephropathy                           |0.14 (0.00-0.79) |0.00 (0.00-2.45) |0.12 (0.00-0.65)          |0.07 (0.02-0.22) |0.00 (0.00-0.51) |0.09 (0.02-0.27)                |0.11 (0.02-0.32) |0.11 (0.01-0.41)  |0.04 (0.01-0.12)              |
|Comorbidity           |Kidney disease             |Nephrotic syndrome                        |0.28 (0.03-1.02) |0.00 (0.00-2.44) |0.00 (0.00-0.43)          |0.05 (0.01-0.18) |0.14 (0.00-0.77) |0.03 (0.00-0.17)                |0.07 (0.01-0.27) |0.06 (0.00-0.32)  |0.04 (0.01-0.12)              |
|Comorbidity           |Lung disease               |Apical Pulmonary fibrosis                 |0.00 (0.00-0.52) |0.00 (0.00-2.44) |0.12 (0.00-0.65)          |0.00 (0.00-0.09) |0.00 (0.00-0.51) |0.00 (0.00-0.11)                |0.00 (0.00-0.14) |0.00 (0.00-0.21)  |0.00 (0.00-0.05)              |
|Comorbidity           |Lung disease               |Interstitial lung disease                 |0.00 (0.00-0.52) |0.00 (0.00-2.44) |0.00 (0.00-0.43)          |0.07 (0.02-0.22) |0.14 (0.00-0.77) |0.00 (0.00-0.12)                |0.45 (0.23-0.78) |0.52 (0.24-0.98)  |0.18 (0.10-0.31)              |
|Comorbidity           |Lung disease               |Restrictive lung disease                  |0.57 (0.16-1.46) |0.00 (0.00-2.44) |1.17 (0.56-2.15)          |0.60 (0.39-0.89) |0.57 (0.15-1.45) |0.66 (0.41-1.01)                |1.73 (1.26-2.33) |1.33 (0.83-2.02)  |1.80 (1.49-2.15)              |
|Comorbidity           |Neurological Disease       |Cauda Equina syndrome                     |0.00 (0.00-0.52) |0.00 (0.00-2.44) |0.12 (0.00-0.65)          |0.02 (0.00-0.14) |0.00 (0.00-0.51) |0.00 (0.00-0.12)                |0.04 (0.00-0.20) |0.06 (0.00-0.32)  |0.06 (0.02-0.14)              |
|Comorbidity           |Neurological Disease       |Spinal Cord compression                   |0.00 (0.00-0.52) |0.00 (0.00-2.44) |0.12 (0.00-0.65)          |0.25 (0.12-0.46) |0.14 (0.00-0.77) |0.28 (0.13-0.53)                |0.07 (0.01-0.27) |0.11 (0.01-0.41)  |0.18 (0.10-0.31)              |
|Comorbidity           |Osteoporotic fracture      |Clinical vertebral fracture               |0.57 (0.15-1.45) |0.00 (0.00-2.47) |0.70 (0.26-1.53)          |0.37 (0.21-0.62) |0.14 (0.00-0.78) |0.72 (0.46-1.09)                |1.63 (1.18-2.21) |1.95 (1.33-2.75)  |1.70 (1.41-2.04)              |
|Comorbidity           |Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |1.43 (0.69-2.63) |1.34 (0.16-4.82) |2.14 (1.27-3.38)          |1.16 (0.85-1.55) |0.99 (0.40-2.03) |1.01 (0.69-1.43)                |1.99 (1.48-2.62) |2.46 (1.75-3.36)  |2.20 (1.86-2.59)              |
|Disease manifestation |Inflammatory bowel disease |Crohn’s Disease                           |1.95 (1.04-3.33) |0.70 (0.02-3.88) |1.55 (0.82-2.65)          |1.69 (1.31-2.16) |1.46 (0.70-2.69) |1.41 (1.02-1.89)                |0.83 (0.52-1.27) |0.41 (0.17-0.85)  |0.59 (0.42-0.80)              |
|Disease manifestation |Inflammatory bowel disease |Ulcerative Colitis                        |0.73 (0.24-1.70) |0.00 (0.00-2.44) |0.94 (0.41-1.86)          |1.35 (1.01-1.77) |1.27 (0.58-2.41) |1.08 (0.75-1.51)                |1.03 (0.67-1.51) |0.71 (0.37-1.24)  |0.57 (0.41-0.77)              |
|Disease manifestation |PsO/PsA                    |Psoriasis                                 |1.89 (1.00-3.23) |0.67 (0.02-3.74) |0.94 (0.41-1.86)          |2.04 (1.61-2.54) |1.72 (0.89-3.01) |1.34 (0.97-1.81)                |1.26 (0.86-1.78) |0.80 (0.42-1.36)  |0.81 (0.61-1.05)              |
|Disease manifestation |PsO/PsA                    |Psoriatic arthritis                       |2.37 (1.36-3.86) |1.36 (0.16-4.91) |1.06 (0.49-2.02)          |2.16 (1.72-2.69) |2.62 (1.55-4.13) |1.09 (0.75-1.52)                |1.33 (0.91-1.86) |0.49 (0.21-0.97)  |0.59 (0.42-0.80)              |
|Disease manifestation |Uveitis                    |Uveitis                                   |2.61 (1.52-4.18) |3.71 (1.20-8.65) |4.27 (2.95-5.96)          |3.55 (2.96-4.21) |2.67 (1.58-4.22) |4.04 (3.35-4.83)                |1.61 (1.14-2.20) |0.92 (0.52-1.52)  |1.17 (0.92-1.45)              |


## TNF vs NSAID or no exposure


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
## Warning: Removed 2 rows containing missing values (geom_errorbar).
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
## Warning: Removed 2 rows containing missing values (geom_errorbar).
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
## Warning: Removed 3 rows containing missing values (geom_errorbar).
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
## Warning: Removed 3 rows containing missing values (geom_errorbar).
```


## **TNF** versus **NSAID or no exposure**

**MPCD**



**Marketscan**



**Medicare**



## **TNF** versus **DMARD**

**MPCD**



**Marketscan**



**Medicare**


