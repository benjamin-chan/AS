# Propensity score

April 06, 2018


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
indInflamMarker | Inflammatory marker
indRxNSAID | Prescription drug indicator: NSAID
indRxHtn | Prescription drug indicator: Antihypertensive
indRxNarcotics | Prescription drug indicator: Narcotic
indRxFungus | Prescription drug indicator: Antifungal
indRxOP_bisphosp | Prescription drug indicator: Bisphosphonate
indRxThiazide | Prescription drug indicator: Thiazide
indRxAnticoagulant | Prescription drug indicator: Anticoagulant
indIPAdmit12mPrior | Inpatient admission 12 months prior to exposure
indERVisit12mPrior | ER visit 12 months prior to exposure
quartileCIRAS | CIRAS: quartiles within data source
quartileAVPhysEncounters | Number of ambulatory office visits: quartiles within data source

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
|FALSE            |MPCD       |TNF                  |    35| 0.021| 0.970|   1.031|  46.913|
|FALSE            |MPCD       |NSAID or no exposure |   171| 0.004| 0.876|   1.004|   8.077|
|FALSE            |Marketscan |DMARD                |     3| 0.012| 0.905|   1.012|  10.529|
|FALSE            |Marketscan |NSAID or no exposure |    85| 0.002| 0.918|   1.002|  12.188|
|FALSE            |Medicare   |TNF                  |     9| 0.739| 0.843|   1.186|   1.353|
|FALSE            |Medicare   |DMARD                |     7| 0.007| 0.010|   1.007|   1.011|
|FALSE            |Medicare   |NSAID or no exposure |   682| 0.002| 0.767|   1.002|   4.299|
|TRUE             |MPCD       |TNF                  |  1243| 0.031| 0.757|   1.321|  31.870|
|TRUE             |MPCD       |DMARD                |   481| 0.028| 0.760|   1.029|   4.158|
|TRUE             |MPCD       |NSAID or no exposure |  2422| 0.029| 0.750|   1.030|   4.005|
|TRUE             |Marketscan |TNF                  |  5779| 0.018| 0.905|   1.105|  56.188|
|TRUE             |Marketscan |DMARD                |  2042| 0.025| 0.859|   1.026|   7.072|
|TRUE             |Marketscan |NSAID or no exposure | 10504| 0.018| 0.834|   1.018|   6.033|
|TRUE             |Medicare   |TNF                  |  5920| 0.010| 0.735|   1.360|  95.508|
|TRUE             |Medicare   |DMARD                |  5186| 0.011| 0.736|   1.011|   3.783|
|TRUE             |Medicare   |NSAID or no exposure | 25440| 0.010| 0.713|   1.011|   3.481|
|NA               |MPCD       |TNF                  |     1|    NA|    NA|      NA|      NA|

\newline


|database   | commonSupportLowerBound| commonSupportUpperBound|
|:----------|-----------------------:|-----------------------:|
|MPCD       |               0.0283047|               0.7595103|
|Marketscan |               0.0177974|               0.9049559|
|Medicare   |               0.0104703|               0.7356851|

Create propensity score deciles cutpoints.






## Covariate balance

Include only episodes with propensity scores in the common support region.



**Propensity of TNF.**
Create propensity score deciles.


