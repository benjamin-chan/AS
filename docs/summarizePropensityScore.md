# Propensity score

May 22, 2018


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
|FALSE            |MPCD       |TNF                  |   76| 0.792| 0.960|   1.042|   1.262|
|FALSE            |MPCD       |DMARD                |   25| 0.000| 0.063|   1.000|   1.067|
|FALSE            |MPCD       |NSAID or no exposure |   99| 0.000| 0.951|   1.000|  20.304|
|FALSE            |Marketscan |TNF                  | 1027| 0.956| 1.000|   1.000|   1.046|
|FALSE            |Marketscan |DMARD                |    2| 0.021| 0.025|   1.021|   1.026|
|FALSE            |Marketscan |NSAID or no exposure |   87| 0.005| 0.966|   1.005|  29.465|
|FALSE            |Medicare   |TNF                  |  591| 0.573| 1.000|   1.000|   1.746|
|FALSE            |Medicare   |DMARD                |   10| 0.000| 0.012|   1.000|   1.013|
|FALSE            |Medicare   |NSAID or no exposure |  378| 0.000| 0.850|   1.000|   6.672|
|TRUE             |MPCD       |TNF                  |  594| 0.064| 0.792|   1.262|  15.719|
|TRUE             |MPCD       |DMARD                |  140| 0.066| 0.792|   1.070|   4.812|
|TRUE             |MPCD       |NSAID or no exposure |  768| 0.065| 0.779|   1.070|   4.516|
|TRUE             |Marketscan |TNF                  | 2426| 0.031| 0.956|   1.046|  32.445|
|TRUE             |Marketscan |DMARD                |  775| 0.037| 0.956|   1.038|  22.614|
|TRUE             |Marketscan |NSAID or no exposure | 3345| 0.031| 0.948|   1.032|  19.091|
|TRUE             |Medicare   |TNF                  | 2677| 0.014| 0.572|   1.747|  71.923|
|TRUE             |Medicare   |DMARD                | 1678| 0.018| 0.573|   1.018|   2.340|
|TRUE             |Medicare   |NSAID or no exposure | 6258| 0.015| 0.573|   1.015|   2.339|

\newline

Summarize common support region bounds.


|database   | commonSupportLowerBound| commonSupportUpperBound|
|:----------|-----------------------:|-----------------------:|
|MPCD       |               0.0636161|               0.7921927|
|Marketscan |               0.0308216|               0.9557802|
|Medicare   |               0.0139038|               0.5727082|

Create propensity score deciles cutpoints.






## Covariate balance

Include only episodes with propensity scores in the common support region.



**Propensity of TNF.**
Create propensity score deciles.


