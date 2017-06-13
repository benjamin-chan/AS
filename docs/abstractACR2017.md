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
|Cancer                     |Hematologic Cancer                        |12-month (6-month baseline to 6-month follow-up) |      0.3|        0.2|                       0.5|            0.3|              1.0|                             0.8|          1.0|            2.1|                           2.3|
|Cancer                     |Non Melanoma Skin Cancer                  |12-month (6-month baseline to 6-month follow-up) |      0.0|        0.0|                       0.0|            1.4|              1.7|                             1.8|          2.1|            2.3|                           3.7|
|Cancer                     |Solid Cancer                              |12-month (6-month baseline to 6-month follow-up) |      2.7|        1.5|                       4.4|            2.5|              5.2|                             5.3|          7.5|           10.1|                          13.5|
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |12-month (6-month baseline to 6-month follow-up) |      1.8|        1.0|                       1.9|            1.4|              1.9|                             2.3|          4.5|            6.2|                           7.9|
|Cardiac disease            |Conduction Block                          |12-month (6-month baseline to 6-month follow-up) |      0.2|        0.0|                       1.0|            1.2|              1.8|                             2.3|          3.7|            4.9|                           7.5|
|Cardiac disease            |Myocardial infarction                     |12-month (6-month baseline to 6-month follow-up) |      0.3|        0.0|                       0.5|            0.2|              0.1|                             0.7|          0.5|            0.9|                           1.7|
|Inflammatory bowel disease |Crohn’s Disease                           |12-month (6-month baseline to 6-month follow-up) |      5.9|        4.0|                       3.4|            6.1|              4.1|                             3.1|          8.9|            7.0|                           4.4|
|Inflammatory bowel disease |Ulcerative Colitis                        |12-month (6-month baseline to 6-month follow-up) |      3.1|        2.5|                       1.9|            4.3|              3.3|                             2.5|          4.8|            4.6|                           2.8|
|Kidney disease             |Amyloidosis                               |12-month (6-month baseline to 6-month follow-up) |      0.0|        0.0|                       0.0|            0.0|              0.0|                             0.0|          0.1|            0.1|                           0.1|
|Kidney disease             |IgA nephropathy                           |12-month (6-month baseline to 6-month follow-up) |      0.3|        0.2|                       0.1|            0.2|              0.1|                             0.1|          0.3|            0.3|                           0.3|
|Kidney disease             |Nephrotic syndrome                        |12-month (6-month baseline to 6-month follow-up) |      0.2|        0.2|                       0.0|            0.1|              0.0|                             0.0|          0.2|            0.3|                           0.2|
|Lung disease               |Apical Pulmonary fibrosis                 |12-month (6-month baseline to 6-month follow-up) |      0.0|        0.0|                       0.0|            0.0|              0.0|                             0.0|          0.0|            0.1|                           0.0|
|Lung disease               |Interstitial lung disease                 |12-month (6-month baseline to 6-month follow-up) |      0.0|        0.0|                       0.1|            0.1|              0.1|                             0.1|          0.1|            0.4|                           0.1|
|Lung disease               |Restrictive lung disease                  |12-month (6-month baseline to 6-month follow-up) |      0.7|        0.4|                       1.7|            2.3|              3.1|                             3.6|          7.3|           10.5|                          10.7|
|Neurological Disease       |Cauda Equina syndrome                     |12-month (6-month baseline to 6-month follow-up) |      0.0|        0.0|                       0.2|            0.0|              0.1|                             0.1|          0.1|            0.0|                           0.2|
|Neurological Disease       |Spinal Cord compression                   |12-month (6-month baseline to 6-month follow-up) |      0.2|        0.0|                       0.3|            0.3|              0.5|                             0.6|          0.6|            0.8|                           1.5|
|PsO/PsA                    |Psoriasis                                 |12-month (6-month baseline to 6-month follow-up) |      4.3|        1.5|                       1.9|            4.8|              3.8|                             2.2|          7.5|            5.3|                           3.4|
|PsO/PsA                    |Psoriatic arthritis                       |12-month (6-month baseline to 6-month follow-up) |      6.5|        5.4|                       2.4|            8.1|              7.3|                             2.9|         11.7|            9.2|                           3.5|
|Uveitis                    |Uveitis                                   |12-month (6-month baseline to 6-month follow-up) |      8.4|        7.3|                       6.2|           10.3|              9.0|                             9.8|          9.5|            6.5|                           5.0|


