# Propensity score

April 12, 2018


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
indRxBiologics | Prescription drug indicator: Biologics

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
|FALSE            |MPCD       |TNF                  |    43| 0.025| 0.988|   1.012|  39.928|
|FALSE            |MPCD       |NSAID or no exposure |   283| 0.004| 0.931|   1.004|  14.485|
|FALSE            |Marketscan |TNF                  |     7| 0.011| 0.970|   1.031|  94.365|
|FALSE            |Marketscan |NSAID or no exposure |    83| 0.002| 0.950|   1.002|  19.957|
|FALSE            |Medicare   |TNF                  |     8| 0.895| 0.939|   1.065|   1.118|
|FALSE            |Medicare   |DMARD                |     2| 0.008| 0.008|   1.008|   1.008|
|FALSE            |Medicare   |NSAID or no exposure |   276| 0.003| 0.908|   1.003|  10.867|
|TRUE             |MPCD       |TNF                  |  1235| 0.041| 0.917|   1.091|  24.148|
|TRUE             |MPCD       |DMARD                |   481| 0.034| 0.919|   1.035|  12.390|
|TRUE             |MPCD       |NSAID or no exposure |  2310| 0.034| 0.914|   1.035|  11.567|
|TRUE             |Marketscan |TNF                  |  5772| 0.022| 0.947|   1.056|  45.061|
|TRUE             |Marketscan |DMARD                |  2045| 0.014| 0.947|   1.014|  18.866|
|TRUE             |Marketscan |NSAID or no exposure | 10506| 0.014| 0.944|   1.014|  18.009|
|TRUE             |Medicare   |TNF                  |  5921| 0.009| 0.892|   1.121| 107.838|
|TRUE             |Medicare   |DMARD                |  5191| 0.010| 0.892|   1.010|   9.249|
|TRUE             |Medicare   |NSAID or no exposure | 25846| 0.009| 0.875|   1.009|   8.010|
|NA               |MPCD       |TNF                  |     1|    NA|    NA|      NA|      NA|

\newline


|database   | commonSupportLowerBound| commonSupportUpperBound|
|:----------|-----------------------:|-----------------------:|
|MPCD       |               0.0336678|               0.9192914|
|Marketscan |               0.0139976|               0.9469954|
|Medicare   |               0.0092732|               0.8918854|

Create propensity score deciles cutpoints.






## Covariate balance

Include only episodes with propensity scores in the common support region.



**Propensity of TNF.**
Create propensity score deciles.


