# ACR 2017 abstract

**Do TNF Inhibitors Reduce the Incidence of Cardiac, Pulmonary and Neurologic Comorbidities in Ankylosing Spondylitis? An Analysis of Three Large US Claims Databases.**
Atul Deodhar, Kevin Winthrop, Benjamin Chan, Sarah Siegel, Jeffery Stark, Robert Suruki, Rhonda Bohn, Huifeng Yun, Lang Chen, Jeffery Curtis

Build tables for Atul's 2017 ACR abstract.
Collects code chunks from `summarizePrevalence.Rmd` and `summarizeIncidence.Rmd`.


## Prevalence, unadjusted

Prevalence is **12-month (6-month baseline to 6-month follow-up)**.


|outcomeCategory            |disease                                   | MPCD TNF | MPCD DMARD | MPCD NSAID or no exposure | Marketscan TNF | Marketscan DMARD | Marketscan NSAID or no exposure | Medicare TNF | Medicare DMARD | Medicare NSAID or no exposure |
|:--------------------------|:-----------------------------------------|:--------:|:----------:|:-------------------------:|:--------------:|:----------------:|:-------------------------------:|:------------:|:--------------:|:-----------------------------:|
|Cancer                     |Hematologic Cancer                        |   0.3    |    0.2     |            0.4            |      0.2       |       0.6        |               0.5               |     0.8      |      2.0       |              2.1              |
|Cancer                     |Non Melanoma Skin Cancer                  |   0.0    |    0.0     |            0.0            |      0.2       |       0.1        |               0.2               |     0.9      |      0.9       |              1.5              |
|Cancer                     |Solid Cancer                              |   2.1    |    1.5     |            3.5            |      0.8       |       2.9        |               2.5               |     6.6      |      9.0       |             12.1              |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |   1.8    |    1.0     |            1.5            |      0.5       |       0.6        |               0.7               |     2.5      |      3.4       |              4.5              |
|Cardiac disease            |Conduction Block                          |   0.2    |    0.0     |            0.7            |      0.5       |       0.9        |               0.9               |     2.2      |      2.8       |              4.5              |
|Cardiac disease            |Myocardial infarction                     |   0.0    |    0.0     |            0.0            |      0.2       |       0.1        |               0.6               |     0.3      |      0.6       |              1.0              |
|Infection                  |Hospitalized infection                    |   0.1    |    0.0     |            0.2            |      2.9       |       3.5        |               5.6               |     7.2      |      11.2      |             15.4              |
|Infection                  |Opportunistic infection                   |   1.3    |    1.0     |            0.8            |      0.7       |       0.8        |               0.5               |     3.3      |      3.1       |              2.1              |
|Inflammatory bowel disease |Crohn’s Disease                           |   5.8    |    3.7     |            3.1            |      3.7       |       2.7        |               1.9               |     8.4      |      6.4       |              4.0              |
|Inflammatory bowel disease |Ulcerative Colitis                        |   2.9    |    2.5     |            1.6            |      2.2       |       1.5        |               1.1               |     4.2      |      3.8       |              2.3              |
|Kidney disease             |Amyloidosis                               |   0.0    |    0.0     |            0.0            |      0.0       |       0.0        |               0.0               |     0.1      |      0.0       |              0.1              |
|Kidney disease             |IgA nephropathy                           |   0.3    |    0.2     |            0.1            |      0.1       |       0.1        |               0.0               |     0.2      |      0.3       |              0.2              |
|Kidney disease             |Nephrotic syndrome                        |   0.0    |    0.0     |            0.0            |      0.0       |       0.0        |               0.0               |     0.2      |      0.3       |              0.2              |
|Lung disease               |Apical Pulmonary fibrosis                 |   0.0    |    0.0     |            0.0            |      0.0       |       0.0        |               0.0               |     0.0      |      0.1       |              0.0              |
|Lung disease               |Interstitial lung disease                 |   0.0    |    0.0     |            0.0            |      0.1       |       0.0        |               0.1               |     0.3      |      0.8       |              0.4              |
|Lung disease               |Restrictive lung disease                  |   0.7    |    0.4     |            1.2            |      0.7       |       0.8        |               1.0               |     6.5      |      9.4       |              9.7              |
|Neurological Disease       |Cauda Equina syndrome                     |   0.0    |    0.0     |            0.1            |      0.0       |       0.1        |               0.0               |     0.1      |      0.0       |              0.2              |
|Neurological Disease       |Spinal Cord compression                   |   0.2    |    0.0     |            0.3            |      0.1       |       0.2        |               0.2               |     0.5      |      0.7       |              1.2              |
|Osteoporotic fracture      |Clinical vertebral fracture               |   1.3    |    0.2     |            2.2            |      0.4       |       0.9        |               2.1               |     3.0      |      4.0       |              8.1              |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |   1.8    |    0.6     |            2.8            |      1.0       |       0.9        |               1.9               |     3.4      |      3.4       |              5.1              |
|PsO/PsA                    |Psoriasis                                 |   4.1    |    1.2     |            1.8            |      0.8       |       0.9        |               0.5               |     5.0      |      3.5       |              1.8              |
|PsO/PsA                    |Psoriatic arthritis                       |   6.4    |    5.4     |            2.2            |      2.2       |       2.1        |               0.6               |     11.0     |      8.5       |              3.2              |
|Uveitis                    |Uveitis                                   |   7.2    |    5.8     |            5.2            |      1.9       |       1.5        |               1.6               |     8.0      |      5.3       |              4.1              |


