---
title: "Comorbidities and Disease Manifestations in Ankylosing Spondylitis (BAD AS)"
date: "2018-06-25 14:55:42"
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
|1   |MPCD       |       2384|
|85  |Marketscan |       9032|
|173 |Medicare   |       9044|

Table of **prevalence %**


|outcomeCategory            |disease                                   |timeWindow                  |MPCD AS cohort |Marketscan AS cohort |Medicare AS cohort |
|:--------------------------|:-----------------------------------------|:---------------------------|:--------------|:--------------------|:------------------|
|Cancer                     |Hematologic Cancer                        |12 months                   |0.7 (0.4-1.1)  |0.5 (0.3-0.6)        |1.5 (1.3-1.8)      |
|Cancer                     |Hematologic Cancer                        |24 months                   |0.8 (0.5-1.3)  |0.6 (0.5-0.8)        |1.9 (1.6-2.2)      |
|Cancer                     |Hematologic Cancer                        |36 months                   |0.9 (0.6-1.4)  |0.7 (0.5-0.9)        |2.3 (2.0-2.6)      |
|Cancer                     |Hematologic Cancer                        |AS cohort entry to exposure |0.8 (0.5-1.3)  |0.4 (0.3-0.5)        |1.8 (1.6-2.1)      |
|Cancer                     |Non Melanoma Skin Cancer                  |12 months                   |0              |0.5 (0.4-0.7)        |1.8 (1.6-2.1)      |
|Cancer                     |Non Melanoma Skin Cancer                  |24 months                   |0              |1.1 (0.9-1.3)        |3.1 (2.8-3.5)      |
|Cancer                     |Non Melanoma Skin Cancer                  |36 months                   |0              |1.5 (1.2-1.7)        |4.1 (3.7-4.5)      |
|Cancer                     |Non Melanoma Skin Cancer                  |AS cohort entry to exposure |0              |0.6 (0.5-0.8)        |1.7 (1.5-2.0)      |
|Cancer                     |Solid Cancer                              |12 months                   |3.8 (3.1-4.6)  |2.9 (2.5-3.2)        |11.7 (11.1-12.4)   |
|Cancer                     |Solid Cancer                              |24 months                   |5.4 (4.6-6.4)  |3.8 (3.4-4.2)        |14.6 (13.9-15.4)   |
|Cancer                     |Solid Cancer                              |36 months                   |6.0 (5.1-7.1)  |4.3 (3.9-4.7)        |16.8 (16.1-17.6)   |
|Cancer                     |Solid Cancer                              |AS cohort entry to exposure |3.7 (3.0-4.6)  |3.0 (2.7-3.4)        |12.7 (12.0-13.4)   |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |12 months                   |1.8 (1.3-2.4)  |1.1 (0.9-1.3)        |6.2 (5.8-6.7)      |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |24 months                   |2.2 (1.7-2.8)  |1.4 (1.2-1.7)        |8.7 (8.1-9.3)      |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |36 months                   |2.5 (1.9-3.2)  |1.6 (1.3-1.9)        |10.6 (9.9-11.2)    |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |AS cohort entry to exposure |1.4 (1.0-1.9)  |1.1 (0.9-1.3)        |7.5 (7.0-8.1)      |
|Cardiac disease            |Conduction Block                          |12 months                   |0.6 (0.4-1.0)  |0.8 (0.6-1.0)        |3.8 (3.4-4.2)      |
|Cardiac disease            |Conduction Block                          |24 months                   |0.9 (0.6-1.4)  |1.3 (1.1-1.5)        |6.4 (5.9-6.9)      |
|Cardiac disease            |Conduction Block                          |36 months                   |1.0 (0.7-1.5)  |1.6 (1.3-1.8)        |8.3 (7.7-8.9)      |
|Cardiac disease            |Conduction Block                          |AS cohort entry to exposure |0.7 (0.4-1.1)  |0.8 (0.6-1.0)        |5.0 (4.5-5.4)      |
|Cardiac disease            |Myocardial infarction                     |12 months                   |0.0 (0.0-0.2)  |0.2 (0.1-0.3)        |1.0 (0.8-1.3)      |
|Cardiac disease            |Myocardial infarction                     |24 months                   |0.2 (0.1-0.4)  |0.3 (0.2-0.5)        |2.2 (1.9-2.5)      |
|Cardiac disease            |Myocardial infarction                     |36 months                   |0.3 (0.1-0.5)  |0.5 (0.3-0.6)        |3.0 (2.7-3.4)      |
|Cardiac disease            |Myocardial infarction                     |AS cohort entry to exposure |0.2 (0.1-0.5)  |0.2 (0.1-0.3)        |1.3 (1.1-1.5)      |
|Infection                  |Hospitalized infection                    |12 months                   |1.4 (1.0-1.9)  |3.0 (2.7-3.4)        |10.0 (9.3-10.6)    |
|Infection                  |Hospitalized infection                    |24 months                   |2.6 (2.0-3.3)  |5.0 (4.5-5.4)        |18.4 (17.6-19.2)   |
|Infection                  |Hospitalized infection                    |36 months                   |3.4 (2.7-4.1)  |6.0 (5.5-6.5)        |24.5 (23.6-25.4)   |
|Infection                  |Hospitalized infection                    |AS cohort entry to exposure |1.8 (1.3-2.4)  |3.7 (3.3-4.1)        |13.6 (12.9-14.3)   |
|Infection                  |Opportunistic infection                   |12 months                   |0.8 (0.5-1.3)  |1.0 (0.8-1.2)        |1.7 (1.4-2.0)      |
|Infection                  |Opportunistic infection                   |24 months                   |1.3 (0.9-1.9)  |1.4 (1.2-1.6)        |2.9 (2.6-3.3)      |
|Infection                  |Opportunistic infection                   |36 months                   |1.6 (1.1-2.2)  |1.7 (1.5-2.0)        |3.9 (3.5-4.3)      |
|Infection                  |Opportunistic infection                   |AS cohort entry to exposure |1.0 (0.7-1.5)  |0.8 (0.6-1.0)        |2.6 (2.3-3.0)      |
|Inflammatory bowel disease |Crohn’s Disease                           |12 months                   |3.3 (2.7-4.1)  |3.7 (3.3-4.1)        |1.9 (1.6-2.2)      |
|Inflammatory bowel disease |Crohn’s Disease                           |24 months                   |4.3 (3.6-5.2)  |4.5 (4.0-4.9)        |2.4 (2.1-2.7)      |
|Inflammatory bowel disease |Crohn’s Disease                           |36 months                   |4.8 (4.0-5.7)  |4.7 (4.3-5.2)        |2.6 (2.3-3.0)      |
|Inflammatory bowel disease |Crohn’s Disease                           |AS cohort entry to exposure |3.0 (2.4-3.7)  |3.5 (3.1-3.9)        |2.3 (2.0-2.6)      |
|Inflammatory bowel disease |Ulcerative Colitis                        |12 months                   |2.5 (1.9-3.2)  |2.9 (2.6-3.3)        |1.6 (1.3-1.8)      |
|Inflammatory bowel disease |Ulcerative Colitis                        |24 months                   |2.9 (2.2-3.6)  |3.5 (3.1-3.9)        |2.3 (2.0-2.6)      |
|Inflammatory bowel disease |Ulcerative Colitis                        |36 months                   |3.0 (2.4-3.8)  |3.7 (3.3-4.1)        |2.7 (2.4-3.1)      |
|Inflammatory bowel disease |Ulcerative Colitis                        |AS cohort entry to exposure |2.4 (1.8-3.1)  |2.7 (2.4-3.1)        |2.3 (2.0-2.7)      |
|Kidney disease             |Amyloidosis                               |12 months                   |0.1 (0.0-0.3)  |0.0 (0.0-0.1)        |0.0 (0.0-0.1)      |
|Kidney disease             |Amyloidosis                               |24 months                   |0.2 (0.1-0.4)  |0.1 (0.0-0.1)        |0.1 (0.0-0.2)      |
|Kidney disease             |Amyloidosis                               |36 months                   |0.2 (0.1-0.5)  |0.1 (0.0-0.1)        |0.1 (0.1-0.2)      |
|Kidney disease             |Amyloidosis                               |AS cohort entry to exposure |0.1 (0.0-0.3)  |0.0 (0.0-0.1)        |0.1 (0.0-0.1)      |
|Kidney disease             |IgA nephropathy                           |12 months                   |0.3 (0.1-0.5)  |0.1 (0.1-0.2)        |0.1 (0.0-0.2)      |
|Kidney disease             |IgA nephropathy                           |24 months                   |0.3 (0.1-0.6)  |0.1 (0.1-0.2)        |0.2 (0.1-0.3)      |
|Kidney disease             |IgA nephropathy                           |36 months                   |0.4 (0.2-0.7)  |0.2 (0.1-0.3)        |0.2 (0.2-0.4)      |
|Kidney disease             |IgA nephropathy                           |AS cohort entry to exposure |0.2 (0.1-0.4)  |0.1 (0.1-0.2)        |0.2 (0.1-0.3)      |
|Kidney disease             |Nephrotic syndrome                        |12 months                   |0.0 (0.0-0.2)  |0.0 (0.0-0.1)        |0.1 (0.1-0.2)      |
|Kidney disease             |Nephrotic syndrome                        |24 months                   |0.1 (0.0-0.3)  |0.0 (0.0-0.1)        |0.1 (0.1-0.2)      |
|Kidney disease             |Nephrotic syndrome                        |36 months                   |0.1 (0.0-0.3)  |0.1 (0.0-0.1)        |0.2 (0.1-0.3)      |
|Kidney disease             |Nephrotic syndrome                        |AS cohort entry to exposure |0.0 (0.0-0.1)  |0.0 (0.0-0.1)        |0.1 (0.1-0.2)      |
|Lung disease               |Apical Pulmonary fibrosis                 |12 months                   |0.0 (0.0-0.1)  |0                    |0.0 (0.0-0.1)      |
|Lung disease               |Apical Pulmonary fibrosis                 |24 months                   |0.0 (0.0-0.2)  |0                    |0.0 (0.0-0.1)      |
|Lung disease               |Apical Pulmonary fibrosis                 |36 months                   |0.0 (0.0-0.2)  |0                    |0.0 (0.0-0.1)      |
|Lung disease               |Apical Pulmonary fibrosis                 |AS cohort entry to exposure |0.0 (0.0-0.1)  |0                    |0.0 (0.0-0.1)      |
|Lung disease               |Interstitial lung disease                 |12 months                   |0              |0.1 (0.1-0.2)        |0.4 (0.3-0.6)      |
|Lung disease               |Interstitial lung disease                 |24 months                   |0              |0.1 (0.1-0.2)        |0.7 (0.6-0.9)      |
|Lung disease               |Interstitial lung disease                 |36 months                   |0              |0.2 (0.1-0.3)        |0.9 (0.7-1.1)      |
|Lung disease               |Interstitial lung disease                 |AS cohort entry to exposure |0              |0.0 (0.0-0.1)        |0.7 (0.5-0.8)      |
|Lung disease               |Restrictive lung disease                  |12 months                   |1.0 (0.7-1.5)  |0.9 (0.7-1.1)        |3.1 (2.7-3.5)      |
|Lung disease               |Restrictive lung disease                  |24 months                   |1.6 (1.1-2.2)  |1.4 (1.2-1.7)        |4.8 (4.4-5.2)      |
|Lung disease               |Restrictive lung disease                  |36 months                   |1.9 (1.4-2.5)  |1.6 (1.4-1.9)        |6.0 (5.5-6.5)      |
|Lung disease               |Restrictive lung disease                  |AS cohort entry to exposure |1.2 (0.8-1.7)  |0.9 (0.7-1.1)        |4.3 (3.9-4.7)      |
|Neurological Disease       |Cauda Equina syndrome                     |12 months                   |0.0 (0.0-0.2)  |0.0 (0.0-0.1)        |0.1 (0.0-0.2)      |
|Neurological Disease       |Cauda Equina syndrome                     |24 months                   |0.1 (0.0-0.3)  |0.1 (0.0-0.1)        |0.1 (0.1-0.2)      |
|Neurological Disease       |Cauda Equina syndrome                     |36 months                   |0.1 (0.0-0.3)  |0.1 (0.0-0.1)        |0.2 (0.1-0.3)      |
|Neurological Disease       |Cauda Equina syndrome                     |AS cohort entry to exposure |0.1 (0.0-0.3)  |0.0 (0.0-0.1)        |0.1 (0.1-0.2)      |
|Neurological Disease       |Spinal Cord compression                   |12 months                   |0.1 (0.0-0.3)  |0.1 (0.0-0.2)        |0.2 (0.1-0.3)      |
|Neurological Disease       |Spinal Cord compression                   |24 months                   |0.2 (0.1-0.5)  |0.2 (0.2-0.4)        |0.3 (0.2-0.4)      |
|Neurological Disease       |Spinal Cord compression                   |36 months                   |0.3 (0.1-0.5)  |0.3 (0.2-0.4)        |0.4 (0.3-0.5)      |
|Neurological Disease       |Spinal Cord compression                   |AS cohort entry to exposure |0.1 (0.0-0.3)  |0.1 (0.0-0.2)        |0.3 (0.2-0.5)      |
|Osteoporotic fracture      |Clinical vertebral fracture               |12 months                   |1.4 (1.0-2.0)  |0.7 (0.6-0.9)        |4.0 (3.6-4.4)      |
|Osteoporotic fracture      |Clinical vertebral fracture               |24 months                   |2.1 (1.6-2.7)  |1.2 (1.0-1.4)        |6.3 (5.8-6.8)      |
|Osteoporotic fracture      |Clinical vertebral fracture               |36 months                   |2.3 (1.7-2.9)  |1.4 (1.1-1.6)        |8.3 (7.7-8.9)      |
|Osteoporotic fracture      |Clinical vertebral fracture               |AS cohort entry to exposure |1.0 (0.7-1.5)  |0.8 (0.7-1.0)        |5.4 (4.9-5.8)      |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |12 months                   |1.8 (1.4-2.4)  |1.0 (0.8-1.2)        |4.2 (3.8-4.7)      |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |24 months                   |3.3 (2.6-4.0)  |1.8 (1.5-2.1)        |7.6 (7.0-8.1)      |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |36 months                   |3.7 (3.0-4.6)  |2.3 (2.0-2.6)        |10.0 (9.4-10.7)    |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |AS cohort entry to exposure |2.2 (1.7-2.8)  |1.5 (1.2-1.7)        |6.9 (6.3-7.4)      |
|PsO/PsA                    |Psoriasis                                 |12 months                   |2.7 (2.1-3.4)  |3.5 (3.1-3.9)        |3.3 (2.9-3.6)      |
|PsO/PsA                    |Psoriasis                                 |24 months                   |3.6 (2.9-4.4)  |4.6 (4.2-5.1)        |4.4 (4.0-4.8)      |
|PsO/PsA                    |Psoriasis                                 |36 months                   |4.2 (3.4-5.0)  |5.2 (4.7-5.6)        |5.1 (4.7-5.6)      |
|PsO/PsA                    |Psoriasis                                 |AS cohort entry to exposure |2.5 (1.9-3.2)  |2.9 (2.6-3.3)        |4.5 (4.1-4.9)      |
|PsO/PsA                    |Psoriatic arthritis                       |12 months                   |5.0 (4.2-6.0)  |5.3 (4.9-5.8)        |3.4 (3.1-3.8)      |
|PsO/PsA                    |Psoriatic arthritis                       |24 months                   |6.2 (5.3-7.2)  |6.7 (6.2-7.2)        |4.2 (3.8-4.7)      |
|PsO/PsA                    |Psoriatic arthritis                       |36 months                   |7.0 (6.0-8.0)  |7.3 (6.8-7.8)        |4.6 (4.2-5.0)      |
|PsO/PsA                    |Psoriatic arthritis                       |AS cohort entry to exposure |4.3 (3.6-5.2)  |4.1 (3.7-4.5)        |3.6 (3.2-4.0)      |
|Uveitis                    |Uveitis                                   |12 months                   |5.5 (4.7-6.5)  |6.4 (5.9-6.9)        |2.1 (1.9-2.5)      |
|Uveitis                    |Uveitis                                   |24 months                   |7.3 (6.3-8.4)  |7.9 (7.4-8.5)        |2.8 (2.5-3.1)      |
|Uveitis                    |Uveitis                                   |36 months                   |7.8 (6.8-9.0)  |8.7 (8.1-9.3)        |3.1 (2.8-3.5)      |
|Uveitis                    |Uveitis                                   |AS cohort entry to exposure |5.7 (4.8-6.7)  |6.7 (6.2-7.2)        |2.6 (2.3-2.9)      |


