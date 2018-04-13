# Propensity score

April 13, 2018


## Description of model

See [`modelPropensityScore.sas`](../scripts/modelPropensityScore.sas) script for details on model.

The propensity of exposure to the three treatments: TNF, DMARD, and NSAID or no exposure, was modeled using a multinomial logistic regression model (SAS `proc logistic`).
The link function used was a generalized logit.
TNF exposure was used as the reference exposure.

Included independent variables:

Variable name | Description
--------------|------------
age | Categorized: <19, 19-29, 30-39, 40-49, 50-59, 60-69, 70+
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
indCOPDEmphysema | COPD or emphysema
meanPredEqDoseCat | Categorized: None, Low (<2.5 mg/d), Medium-Low (2.5-5 mg/d), Medium-High (5-10 mg/d), High (10+ mg/d)
quartileCharlson | Charlson comorbidity index: quartiles within data source
indInflamMarker | 1+ Sedimentation rate, erythrocyte or C-reactive protein CPT code
indRxNSAID | Prescription drug indicator: NSAID
indRxHtn | Prescription drug indicator: Antihypertensive
indRxNarcotics | Prescription drug indicator: Narcotic
indRxFungus | Prescription drug indicator: Antifungal
indRxOP_bisphosp | Prescription drug indicator: Bisphosphonate
indRxThiazide | Prescription drug indicator: Thiazide
indRxAnticoagulant | Prescription drug indicator: Anticoagulant
indIPAdmit12mPrior | Inpatient admission 12 months prior to exposure
indERVisit12mPrior | ER visit 12 months prior to exposure
countAVRheum12mPrior | Number of rheumatologist visits 12 months prior
indRxBiologics | Prescription drug indicator: Biologics, 7-12 months prior

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
Balance is indicated if the plots overlap.
Systematic deviations of the lines indicate residual imbalance not accounted for by the propensity scores.
Variables that exhibit such deviations should be considered for inclusion as a covariate in the outcomes models.

Inverse probability treatment weight (IPTW) for TNF exposure was calculated as

$$
IPTW_\text{TNF} = \frac{I_\text{TNF}}{\hat{p}_\text{TNF}} + \frac{1 - I_\text{TNF}}{1 - \hat{p}_\text{TNF}}
$$

where $I_\text{TNF}$ is a 0/1 indicator for TNF exposure.

IPTW will be **low** if

* True exposure was TNF **and** propensity for TNF was high, or
* True exposure was not TNF **and** propensity for TNF was low

I.e., individuals are weighted higher if the true exposure is contrary to the propensity.

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


|indCommonSupport |database   |exposure             |     n| minPS| maxPS| minIPTW| maxIPTW|
|:----------------|:----------|:--------------------|-----:|-----:|-----:|-------:|-------:|
|FALSE            |MPCD       |TNF                  |    37| 0.025| 0.985|   1.016|  40.058|
|FALSE            |MPCD       |NSAID or no exposure |   284| 0.004| 0.923|   1.004|  12.917|
|FALSE            |Marketscan |TNF                  |     7| 0.012| 0.968|   1.033|  84.942|
|FALSE            |Marketscan |NSAID or no exposure |    90| 0.002| 0.945|   1.002|  18.192|
|FALSE            |Medicare   |TNF                  |     8| 0.895| 0.941|   1.063|   1.117|
|FALSE            |Medicare   |DMARD                |     2| 0.008| 0.008|   1.008|   1.008|
|FALSE            |Medicare   |NSAID or no exposure |   268| 0.003| 0.906|   1.003|  10.678|
|TRUE             |MPCD       |TNF                  |  1241| 0.041| 0.914|   1.095|  24.638|
|TRUE             |MPCD       |DMARD                |   481| 0.034| 0.917|   1.036|  11.981|
|TRUE             |MPCD       |NSAID or no exposure |  2309| 0.034| 0.911|   1.036|  11.282|
|TRUE             |Marketscan |TNF                  |  5772| 0.024| 0.942|   1.061|  42.087|
|TRUE             |Marketscan |DMARD                |  2045| 0.015| 0.943|   1.015|  17.562|
|TRUE             |Marketscan |NSAID or no exposure | 10499| 0.015| 0.938|   1.015|  16.214|
|TRUE             |Medicare   |TNF                  |  5921| 0.009| 0.893|   1.120| 107.107|
|TRUE             |Medicare   |DMARD                |  5191| 0.011| 0.893|   1.011|   9.341|
|TRUE             |Medicare   |NSAID or no exposure | 25854| 0.009| 0.892|   1.009|   9.287|
|NA               |MPCD       |TNF                  |     1|    NA|    NA|      NA|      NA|

\newline