|database   |exposure             | psDecile|     n|  min|  max|
|:----------|:--------------------|--------:|-----:|----:|----:|
|MPCD       |TNF                  |        1|   124| 0.04| 0.17|
|MPCD       |TNF                  |        2|   123| 0.17| 0.23|
|MPCD       |TNF                  |        3|   132| 0.23| 0.28|
|MPCD       |TNF                  |        4|   115| 0.28| 0.35|
|MPCD       |TNF                  |        5|   124| 0.35| 0.42|
|MPCD       |TNF                  |        6|   123| 0.42| 0.51|
|MPCD       |TNF                  |        7|   123| 0.51| 0.60|
|MPCD       |TNF                  |        8|   124| 0.60| 0.71|
|MPCD       |TNF                  |        9|   123| 0.71| 0.81|
|MPCD       |TNF                  |       10|   124| 0.81| 0.92|
|MPCD       |DMARD                |        1|    97| 0.03| 0.17|
|MPCD       |DMARD                |        2|    71| 0.17| 0.23|
|MPCD       |DMARD                |        3|    60| 0.23| 0.28|
|MPCD       |DMARD                |        4|    64| 0.28| 0.35|
|MPCD       |DMARD                |        5|    65| 0.35| 0.42|
|MPCD       |DMARD                |        6|    53| 0.42| 0.51|
|MPCD       |DMARD                |        7|    31| 0.51| 0.60|
|MPCD       |DMARD                |        8|    23| 0.61| 0.71|
|MPCD       |DMARD                |        9|     9| 0.72| 0.80|
|MPCD       |DMARD                |       10|     8| 0.81| 0.92|
|MPCD       |NSAID or no exposure |        1|  1075| 0.03| 0.17|
|MPCD       |NSAID or no exposure |        2|   403| 0.17| 0.23|
|MPCD       |NSAID or no exposure |        3|   261| 0.23| 0.28|
|MPCD       |NSAID or no exposure |        4|   178| 0.28| 0.35|
|MPCD       |NSAID or no exposure |        5|   128| 0.35| 0.42|
|MPCD       |NSAID or no exposure |        6|   119| 0.42| 0.51|
|MPCD       |NSAID or no exposure |        7|    60| 0.51| 0.60|
|MPCD       |NSAID or no exposure |        8|    42| 0.61| 0.71|
|MPCD       |NSAID or no exposure |        9|    27| 0.71| 0.81|
|MPCD       |NSAID or no exposure |       10|    17| 0.81| 0.91|
|Marketscan |TNF                  |        1|   578| 0.02| 0.18|
|Marketscan |TNF                  |        2|   577| 0.18| 0.23|
|Marketscan |TNF                  |        3|   577| 0.23| 0.27|
|Marketscan |TNF                  |        4|   577| 0.27| 0.33|
|Marketscan |TNF                  |        5|   577| 0.33| 0.41|
|Marketscan |TNF                  |        6|   577| 0.41| 0.55|
|Marketscan |TNF                  |        7|   577| 0.55| 0.66|
|Marketscan |TNF                  |        8|   577| 0.66| 0.73|
|Marketscan |TNF                  |        9|   577| 0.73| 0.81|
|Marketscan |TNF                  |       10|   578| 0.81| 0.95|
|Marketscan |DMARD                |        1|   378| 0.01| 0.18|
|Marketscan |DMARD                |        2|   320| 0.18| 0.23|
|Marketscan |DMARD                |        3|   338| 0.23| 0.27|
|Marketscan |DMARD                |        4|   310| 0.27| 0.33|
|Marketscan |DMARD                |        5|   294| 0.33| 0.41|
|Marketscan |DMARD                |        6|   173| 0.41| 0.55|
|Marketscan |DMARD                |        7|    95| 0.55| 0.66|
|Marketscan |DMARD                |        8|    45| 0.66| 0.73|
|Marketscan |DMARD                |        9|    40| 0.73| 0.80|
|Marketscan |DMARD                |       10|    52| 0.81| 0.95|
|Marketscan |NSAID or no exposure |        1|  4508| 0.01| 0.18|
|Marketscan |NSAID or no exposure |        2|  1917| 0.18| 0.23|
|Marketscan |NSAID or no exposure |        3|  1346| 0.23| 0.27|
|Marketscan |NSAID or no exposure |        4|   926| 0.27| 0.33|
|Marketscan |NSAID or no exposure |        5|   731| 0.33| 0.41|
|Marketscan |NSAID or no exposure |        6|   396| 0.41| 0.55|
|Marketscan |NSAID or no exposure |        7|   277| 0.55| 0.66|
|Marketscan |NSAID or no exposure |        8|   186| 0.66| 0.73|
|Marketscan |NSAID or no exposure |        9|   134| 0.73| 0.80|
|Marketscan |NSAID or no exposure |       10|    85| 0.81| 0.94|
|Medicare   |TNF                  |        1|   593| 0.01| 0.09|
|Medicare   |TNF                  |        2|   592| 0.09| 0.13|
|Medicare   |TNF                  |        3|   592| 0.13| 0.17|
|Medicare   |TNF                  |        4|   592| 0.17| 0.22|
|Medicare   |TNF                  |        5|   592| 0.22| 0.28|
|Medicare   |TNF                  |        6|   592| 0.28| 0.35|
|Medicare   |TNF                  |        7|   592| 0.35| 0.44|
|Medicare   |TNF                  |        8|   592| 0.44| 0.52|
|Medicare   |TNF                  |        9|   592| 0.52| 0.63|
|Medicare   |TNF                  |       10|   592| 0.63| 0.89|
|Medicare   |DMARD                |        1|  1366| 0.01| 0.09|
|Medicare   |DMARD                |        2|   894| 0.09| 0.13|
|Medicare   |DMARD                |        3|   592| 0.13| 0.17|
|Medicare   |DMARD                |        4|   581| 0.17| 0.22|
|Medicare   |DMARD                |        5|   448| 0.22| 0.28|
|Medicare   |DMARD                |        6|   396| 0.28| 0.35|
|Medicare   |DMARD                |        7|   356| 0.35| 0.44|
|Medicare   |DMARD                |        8|   202| 0.44| 0.52|
|Medicare   |DMARD                |        9|   194| 0.52| 0.63|
|Medicare   |DMARD                |       10|   162| 0.63| 0.89|
|Medicare   |NSAID or no exposure |        1| 15119| 0.01| 0.09|
|Medicare   |NSAID or no exposure |        2|  3775| 0.09| 0.13|
|Medicare   |NSAID or no exposure |        3|  1970| 0.13| 0.17|
|Medicare   |NSAID or no exposure |        4|  1576| 0.17| 0.22|
|Medicare   |NSAID or no exposure |        5|  1096| 0.22| 0.28|
|Medicare   |NSAID or no exposure |        6|   832| 0.28| 0.35|
|Medicare   |NSAID or no exposure |        7|   612| 0.35| 0.44|
|Medicare   |NSAID or no exposure |        8|   376| 0.44| 0.52|
|Medicare   |NSAID or no exposure |        9|   301| 0.52| 0.63|
|Medicare   |NSAID or no exposure |       10|   189| 0.63| 0.88|

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


