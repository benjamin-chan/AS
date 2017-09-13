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
