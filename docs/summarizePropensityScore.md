# Propensity score

December 07, 2017


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
|FALSE            |MPCD       |TNF                  |    29| 0.019| 0.969|   1.032|  53.047|
|FALSE            |MPCD       |NSAID or no exposure |   188| 0.007| 0.885|   1.007|   8.715|
|FALSE            |Marketscan |TNF                  |     4| 0.876| 0.901|   1.110|   1.141|
|FALSE            |Marketscan |DMARD                |     3| 0.009| 0.031|   1.009|   1.032|
|FALSE            |Marketscan |NSAID or no exposure |   146| 0.005| 0.885|   1.005|   8.722|
|FALSE            |Medicare   |TNF                  |     7| 0.717| 0.778|   1.286|   1.396|
|FALSE            |Medicare   |DMARD                |     2| 0.012| 0.723|   1.013|   3.612|
|FALSE            |Medicare   |NSAID or no exposure |   158| 0.006| 0.013|   1.006|   1.013|
|TRUE             |MPCD       |TNF                  |  1249| 0.048| 0.766|   1.305|  20.933|
|TRUE             |MPCD       |DMARD                |   481| 0.034| 0.769|   1.035|   4.337|
|TRUE             |MPCD       |NSAID or no exposure |  2405| 0.034| 0.765|   1.035|   4.255|
|TRUE             |Marketscan |TNF                  |  5775| 0.033| 0.858|   1.166|  30.691|
|TRUE             |Marketscan |DMARD                |  2042| 0.043| 0.866|   1.045|   7.469|
|TRUE             |Marketscan |NSAID or no exposure | 10443| 0.033| 0.830|   1.034|   5.892|
|TRUE             |Medicare   |TNF                  |  5922| 0.013| 0.714|   1.401|  77.972|
|TRUE             |Medicare   |DMARD                |  5191| 0.013| 0.691|   1.013|   3.239|
|TRUE             |Medicare   |NSAID or no exposure | 25964| 0.013| 0.714|   1.013|   3.495|
|NA               |MPCD       |TNF                  |     1|    NA|    NA|      NA|      NA|

\newline


|database   | commonSupportLowerBound| commonSupportUpperBound|
|:----------|-----------------------:|-----------------------:|
|MPCD       |               0.0335125|               0.7694361|
|Marketscan |               0.0325833|               0.8661170|
|Medicare   |               0.0128251|               0.7139090|

Create propensity score deciles cutpoints.






## Covariate balance

Include only episodes with propensity scores in the common support region.



**Propensity of TNF.**
Create propensity score deciles.


