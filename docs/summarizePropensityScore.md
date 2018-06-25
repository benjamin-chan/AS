# Propensity score

June 25, 2018


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
|FALSE            |MPCD       |TNF                          |   28| 0.946| 0.999|   1.001|   1.057|
|FALSE            |MPCD       |DMARD, NSAID, or no exposure |   46| 0.003| 0.013|   1.003|   1.013|
|FALSE            |Marketscan |TNF                          |   24| 0.018| 0.977|   1.023|  54.554|
|FALSE            |Medicare   |TNF                          |    4| 0.989| 0.998|   1.002|   1.011|
|FALSE            |Medicare   |DMARD, NSAID, or no exposure | 7249| 0.000| 0.009|   1.000|   1.009|
|TRUE             |MPCD       |TNF                          |  966| 0.013| 0.940|   1.064|  78.104|
|TRUE             |MPCD       |DMARD, NSAID, or no exposure | 2358| 0.013| 0.942|   1.013|  17.248|
|TRUE             |Marketscan |TNF                          | 4744| 0.043| 0.945|   1.058|  23.520|
|TRUE             |Marketscan |DMARD, NSAID, or no exposure | 8838| 0.019| 0.945|   1.019|  18.205|
|TRUE             |Medicare   |TNF                          | 1285| 0.009| 0.986|   1.014| 107.961|
|TRUE             |Medicare   |DMARD, NSAID, or no exposure | 6945| 0.009| 0.987|   1.009|  74.394|

\newline

Summarize common support region bounds.


|database   | commonSupportLowerBound| commonSupportUpperBound|
|:----------|-----------------------:|-----------------------:|
|MPCD       |               0.0128034|               0.9420227|
|Marketscan |               0.0185684|               0.9450698|
|Medicare   |               0.0092626|               0.9865581|

Create propensity score deciles cutpoints.






## Covariate balance

Include only episodes with propensity scores in the common support region.



**Propensity of TNF.**
Create propensity score deciles.


|database   |exposure                     | psDecile|    n|  min|  max|
|:----------|:----------------------------|--------:|----:|----:|----:|
|MPCD       |TNF                          |        1|   97| 0.01| 0.15|
|MPCD       |TNF                          |        2|   97| 0.15| 0.23|
|MPCD       |TNF                          |        3|   97| 0.23| 0.30|
|MPCD       |TNF                          |        4|   96| 0.30| 0.37|
|MPCD       |TNF                          |        5|   96| 0.37| 0.46|
|MPCD       |TNF                          |        6|   97| 0.46| 0.56|
|MPCD       |TNF                          |        7|   96| 0.56| 0.64|
|MPCD       |TNF                          |        8|   97| 0.64| 0.73|
|MPCD       |TNF                          |        9|   96| 0.74| 0.83|
|MPCD       |TNF                          |       10|   97| 0.83| 0.94|
|MPCD       |DMARD, NSAID, or no exposure |        1| 1094| 0.01| 0.15|
|MPCD       |DMARD, NSAID, or no exposure |        2|  450| 0.15| 0.23|
|MPCD       |DMARD, NSAID, or no exposure |        3|  254| 0.23| 0.30|
|MPCD       |DMARD, NSAID, or no exposure |        4|  176| 0.30| 0.37|
|MPCD       |DMARD, NSAID, or no exposure |        5|  144| 0.37| 0.46|
|MPCD       |DMARD, NSAID, or no exposure |        6|   99| 0.46| 0.56|
|MPCD       |DMARD, NSAID, or no exposure |        7|   44| 0.56| 0.64|
|MPCD       |DMARD, NSAID, or no exposure |        8|   48| 0.64| 0.73|
|MPCD       |DMARD, NSAID, or no exposure |        9|   31| 0.74| 0.83|
|MPCD       |DMARD, NSAID, or no exposure |       10|   18| 0.83| 0.94|
|Marketscan |TNF                          |        1|  475| 0.04| 0.20|
|Marketscan |TNF                          |        2|  474| 0.20| 0.26|
|Marketscan |TNF                          |        3|  474| 0.26| 0.31|
|Marketscan |TNF                          |        4|  475| 0.31| 0.36|
|Marketscan |TNF                          |        5|  474| 0.36| 0.44|
|Marketscan |TNF                          |        6|  474| 0.44| 0.53|
|Marketscan |TNF                          |        7|  475| 0.53| 0.63|
|Marketscan |TNF                          |        8|  474| 0.63| 0.72|
|Marketscan |TNF                          |        9|  474| 0.72| 0.79|
|Marketscan |TNF                          |       10|  475| 0.79| 0.94|
|Marketscan |DMARD, NSAID, or no exposure |        1| 3152| 0.02| 0.20|
|Marketscan |DMARD, NSAID, or no exposure |        2| 1652| 0.20| 0.26|
|Marketscan |DMARD, NSAID, or no exposure |        3| 1173| 0.26| 0.31|
|Marketscan |DMARD, NSAID, or no exposure |        4|  925| 0.31| 0.36|
|Marketscan |DMARD, NSAID, or no exposure |        5|  685| 0.36| 0.44|
|Marketscan |DMARD, NSAID, or no exposure |        6|  404| 0.44| 0.53|
|Marketscan |DMARD, NSAID, or no exposure |        7|  299| 0.53| 0.63|
|Marketscan |DMARD, NSAID, or no exposure |        8|  268| 0.63| 0.72|
|Marketscan |DMARD, NSAID, or no exposure |        9|  169| 0.72| 0.79|
|Marketscan |DMARD, NSAID, or no exposure |       10|  111| 0.79| 0.95|
|Medicare   |TNF                          |        1|  129| 0.01| 0.07|
|Medicare   |TNF                          |        2|  128| 0.07| 0.12|
|Medicare   |TNF                          |        3|  129| 0.12| 0.18|
|Medicare   |TNF                          |        4|  128| 0.18| 0.24|
|Medicare   |TNF                          |        5|  129| 0.24| 0.31|
|Medicare   |TNF                          |        6|  128| 0.31| 0.41|
|Medicare   |TNF                          |        7|  128| 0.42| 0.53|
|Medicare   |TNF                          |        8|  129| 0.53| 0.70|
|Medicare   |TNF                          |        9|  128| 0.70| 0.84|
|Medicare   |TNF                          |       10|  129| 0.84| 0.99|
|Medicare   |DMARD, NSAID, or no exposure |        1| 3726| 0.01| 0.07|
|Medicare   |DMARD, NSAID, or no exposure |        2| 1246| 0.07| 0.12|
|Medicare   |DMARD, NSAID, or no exposure |        3|  704| 0.12| 0.18|
|Medicare   |DMARD, NSAID, or no exposure |        4|  447| 0.18| 0.24|
|Medicare   |DMARD, NSAID, or no exposure |        5|  300| 0.24| 0.31|
|Medicare   |DMARD, NSAID, or no exposure |        6|  239| 0.31| 0.41|
|Medicare   |DMARD, NSAID, or no exposure |        7|  121| 0.41| 0.53|
|Medicare   |DMARD, NSAID, or no exposure |        8|  110| 0.54| 0.69|
|Medicare   |DMARD, NSAID, or no exposure |        9|   35| 0.70| 0.83|
|Medicare   |DMARD, NSAID, or no exposure |       10|   17| 0.84| 0.99|

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


