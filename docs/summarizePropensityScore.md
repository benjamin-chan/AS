# Propensity score

June 13, 2018


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
indRxAntibiotics | Prescription drug indicator: Antibiotics
countIPAdmit12mPrior | Number of inpatient admission 12 months prior to exposure
indERVisit12mPrior | ER visit 12 months prior to exposure
countAVRheum12mPrior | Number of rheumatologist visits 12 months prior
indRxBiologics | Prescription drug indicator: Biologics, 7+ months prior
indOutpatientInfection | Outpatient infectiion

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

Summarize propensity scores and IPTWs by data source and exposure.


|indCommonSupport |database   |exposure             |    n| minPS| maxPS| minIPTW| maxIPTW|
|:----------------|:----------|:--------------------|----:|-----:|-----:|-------:|-------:|
|FALSE            |MPCD       |TNF                  |   61| 0.924| 1.000|   1.000|   1.082|
|FALSE            |MPCD       |DMARD                |    6| 0.000| 0.932|   1.000|  14.611|
|FALSE            |MPCD       |NSAID or no exposure |   48| 0.003| 0.030|   1.003|   1.031|
|FALSE            |Marketscan |TNF                  |   70| 0.022| 1.000|   1.000|  45.775|
|FALSE            |Marketscan |NSAID or no exposure |    5| 0.010| 0.963|   1.010|  26.981|
|FALSE            |Medicare   |TNF                  |    1| 0.867| 0.867|   1.153|   1.153|
|FALSE            |Medicare   |DMARD                |   16| 0.000| 0.025|   1.000|   1.026|
|FALSE            |Medicare   |NSAID or no exposure |  102| 0.000| 0.889|   1.000|   9.047|
|TRUE             |MPCD       |TNF                  |  609| 0.030| 0.924|   1.082|  33.344|
|TRUE             |MPCD       |DMARD                |  159| 0.034| 0.919|   1.035|  12.332|
|TRUE             |MPCD       |NSAID or no exposure |  819| 0.030| 0.924|   1.031|  13.148|
|TRUE             |Marketscan |TNF                  | 3383| 0.053| 0.938|   1.066|  18.918|
|TRUE             |Marketscan |DMARD                |  777| 0.034| 0.938|   1.035|  16.241|
|TRUE             |Marketscan |NSAID or no exposure | 3427| 0.035| 0.933|   1.036|  14.823|
|TRUE             |Medicare   |TNF                  |  809| 0.028| 0.840|   1.190|  35.497|
|TRUE             |Medicare   |DMARD                |  626| 0.029| 0.841|   1.030|   6.291|
|TRUE             |Medicare   |NSAID or no exposure | 2771| 0.028| 0.840|   1.029|   6.261|

\newline

Summarize common support region bounds.


|database   | commonSupportLowerBound| commonSupportUpperBound|
|:----------|-----------------------:|-----------------------:|
|MPCD       |               0.0299903|               0.9239443|
|Marketscan |               0.0337966|               0.9384292|
|Medicare   |               0.0281712|               0.8410338|

Create propensity score deciles cutpoints.






## Covariate balance

Include only episodes with propensity scores in the common support region.



**Propensity of TNF.**
Create propensity score deciles.