|database   |exposure             | psDecile|     n|  min|  max|
|:----------|:--------------------|--------:|-----:|----:|----:|
|MPCD       |TNF                  |        1|   125| 0.05| 0.21|
|MPCD       |TNF                  |        2|   125| 0.21| 0.26|
|MPCD       |TNF                  |        3|   126| 0.26| 0.29|
|MPCD       |TNF                  |        4|   124| 0.29| 0.33|
|MPCD       |TNF                  |        5|   129| 0.33| 0.37|
|MPCD       |TNF                  |        6|   120| 0.37| 0.40|
|MPCD       |TNF                  |        7|   125| 0.41| 0.44|
|MPCD       |TNF                  |        8|   126| 0.44| 0.49|
|MPCD       |TNF                  |        9|   124| 0.49| 0.57|
|MPCD       |TNF                  |       10|   125| 0.57| 0.77|
|MPCD       |DMARD                |        1|    77| 0.03| 0.21|
|MPCD       |DMARD                |        2|    42| 0.21| 0.25|
|MPCD       |DMARD                |        3|    39| 0.26| 0.29|
|MPCD       |DMARD                |        4|    60| 0.29| 0.33|
|MPCD       |DMARD                |        5|    41| 0.33| 0.37|
|MPCD       |DMARD                |        6|    55| 0.37| 0.40|
|MPCD       |DMARD                |        7|    41| 0.41| 0.44|
|MPCD       |DMARD                |        8|    50| 0.44| 0.49|
|MPCD       |DMARD                |        9|    51| 0.49| 0.57|
|MPCD       |DMARD                |       10|    25| 0.58| 0.77|
|MPCD       |NSAID or no exposure |        1|   938| 0.03| 0.21|
|MPCD       |NSAID or no exposure |        2|   335| 0.21| 0.26|
|MPCD       |NSAID or no exposure |        3|   239| 0.26| 0.29|
|MPCD       |NSAID or no exposure |        4|   208| 0.29| 0.33|
|MPCD       |NSAID or no exposure |        5|   181| 0.33| 0.37|
|MPCD       |NSAID or no exposure |        6|   149| 0.37| 0.40|
|MPCD       |NSAID or no exposure |        7|   139| 0.41| 0.44|
|MPCD       |NSAID or no exposure |        8|    75| 0.44| 0.49|
|MPCD       |NSAID or no exposure |        9|    92| 0.49| 0.57|
|MPCD       |NSAID or no exposure |       10|    49| 0.57| 0.76|
|Marketscan |TNF                  |        1|   578| 0.03| 0.20|
|Marketscan |TNF                  |        2|   577| 0.20| 0.26|
|Marketscan |TNF                  |        3|   601| 0.26| 0.30|
|Marketscan |TNF                  |        4|   554| 0.30| 0.33|
|Marketscan |TNF                  |        5|   583| 0.33| 0.37|
|Marketscan |TNF                  |        6|   576| 0.37| 0.40|
|Marketscan |TNF                  |        7|   573| 0.40| 0.44|
|Marketscan |TNF                  |        8|   578| 0.44| 0.50|
|Marketscan |TNF                  |        9|   577| 0.50| 0.59|
|Marketscan |TNF                  |       10|   578| 0.59| 0.86|
|Marketscan |DMARD                |        1|   251| 0.04| 0.20|
|Marketscan |DMARD                |        2|   227| 0.20| 0.26|
|Marketscan |DMARD                |        3|   213| 0.26| 0.30|
|Marketscan |DMARD                |        4|   223| 0.30| 0.33|
|Marketscan |DMARD                |        5|   238| 0.33| 0.37|
|Marketscan |DMARD                |        6|   191| 0.37| 0.40|
|Marketscan |DMARD                |        7|   215| 0.40| 0.44|
|Marketscan |DMARD                |        8|   213| 0.44| 0.50|
|Marketscan |DMARD                |        9|   161| 0.50| 0.59|
|Marketscan |DMARD                |       10|   110| 0.59| 0.87|
|Marketscan |NSAID or no exposure |        1|  3424| 0.03| 0.20|
|Marketscan |NSAID or no exposure |        2|  1716| 0.20| 0.26|
|Marketscan |NSAID or no exposure |        3|  1284| 0.26| 0.30|
|Marketscan |NSAID or no exposure |        4|   918| 0.30| 0.33|
|Marketscan |NSAID or no exposure |        5|   834| 0.33| 0.37|
|Marketscan |NSAID or no exposure |        6|   706| 0.37| 0.40|
|Marketscan |NSAID or no exposure |        7|   569| 0.40| 0.44|
|Marketscan |NSAID or no exposure |        8|   482| 0.44| 0.50|
|Marketscan |NSAID or no exposure |        9|   313| 0.50| 0.59|
|Marketscan |NSAID or no exposure |       10|   197| 0.59| 0.83|
|Medicare   |TNF                  |        1|   593| 0.01| 0.09|
|Medicare   |TNF                  |        2|   592| 0.09| 0.13|
|Medicare   |TNF                  |        3|   593| 0.13| 0.16|
|Medicare   |TNF                  |        4|   591| 0.16| 0.19|
|Medicare   |TNF                  |        5|   592| 0.19| 0.22|
|Medicare   |TNF                  |        6|   592| 0.22| 0.26|
|Medicare   |TNF                  |        7|   593| 0.26| 0.30|
|Medicare   |TNF                  |        8|   591| 0.30| 0.35|
|Medicare   |TNF                  |        9|   592| 0.35| 0.43|
|Medicare   |TNF                  |       10|   593| 0.43| 0.71|
|Medicare   |DMARD                |        1|   973| 0.01| 0.09|
|Medicare   |DMARD                |        2|   791| 0.09| 0.13|
|Medicare   |DMARD                |        3|   596| 0.13| 0.16|
|Medicare   |DMARD                |        4|   536| 0.16| 0.19|
|Medicare   |DMARD                |        5|   488| 0.19| 0.22|
|Medicare   |DMARD                |        6|   417| 0.22| 0.26|
|Medicare   |DMARD                |        7|   409| 0.26| 0.30|
|Medicare   |DMARD                |        8|   344| 0.30| 0.35|
|Medicare   |DMARD                |        9|   370| 0.35| 0.43|
|Medicare   |DMARD                |       10|   267| 0.43| 0.69|
|Medicare   |NSAID or no exposure |        1| 10906| 0.01| 0.09|
|Medicare   |NSAID or no exposure |        2|  4252| 0.09| 0.13|
|Medicare   |NSAID or no exposure |        3|  2699| 0.13| 0.16|
|Medicare   |NSAID or no exposure |        4|  2006| 0.16| 0.19|
|Medicare   |NSAID or no exposure |        5|  1623| 0.19| 0.22|
|Medicare   |NSAID or no exposure |        6|  1428| 0.22| 0.26|
|Medicare   |NSAID or no exposure |        7|  1213| 0.26| 0.30|
|Medicare   |NSAID or no exposure |        8|   823| 0.30| 0.35|
|Medicare   |NSAID or no exposure |        9|   628| 0.35| 0.43|
|Medicare   |NSAID or no exposure |       10|   386| 0.43| 0.71|

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