|database   | commonSupportLowerBound| commonSupportUpperBound|
|:----------|-----------------------:|-----------------------:|
|MPCD       |               0.0343086|               0.9165376|
|Marketscan |               0.0151504|               0.9430575|
|Medicare   |               0.0093365|               0.8929503|

Create propensity score deciles cutpoints.






## Covariate balance

Include only episodes with propensity scores in the common support region.



**Propensity of TNF.**
Create propensity score deciles.


|database   |exposure             | psDecile|     n|  min|  max|
|:----------|:--------------------|--------:|-----:|----:|----:|
|MPCD       |TNF                  |        1|   125| 0.04| 0.18|
|MPCD       |TNF                  |        2|   124| 0.18| 0.24|
|MPCD       |TNF                  |        3|   124| 0.24| 0.29|
|MPCD       |TNF                  |        4|   124| 0.29| 0.35|
|MPCD       |TNF                  |        5|   124| 0.35| 0.42|
|MPCD       |TNF                  |        6|   124| 0.42| 0.48|
|MPCD       |TNF                  |        7|   124| 0.49| 0.58|
|MPCD       |TNF                  |        8|   124| 0.58| 0.66|
|MPCD       |TNF                  |        9|   124| 0.66| 0.77|
|MPCD       |TNF                  |       10|   124| 0.77| 0.91|
|MPCD       |DMARD                |        1|    91| 0.03| 0.18|
|MPCD       |DMARD                |        2|    69| 0.18| 0.23|
|MPCD       |DMARD                |        3|    60| 0.24| 0.29|
|MPCD       |DMARD                |        4|    60| 0.30| 0.35|
|MPCD       |DMARD                |        5|    61| 0.35| 0.42|
|MPCD       |DMARD                |        6|    45| 0.42| 0.48|
|MPCD       |DMARD                |        7|    38| 0.49| 0.58|
|MPCD       |DMARD                |        8|    26| 0.58| 0.65|
|MPCD       |DMARD                |        9|    19| 0.66| 0.76|
|MPCD       |DMARD                |       10|    12| 0.77| 0.92|
|MPCD       |NSAID or no exposure |        1|  1048| 0.03| 0.18|
|MPCD       |NSAID or no exposure |        2|   416| 0.18| 0.24|
|MPCD       |NSAID or no exposure |        3|   267| 0.24| 0.29|
|MPCD       |NSAID or no exposure |        4|   165| 0.29| 0.35|
|MPCD       |NSAID or no exposure |        5|   138| 0.35| 0.42|
|MPCD       |NSAID or no exposure |        6|    97| 0.42| 0.48|
|MPCD       |NSAID or no exposure |        7|    74| 0.49| 0.58|
|MPCD       |NSAID or no exposure |        8|    43| 0.58| 0.65|
|MPCD       |NSAID or no exposure |        9|    37| 0.66| 0.76|
|MPCD       |NSAID or no exposure |       10|    24| 0.77| 0.91|
|Marketscan |TNF                  |        1|   578| 0.02| 0.19|
|Marketscan |TNF                  |        2|   577| 0.19| 0.24|
|Marketscan |TNF                  |        3|   577| 0.24| 0.28|
|Marketscan |TNF                  |        4|   577| 0.28| 0.33|
|Marketscan |TNF                  |        5|   577| 0.33| 0.39|
|Marketscan |TNF                  |        6|   577| 0.39| 0.48|
|Marketscan |TNF                  |        7|   577| 0.48| 0.58|
|Marketscan |TNF                  |        8|   577| 0.58| 0.67|
|Marketscan |TNF                  |        9|   577| 0.67| 0.76|
|Marketscan |TNF                  |       10|   578| 0.76| 0.94|
|Marketscan |DMARD                |        1|   345| 0.02| 0.19|
|Marketscan |DMARD                |        2|   278| 0.19| 0.24|
|Marketscan |DMARD                |        3|   325| 0.24| 0.28|
|Marketscan |DMARD                |        4|   275| 0.28| 0.33|
|Marketscan |DMARD                |        5|   260| 0.33| 0.39|
|Marketscan |DMARD                |        6|   231| 0.39| 0.48|
|Marketscan |DMARD                |        7|   118| 0.48| 0.58|
|Marketscan |DMARD                |        8|   103| 0.58| 0.67|
|Marketscan |DMARD                |        9|    45| 0.67| 0.76|
|Marketscan |DMARD                |       10|    65| 0.76| 0.94|
|Marketscan |NSAID or no exposure |        1|  4332| 0.02| 0.19|
|Marketscan |NSAID or no exposure |        2|  1777| 0.19| 0.24|
|Marketscan |NSAID or no exposure |        3|  1354| 0.24| 0.28|
|Marketscan |NSAID or no exposure |        4|   916| 0.28| 0.33|
|Marketscan |NSAID or no exposure |        5|   678| 0.33| 0.39|
|Marketscan |NSAID or no exposure |        6|   554| 0.39| 0.48|
|Marketscan |NSAID or no exposure |        7|   332| 0.48| 0.58|
|Marketscan |NSAID or no exposure |        8|   265| 0.58| 0.67|
|Marketscan |NSAID or no exposure |        9|   175| 0.67| 0.76|
|Marketscan |NSAID or no exposure |       10|   116| 0.76| 0.94|
|Medicare   |TNF                  |        1|   593| 0.01| 0.09|
|Medicare   |TNF                  |        2|   593| 0.09| 0.14|
|Medicare   |TNF                  |        3|   591| 0.14| 0.17|
|Medicare   |TNF                  |        4|   592| 0.17| 0.22|
|Medicare   |TNF                  |        5|   592| 0.22| 0.27|
|Medicare   |TNF                  |        6|   593| 0.27| 0.33|
|Medicare   |TNF                  |        7|   591| 0.33| 0.41|
|Medicare   |TNF                  |        8|   592| 0.41| 0.49|
|Medicare   |TNF                  |        9|   592| 0.50| 0.61|
|Medicare   |TNF                  |       10|   592| 0.61| 0.89|
|Medicare   |DMARD                |        1|  1320| 0.01| 0.09|
|Medicare   |DMARD                |        2|   856| 0.09| 0.13|
|Medicare   |DMARD                |        3|   624| 0.14| 0.17|
|Medicare   |DMARD                |        4|   551| 0.17| 0.22|
|Medicare   |DMARD                |        5|   437| 0.22| 0.27|
|Medicare   |DMARD                |        6|   386| 0.27| 0.33|
|Medicare   |DMARD                |        7|   363| 0.33| 0.41|
|Medicare   |DMARD                |        8|   261| 0.41| 0.49|
|Medicare   |DMARD                |        9|   223| 0.50| 0.61|
|Medicare   |DMARD                |       10|   170| 0.61| 0.89|
|Medicare   |NSAID or no exposure |        1| 14952| 0.01| 0.09|
|Medicare   |NSAID or no exposure |        2|  3812| 0.09| 0.14|
|Medicare   |NSAID or no exposure |        3|  2066| 0.14| 0.17|
|Medicare   |NSAID or no exposure |        4|  1529| 0.17| 0.22|
|Medicare   |NSAID or no exposure |        5|  1049| 0.22| 0.27|
|Medicare   |NSAID or no exposure |        6|   836| 0.27| 0.33|
|Medicare   |NSAID or no exposure |        7|   636| 0.33| 0.41|
|Medicare   |NSAID or no exposure |        8|   434| 0.41| 0.49|
|Medicare   |NSAID or no exposure |        9|   333| 0.49| 0.61|
|Medicare   |NSAID or no exposure |       10|   207| 0.61| 0.89|