|database   |exposure             | psDecile|    n|  min|  max|
|:----------|:--------------------|--------:|----:|----:|----:|
|MPCD       |TNF                  |        1|   61| 0.03| 0.21|
|MPCD       |TNF                  |        2|   62| 0.22| 0.31|
|MPCD       |TNF                  |        3|   60| 0.31| 0.39|
|MPCD       |TNF                  |        4|   61| 0.40| 0.48|
|MPCD       |TNF                  |        5|   61| 0.48| 0.57|
|MPCD       |TNF                  |        6|   60| 0.57| 0.64|
|MPCD       |TNF                  |        7|   61| 0.64| 0.73|
|MPCD       |TNF                  |        8|   61| 0.73| 0.80|
|MPCD       |TNF                  |        9|   61| 0.80| 0.87|
|MPCD       |TNF                  |       10|   61| 0.87| 0.92|
|MPCD       |DMARD                |        1|   56| 0.03| 0.21|
|MPCD       |DMARD                |        2|   20| 0.23| 0.30|
|MPCD       |DMARD                |        3|   21| 0.31| 0.39|
|MPCD       |DMARD                |        4|   15| 0.41| 0.48|
|MPCD       |DMARD                |        5|   18| 0.49| 0.56|
|MPCD       |DMARD                |        6|    9| 0.57| 0.62|
|MPCD       |DMARD                |        7|    8| 0.64| 0.69|
|MPCD       |DMARD                |        8|    6| 0.73| 0.79|
|MPCD       |DMARD                |        9|    5| 0.80| 0.86|
|MPCD       |DMARD                |       10|    1| 0.92| 0.92|
|MPCD       |NSAID or no exposure |        1|  420| 0.03| 0.21|
|MPCD       |NSAID or no exposure |        2|  138| 0.21| 0.31|
|MPCD       |NSAID or no exposure |        3|   75| 0.31| 0.39|
|MPCD       |NSAID or no exposure |        4|   59| 0.39| 0.48|
|MPCD       |NSAID or no exposure |        5|   47| 0.49| 0.57|
|MPCD       |NSAID or no exposure |        6|   26| 0.57| 0.64|
|MPCD       |NSAID or no exposure |        7|   28| 0.65| 0.73|
|MPCD       |NSAID or no exposure |        8|    5| 0.74| 0.78|
|MPCD       |NSAID or no exposure |        9|   13| 0.80| 0.86|
|MPCD       |NSAID or no exposure |       10|    8| 0.87| 0.92|
|Marketscan |TNF                  |        1|  339| 0.05| 0.24|
|Marketscan |TNF                  |        2|  338| 0.24| 0.37|
|Marketscan |TNF                  |        3|  338| 0.37| 0.47|
|Marketscan |TNF                  |        4|  338| 0.47| 0.54|
|Marketscan |TNF                  |        5|  339| 0.54| 0.60|
|Marketscan |TNF                  |        6|  338| 0.61| 0.66|
|Marketscan |TNF                  |        7|  338| 0.66| 0.74|
|Marketscan |TNF                  |        8|  338| 0.74| 0.82|
|Marketscan |TNF                  |        9|  338| 0.82| 0.88|
|Marketscan |TNF                  |       10|  339| 0.88| 0.94|
|Marketscan |DMARD                |        1|  250| 0.03| 0.24|
|Marketscan |DMARD                |        2|  154| 0.24| 0.37|
|Marketscan |DMARD                |        3|   64| 0.37| 0.47|
|Marketscan |DMARD                |        4|   73| 0.48| 0.54|
|Marketscan |DMARD                |        5|   61| 0.54| 0.60|
|Marketscan |DMARD                |        6|   54| 0.61| 0.66|
|Marketscan |DMARD                |        7|   56| 0.66| 0.73|
|Marketscan |DMARD                |        8|   25| 0.74| 0.81|
|Marketscan |DMARD                |        9|   21| 0.82| 0.88|
|Marketscan |DMARD                |       10|   19| 0.88| 0.94|
|Marketscan |NSAID or no exposure |        1| 1691| 0.03| 0.24|
|Marketscan |NSAID or no exposure |        2|  545| 0.24| 0.37|
|Marketscan |NSAID or no exposure |        3|  358| 0.37| 0.47|
|Marketscan |NSAID or no exposure |        4|  232| 0.47| 0.54|
|Marketscan |NSAID or no exposure |        5|  213| 0.54| 0.60|
|Marketscan |NSAID or no exposure |        6|  142| 0.61| 0.66|
|Marketscan |NSAID or no exposure |        7|  110| 0.66| 0.74|
|Marketscan |NSAID or no exposure |        8|   66| 0.74| 0.82|
|Marketscan |NSAID or no exposure |        9|   40| 0.82| 0.87|
|Marketscan |NSAID or no exposure |       10|   30| 0.88| 0.93|
|Medicare   |TNF                  |        1|   81| 0.03| 0.11|
|Medicare   |TNF                  |        2|   81| 0.11| 0.14|
|Medicare   |TNF                  |        3|   81| 0.14| 0.17|
|Medicare   |TNF                  |        4|   81| 0.17| 0.20|
|Medicare   |TNF                  |        5|   81| 0.20| 0.25|
|Medicare   |TNF                  |        6|   80| 0.25| 0.29|
|Medicare   |TNF                  |        7|   81| 0.29| 0.35|
|Medicare   |TNF                  |        8|   81| 0.36| 0.43|
|Medicare   |TNF                  |        9|   81| 0.43| 0.53|
|Medicare   |TNF                  |       10|   81| 0.53| 0.84|
|Medicare   |DMARD                |        1|  118| 0.03| 0.11|
|Medicare   |DMARD                |        2|   86| 0.11| 0.14|
|Medicare   |DMARD                |        3|   76| 0.14| 0.17|
|Medicare   |DMARD                |        4|   72| 0.17| 0.20|
|Medicare   |DMARD                |        5|   67| 0.20| 0.25|
|Medicare   |DMARD                |        6|   46| 0.25| 0.29|
|Medicare   |DMARD                |        7|   61| 0.29| 0.35|
|Medicare   |DMARD                |        8|   27| 0.36| 0.43|
|Medicare   |DMARD                |        9|   38| 0.43| 0.53|
|Medicare   |DMARD                |       10|   35| 0.54| 0.84|
|Medicare   |NSAID or no exposure |        1| 1149| 0.03| 0.11|
|Medicare   |NSAID or no exposure |        2|  431| 0.11| 0.14|
|Medicare   |NSAID or no exposure |        3|  364| 0.14| 0.17|
|Medicare   |NSAID or no exposure |        4|  240| 0.17| 0.20|
|Medicare   |NSAID or no exposure |        5|  213| 0.20| 0.25|
|Medicare   |NSAID or no exposure |        6|  114| 0.25| 0.29|
|Medicare   |NSAID or no exposure |        7|  110| 0.29| 0.35|
|Medicare   |NSAID or no exposure |        8|   68| 0.35| 0.43|
|Medicare   |NSAID or no exposure |        9|   48| 0.43| 0.53|
|Medicare   |NSAID or no exposure |       10|   34| 0.54| 0.84|

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



![covarBalRxAntibiotics.png](../figures/covarBalRxAntibiotics.png)



![covarBalIPAdmit12mPrior.png](../figures/covarBalIPAdmit12mPrior.png)



![covarBalERVisit12mPrior.png](../figures/covarBalERVisit12mPrior.png)



![covarBalAVRheum12mPrior.png](../figures/covarBalAVRheum12mPrior.png)



![covarBalRxBiologics.png](../figures/covarBalRxBiologics.png)



![covarBalOutpatientInfection.png](../figures/covarBalOutpatientInfection.png)




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


