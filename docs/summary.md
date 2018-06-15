---
title: "Comorbidities and Disease Manifestations in Ankylosing Spondylitis (BAD AS)"
date: "2018-06-15 15:54:52"
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
|Marketscan |DMARD, NSAID, or no exposure |   3140|
|Marketscan |TNF                          |   2854|
|Medicare   |DMARD, NSAID, or no exposure |   2239|
|Medicare   |TNF                          |    702|
|MPCD       |DMARD, NSAID, or no exposure |    748|
|MPCD       |TNF                          |    539|

\newline



Table of **incidence per 100 person-years**


|type                  |outcomeCategory            |disease                                   |MPCD TNF         |MPCD DMARD, NSAID, or no exposure |Marketscan TNF   |Marketscan DMARD, NSAID, or no exposure |Medicare TNF     |Medicare DMARD, NSAID, or no exposure |
|:---------------------|:--------------------------|:-----------------------------------------|:----------------|:---------------------------------|:----------------|:---------------------------------------|:----------------|:-------------------------------------|
|Comorbidity           |Cancer                     |Hematologic Cancer                        |0.14 (0.00-0.79) |0.40 (0.11-1.02)                  |0.12 (0.04-0.29) |0.46 (0.27-0.73)                        |0.79 (0.49-1.20) |0.48 (0.34-0.64)                      |
|Comorbidity           |Cancer                     |Non Melanoma Skin Cancer                  |1.43 (0.69-2.63) |1.21 (0.62-2.11)                  |0.94 (0.66-1.29) |0.90 (0.62-1.25)                        |3.27 (2.59-4.06) |3.13 (2.76-3.54)                      |
|Comorbidity           |Cancer                     |Solid Cancer                              |1.45 (0.70-2.67) |3.43 (2.36-4.82)                  |1.36 (1.02-1.77) |2.38 (1.91-2.93)                        |3.33 (2.62-4.18) |5.22 (4.71-5.78)                      |
|Comorbidity           |Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |0.71 (0.23-1.65) |1.22 (0.63-2.13)                  |0.47 (0.28-0.73) |0.67 (0.44-0.98)                        |2.34 (1.77-3.04) |2.71 (2.36-3.10)                      |
|Comorbidity           |Cardiac disease            |Conduction Block                          |0.28 (0.03-1.02) |0.90 (0.41-1.72)                  |0.59 (0.38-0.88) |0.98 (0.69-1.34)                        |2.08 (1.55-2.72) |2.63 (2.29-3.00)                      |
|Comorbidity           |Cardiac disease            |Myocardial infarction                     |0.42 (0.09-1.24) |0.00 (0.00-0.37)                  |0.22 (0.10-0.42) |0.20 (0.09-0.40)                        |0.79 (0.49-1.21) |0.94 (0.75-1.17)                      |
|Comorbidity           |Infection                  |Hospitalized infection                    |3.04 (1.88-4.64) |1.82 (1.08-2.87)                  |5.41 (4.70-6.19) |5.00 (4.31-5.77)                        |8.42 (7.25-9.71) |9.29 (8.62-10.01)                     |
|Comorbidity           |Infection                  |Opportunistic infection                   |0.85 (0.31-1.85) |0.70 (0.28-1.45)                  |1.56 (1.20-2.00) |1.24 (0.91-1.64)                        |1.67 (1.21-2.25) |1.92 (1.64-2.24)                      |
|Comorbidity           |Kidney disease             |Amyloidosis                               |0.00 (0.00-0.52) |0.30 (0.06-0.87)                  |0.02 (0.00-0.14) |0.00 (0.00-0.09)                        |0.04 (0.00-0.20) |0.04 (0.01-0.11)                      |
|Comorbidity           |Kidney disease             |IgA nephropathy                           |0.14 (0.00-0.79) |0.10 (0.00-0.55)                  |0.07 (0.02-0.21) |0.08 (0.02-0.22)                        |0.11 (0.02-0.32) |0.06 (0.02-0.13)                      |
|Comorbidity           |Kidney disease             |Nephrotic syndrome                        |0.28 (0.03-1.02) |0.00 (0.00-0.37)                  |0.05 (0.01-0.18) |0.05 (0.01-0.18)                        |0.07 (0.01-0.27) |0.04 (0.01-0.11)                      |
|Comorbidity           |Lung disease               |Apical Pulmonary fibrosis                 |0.00 (0.00-0.52) |0.10 (0.00-0.55)                  |0.00 (0.00-0.09) |0.00 (0.00-0.09)                        |0.00 (0.00-0.14) |0.00 (0.00-0.04)                      |
|Comorbidity           |Lung disease               |Interstitial lung disease                 |0.00 (0.00-0.52) |0.00 (0.00-0.37)                  |0.07 (0.02-0.21) |0.03 (0.00-0.14)                        |0.45 (0.23-0.78) |0.25 (0.15-0.37)                      |
|Comorbidity           |Lung disease               |Restrictive lung disease                  |0.57 (0.16-1.46) |1.00 (0.48-1.84)                  |0.59 (0.38-0.88) |0.64 (0.42-0.95)                        |1.73 (1.26-2.33) |1.69 (1.43-2.00)                      |
|Comorbidity           |Neurological Disease       |Cauda Equina syndrome                     |0.00 (0.00-0.52) |0.10 (0.00-0.55)                  |0.02 (0.00-0.14) |0.00 (0.00-0.09)                        |0.04 (0.00-0.20) |0.06 (0.02-0.13)                      |
|Comorbidity           |Neurological Disease       |Spinal Cord compression                   |0.00 (0.00-0.52) |0.10 (0.00-0.55)                  |0.24 (0.12-0.45) |0.25 (0.12-0.47)                        |0.07 (0.01-0.27) |0.17 (0.09-0.28)                      |
|Comorbidity           |Osteoporotic fracture      |Clinical vertebral fracture               |0.71 (0.23-1.65) |0.60 (0.22-1.31)                  |0.37 (0.21-0.61) |0.62 (0.39-0.92)                        |1.63 (1.18-2.21) |1.75 (1.48-2.06)                      |
|Comorbidity           |Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |1.43 (0.68-2.62) |2.03 (1.24-3.14)                  |1.15 (0.84-1.53) |1.01 (0.72-1.37)                        |1.99 (1.47-2.62) |2.26 (1.95-2.61)                      |
|Disease manifestation |Inflammatory bowel disease |Crohn’s Disease                           |1.94 (1.03-3.32) |1.43 (0.78-2.40)                  |1.67 (1.29-2.13) |1.42 (1.06-1.85)                        |0.83 (0.51-1.27) |0.55 (0.41-0.73)                      |
|Disease manifestation |Inflammatory bowel disease |Ulcerative Colitis                        |0.73 (0.24-1.70) |0.81 (0.35-1.59)                  |1.38 (1.04-1.80) |1.11 (0.81-1.50)                        |1.03 (0.67-1.51) |0.60 (0.44-0.78)                      |
|Disease manifestation |PsO/PsA                    |Psoriasis                                 |1.88 (1.00-3.22) |0.91 (0.42-1.73)                  |2.06 (1.64-2.56) |1.41 (1.06-1.84)                        |1.26 (0.86-1.78) |0.80 (0.62-1.01)                      |
|Disease manifestation |PsO/PsA                    |Psoriatic arthritis                       |2.52 (1.47-4.04) |1.11 (0.56-1.99)                  |2.19 (1.75-2.71) |1.36 (1.02-1.78)                        |1.32 (0.91-1.86) |0.57 (0.42-0.75)                      |
|Disease manifestation |Uveitis                    |Uveitis                                   |2.60 (1.51-4.16) |4.22 (3.00-5.76)                  |3.58 (3.00-4.24) |3.78 (3.17-4.47)                        |1.61 (1.14-2.20) |1.12 (0.90-1.37)                      |


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


## **TNF** versus **DMARD, NSAID, or no exposure**

**MPCD**



**Marketscan**



**Medicare**