\newline


### Demographic characteristics

![covarBalGender.png](../figures/covarBalGender.png)



![covarBalAge.png](../figures/covarBalAge.png)




### Other covariates

![covarBalDiabetes.png](../figures/covarBalDiabetes.png)



![covarBalHT.png](../figures/covarBalHT.png)



![covarBalMetabSyn.png](../figures/covarBalMetabSyn.png)



![covarBalNAFattyLiverDis.png](../figures/covarBalNAFattyLiverDis.png)



![covarBalCOPDEmphysema.png](../figures/covarBalCOPDEmphysema.png)



![covarBalOralCorticosteroid.png](../figures/covarBalOralCorticosteroid.png)



![covarBalCharlsonDichot.png](../figures/covarBalCharlsonDichot.png)



![covarBalCharlsonCont.png](../figures/covarBalCharlsonCont.png)



![covarBalInflamMarker.png](../figures/covarBalInflamMarker.png)



![covarBalRxNSAID.png](../figures/covarBalRxNSAID.png)



![covarBalRxHtn.png](../figures/covarBalRxHtn.png)



![covarBalRxNarcotics.png](../figures/covarBalRxNarcotics.png)



![covarBalRxFungus.png](../figures/covarBalRxFungus.png)



![covarBalRxOP_bisphosp.png](../figures/covarBalRxOP_bisphosp.png)



![covarBalRxThiazide.png](../figures/covarBalRxThiazide.png)



![covarBalRxAnticoagulant.png](../figures/covarBalRxAnticoagulant.png)



![covarBalIPAdmit12mPrior.png](../figures/covarBalIPAdmit12mPrior.png)



![covarBalERVisit12mPrior.png](../figures/covarBalERVisit12mPrior.png)



![covarBalAVRheum12mPrior.png](../figures/covarBalAVRheum12mPrior.png)



![covarBalRxBiologics.png](../figures/covarBalRxBiologics.png)




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


