# Propensity score

November 27, 2017


## Description of model

See [`modelPropensityScore.sas`](../scripts/modelPropensityScore.sas) script for details on model.

The propensity of exposure to the three treatments: TNF, DMARD, and NSAID or no exposure, was modeled using a multinomial logistic regression model (SAS `proc logistic`).
The link function used was a generalized logit.
TNF exposure was used as the reference exposure.

Included independent variables:

Variable name | Description
--------------|------------
age | Categorized; <19, 19-29, 30-39, 40-49, 50-59, 60-69, 70+
sex | Male, Female
indAmyloidosis | Amyloidosis (any prior to exposure)
indAortInsuffRegurg | Aortic Insufficiency/Aortic Regurgitation (any prior to exposure)
indApicalPulmFib | Apical Pulmonary fibrosis (any prior to exposure)
indCaudaEquina | Cauda Equina syndrome (any prior to exposure)
indVertFrac | Clinical vertebral fracture (any prior to exposure)
indConductBlock | Conduction Block (any prior to exposure)
indCrohnsDis | Crohn’s Disease (any prior to exposure)
indHematCa | Hematologic Cancer (any prior to exposure)
indHospInf | Hospitalized infection (any prior to exposure)
indIgANeph | IgA nephropathy (any prior to exposure)
indInterstLungDis | Interstitial lung disease (any prior to exposure)
indMI | Myocardial infarction (any prior to exposure)
indNephSyn | Nephrotic syndrome (any prior to exposure)
indNMSC | Non Melanoma Skin Cancer (any prior to exposure)
indNonVertOsFrac | Non-vertebral osteoporotic fracture (any prior to exposure)
indOppInf | Opportunistic infection (any prior to exposure)
indPsoriasis | Psoriasis (any prior to exposure)
indPSA | Psoriatic arthritis (any prior to exposure)
indRestrictLungDis | Restrictive lung disease (any prior to exposure)
indSolidCa | Solid Cancer (any prior to exposure)
indSpinalCordComp | Spinal Cord compression (any prior to exposure)
indUlcerColitis | Ulcerative Colitis (any prior to exposure)
indUveitis | Uveitis (any prior to exposure)
indDiabetes | Diabetes
indHT | Hypertention
indMetabSyn | Metabolic syndrome
indNAFattyLiverDis | Non-alcoholic fatty liver disease

Model output is probability of exposure to TNF, DMARD, and NSAID or no exposure.
For our purposes, we focus only on the propensity for TNF exposure.

Model estimation was performed separately for the 3 data sources: MPCD, Marketscan, and Medicare.
Independent variables were excluded from model estimation if they led to unstable estimates when included in data source-specific models.
This can occur if the covariate is so rare that zero records with this covariate appear in the model estimation cohort.

The common support region lower bound is the maximum of the lowest TNF propensity score among the 3 exposure groups.
The common support region upper bound is the minimum of the greatest TNF propensity score among the 3 exposure groups.

To check covariate balance, subjects are partitioned into deciles defined by the TNF propensity score, regardless of true exposure.
Model covariates are plotted on the y-axis in relation to TNF propensity decile on the x-axis.
Comparisons are made between exposure groups to check for balance.

Inverse probability treatment weight (IPTW) for TNF exposure was calculated as

$$
IPTW_\text{TNF} = \frac{I_\text{TNF}}{\hat{p}_\text{TNF}} + \frac{1 - I_\text{TNF}}{1 - \hat{p}_\text{TNF}}
$$

where $I_\text{TNF}$ is a 0/1 indicator for TNF exposure.

