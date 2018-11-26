---
title: "Comorbidities and Disease Manifestations in Ankylosing Spondylitis (BAD AS)"
date: "2018-11-26 13:52:00"
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
|1   |MPCD       |       2608|
|89  |Marketscan |       9575|
|177 |Medicare   |       9273|

Table of **prevalence %**


|outcomeCategory            |disease                                   |timeWindow                  |MPCD AS cohort |Marketscan AS cohort |Medicare AS cohort |
|:--------------------------|:-----------------------------------------|:---------------------------|:--------------|:--------------------|:------------------|
|Cancer                     |Hematologic Cancer                        |12 months                   |1.7 (1.2-2.2)  |0.4 (0.3-0.6)        |1.7 (1.4-1.9)      |
|Cancer                     |Hematologic Cancer                        |24 months                   |1.8 (1.4-2.4)  |0.6 (0.4-0.8)        |2.0 (1.8-2.3)      |
|Cancer                     |Hematologic Cancer                        |36 months                   |2.0 (1.5-2.5)  |0.7 (0.5-0.8)        |2.4 (2.1-2.7)      |
|Cancer                     |Hematologic Cancer                        |AS cohort entry to exposure |1.8 (1.3-2.4)  |0.4 (0.3-0.5)        |2.0 (1.7-2.3)      |
|Cancer                     |Non Melanoma Skin Cancer                  |12 months                   |0              |0.5 (0.4-0.7)        |1.9 (1.6-2.2)      |
|Cancer                     |Non Melanoma Skin Cancer                  |24 months                   |0              |1.1 (0.9-1.3)        |3.1 (2.8-3.5)      |
|Cancer                     |Non Melanoma Skin Cancer                  |36 months                   |0              |1.5 (1.3-1.8)        |4.2 (3.8-4.6)      |
|Cancer                     |Non Melanoma Skin Cancer                  |AS cohort entry to exposure |0              |0.6 (0.5-0.8)        |1.8 (1.6-2.1)      |
|Cancer                     |Solid Cancer                              |12 months                   |4.9 (4.1-5.7)  |2.8 (2.5-3.2)        |11.8 (11.2-12.5)   |
|Cancer                     |Solid Cancer                              |24 months                   |6.4 (5.5-7.4)  |3.7 (3.3-4.1)        |14.8 (14.1-15.6)   |
|Cancer                     |Solid Cancer                              |36 months                   |7.0 (6.0-8.0)  |4.1 (3.8-4.6)        |17.0 (16.2-17.7)   |
|Cancer                     |Solid Cancer                              |AS cohort entry to exposure |4.8 (4.1-5.7)  |2.9 (2.6-3.3)        |12.8 (12.2-13.5)   |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |12 months                   |2.8 (2.3-3.5)  |1.0 (0.8-1.3)        |6.1 (5.7-6.6)      |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |24 months                   |3.3 (2.6-4.0)  |1.4 (1.2-1.6)        |8.5 (8.0-9.1)      |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |36 months                   |3.6 (2.9-4.3)  |1.5 (1.3-1.8)        |10.4 (9.8-11.1)    |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |AS cohort entry to exposure |2.4 (1.8-3.0)  |1.0 (0.8-1.2)        |7.6 (7.0-8.1)      |
|Cardiac disease            |Conduction Block                          |12 months                   |1.7 (1.2-2.2)  |0.9 (0.7-1.1)        |3.8 (3.4-4.2)      |
|Cardiac disease            |Conduction Block                          |24 months                   |2.0 (1.5-2.5)  |1.3 (1.1-1.5)        |6.4 (6.0-7.0)      |
|Cardiac disease            |Conduction Block                          |36 months                   |2.1 (1.6-2.7)  |1.5 (1.3-1.8)        |8.2 (7.7-8.8)      |
|Cardiac disease            |Conduction Block                          |AS cohort entry to exposure |1.6 (1.1-2.1)  |0.8 (0.7-1.0)        |5.1 (4.6-5.5)      |
|Cardiac disease            |Myocardial infarction                     |12 months                   |0.1 (0.0-0.2)  |0.2 (0.1-0.3)        |1.0 (0.8-1.3)      |
|Cardiac disease            |Myocardial infarction                     |24 months                   |0.2 (0.1-0.4)  |0.3 (0.2-0.5)        |2.1 (1.9-2.5)      |
|Cardiac disease            |Myocardial infarction                     |36 months                   |0.3 (0.1-0.5)  |0.5 (0.3-0.6)        |3.0 (2.7-3.4)      |
|Cardiac disease            |Myocardial infarction                     |AS cohort entry to exposure |0.2 (0.1-0.4)  |0.2 (0.1-0.3)        |1.3 (1.1-1.5)      |
|Infection                  |Hospitalized infection                    |12 months                   |1.5 (1.0-2.0)  |3.0 (2.7-3.3)        |10.1 (9.5-10.8)    |
|Infection                  |Hospitalized infection                    |24 months                   |2.6 (2.1-3.3)  |4.8 (4.4-5.3)        |18.6 (17.8-19.4)   |
|Infection                  |Hospitalized infection                    |36 months                   |3.3 (2.7-4.1)  |5.8 (5.3-6.3)        |24.7 (23.8-25.6)   |
|Infection                  |Hospitalized infection                    |AS cohort entry to exposure |2.0 (1.5-2.5)  |3.5 (3.1-3.9)        |13.7 (13.0-14.5)   |
|Infection                  |Opportunistic infection                   |12 months                   |1.9 (1.4-2.5)  |1.0 (0.8-1.3)        |1.7 (1.4-2.0)      |
|Infection                  |Opportunistic infection                   |24 months                   |2.5 (1.9-3.1)  |1.4 (1.2-1.7)        |2.9 (2.6-3.3)      |
|Infection                  |Opportunistic infection                   |36 months                   |2.7 (2.1-3.4)  |1.8 (1.5-2.1)        |3.9 (3.5-4.3)      |
|Infection                  |Opportunistic infection                   |AS cohort entry to exposure |2.0 (1.5-2.6)  |0.9 (0.7-1.1)        |2.6 (2.3-3.0)      |
|Inflammatory bowel disease |Crohn’s Disease                           |12 months                   |5.0 (4.2-5.9)  |4.2 (3.9-4.7)        |2.1 (1.8-2.4)      |
|Inflammatory bowel disease |Crohn’s Disease                           |24 months                   |5.9 (5.0-6.8)  |5.0 (4.6-5.5)        |2.6 (2.2-2.9)      |
|Inflammatory bowel disease |Crohn’s Disease                           |36 months                   |6.3 (5.4-7.3)  |5.3 (4.9-5.8)        |2.8 (2.5-3.2)      |
|Inflammatory bowel disease |Crohn’s Disease                           |AS cohort entry to exposure |4.5 (3.7-5.3)  |4.1 (3.8-4.6)        |2.5 (2.2-2.8)      |
|Inflammatory bowel disease |Ulcerative Colitis                        |12 months                   |3.5 (2.8-4.2)  |3.2 (2.9-3.6)        |1.6 (1.4-1.9)      |
|Inflammatory bowel disease |Ulcerative Colitis                        |24 months                   |3.9 (3.2-4.7)  |3.9 (3.6-4.4)        |2.4 (2.1-2.7)      |
|Inflammatory bowel disease |Ulcerative Colitis                        |36 months                   |4.2 (3.5-5.0)  |4.1 (3.7-4.5)        |2.8 (2.5-3.2)      |
|Inflammatory bowel disease |Ulcerative Colitis                        |AS cohort entry to exposure |3.3 (2.7-4.0)  |3.1 (2.8-3.5)        |2.5 (2.2-2.8)      |
|Kidney disease             |Amyloidosis                               |12 months                   |0.8 (0.5-1.2)  |0.0 (0.0-0.1)        |0.0 (0.0-0.1)      |
|Kidney disease             |Amyloidosis                               |24 months                   |0.8 (0.5-1.3)  |0.0 (0.0-0.1)        |0.1 (0.0-0.2)      |
|Kidney disease             |Amyloidosis                               |36 months                   |0.9 (0.6-1.3)  |0.0 (0.0-0.1)        |0.1 (0.1-0.2)      |
|Kidney disease             |Amyloidosis                               |AS cohort entry to exposure |0.8 (0.5-1.2)  |0.0 (0.0-0.1)        |0.1 (0.0-0.1)      |
|Kidney disease             |IgA nephropathy                           |12 months                   |0.3 (0.1-0.5)  |0.1 (0.1-0.2)        |0.1 (0.0-0.1)      |
|Kidney disease             |IgA nephropathy                           |24 months                   |0.3 (0.1-0.6)  |0.1 (0.1-0.2)        |0.1 (0.1-0.2)      |
|Kidney disease             |IgA nephropathy                           |36 months                   |0.4 (0.2-0.7)  |0.2 (0.1-0.3)        |0.2 (0.2-0.4)      |
|Kidney disease             |IgA nephropathy                           |AS cohort entry to exposure |0.2 (0.1-0.5)  |0.1 (0.0-0.2)        |0.2 (0.1-0.2)      |
|Kidney disease             |Nephrotic syndrome                        |12 months                   |0.0 (0.0-0.2)  |0.0 (0.0-0.1)        |0.1 (0.1-0.2)      |
|Kidney disease             |Nephrotic syndrome                        |24 months                   |0.1 (0.0-0.2)  |0.0 (0.0-0.1)        |0.2 (0.1-0.2)      |
|Kidney disease             |Nephrotic syndrome                        |36 months                   |0.1 (0.0-0.2)  |0.1 (0.0-0.1)        |0.2 (0.1-0.3)      |
|Kidney disease             |Nephrotic syndrome                        |AS cohort entry to exposure |0.0 (0.0-0.1)  |0.0 (0.0-0.1)        |0.1 (0.1-0.2)      |
|Lung disease               |Apical Pulmonary fibrosis                 |12 months                   |0.2 (0.1-0.5)  |0                    |0.0 (0.0-0.1)      |
|Lung disease               |Apical Pulmonary fibrosis                 |24 months                   |0.3 (0.1-0.5)  |0                    |0.0 (0.0-0.1)      |
|Lung disease               |Apical Pulmonary fibrosis                 |36 months                   |0.3 (0.1-0.6)  |0                    |0.0 (0.0-0.1)      |
|Lung disease               |Apical Pulmonary fibrosis                 |AS cohort entry to exposure |0.1 (0.0-0.3)  |0                    |0.0 (0.0-0.1)      |
|Lung disease               |Interstitial lung disease                 |12 months                   |0.0 (0.0-0.1)  |0.1 (0.1-0.2)        |0.4 (0.3-0.6)      |
|Lung disease               |Interstitial lung disease                 |24 months                   |0.0 (0.0-0.2)  |0.1 (0.1-0.2)        |0.7 (0.5-0.9)      |
|Lung disease               |Interstitial lung disease                 |36 months                   |0.0 (0.0-0.2)  |0.2 (0.1-0.3)        |0.9 (0.7-1.1)      |
|Lung disease               |Interstitial lung disease                 |AS cohort entry to exposure |0.0 (0.0-0.1)  |0.1 (0.0-0.1)        |0.7 (0.6-0.9)      |
|Lung disease               |Restrictive lung disease                  |12 months                   |2.2 (1.7-2.8)  |0.9 (0.7-1.1)        |3.1 (2.8-3.5)      |
|Lung disease               |Restrictive lung disease                  |24 months                   |2.7 (2.1-3.4)  |1.4 (1.2-1.6)        |4.7 (4.3-5.2)      |
|Lung disease               |Restrictive lung disease                  |36 months                   |3.0 (2.4-3.7)  |1.6 (1.4-1.9)        |5.9 (5.4-6.4)      |
|Lung disease               |Restrictive lung disease                  |AS cohort entry to exposure |2.3 (1.8-2.9)  |0.8 (0.7-1.0)        |4.3 (3.9-4.8)      |
|Neurological Disease       |Cauda Equina syndrome                     |12 months                   |0.0 (0.0-0.2)  |0.0 (0.0-0.1)        |0.1 (0.0-0.1)      |
|Neurological Disease       |Cauda Equina syndrome                     |24 months                   |0.1 (0.0-0.2)  |0.1 (0.0-0.1)        |0.1 (0.1-0.2)      |
|Neurological Disease       |Cauda Equina syndrome                     |36 months                   |0.1 (0.0-0.2)  |0.1 (0.0-0.1)        |0.2 (0.1-0.3)      |
|Neurological Disease       |Cauda Equina syndrome                     |AS cohort entry to exposure |0.1 (0.0-0.2)  |0.0 (0.0-0.1)        |0.1 (0.1-0.2)      |
|Neurological Disease       |Spinal Cord compression                   |12 months                   |0.2 (0.1-0.4)  |0.1 (0.0-0.2)        |0.2 (0.1-0.3)      |
|Neurological Disease       |Spinal Cord compression                   |24 months                   |0.2 (0.1-0.5)  |0.2 (0.1-0.3)        |0.3 (0.2-0.4)      |
|Neurological Disease       |Spinal Cord compression                   |36 months                   |0.3 (0.1-0.5)  |0.3 (0.2-0.4)        |0.4 (0.3-0.5)      |
|Neurological Disease       |Spinal Cord compression                   |AS cohort entry to exposure |0.1 (0.0-0.3)  |0.1 (0.0-0.2)        |0.3 (0.2-0.4)      |
|Osteoporotic fracture      |Clinical vertebral fracture               |12 months                   |2.5 (2.0-3.2)  |0.7 (0.6-0.9)        |4.0 (3.6-4.4)      |
|Osteoporotic fracture      |Clinical vertebral fracture               |24 months                   |3.1 (2.5-3.9)  |1.1 (0.9-1.3)        |6.2 (5.8-6.8)      |
|Osteoporotic fracture      |Clinical vertebral fracture               |36 months                   |3.4 (2.7-4.1)  |1.3 (1.1-1.6)        |8.2 (7.7-8.8)      |
|Osteoporotic fracture      |Clinical vertebral fracture               |AS cohort entry to exposure |2.2 (1.7-2.8)  |0.8 (0.6-1.0)        |5.4 (4.9-5.8)      |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |12 months                   |3.0 (2.4-3.7)  |1.0 (0.8-1.2)        |4.2 (3.8-4.7)      |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |24 months                   |4.6 (3.8-5.4)  |1.9 (1.6-2.1)        |7.5 (7.0-8.0)      |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |36 months                   |5.2 (4.4-6.1)  |2.4 (2.1-2.7)        |10.0 (9.4-10.7)    |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |AS cohort entry to exposure |3.3 (2.6-4.0)  |1.4 (1.2-1.7)        |7.0 (6.5-7.5)      |
|PsO/PsA                    |Psoriasis                                 |12 months                   |3.0 (2.4-3.7)  |3.6 (3.2-3.9)        |3.3 (3.0-3.7)      |
|PsO/PsA                    |Psoriasis                                 |24 months                   |3.9 (3.2-4.7)  |4.6 (4.2-5.1)        |4.6 (4.1-5.0)      |
|PsO/PsA                    |Psoriasis                                 |36 months                   |4.4 (3.7-5.2)  |5.1 (4.7-5.6)        |5.3 (4.8-5.7)      |
|PsO/PsA                    |Psoriasis                                 |AS cohort entry to exposure |2.6 (2.0-3.3)  |3.1 (2.7-3.4)        |4.6 (4.2-5.1)      |
|PsO/PsA                    |Psoriatic arthritis                       |12 months                   |5.9 (5.1-6.9)  |5.3 (4.8-5.7)        |3.7 (3.3-4.1)      |
|PsO/PsA                    |Psoriatic arthritis                       |24 months                   |7.2 (6.3-8.2)  |6.6 (6.1-7.1)        |4.4 (4.0-4.9)      |
|PsO/PsA                    |Psoriatic arthritis                       |36 months                   |7.9 (6.9-9.0)  |7.2 (6.7-7.7)        |4.8 (4.3-5.2)      |
|PsO/PsA                    |Psoriatic arthritis                       |AS cohort entry to exposure |5.2 (4.4-6.1)  |4.2 (3.8-4.6)        |3.9 (3.5-4.3)      |
|Uveitis                    |Uveitis                                   |12 months                   |6.1 (5.2-7.1)  |6.3 (5.9-6.8)        |2.1 (1.8-2.4)      |
|Uveitis                    |Uveitis                                   |24 months                   |7.8 (6.8-8.9)  |7.9 (7.4-8.5)        |2.8 (2.5-3.1)      |
|Uveitis                    |Uveitis                                   |36 months                   |8.2 (7.2-9.3)  |8.6 (8.1-9.2)        |3.1 (2.7-3.4)      |
|Uveitis                    |Uveitis                                   |AS cohort entry to exposure |6.2 (5.3-7.1)  |6.6 (6.1-7.1)        |2.6 (2.3-3.0)      |


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
|Marketscan |DMARD, NSAID, or no exposure |   6242|
|Marketscan |TNF                          |   3378|
|Medicare   |DMARD, NSAID, or no exposure |   8045|
|Medicare   |TNF                          |    561|
|MPCD       |DMARD, NSAID, or no exposure |   1750|
|MPCD       |TNF                          |    728|