|database   |exposure             | psDecile|    n|  min|  max|
|:----------|:--------------------|--------:|----:|----:|----:|
|MPCD       |TNF                  |        1|   88| 0.06| 0.28|
|MPCD       |TNF                  |        2|   45| 0.28| 0.29|
|MPCD       |TNF                  |        3|   45| 0.30| 0.43|
|MPCD       |TNF                  |        4|  111| 0.43| 0.46|
|MPCD       |TNF                  |        5|   34| 0.46| 0.47|
|MPCD       |TNF                  |        6|   52| 0.47| 0.49|
|MPCD       |TNF                  |        7|   50| 0.49| 0.52|
|MPCD       |TNF                  |        8|   50| 0.52| 0.60|
|MPCD       |TNF                  |        9|   60| 0.60| 0.70|
|MPCD       |TNF                  |       10|   59| 0.70| 0.79|
|MPCD       |DMARD                |        1|   53| 0.07| 0.28|
|MPCD       |DMARD                |        2|   14| 0.29| 0.29|
|MPCD       |DMARD                |        3|   11| 0.29| 0.43|
|MPCD       |DMARD                |        4|   22| 0.44| 0.46|
|MPCD       |DMARD                |        5|    5| 0.47| 0.47|
|MPCD       |DMARD                |        6|    9| 0.49| 0.49|
|MPCD       |DMARD                |        7|    6| 0.49| 0.52|
|MPCD       |DMARD                |        8|    7| 0.52| 0.59|
|MPCD       |DMARD                |        9|    8| 0.61| 0.67|
|MPCD       |DMARD                |       10|    5| 0.74| 0.79|
|MPCD       |NSAID or no exposure |        1|  327| 0.07| 0.28|
|MPCD       |NSAID or no exposure |        2|   59| 0.28| 0.29|
|MPCD       |NSAID or no exposure |        3|   81| 0.29| 0.43|
|MPCD       |NSAID or no exposure |        4|  114| 0.43| 0.46|
|MPCD       |NSAID or no exposure |        5|   32| 0.47| 0.47|
|MPCD       |NSAID or no exposure |        6|   43| 0.47| 0.49|
|MPCD       |NSAID or no exposure |        7|   42| 0.49| 0.52|
|MPCD       |NSAID or no exposure |        8|   31| 0.52| 0.60|
|MPCD       |NSAID or no exposure |        9|   24| 0.61| 0.69|
|MPCD       |NSAID or no exposure |       10|   15| 0.70| 0.78|
|Marketscan |TNF                  |        1|  280| 0.03| 0.22|
|Marketscan |TNF                  |        2|  256| 0.22| 0.25|
|Marketscan |TNF                  |        3|  222| 0.26| 0.28|
|Marketscan |TNF                  |        4|  213| 0.28| 0.34|
|Marketscan |TNF                  |        5|  242| 0.34| 0.51|
|Marketscan |TNF                  |        6|  243| 0.51| 0.64|
|Marketscan |TNF                  |        7|  242| 0.65| 0.77|
|Marketscan |TNF                  |        8|  243| 0.77| 0.86|
|Marketscan |TNF                  |        9|  242| 0.86| 0.92|
|Marketscan |TNF                  |       10|  243| 0.92| 0.96|
|Marketscan |DMARD                |        1|  285| 0.04| 0.22|
|Marketscan |DMARD                |        2|  147| 0.22| 0.25|
|Marketscan |DMARD                |        3|  107| 0.25| 0.28|
|Marketscan |DMARD                |        4|   83| 0.28| 0.34|
|Marketscan |DMARD                |        5|   93| 0.34| 0.51|
|Marketscan |DMARD                |        6|   35| 0.51| 0.64|
|Marketscan |DMARD                |        7|   15| 0.65| 0.75|
|Marketscan |DMARD                |        8|    6| 0.79| 0.84|
|Marketscan |DMARD                |        9|    3| 0.87| 0.91|
|Marketscan |DMARD                |       10|    1| 0.96| 0.96|
|Marketscan |NSAID or no exposure |        1| 1297| 0.03| 0.22|
|Marketscan |NSAID or no exposure |        2|  485| 0.22| 0.25|
|Marketscan |NSAID or no exposure |        3|  304| 0.25| 0.28|
|Marketscan |NSAID or no exposure |        4|  407| 0.28| 0.34|
|Marketscan |NSAID or no exposure |        5|  504| 0.34| 0.51|
|Marketscan |NSAID or no exposure |        6|  192| 0.51| 0.64|
|Marketscan |NSAID or no exposure |        7|   85| 0.64| 0.77|
|Marketscan |NSAID or no exposure |        8|   45| 0.77| 0.86|
|Marketscan |NSAID or no exposure |        9|   15| 0.86| 0.92|
|Marketscan |NSAID or no exposure |       10|   11| 0.92| 0.95|
|Medicare   |TNF                  |        1|  268| 0.01| 0.13|
|Medicare   |TNF                  |        2|  268| 0.13| 0.20|
|Medicare   |TNF                  |        3|  267| 0.20| 0.25|
|Medicare   |TNF                  |        4|  268| 0.25| 0.31|
|Medicare   |TNF                  |        5|  268| 0.31| 0.36|
|Medicare   |TNF                  |        6|  267| 0.36| 0.41|
|Medicare   |TNF                  |        7|  268| 0.41| 0.46|
|Medicare   |TNF                  |        8|  267| 0.46| 0.50|
|Medicare   |TNF                  |        9|  268| 0.50| 0.53|
|Medicare   |TNF                  |       10|  268| 0.54| 0.57|
|Medicare   |DMARD                |        1|  947| 0.02| 0.13|
|Medicare   |DMARD                |        2|  402| 0.13| 0.20|
|Medicare   |DMARD                |        3|  154| 0.20| 0.25|
|Medicare   |DMARD                |        4|   72| 0.25| 0.31|
|Medicare   |DMARD                |        5|   39| 0.31| 0.36|
|Medicare   |DMARD                |        6|   30| 0.36| 0.41|
|Medicare   |DMARD                |        7|   17| 0.41| 0.45|
|Medicare   |DMARD                |        8|    7| 0.46| 0.49|
|Medicare   |DMARD                |        9|    3| 0.50| 0.52|
|Medicare   |DMARD                |       10|    7| 0.54| 0.57|
|Medicare   |NSAID or no exposure |        1| 1978| 0.01| 0.13|
|Medicare   |NSAID or no exposure |        2|  970| 0.13| 0.20|
|Medicare   |NSAID or no exposure |        3|  822| 0.20| 0.25|
|Medicare   |NSAID or no exposure |        4|  633| 0.25| 0.31|
|Medicare   |NSAID or no exposure |        5|  463| 0.31| 0.36|
|Medicare   |NSAID or no exposure |        6|  332| 0.36| 0.41|
|Medicare   |NSAID or no exposure |        7|  356| 0.41| 0.46|
|Medicare   |NSAID or no exposure |        8|  266| 0.46| 0.50|
|Medicare   |NSAID or no exposure |        9|  238| 0.50| 0.53|
|Medicare   |NSAID or no exposure |       10|  200| 0.54| 0.57|

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