|database   |exposure             | psDecile|     n|  min|  max|
|:----------|:--------------------|--------:|-----:|----:|----:|
|MPCD       |TNF                  |        1|   125| 0.03| 0.20|
|MPCD       |TNF                  |        2|   124| 0.20| 0.26|
|MPCD       |TNF                  |        3|   124| 0.26| 0.29|
|MPCD       |TNF                  |        4|   132| 0.29| 0.33|
|MPCD       |TNF                  |        5|   117| 0.33| 0.37|
|MPCD       |TNF                  |        6|   126| 0.37| 0.41|
|MPCD       |TNF                  |        7|   122| 0.41| 0.45|
|MPCD       |TNF                  |        8|   124| 0.45| 0.51|
|MPCD       |TNF                  |        9|   124| 0.51| 0.59|
|MPCD       |TNF                  |       10|   125| 0.59| 0.76|
|MPCD       |DMARD                |        1|    73| 0.03| 0.20|
|MPCD       |DMARD                |        2|    50| 0.20| 0.25|
|MPCD       |DMARD                |        3|    46| 0.26| 0.29|
|MPCD       |DMARD                |        4|    56| 0.30| 0.33|
|MPCD       |DMARD                |        5|    42| 0.34| 0.37|
|MPCD       |DMARD                |        6|    53| 0.37| 0.41|
|MPCD       |DMARD                |        7|    48| 0.42| 0.45|
|MPCD       |DMARD                |        8|    42| 0.46| 0.51|
|MPCD       |DMARD                |        9|    42| 0.51| 0.59|
|MPCD       |DMARD                |       10|    29| 0.60| 0.76|
|MPCD       |NSAID or no exposure |        1|   985| 0.03| 0.20|
|MPCD       |NSAID or no exposure |        2|   356| 0.20| 0.26|
|MPCD       |NSAID or no exposure |        3|   211| 0.26| 0.29|
|MPCD       |NSAID or no exposure |        4|   235| 0.29| 0.33|
|MPCD       |NSAID or no exposure |        5|   148| 0.33| 0.37|
|MPCD       |NSAID or no exposure |        6|   138| 0.37| 0.41|
|MPCD       |NSAID or no exposure |        7|   131| 0.41| 0.45|
|MPCD       |NSAID or no exposure |        8|    99| 0.45| 0.51|
|MPCD       |NSAID or no exposure |        9|    82| 0.51| 0.59|
|MPCD       |NSAID or no exposure |       10|    37| 0.59| 0.75|
|Marketscan |TNF                  |        1|   578| 0.02| 0.20|
|Marketscan |TNF                  |        2|   578| 0.20| 0.25|
|Marketscan |TNF                  |        3|   578| 0.25| 0.30|
|Marketscan |TNF                  |        4|   578| 0.30| 0.34|
|Marketscan |TNF                  |        5|   578| 0.34| 0.39|
|Marketscan |TNF                  |        6|   577| 0.39| 0.43|
|Marketscan |TNF                  |        7|   578| 0.43| 0.48|
|Marketscan |TNF                  |        8|   578| 0.48| 0.53|
|Marketscan |TNF                  |        9|   578| 0.53| 0.62|
|Marketscan |TNF                  |       10|   578| 0.62| 0.90|
|Marketscan |DMARD                |        1|   298| 0.03| 0.20|
|Marketscan |DMARD                |        2|   223| 0.20| 0.25|
|Marketscan |DMARD                |        3|   237| 0.25| 0.30|
|Marketscan |DMARD                |        4|   244| 0.30| 0.34|
|Marketscan |DMARD                |        5|   230| 0.34| 0.39|
|Marketscan |DMARD                |        6|   190| 0.39| 0.43|
|Marketscan |DMARD                |        7|   210| 0.43| 0.48|
|Marketscan |DMARD                |        8|   160| 0.48| 0.53|
|Marketscan |DMARD                |        9|   157| 0.53| 0.62|
|Marketscan |DMARD                |       10|    93| 0.62| 0.86|
|Marketscan |NSAID or no exposure |        1|  3897| 0.02| 0.20|
|Marketscan |NSAID or no exposure |        2|  1594| 0.20| 0.25|
|Marketscan |NSAID or no exposure |        3|  1234| 0.25| 0.30|
|Marketscan |NSAID or no exposure |        4|   973| 0.30| 0.34|
|Marketscan |NSAID or no exposure |        5|   776| 0.34| 0.39|
|Marketscan |NSAID or no exposure |        6|   636| 0.39| 0.43|
|Marketscan |NSAID or no exposure |        7|   500| 0.43| 0.48|
|Marketscan |NSAID or no exposure |        8|   419| 0.48| 0.53|
|Marketscan |NSAID or no exposure |        9|   306| 0.53| 0.62|
|Marketscan |NSAID or no exposure |       10|   169| 0.62| 0.83|
|Medicare   |TNF                  |        1|   592| 0.01| 0.09|
|Medicare   |TNF                  |        2|   592| 0.09| 0.13|
|Medicare   |TNF                  |        3|   593| 0.13| 0.16|
|Medicare   |TNF                  |        4|   591| 0.16| 0.20|
|Medicare   |TNF                  |        5|   592| 0.20| 0.23|
|Medicare   |TNF                  |        6|   592| 0.23| 0.27|
|Medicare   |TNF                  |        7|   592| 0.27| 0.31|
|Medicare   |TNF                  |        8|   592| 0.31| 0.37|
|Medicare   |TNF                  |        9|   592| 0.37| 0.45|
|Medicare   |TNF                  |       10|   592| 0.45| 0.74|
|Medicare   |DMARD                |        1|   939| 0.01| 0.09|
|Medicare   |DMARD                |        2|   797| 0.09| 0.13|
|Medicare   |DMARD                |        3|   641| 0.13| 0.16|
|Medicare   |DMARD                |        4|   508| 0.16| 0.19|
|Medicare   |DMARD                |        5|   550| 0.20| 0.23|
|Medicare   |DMARD                |        6|   440| 0.23| 0.27|
|Medicare   |DMARD                |        7|   364| 0.27| 0.31|
|Medicare   |DMARD                |        8|   367| 0.31| 0.37|
|Medicare   |DMARD                |        9|   326| 0.37| 0.45|
|Medicare   |DMARD                |       10|   254| 0.45| 0.74|
|Medicare   |NSAID or no exposure |        1| 10994| 0.01| 0.09|
|Medicare   |NSAID or no exposure |        2|  3949| 0.09| 0.13|
|Medicare   |NSAID or no exposure |        3|  2696| 0.13| 0.16|
|Medicare   |NSAID or no exposure |        4|  2029| 0.16| 0.20|
|Medicare   |NSAID or no exposure |        5|  1617| 0.20| 0.23|
|Medicare   |NSAID or no exposure |        6|  1388| 0.23| 0.27|
|Medicare   |NSAID or no exposure |        7|  1012| 0.27| 0.31|
|Medicare   |NSAID or no exposure |        8|   830| 0.31| 0.37|
|Medicare   |NSAID or no exposure |        9|   583| 0.37| 0.45|
|Medicare   |NSAID or no exposure |       10|   342| 0.45| 0.71|

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



![covarBalCIRASDichot.png](../figures/covarBalCIRASDichot.png)



![covarBalCIRASCont.png](../figures/covarBalCIRASCont.png)



![covarBalAVPhysEncDichot.png](../figures/covarBalAVPhysEncDichot.png)



![covarBalAVPhysEncCont.png](../figures/covarBalAVPhysEncCont.png)




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