Stabilized IPTW are calculated as described in
Austin, P. C., and Stuart, E. A. (2015) Moving towards best practice when
using inverse probability of treatment weighting (IPTW) using the propensity
score to estimate causal treatment effects in observational studies. Statist.
Med., 34: 3661–3679. 
doi: [10.1002/sim.6607](http://onlinelibrary.wiley.com/doi/10.1002/sim.6607/abstract).


## Import data sets

Read deidentified propensity score data.
Data was created by [`modelPropensityScore.sas`](../scripts/modelPropensityScore.sas).

* Image files saved as [PNG](../figures/densityPS.png), [SVG](../figures/densityPS.svg)

![Densities propensity scores.png](../figures/densityPS.png)



\newline


|indCommonSupport |model            |exposure             |     n| minPS| maxPS| minIPTW| maxIPTW|
|:----------------|:----------------|:--------------------|-----:|-----:|-----:|-------:|-------:|
|FALSE            |3-level exposure |TNF                  |     7| 0.841| 0.960|   1.041|   1.189|
|FALSE            |3-level exposure |DMARD                |     2| 0.018| 0.018|   1.018|   1.018|
|FALSE            |3-level exposure |NSAID or no exposure |    24| 0.010| 0.883|   1.010|   8.512|
|TRUE             |3-level exposure |TNF                  | 12979| 0.022| 0.840|   1.190|  45.123|
|TRUE             |3-level exposure |DMARD                |  7717| 0.022| 0.840|   1.023|   6.265|
|TRUE             |3-level exposure |NSAID or no exposure | 39280| 0.022| 0.781|   1.023|   4.567|
|NA               |3-level exposure |TNF                  |     1|    NA|    NA|      NA|      NA|

\newline


|model            | commonSupportLowerBound| commonSupportUpperBound|
|:----------------|-----------------------:|-----------------------:|
|3-level exposure |               0.0221618|               0.8403839|




## Covariate balance

Include only episodes with propensity scores in the common support region.



**Propensity of TNF.**
Create propensity score deciles.


|model            |exposure             | psDecile|    n|  min|  max|
|:----------------|:--------------------|--------:|----:|----:|----:|
|3-level exposure |TNF                  |        1|  314| 0.02| 0.06|
|3-level exposure |TNF                  |        2|  397| 0.06| 0.09|
|3-level exposure |TNF                  |        3|  709| 0.09| 0.13|
|3-level exposure |TNF                  |        4|  960| 0.13| 0.17|
|3-level exposure |TNF                  |        5|  989| 0.17| 0.20|
|3-level exposure |TNF                  |        6| 1363| 0.20| 0.25|
|3-level exposure |TNF                  |        7| 1837| 0.25| 0.29|
|3-level exposure |TNF                  |        8| 1668| 0.29| 0.32|
|3-level exposure |TNF                  |        9| 2002| 0.32| 0.35|
|3-level exposure |TNF                  |       10| 2740| 0.35| 0.84|
|3-level exposure |DMARD                |        1|  543| 0.02| 0.06|
|3-level exposure |DMARD                |        2|  780| 0.06| 0.09|
|3-level exposure |DMARD                |        3|  705| 0.09| 0.13|
|3-level exposure |DMARD                |        4|  995| 0.13| 0.17|
|3-level exposure |DMARD                |        5|  768| 0.17| 0.20|
|3-level exposure |DMARD                |        6|  852| 0.20| 0.25|
|3-level exposure |DMARD                |        7|  851| 0.25| 0.29|
|3-level exposure |DMARD                |        8|  639| 0.29| 0.32|
|3-level exposure |DMARD                |        9|  643| 0.32| 0.35|
|3-level exposure |DMARD                |       10|  941| 0.35| 0.84|
|3-level exposure |NSAID or no exposure |        1| 5252| 0.02| 0.06|
|3-level exposure |NSAID or no exposure |        2| 4711| 0.06| 0.09|
|3-level exposure |NSAID or no exposure |        3| 4636| 0.09| 0.13|
|3-level exposure |NSAID or no exposure |        4| 4711| 0.13| 0.17|
|3-level exposure |NSAID or no exposure |        5| 3529| 0.17| 0.20|
|3-level exposure |NSAID or no exposure |        6| 3817| 0.20| 0.25|
|3-level exposure |NSAID or no exposure |        7| 3959| 0.25| 0.29|
|3-level exposure |NSAID or no exposure |        8| 3022| 0.29| 0.32|
|3-level exposure |NSAID or no exposure |        9| 3327| 0.32| 0.35|
|3-level exposure |NSAID or no exposure |       10| 2316| 0.35| 0.78|

\newline


### Demographic characteristics

![covarBalGender.png](../figures/covarBalGender.png)



![covarBalAge.png](../figures/covarBalAge.png)




### Other covariates

![covarBalDiabetes.png](../figures/covarBalDiabetes.png)



![covarBalHT.png](../figures/covarBalHT.png)



![covarBalMetabSyn.png](../figures/covarBalMetabSyn.png)



![covarBalNAFattyLiverDis.png](../figures/covarBalNAFattyLiverDis.png)




### Comorbidities

![covarBalHematCa.png](../figures/covarBalHematCa.png)



![covarBalNMSC.png](../figures/covarBalNMSC.png)



![covarBalSolidCa.png](../figures/covarBalSolidCa.png)



![covarBalAortInsuffRegurg.png](../figures/covarBalAortInsuffRegurg.png)



![covarBalConductBlock.png](../figures/covarBalConductBlock.png)



![covarBalMI.png](../figures/covarBalMI.png)



![covarBalHospInf.png](../figures/covarBalHospInf.png)



![covarBalOppInf.png](../figures/covarBalOppInf.png)



![covarBalAmyloidosis.png](../figures/covarBalAmyloidosis.png)



![covarBalIgANeph.png](../figures/covarBalIgANeph.png)



![covarBalNephSyn.png](../figures/covarBalNephSyn.png)



![covarBalApicalPulmFib.png](../figures/covarBalApicalPulmFib.png)



![covarBalInterstLungDis.png](../figures/covarBalInterstLungDis.png)



![covarBalRestrictLungDis.png](../figures/covarBalRestrictLungDis.png)



![covarBalCaudaEquina.png](../figures/covarBalCaudaEquina.png)



![covarBalSpinalCordComp.png](../figures/covarBalSpinalCordComp.png)



![covarBalVertFrac.png](../figures/covarBalVertFrac.png)



![covarBalNonVertOsFrac.png](../figures/covarBalNonVertOsFrac.png)




### Extra-articular manifestations (EAMs)

![covarBalCrohnsDis.png](../figures/covarBalCrohnsDis.png)



![covarBalUlcerColitis.png](../figures/covarBalUlcerColitis.png)



![covarBalPsoriasis.png](../figures/covarBalPsoriasis.png)



![covarBalPSA.png](../figures/covarBalPSA.png)



![covarBalUveitis.png](../figures/covarBalUveitis.png)