## Incidence, unadjusted



**TNF vs NSAID or no exposure**


|outcomeCategory            |disease                                   | MPCD TNF | MPCD NSAID or no exposure | MPCD p-value | Marketscan TNF | Marketscan NSAID or no exposure | Marketscan p-value | Medicare TNF | Medicare NSAID or no exposure | Medicare p-value |
|:--------------------------|:-----------------------------------------|:--------:|:-------------------------:|:------------:|:--------------:|:-------------------------------:|:------------------:|:------------:|:-----------------------------:|:----------------:|
|Cancer                     |Hematologic Cancer                        |   0.2    |            0.4            |      NS      |      0.2       |               0.5               |       0.005        |     0.6      |              1.3              |      <0.001      |
|Cancer                     |Non Melanoma Skin Cancer                  |   0.0    |            0.0            |      NS      |      0.3       |               0.2               |         NS         |     1.0      |              1.6              |      <0.001      |
|Cancer                     |Solid Cancer                              |   1.8    |            3.7            |    <0.001    |      0.9       |               2.7               |       <0.001       |     4.0      |              8.0              |      <0.001      |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |   1.3    |            1.6            |      NS      |      0.6       |               0.8               |         NS         |     1.9      |              3.4              |      <0.001      |
|Cardiac disease            |Conduction Block                          |   0.3    |            0.6            |      NS      |      0.5       |               0.9               |       0.002        |     2.0      |              3.8              |      <0.001      |
|Cardiac disease            |Myocardial infarction                     |   0.0    |            0.0            |      NS      |      0.2       |               0.6               |       <0.001       |     0.4      |              0.9              |      <0.001      |
|Infection                  |Hospitalized infection                    |   0.1    |            0.2            |      NS      |      2.6       |               5.4               |       <0.001       |     7.1      |             12.7              |      <0.001      |
|Infection                  |Opportunistic infection                   |   0.9    |            0.5            |      NS      |      0.3       |               0.3               |         NS         |     1.8      |              1.7              |        NS        |
|Inflammatory bowel disease |Crohn.s Disease                           |   4.6    |            2.6            |    <0.001    |      2.8       |               1.4               |       <0.001       |     3.6      |              2.3              |      <0.001      |
|Inflammatory bowel disease |Ulcerative Colitis                        |   2.5    |            1.3            |    0.006     |      1.5       |               0.8               |       <0.001       |     2.2      |              1.5              |      <0.001      |
|Kidney disease             |Amyloidosis                               |   0.0    |            0.0            |      NS      |      0.0       |               0.0               |         NS         |     0.1      |              0.1              |        NS        |
|Kidney disease             |IgA nephropathy                           |   0.2    |            0.1            |      NS      |      0.0       |               0.0               |         NS         |     0.2      |              0.2              |        NS        |
|Kidney disease             |Nephrotic syndrome                        |   0.0    |            0.0            |      NS      |      0.0       |               0.0               |         NS         |     0.2      |              0.1              |        NS        |
|Lung disease               |Apical Pulmonary fibrosis                 |   0.0    |            0.0            |      NS      |      0.0       |               0.0               |         NS         |     0.0      |              0.0              |        NS        |
|Lung disease               |Interstitial lung disease                 |   0.0    |            0.0            |      NS      |      0.0       |               0.1               |         NS         |     0.3      |              0.3              |        NS        |
|Lung disease               |Restrictive lung disease                  |   0.9    |            1.5            |      NS      |      0.6       |               0.9               |       0.017        |     5.3      |              7.8              |      <0.001      |
|Neurological Disease       |Cauda Equina syndrome                     |   0.0    |            0.1            |      NS      |      0.0       |               0.0               |         NS         |     0.1      |              0.1              |        NS        |
|Neurological Disease       |Spinal Cord compression                   |   0.1    |            0.3            |      NS      |      0.1       |               0.1               |         NS         |     0.4      |              0.7              |      <0.001      |
|Osteoporotic fracture      |Clinical vertebral fracture               |   0.9    |            1.5            |      NS      |      0.4       |               1.8               |       <0.001       |     2.3      |              4.6              |      <0.001      |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |   1.0    |            2.8            |    <0.001    |      1.2       |               1.6               |       0.021        |     2.9      |              3.9              |      <0.001      |
|PsO/PsA                    |Psoriasis                                 |   3.4    |            1.5            |    <0.001    |      0.8       |               0.4               |       <0.001       |     2.5      |              1.1              |      <0.001      |
|PsO/PsA                    |Psoriatic arthritis                       |   5.1    |            1.6            |    <0.001    |      1.7       |               0.5               |       <0.001       |     5.0      |              1.7              |      <0.001      |
|Uveitis                    |Uveitis                                   |   4.4    |            3.9            |      NS      |      0.9       |               0.8               |         NS         |     4.1      |              2.5              |      <0.001      |

