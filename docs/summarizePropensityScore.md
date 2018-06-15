# Propensity score

June 15, 2018


## Description of model

See [`modelPropensityScore.sas`](../scripts/modelPropensityScore.sas) script for details on model.

The propensity of exposure to the two treatments: TNF versus DMARD, NSAID, or no exposure, was modeled using a logistic regression model (SAS `proc logistic`).

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

Model output is probability of exposure to TNF.

Model estimation was performed separately for the 3 data sources: MPCD, Marketscan, and Medicare.
Independent variables were excluded from model estimation if they led to unstable estimates when included in data source-specific models.
This can occur if the covariate is so rare that zero records with this covariate appear in the model estimation cohort.

The common support region lower bound is the maximum of the lowest TNF propensity score among the 2 exposure groups.
The common support region upper bound is the minimum of the greatest TNF propensity score among the 2 exposure groups.

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


|indCommonSupport |database   |exposure                     |    n| minPS| maxPS| minIPTW| maxIPTW|
|:----------------|:----------|:----------------------------|----:|-----:|-----:|-------:|-------:|
|FALSE            |MPCD       |TNF                          |   60| 0.930| 0.998|   1.002|   1.075|
|FALSE            |MPCD       |DMARD, NSAID, or no exposure |   59| 0.004| 0.035|   1.004|   1.036|
|FALSE            |Marketscan |TNF                          |   13| 0.974| 1.000|   1.000|   1.027|
|FALSE            |Marketscan |DMARD, NSAID, or no exposure |    1| 0.008| 0.008|   1.008|   1.008|
|FALSE            |Medicare   |DMARD, NSAID, or no exposure |  118| 0.000| 0.979|   1.000|  47.247|
|TRUE             |MPCD       |TNF                          |  610| 0.035| 0.929|   1.076|  28.432|
|TRUE             |MPCD       |DMARD, NSAID, or no exposure |  973| 0.036| 0.929|   1.037|  14.152|
|TRUE             |Marketscan |TNF                          | 3440| 0.020| 0.970|   1.030|  50.224|
|TRUE             |Marketscan |DMARD, NSAID, or no exposure | 4208| 0.027| 0.971|   1.028|  34.199|
|TRUE             |Medicare   |TNF                          |  810| 0.029| 0.926|   1.080|  34.281|
|TRUE             |Medicare   |DMARD, NSAID, or no exposure | 3397| 0.029| 0.922|   1.030|  12.848|

\newline

Summarize common support region bounds.


|database   | commonSupportLowerBound| commonSupportUpperBound|
|:----------|-----------------------:|-----------------------:|
|MPCD       |               0.0351711|               0.9293361|
|Marketscan |               0.0199106|               0.9707597|
|Medicare   |               0.0291705|               0.9263483|

Create propensity score deciles cutpoints.






## Covariate balance

Include only episodes with propensity scores in the common support region.



**Propensity of TNF.**
Create propensity score deciles.