\newline



Table of **incidence per 100 person-years**


|type                  |outcomeCategory            |disease                                   |MPCD TNF         |MPCD DMARD, NSAID, or no exposure |Marketscan TNF   |Marketscan DMARD, NSAID, or no exposure |Medicare TNF     |Medicare DMARD, NSAID, or no exposure |
|:---------------------|:--------------------------|:-----------------------------------------|:----------------|:---------------------------------|:----------------|:---------------------------------------|:----------------|:-------------------------------------|
|Comorbidity           |Cancer                     |Hematologic Cancer                        |0.00 (0.00-0.42) |0.36 (0.16-0.71)                  |0.09 (0.02-0.23) |0.43 (0.29-0.62)                        |0.24 (0.08-0.57) |0.49 (0.41-0.57)                      |
|Comorbidity           |Cancer                     |Non Melanoma Skin Cancer                  |1.02 (0.47-1.95) |1.09 (0.70-1.62)                  |0.61 (0.40-0.88) |0.64 (0.47-0.86)                        |1.47 (0.99-2.12) |2.17 (2.00-2.36)                      |
|Comorbidity           |Cancer                     |Solid Cancer                              |0.92 (0.40-1.82) |3.82 (3.04-4.75)                  |1.10 (0.81-1.46) |2.32 (1.97-2.71)                        |2.14 (1.52-2.94) |4.17 (3.91-4.43)                      |
|Comorbidity           |Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |0.46 (0.12-1.17) |1.23 (0.81-1.79)                  |0.50 (0.31-0.75) |0.63 (0.46-0.85)                        |1.27 (0.81-1.89) |2.47 (2.28-2.66)                      |
|Comorbidity           |Cardiac disease            |Conduction Block                          |0.00 (0.00-0.42) |0.77 (0.45-1.23)                  |0.36 (0.21-0.59) |0.76 (0.57-0.99)                        |0.97 (0.59-1.52) |2.03 (1.86-2.21)                      |
|Comorbidity           |Cardiac disease            |Myocardial infarction                     |0.00 (0.00-0.42) |0.04 (0.00-0.25)                  |0.13 (0.05-0.29) |0.21 (0.12-0.35)                        |0.49 (0.24-0.90) |0.83 (0.73-0.95)                      |
|Comorbidity           |Infection                  |Hospitalized infection                    |1.84 (1.05-2.98) |3.05 (2.36-3.88)                  |4.12 (3.54-4.78) |4.11 (3.65-4.62)                        |6.11 (5.02-7.38) |7.97 (7.62-8.34)                      |
|Comorbidity           |Infection                  |Opportunistic infection                   |0.91 (0.39-1.79) |0.54 (0.28-0.95)                  |0.95 (0.68-1.28) |0.90 (0.69-1.15)                        |1.05 (0.65-1.60) |1.48 (1.34-1.63)                      |
|Comorbidity           |Kidney disease             |Amyloidosis                               |0.00 (0.00-0.42) |0.13 (0.03-0.39)                  |0.02 (0.00-0.12) |0.00 (0.00-0.05)                        |0.00 (0.00-0.18) |0.02 (0.01-0.05)                      |
|Comorbidity           |Kidney disease             |IgA nephropathy                           |0.23 (0.03-0.82) |0.04 (0.00-0.25)                  |0.07 (0.01-0.20) |0.06 (0.02-0.14)                        |0.05 (0.00-0.27) |0.04 (0.02-0.07)                      |
|Comorbidity           |Kidney disease             |Nephrotic syndrome                        |0.23 (0.03-0.82) |0.00 (0.00-0.17)                  |0.02 (0.00-0.12) |0.01 (0.00-0.08)                        |0.05 (0.00-0.27) |0.02 (0.01-0.05)                      |
|Comorbidity           |Lung disease               |Apical Pulmonary fibrosis                 |0.00 (0.00-0.42) |0.04 (0.00-0.25)                  |0.00 (0.00-0.08) |0.00 (0.00-0.05)                        |0.00 (0.00-0.18) |0.00 (0.00-0.01)                      |
|Comorbidity           |Lung disease               |Interstitial lung disease                 |0.00 (0.00-0.42) |0.00 (0.00-0.17)                  |0.02 (0.00-0.12) |0.06 (0.02-0.14)                        |0.15 (0.03-0.43) |0.14 (0.10-0.20)                      |
|Comorbidity           |Lung disease               |Restrictive lung disease                  |0.11 (0.00-0.63) |0.77 (0.45-1.23)                  |0.47 (0.29-0.72) |0.65 (0.47-0.86)                        |0.68 (0.36-1.16) |1.19 (1.06-1.33)                      |
|Comorbidity           |Neurological Disease       |Cauda Equina syndrome                     |0.00 (0.00-0.42) |0.04 (0.00-0.25)                  |0.02 (0.00-0.12) |0.03 (0.00-0.10)                        |0.00 (0.00-0.18) |0.03 (0.01-0.06)                      |
|Comorbidity           |Neurological Disease       |Spinal Cord compression                   |0.00 (0.00-0.42) |0.09 (0.01-0.32)                  |0.11 (0.04-0.26) |0.06 (0.02-0.14)                        |0.05 (0.00-0.27) |0.10 (0.07-0.15)                      |
|Comorbidity           |Osteoporotic fracture      |Clinical vertebral fracture               |0.57 (0.18-1.33) |1.23 (0.81-1.79)                  |0.31 (0.17-0.53) |0.66 (0.48-0.88)                        |1.03 (0.63-1.59) |1.75 (1.59-1.91)                      |
|Comorbidity           |Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |1.03 (0.47-1.96) |1.74 (1.23-2.38)                  |0.82 (0.57-1.13) |0.93 (0.72-1.19)                        |1.57 (1.06-2.24) |2.36 (2.18-2.56)                      |
|Disease manifestation |Inflammatory bowel disease |Crohn’s Disease                           |1.33 (0.66-2.37) |1.00 (0.63-1.52)                  |1.20 (0.89-1.58) |1.33 (1.07-1.63)                        |0.47 (0.21-0.89) |0.37 (0.30-0.45)                      |
|Disease manifestation |Inflammatory bowel disease |Ulcerative Colitis                        |0.58 (0.19-1.35) |0.95 (0.59-1.45)                  |1.06 (0.78-1.41) |1.32 (1.07-1.62)                        |0.57 (0.28-1.02) |0.50 (0.42-0.59)                      |
|Disease manifestation |PsO/PsA                    |Psoriasis                                 |2.02 (1.18-3.23) |1.19 (0.78-1.74)                  |2.03 (1.63-2.51) |1.18 (0.94-1.46)                        |0.95 (0.56-1.50) |0.78 (0.68-0.89)                      |
|Disease manifestation |PsO/PsA                    |Psoriatic arthritis                       |2.35 (1.41-3.67) |1.30 (0.86-1.87)                  |2.40 (1.95-2.92) |1.48 (1.21-1.80)                        |0.98 (0.58-1.55) |0.40 (0.33-0.48)                      |
|Disease manifestation |Uveitis                    |Uveitis                                   |2.34 (1.41-3.66) |2.38 (1.78-3.14)                  |2.63 (2.16-3.17) |2.56 (2.19-2.96)                        |0.82 (0.47-1.33) |0.42 (0.35-0.50)                      |


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
## Warning: Removed 4 rows containing missing values (geom_errorbar).
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
## Warning: Removed 4 rows containing missing values (geom_errorbar).
```


## **TNF** versus **DMARD, NSAID, or no exposure**

**MPCD**



**Marketscan**



**Medicare**