\newline

**TNF vs DMARD**


|outcomeCategory            |disease                                   | MPCD TNF | MPCD DMARD | MPCD p-value | Marketscan TNF | Marketscan DMARD | Marketscan p-value | Medicare TNF | Medicare DMARD | Medicare p-value |
|:--------------------------|:-----------------------------------------|:--------:|:----------:|:------------:|:--------------:|:----------------:|:------------------:|:------------:|:--------------:|:----------------:|
|Cancer                     |Hematologic Cancer                        |   0.2    |    0.2     |      NS      |      0.2       |       0.4        |         NS         |     0.6      |      1.3       |      <0.001      |
|Cancer                     |Non Melanoma Skin Cancer                  |   0.0    |    0.0     |      NS      |      0.3       |       0.3        |         NS         |     1.0      |      1.3       |      0.037       |
|Cancer                     |Solid Cancer                              |   1.8    |    1.9     |      NS      |      0.9       |       2.7        |       <0.001       |     4.0      |      6.5       |      <0.001      |
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |   1.3    |    0.5     |      NS      |      0.6       |       0.5        |         NS         |     1.9      |      2.5       |      0.003       |
|Cardiac disease            |Conduction Block                          |   0.3    |    0.0     |      NS      |      0.5       |       0.5        |         NS         |     2.0      |      2.6       |      0.004       |
|Cardiac disease            |Myocardial infarction                     |   0.0    |    0.0     |      NS      |      0.2       |       0.2        |         NS         |     0.4      |      0.7       |      0.002       |
|Infection                  |Hospitalized infection                    |   0.1    |    0.0     |      NS      |      2.6       |       3.3        |         NS         |     7.1      |      9.2       |      <0.001      |
|Infection                  |Opportunistic infection                   |   0.9    |    1.2     |      NS      |      0.3       |       0.7        |       0.044        |     1.8      |      2.1       |        NS        |
|Inflammatory bowel disease |Crohn.s Disease                           |   4.6    |    3.1     |      NS      |      2.8       |       2.4        |         NS         |     3.6      |      3.4       |        NS        |
|Inflammatory bowel disease |Ulcerative Colitis                        |   2.5    |    0.7     |    0.018     |      1.5       |       1.4        |         NS         |     2.2      |      2.2       |        NS        |
|Kidney disease             |Amyloidosis                               |   0.0    |    0.0     |      NS      |      0.0       |       0.0        |         NS         |     0.1      |      0.0       |        NS        |
|Kidney disease             |IgA nephropathy                           |   0.2    |    0.0     |      NS      |      0.0       |       0.1        |         NS         |     0.2      |      0.1       |      0.038       |
|Kidney disease             |Nephrotic syndrome                        |   0.0    |    0.0     |      NS      |      0.0       |       0.1        |         NS         |     0.2      |      0.1       |        NS        |
|Lung disease               |Apical Pulmonary fibrosis                 |   0.0    |    0.0     |      NS      |      0.0       |       0.0        |         NS         |     0.0      |      0.0       |        NS        |
|Lung disease               |Interstitial lung disease                 |   0.0    |    0.0     |      NS      |      0.0       |       0.1        |         NS         |     0.3      |      0.7       |      <0.001      |
|Lung disease               |Restrictive lung disease                  |   0.9    |    0.0     |    0.029     |      0.6       |       0.6        |         NS         |     5.3      |      6.9       |      <0.001      |
|Neurological Disease       |Cauda Equina syndrome                     |   0.0    |    0.0     |      NS      |      0.0       |       0.1        |         NS         |     0.1      |      0.1       |        NS        |
|Neurological Disease       |Spinal Cord compression                   |   0.1    |    0.0     |      NS      |      0.1       |       0.2        |         NS         |     0.4      |      0.4       |        NS        |
|Osteoporotic fracture      |Clinical vertebral fracture               |   0.9    |    0.2     |      NS      |      0.4       |       0.6        |         NS         |     2.3      |      3.1       |      <0.001      |
|Osteoporotic fracture      |Non-vertebral osteoporotic fracture       |   1.0    |    0.7     |      NS      |      1.2       |       1.1        |         NS         |     2.9      |      3.5       |      0.011       |
|PsO/PsA                    |Psoriasis                                 |   3.4    |    1.0     |    0.005     |      0.8       |       0.6        |         NS         |     2.5      |      2.0       |      0.011       |
|PsO/PsA                    |Psoriatic arthritis                       |   5.1    |    5.1     |      NS      |      1.7       |       1.9        |         NS         |     5.0      |      4.3       |      0.014       |
|Uveitis                    |Uveitis                                   |   4.4    |    5.2     |      NS      |      0.9       |       1.2        |         NS         |     4.1      |      3.1       |      <0.001      |