## Incidence


|outcomeCategory            |disease                                   | MPCD TNF| MPCD NSAID or no exposure|MPCD p-value | Marketscan TNF| Marketscan NSAID or no exposure|Marketscan p-value | Medicare TNF| Medicare NSAID or no exposure|Medicare p-value |
|:--------------------------|:-----------------------------------------|--------:|-------------------------:|:------------|--------------:|-------------------------------:|:------------------|------------:|-----------------------------:|:----------------|
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |      1.3|                       1.9|NS           |            1.2|                             2.1|<0.001             |          3.2|                           6.0|<0.001           |
|Cardiac disease            |Conduction Block                          |      0.3|                       0.9|0.028        |            1.1|                             2.4|<0.001             |          2.9|                           5.9|<0.001           |
|Cardiac disease            |Myocardial infarction                     |      0.3|                       0.6|NS           |            0.2|                             0.6|<0.001             |          0.7|                           1.5|<0.001           |
|Inflammatory bowel disease |Crohn.s Disease                           |      4.7|                       3.0|0.006        |            4.8|                             2.6|<0.001             |          3.9|                           2.5|<0.001           |
|Inflammatory bowel disease |Ulcerative Colitis                        |      2.5|                       1.6|0.050        |            3.1|                             2.1|<0.001             |          2.4|                           1.8|<0.001           |
|Lung disease               |Restrictive lung disease                  |      0.9|                       2.0|0.008        |            1.9|                             3.2|<0.001             |          5.9|                           8.7|<0.001           |
|Neurological Disease       |Spinal Cord compression                   |      0.1|                       0.3|NS           |            0.3|                             0.5|0.013              |          0.4|                           0.8|<0.001           |
|PsO/PsA                    |Psoriasis                                 |      3.5|                       1.6|<0.001       |            3.8|                             1.8|<0.001             |          3.8|                           2.1|<0.001           |
|Uveitis                    |Uveitis                                   |      5.0|                       4.9|NS           |            7.6|                             8.0|NS                 |          5.0|                           3.0|<0.001           |



|outcomeCategory            |disease                                   | MPCD TNF| MPCD DMARD|MPCD p-value | Marketscan TNF| Marketscan DMARD|Marketscan p-value | Medicare TNF| Medicare DMARD|Medicare p-value |
|:--------------------------|:-----------------------------------------|--------:|----------:|:------------|--------------:|----------------:|:------------------|------------:|--------------:|:----------------|
|Cardiac disease            |Aortic Insufficiency/Aortic Regurgitation |      1.3|        0.5|NS           |            1.2|              1.5|NS                 |          3.2|            4.7|<0.001           |
|Cardiac disease            |Conduction Block                          |      0.3|        0.0|NS           |            1.1|              1.4|NS                 |          2.9|            4.2|<0.001           |
|Cardiac disease            |Myocardial infarction                     |      0.3|        0.0|NS           |            0.2|              0.3|NS                 |          0.7|            1.2|<0.001           |
|Inflammatory bowel disease |Crohn.s Disease                           |      4.7|        3.6|NS           |            4.8|              4.1|NS                 |          3.9|            3.7|NS               |
|Inflammatory bowel disease |Ulcerative Colitis                        |      2.5|        0.9|0.041        |            3.1|              3.2|NS                 |          2.4|            2.6|NS               |
|Lung disease               |Restrictive lung disease                  |      0.9|        0.0|0.029        |            1.9|              2.4|NS                 |          5.9|            7.7|<0.001           |
|Neurological Disease       |Spinal Cord compression                   |      0.1|        0.0|NS           |            0.3|              0.4|NS                 |          0.4|            0.5|NS               |
|PsO/PsA                    |Psoriasis                                 |      3.5|        1.0|0.003        |            3.8|              3.3|NS                 |          3.8|            3.4|NS               |
|Uveitis                    |Uveitis                                   |      5.0|        6.5|NS           |            7.6|              8.6|NS                 |          5.0|            3.8|<0.001           |
