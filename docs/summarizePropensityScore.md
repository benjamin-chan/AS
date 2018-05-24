# Propensity score

May 24, 2018


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
|FALSE            |MPCD       |TNF                  |   36| 0.933| 1.000|   1.000|   1.072|
|FALSE            |MPCD       |DMARD                |   19| 0.000| 0.050|   1.000|   1.053|
|FALSE            |MPCD       |NSAID or no exposure |   87| 0.001| 0.934|   1.001|  15.262|
|FALSE            |Marketscan |TNF                  | 1215| 0.946| 1.000|   1.000|   1.058|
|FALSE            |Marketscan |DMARD                |    6| 0.016| 0.978|   1.017|  46.285|
|FALSE            |Marketscan |NSAID or no exposure |   21| 0.011| 0.020|   1.011|   1.020|
|FALSE            |Medicare   |TNF                  |  574| 0.684| 0.959|   1.043|   1.463|
|FALSE            |Medicare   |DMARD                |    5| 0.018| 0.020|   1.018|   1.020|
|FALSE            |Medicare   |NSAID or no exposure |  149| 0.010| 0.895|   1.010|   9.488|
|TRUE             |MPCD       |TNF                  |  634| 0.051| 0.932|   1.073|  19.596|
|TRUE             |MPCD       |DMARD                |  146| 0.056| 0.933|   1.059|  14.843|
|TRUE             |MPCD       |NSAID or no exposure |  780| 0.051| 0.918|   1.054|  12.234|
|TRUE             |Marketscan |TNF                  | 2238| 0.020| 0.945|   1.058|  48.812|
|TRUE             |Marketscan |DMARD                |  771| 0.022| 0.940|   1.023|  16.754|
|TRUE             |Marketscan |NSAID or no exposure | 3411| 0.021| 0.945|   1.021|  18.283|
|TRUE             |Medicare   |TNF                  | 2694| 0.020| 0.683|   1.464|  49.882|
|TRUE             |Medicare   |DMARD                | 1683| 0.021| 0.683|   1.021|   3.157|
|TRUE             |Medicare   |NSAID or no exposure | 6487| 0.021| 0.683|   1.021|   3.155|

\newline

Summarize common support region bounds.


|database   | commonSupportLowerBound| commonSupportUpperBound|
|:----------|-----------------------:|-----------------------:|
|MPCD       |               0.0510305|               0.9326278|
|Marketscan |               0.0204868|               0.9453038|
|Medicare   |               0.0200474|               0.6832805|

Create propensity score deciles cutpoints.






## Covariate balance

Include only episodes with propensity scores in the common support region.



**Propensity of TNF.**
Create propensity score deciles.


