# ACR 2017 abstract

**Do TNF Inhibitors Reduce the Incidence of Cardiac, Pulmonary and Neurologic Comorbidities in Ankylosing Spondylitis? An Analysis of Three Large US Claims Databases.**
Atul Deodhar, Kevin Winthrop, Benjamin Chan, Sarah Siegel, Jeffery Stark, Robert Suruki, Rhonda Bohn, Huifeng Yun, Lang Chen, Jeffery Curtis

Build tables for Atul's 2017 ACR abstract.
Collects code chunks from `summarizePrevalence.Rmd` and `summarizeIncidence.Rmd`.


## Prevalence, unadjusted

Prevalence is **12-month (6-month baseline to 6-month follow-up)**.


|outcomeCategory            |disease                                   | MPCD TNF | MPCD DMARD | MPCD NSAID or no exposure | Marketscan TNF | Marketscan DMARD | Marketscan NSAID or no exposure | Medicare TNF | Medicare DMARD | Medicare NSAID or no exposure |
|:--------------------------|:-----------------------------------------|:--------:|:----------:|:-------------------------:|:--------------:|:----------------:|:-------------------------------:|:------------:|:--------------:|:-----------------------------:|
|Cancer                     |Hematologic Cancer                        |   0.3    |    0.2     |             0             |      0.1       |       0.8        |                0                |     0.4      |      1.6       |               0               |
|Cancer                     |Non Melanoma Skin Cancer                  |   0.0    |    0.0     |             0             |      0.5       |       0.5        |                0                |     1.2      |      1.3       |               0               |
|Cancer                     |Solid Cancer                              |   2.6    |    1.5     |             0             |      1.8       |       4.2        |                0                |     5.7      |      7.7       |               0               |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |   1.7    |    0.6     |             0             |      0.8       |       0.9        |                0                |     2.9      |      3.7       |               0               |
|Cardiac disease            |Conduction Block                          |   0.2    |    0.0     |             0             |      0.7       |       1.1        |                0                |     2.4      |      3.0       |               0               |
|Cardiac disease            |Myocardial infarction                     |   0.3    |    0.0     |             0             |      0.2       |       0.1        |                0                |     0.5      |      0.9       |               0               |
|Infection                  |Hospitalized infection                    |   1.0    |    1.2     |             0             |      3.5       |       4.8        |                0                |     9.1      |      13.8      |               0               |
|Infection                  |Opportunistic infection                   |   1.3    |    1.0     |             0             |      1.2       |       1.5        |                0                |     2.7      |      2.8       |               0               |
|Inflammatory bowel disease |Crohn’s Disease                           |   5.8    |    4.0     |             0             |      5.5       |       3.9        |                0                |     8.4      |      6.6       |               0               |
|Inflammatory bowel disease |Ulcerative Colitis                        |   3.0    |    2.3     |             0             |      3.6       |       2.6        |                0                |     3.9      |      3.6       |               0               |
|Kidney disease             |Amyloidosis                               |   0.0    |    0.0     |             0             |      0.0       |       0.0        |                0                |     0.1      |      0.0       |               0               |
|Kidney disease             |IgA nephropathy                           |   0.3    |    0.2     |             0             |      0.1       |       0.0        |                0                |     0.1      |      0.2       |               0               |
|Kidney disease             |Nephrotic syndrome                        |   0.2    |    0.2     |             0             |      0.1       |       0.0        |                0                |     0.2      |      0.2       |               0               |
|Lung disease               |Apical Pulmonary fibrosis                 |   0.0    |    0.0     |             0             |      0.0       |       0.0        |                0                |     0.0      |      0.0       |               0               |
|Lung disease               |Interstitial lung disease                 |   0.0    |    0.0     |             0             |      0.1       |       0.1        |                0                |     0.4      |      1.1       |               0               |
|Lung disease               |Restrictive lung disease                  |   0.7    |    0.4     |             0             |      0.9       |       0.7        |                0                |     2.4      |      3.4       |               0               |
|Neurological Disease       |Cauda Equina syndrome                     |   0.0    |    0.0     |             0             |      0.0       |       0.1        |                0                |     0.1      |      0.0       |               0               |
|Neurological Disease       |Spinal Cord compression                   |   0.2    |    0.0     |             0             |      0.2       |       0.2        |                0                |     0.3      |      0.4       |               0               |
|Osteoporotic fracture      |Clinical vertebral fracture               |   1.3    |    0.4     |             0             |      0.6       |       0.8        |                0                |     1.8      |      2.7       |               0               |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |   2.0    |    0.8     |             0             |      1.0       |       1.0        |                0                |     2.9      |      3.0       |               0               |
|PsO/PsA                    |Psoriasis                                 |   4.3    |    1.5     |             0             |      4.4       |       3.6        |                0                |     7.0      |      4.8       |               0               |
|PsO/PsA                    |Psoriatic arthritis                       |   6.5    |    5.4     |             0             |      7.1       |       6.4        |                0                |     10.5     |      8.1       |               0               |
|Uveitis                    |Uveitis                                   |   8.4    |    7.3     |             0             |      7.8       |       6.8        |                0                |     6.9      |      5.0       |               0               |


## Incidence, unadjusted



**TNF vs NSAID or no exposure**


```
## Error in list_or_dots(...): could not find function "compareIncidenceRates"
```

```
## Error in inc[is.na(inc)] <- 0: object 'inc' not found
```

```
## Error in eval(expr, envir, enclos): object 'inc' not found
```

\newline

**TNF vs DMARD**


```
## Error in list_or_dots(...): could not find function "compareIncidenceRates"
```

```
## Error in inc[is.na(inc)] <- 0: object 'inc' not found
```

```
## Error in eval(expr, envir, enclos): object 'inc' not found
```