## By exposure

Read prevalence data.
See `queryPrevalentComorbidities.sas`.



Table of **prevalence %**


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


|database   |exposure                     | nPatid|
|:----------|:----------------------------|------:|
|Marketscan |DMARD, NSAID, or no exposure |   6307|
|Marketscan |TNF                          |   3922|
|Medicare   |DMARD, NSAID, or no exposure |   5191|
|Medicare   |TNF                          |   1110|
|MPCD       |DMARD, NSAID, or no exposure |   1765|
|MPCD       |TNF                          |    840|

\newline



Table of **incidence per 100 person-years**


|type                  |outcomeCategory            |disease                                   |MPCD TNF         |MPCD DMARD, NSAID, or no exposure |Marketscan TNF   |Marketscan DMARD, NSAID, or no exposure |Medicare TNF      |Medicare DMARD, NSAID, or no exposure |
|:---------------------|:--------------------------|:-----------------------------------------|:----------------|:---------------------------------|:----------------|:---------------------------------------|:-----------------|:-------------------------------------|
|Comorbidity           |Cancer                     |Hematologic Cancer                        |0.09 (0.00-0.50) |0.41 (0.20-0.76)                  |0.16 (0.07-0.31) |0.49 (0.35-0.66)                        |0.58 (0.37-0.86)  |0.46 (0.36-0.57)                      |
|Comorbidity           |Cancer                     |Non Melanoma Skin Cancer                  |1.46 (0.83-2.37) |1.38 (0.95-1.94)                  |0.84 (0.61-1.11) |0.96 (0.76-1.20)                        |3.13 (2.60-3.74)  |2.89 (2.63-3.17)                      |
|Comorbidity           |Cancer                     |Solid Cancer                              |1.10 (0.57-1.92) |3.87 (3.11-4.76)                  |1.37 (1.07-1.72) |2.52 (2.19-2.90)                        |3.08 (2.53-3.71)  |4.58 (4.24-4.95)                      |
|Comorbidity           |Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |0.45 (0.15-1.06) |1.17 (0.78-1.70)                  |0.51 (0.34-0.74) |0.82 (0.63-1.04)                        |2.27 (1.81-2.80)  |2.91 (2.64-3.19)                      |
|Comorbidity           |Cardiac disease            |Conduction Block                          |0.18 (0.02-0.65) |0.79 (0.47-1.23)                  |0.49 (0.32-0.71) |1.00 (0.80-1.24)                        |2.22 (1.78-2.75)  |2.54 (2.30-2.81)                      |
|Comorbidity           |Cardiac disease            |Myocardial infarction                     |0.27 (0.06-0.79) |0.04 (0.00-0.23)                  |0.22 (0.11-0.38) |0.24 (0.15-0.37)                        |0.83 (0.57-1.16)  |0.98 (0.84-1.14)                      |
|Comorbidity           |Infection                  |Hospitalized infection                    |2.84 (1.93-4.03) |3.45 (2.74-4.28)                  |5.38 (4.77-6.05) |5.68 (5.17-6.23)                        |9.93 (8.90-11.06) |11.48 (10.93-12.06)                   |
|Comorbidity           |Infection                  |Opportunistic infection                   |0.63 (0.25-1.30) |0.29 (0.12-0.59)                  |1.16 (0.90-1.49) |0.56 (0.41-0.74)                        |1.05 (0.76-1.42)  |0.48 (0.38-0.60)                      |
|Comorbidity           |Kidney disease             |Amyloidosis                               |0.00 (0.00-0.33) |0.12 (0.03-0.36)                  |0.04 (0.00-0.13) |0.01 (0.00-0.07)                        |0.02 (0.00-0.13)  |0.01 (0.00-0.03)                      |
|Comorbidity           |Kidney disease             |IgA nephropathy                           |0.18 (0.02-0.65) |0.04 (0.00-0.23)                  |0.05 (0.01-0.16) |0.05 (0.01-0.12)                        |0.12 (0.04-0.28)  |0.05 (0.02-0.10)                      |
|Comorbidity           |Kidney disease             |Nephrotic syndrome                        |0.18 (0.02-0.65) |0.00 (0.00-0.15)                  |0.04 (0.00-0.13) |0.04 (0.01-0.11)                        |0.05 (0.01-0.17)  |0.02 (0.01-0.06)                      |
|Comorbidity           |Lung disease               |Apical Pulmonary fibrosis                 |0.00 (0.00-0.33) |0.04 (0.00-0.23)                  |0.00 (0.00-0.07) |0.00 (0.00-0.04)                        |0.00 (0.00-0.09)  |0.00 (0.00-0.02)                      |
|Comorbidity           |Lung disease               |Interstitial lung disease                 |0.00 (0.00-0.33) |0.00 (0.00-0.15)                  |0.07 (0.02-0.18) |0.07 (0.03-0.16)                        |0.50 (0.31-0.77)  |0.20 (0.14-0.28)                      |
|Comorbidity           |Lung disease               |Restrictive lung disease                  |0.45 (0.15-1.06) |0.87 (0.54-1.33)                  |0.69 (0.49-0.95) |0.72 (0.55-0.93)                        |1.71 (1.33-2.17)  |1.51 (1.32-1.71)                      |
|Comorbidity           |Neurological Disease       |Cauda Equina syndrome                     |0.00 (0.00-0.33) |0.04 (0.00-0.23)                  |0.02 (0.00-0.10) |0.02 (0.00-0.09)                        |0.02 (0.00-0.13)  |0.05 (0.02-0.09)                      |
|Comorbidity           |Neurological Disease       |Spinal Cord compression                   |0.00 (0.00-0.33) |0.08 (0.01-0.30)                  |0.22 (0.11-0.38) |0.14 (0.07-0.25)                        |0.09 (0.03-0.24)  |0.13 (0.08-0.19)                      |
|Comorbidity           |Osteoporotic fracture      |Clinical vertebral fracture               |0.54 (0.20-1.18) |1.12 (0.74-1.64)                  |0.43 (0.28-0.65) |0.75 (0.58-0.97)                        |2.00 (1.58-2.49)  |2.44 (2.20-2.70)                      |
|Comorbidity           |Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |1.27 (0.69-2.13) |1.85 (1.34-2.48)                  |1.14 (0.87-1.46) |1.05 (0.84-1.30)                        |2.28 (1.83-2.82)  |3.16 (2.89-3.46)                      |
|Disease manifestation |Inflammatory bowel disease |Crohn’s Disease                           |1.71 (1.01-2.70) |1.09 (0.71-1.59)                  |1.58 (1.26-1.96) |1.11 (0.89-1.37)                        |0.69 (0.45-1.00)  |0.40 (0.31-0.50)                      |
|Disease manifestation |Inflammatory bowel disease |Ulcerative Colitis                        |0.74 (0.32-1.46) |0.87 (0.54-1.33)                  |1.31 (1.02-1.65) |1.29 (1.06-1.56)                        |0.86 (0.60-1.21)  |0.47 (0.37-0.59)                      |
|Disease manifestation |PsO/PsA                    |Psoriasis                                 |2.07 (1.30-3.13) |1.13 (0.75-1.65)                  |2.39 (1.99-2.84) |1.40 (1.15-1.68)                        |1.46 (1.10-1.89)  |0.94 (0.79-1.10)                      |
|Disease manifestation |PsO/PsA                    |Psoriatic arthritis                       |2.96 (2.00-4.22) |1.40 (0.97-1.97)                  |2.79 (2.35-3.29) |1.71 (1.43-2.02)                        |1.36 (1.01-1.79)  |0.45 (0.35-0.56)                      |
|Disease manifestation |Uveitis                    |Uveitis                                   |2.44 (1.58-3.60) |2.55 (1.94-3.28)                  |3.24 (2.77-3.78) |2.60 (2.26-2.98)                        |1.26 (0.93-1.67)  |0.47 (0.37-0.59)                      |


## TNF vs DMARD, NSAID, or no exposure


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
## Warning: Removed 2 rows containing missing values (geom_errorbar).
```


## **TNF** versus **DMARD, NSAID, or no exposure**

**MPCD**



**Marketscan**



**Medicare**