|database   |exposure             | psDecile|    n|  min|  max|
|:----------|:--------------------|--------:|----:|----:|----:|
|MPCD       |TNF                  |        1|   64| 0.05| 0.23|
|MPCD       |TNF                  |        2|   63| 0.24| 0.31|
|MPCD       |TNF                  |        3|   64| 0.31| 0.36|
|MPCD       |TNF                  |        4|   63| 0.36| 0.48|
|MPCD       |TNF                  |        5|   63| 0.48| 0.56|
|MPCD       |TNF                  |        6|   63| 0.56| 0.66|
|MPCD       |TNF                  |        7|   64| 0.66| 0.72|
|MPCD       |TNF                  |        8|   63| 0.72| 0.79|
|MPCD       |TNF                  |        9|   63| 0.79| 0.87|
|MPCD       |TNF                  |       10|   64| 0.87| 0.93|
|MPCD       |DMARD                |        1|   49| 0.06| 0.23|
|MPCD       |DMARD                |        2|   16| 0.24| 0.30|
|MPCD       |DMARD                |        3|   16| 0.31| 0.36|
|MPCD       |DMARD                |        4|   18| 0.39| 0.48|
|MPCD       |DMARD                |        5|   20| 0.49| 0.55|
|MPCD       |DMARD                |        6|   10| 0.58| 0.65|
|MPCD       |DMARD                |        7|    6| 0.67| 0.72|
|MPCD       |DMARD                |        8|    7| 0.72| 0.78|
|MPCD       |DMARD                |        9|    3| 0.82| 0.84|
|MPCD       |DMARD                |       10|    1| 0.93| 0.93|
|MPCD       |NSAID or no exposure |        1|  351| 0.05| 0.23|
|MPCD       |NSAID or no exposure |        2|  134| 0.23| 0.31|
|MPCD       |NSAID or no exposure |        3|   96| 0.31| 0.36|
|MPCD       |NSAID or no exposure |        4|   69| 0.36| 0.48|
|MPCD       |NSAID or no exposure |        5|   44| 0.48| 0.56|
|MPCD       |NSAID or no exposure |        6|   34| 0.56| 0.66|
|MPCD       |NSAID or no exposure |        7|   21| 0.67| 0.72|
|MPCD       |NSAID or no exposure |        8|   10| 0.72| 0.78|
|MPCD       |NSAID or no exposure |        9|   17| 0.79| 0.85|
|MPCD       |NSAID or no exposure |       10|    4| 0.88| 0.92|
|Marketscan |TNF                  |        1|  224| 0.02| 0.15|
|Marketscan |TNF                  |        2|  230| 0.15| 0.22|
|Marketscan |TNF                  |        3|  218| 0.22| 0.35|
|Marketscan |TNF                  |        4|  223| 0.35| 0.46|
|Marketscan |TNF                  |        5|  224| 0.46| 0.55|
|Marketscan |TNF                  |        6|  224| 0.55| 0.66|
|Marketscan |TNF                  |        7|  223| 0.66| 0.77|
|Marketscan |TNF                  |        8|  224| 0.77| 0.85|
|Marketscan |TNF                  |        9|  224| 0.85| 0.91|
|Marketscan |TNF                  |       10|  224| 0.91| 0.95|
|Marketscan |DMARD                |        1|  276| 0.02| 0.15|
|Marketscan |DMARD                |        2|  203| 0.15| 0.22|
|Marketscan |DMARD                |        3|  110| 0.22| 0.35|
|Marketscan |DMARD                |        4|   70| 0.35| 0.45|
|Marketscan |DMARD                |        5|   51| 0.46| 0.55|
|Marketscan |DMARD                |        6|   26| 0.55| 0.65|
|Marketscan |DMARD                |        7|   17| 0.67| 0.76|
|Marketscan |DMARD                |        8|    8| 0.77| 0.83|
|Marketscan |DMARD                |        9|    5| 0.85| 0.90|
|Marketscan |DMARD                |       10|    5| 0.91| 0.94|
|Marketscan |NSAID or no exposure |        1| 1359| 0.02| 0.15|
|Marketscan |NSAID or no exposure |        2|  707| 0.15| 0.22|
|Marketscan |NSAID or no exposure |        3|  568| 0.22| 0.35|
|Marketscan |NSAID or no exposure |        4|  268| 0.35| 0.46|
|Marketscan |NSAID or no exposure |        5|  197| 0.46| 0.55|
|Marketscan |NSAID or no exposure |        6|  150| 0.55| 0.66|
|Marketscan |NSAID or no exposure |        7|   93| 0.67| 0.77|
|Marketscan |NSAID or no exposure |        8|   37| 0.77| 0.85|
|Marketscan |NSAID or no exposure |        9|   18| 0.85| 0.90|
|Marketscan |NSAID or no exposure |       10|   14| 0.91| 0.95|
|Medicare   |TNF                  |        1|  270| 0.02| 0.12|
|Medicare   |TNF                  |        2|  269| 0.12| 0.18|
|Medicare   |TNF                  |        3|  269| 0.18| 0.24|
|Medicare   |TNF                  |        4|  270| 0.24| 0.30|
|Medicare   |TNF                  |        5|  269| 0.30| 0.35|
|Medicare   |TNF                  |        6|  269| 0.35| 0.41|
|Medicare   |TNF                  |        7|  270| 0.41| 0.47|
|Medicare   |TNF                  |        8|  269| 0.47| 0.54|
|Medicare   |TNF                  |        9|  269| 0.54| 0.62|
|Medicare   |TNF                  |       10|  270| 0.62| 0.68|
|Medicare   |DMARD                |        1|  827| 0.02| 0.12|
|Medicare   |DMARD                |        2|  384| 0.12| 0.18|
|Medicare   |DMARD                |        3|  171| 0.18| 0.24|
|Medicare   |DMARD                |        4|  131| 0.24| 0.30|
|Medicare   |DMARD                |        5|   75| 0.30| 0.35|
|Medicare   |DMARD                |        6|   51| 0.35| 0.41|
|Medicare   |DMARD                |        7|   30| 0.41| 0.47|
|Medicare   |DMARD                |        8|   11| 0.48| 0.54|
|Medicare   |DMARD                |        9|    2| 0.55| 0.55|
|Medicare   |DMARD                |       10|    1| 0.68| 0.68|
|Medicare   |NSAID or no exposure |        1| 1957| 0.02| 0.12|
|Medicare   |NSAID or no exposure |        2|  938| 0.12| 0.18|
|Medicare   |NSAID or no exposure |        3|  857| 0.18| 0.24|
|Medicare   |NSAID or no exposure |        4|  773| 0.24| 0.30|
|Medicare   |NSAID or no exposure |        5|  555| 0.30| 0.35|
|Medicare   |NSAID or no exposure |        6|  490| 0.35| 0.41|
|Medicare   |NSAID or no exposure |        7|  405| 0.41| 0.47|
|Medicare   |NSAID or no exposure |        8|  229| 0.47| 0.54|
|Medicare   |NSAID or no exposure |        9|  186| 0.54| 0.62|
|Medicare   |NSAID or no exposure |       10|   97| 0.62| 0.68|

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