|database   |exposure                     | psDecile|    n|  min|  max|
|:----------|:----------------------------|--------:|----:|----:|----:|
|MPCD       |TNF                          |        1|   61| 0.04| 0.22|
|MPCD       |TNF                          |        2|   64| 0.22| 0.31|
|MPCD       |TNF                          |        3|   58| 0.31| 0.39|
|MPCD       |TNF                          |        4|   61| 0.39| 0.48|
|MPCD       |TNF                          |        5|   61| 0.48| 0.56|
|MPCD       |TNF                          |        6|   61| 0.56| 0.64|
|MPCD       |TNF                          |        7|   61| 0.64| 0.72|
|MPCD       |TNF                          |        8|   61| 0.72| 0.79|
|MPCD       |TNF                          |        9|   61| 0.79| 0.87|
|MPCD       |TNF                          |       10|   61| 0.87| 0.93|
|MPCD       |DMARD, NSAID, or no exposure |        1|  469| 0.04| 0.22|
|MPCD       |DMARD, NSAID, or no exposure |        2|  155| 0.22| 0.30|
|MPCD       |DMARD, NSAID, or no exposure |        3|   99| 0.31| 0.39|
|MPCD       |DMARD, NSAID, or no exposure |        4|   72| 0.39| 0.48|
|MPCD       |DMARD, NSAID, or no exposure |        5|   64| 0.48| 0.56|
|MPCD       |DMARD, NSAID, or no exposure |        6|   38| 0.56| 0.64|
|MPCD       |DMARD, NSAID, or no exposure |        7|   34| 0.64| 0.71|
|MPCD       |DMARD, NSAID, or no exposure |        8|   16| 0.72| 0.79|
|MPCD       |DMARD, NSAID, or no exposure |        9|   16| 0.80| 0.86|
|MPCD       |DMARD, NSAID, or no exposure |       10|   10| 0.88| 0.93|
|Marketscan |TNF                          |        1|  344| 0.02| 0.24|
|Marketscan |TNF                          |        2|  344| 0.24| 0.38|
|Marketscan |TNF                          |        3|  344| 0.38| 0.47|
|Marketscan |TNF                          |        4|  344| 0.47| 0.54|
|Marketscan |TNF                          |        5|  344| 0.54| 0.60|
|Marketscan |TNF                          |        6|  344| 0.60| 0.67|
|Marketscan |TNF                          |        7|  344| 0.67| 0.75|
|Marketscan |TNF                          |        8|  344| 0.75| 0.83|
|Marketscan |TNF                          |        9|  344| 0.83| 0.88|
|Marketscan |TNF                          |       10|  344| 0.88| 0.97|
|Marketscan |DMARD, NSAID, or no exposure |        1| 1972| 0.03| 0.24|
|Marketscan |DMARD, NSAID, or no exposure |        2|  701| 0.24| 0.38|
|Marketscan |DMARD, NSAID, or no exposure |        3|  408| 0.38| 0.47|
|Marketscan |DMARD, NSAID, or no exposure |        4|  309| 0.47| 0.54|
|Marketscan |DMARD, NSAID, or no exposure |        5|  249| 0.54| 0.60|
|Marketscan |DMARD, NSAID, or no exposure |        6|  214| 0.60| 0.67|
|Marketscan |DMARD, NSAID, or no exposure |        7|  172| 0.67| 0.75|
|Marketscan |DMARD, NSAID, or no exposure |        8|   81| 0.75| 0.82|
|Marketscan |DMARD, NSAID, or no exposure |        9|   54| 0.83| 0.88|
|Marketscan |DMARD, NSAID, or no exposure |       10|   48| 0.88| 0.97|
|Medicare   |TNF                          |        1|   81| 0.03| 0.12|
|Medicare   |TNF                          |        2|   81| 0.12| 0.14|
|Medicare   |TNF                          |        3|   81| 0.14| 0.17|
|Medicare   |TNF                          |        4|   81| 0.17| 0.19|
|Medicare   |TNF                          |        5|   82| 0.19| 0.24|
|Medicare   |TNF                          |        6|   80| 0.24| 0.27|
|Medicare   |TNF                          |        7|   81| 0.27| 0.34|
|Medicare   |TNF                          |        8|   81| 0.34| 0.43|
|Medicare   |TNF                          |        9|   81| 0.43| 0.54|
|Medicare   |TNF                          |       10|   81| 0.54| 0.93|
|Medicare   |DMARD, NSAID, or no exposure |        1| 1287| 0.03| 0.12|
|Medicare   |DMARD, NSAID, or no exposure |        2|  463| 0.12| 0.14|
|Medicare   |DMARD, NSAID, or no exposure |        3|  475| 0.14| 0.17|
|Medicare   |DMARD, NSAID, or no exposure |        4|  278| 0.17| 0.19|
|Medicare   |DMARD, NSAID, or no exposure |        5|  315| 0.19| 0.23|
|Medicare   |DMARD, NSAID, or no exposure |        6|  159| 0.24| 0.27|
|Medicare   |DMARD, NSAID, or no exposure |        7|  161| 0.28| 0.34|
|Medicare   |DMARD, NSAID, or no exposure |        8|  129| 0.34| 0.43|
|Medicare   |DMARD, NSAID, or no exposure |        9|   73| 0.44| 0.54|
|Medicare   |DMARD, NSAID, or no exposure |       10|   57| 0.54| 0.92|

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


