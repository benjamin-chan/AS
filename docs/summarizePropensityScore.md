# Propensity score

April 09, 2018


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
indAVRheumEncounters | Outpatient rheumatologist encounter 12 months prior
indBiologics12mPrior | Any biologics use 12 months prior

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
|FALSE            |MPCD       |TNF                  |    65| 0.021| 0.988|   1.012|  46.797|
|FALSE            |MPCD       |DMARD                |     4| 0.915| 0.936|  11.818|  15.536|
|FALSE            |MPCD       |NSAID or no exposure |   182| 0.005| 0.029|   1.005|   1.030|
|FALSE            |Marketscan |TNF                  |    23| 0.958| 0.973|   1.027|   1.044|
|FALSE            |Marketscan |DMARD                |     3| 0.007| 0.968|   1.007|  31.537|
|FALSE            |Marketscan |NSAID or no exposure |    92| 0.003| 0.019|   1.003|   1.019|
|FALSE            |Medicare   |TNF                  |    10| 0.854| 0.890|   1.124|   1.171|
|FALSE            |Medicare   |DMARD                |     2| 0.004| 0.005|   1.004|   1.005|
|FALSE            |Medicare   |NSAID or no exposure |   304| 0.002| 0.859|   1.002|   7.075|
|TRUE             |MPCD       |TNF                  |  1213| 0.034| 0.899|   1.113|  29.104|
|TRUE             |MPCD       |DMARD                |   477| 0.030| 0.870|   1.031|   7.687|
|TRUE             |MPCD       |NSAID or no exposure |  2411| 0.030| 0.900|   1.031|   9.952|
|TRUE             |Marketscan |TNF                  |  5756| 0.019| 0.957|   1.045|  52.728|
|TRUE             |Marketscan |DMARD                |  2042| 0.027| 0.957|   1.028|  23.301|
|TRUE             |Marketscan |NSAID or no exposure | 10497| 0.019| 0.957|   1.020|  23.436|
|TRUE             |Medicare   |TNF                  |  5919| 0.009| 0.852|   1.173| 113.534|
|TRUE             |Medicare   |DMARD                |  5191| 0.009| 0.852|   1.009|   6.774|
|TRUE             |Medicare   |NSAID or no exposure | 25818| 0.009| 0.852|   1.009|   6.774|
|NA               |MPCD       |TNF                  |     1|    NA|    NA|      NA|      NA|

\newline


|database   | commonSupportLowerBound| commonSupportUpperBound|
|:----------|-----------------------:|-----------------------:|
|MPCD       |               0.0297569|               0.8995214|
|Marketscan |               0.0189651|               0.9573297|
|Medicare   |               0.0088080|               0.8523810|

Create propensity score deciles cutpoints.






## Covariate balance

Include only episodes with propensity scores in the common support region.



**Propensity of TNF.**
Create propensity score deciles.


|database   |exposure             | psDecile|     n|  min|  max|
|:----------|:--------------------|--------:|-----:|----:|----:|
|MPCD       |TNF                  |        1|   122| 0.03| 0.17|
|MPCD       |TNF                  |        2|   121| 0.17| 0.22|
|MPCD       |TNF                  |        3|   122| 0.22| 0.27|
|MPCD       |TNF                  |        4|   120| 0.27| 0.31|
|MPCD       |TNF                  |        5|   124| 0.31| 0.36|
|MPCD       |TNF                  |        6|   119| 0.36| 0.41|
|MPCD       |TNF                  |        7|   121| 0.41| 0.67|
|MPCD       |TNF                  |        8|   121| 0.67| 0.77|
|MPCD       |TNF                  |        9|   124| 0.77| 0.83|
|MPCD       |TNF                  |       10|   119| 0.83| 0.90|
|MPCD       |DMARD                |        1|    78| 0.03| 0.17|
|MPCD       |DMARD                |        2|    59| 0.17| 0.22|
|MPCD       |DMARD                |        3|    84| 0.22| 0.27|
|MPCD       |DMARD                |        4|    56| 0.27| 0.31|
|MPCD       |DMARD                |        5|    68| 0.31| 0.36|
|MPCD       |DMARD                |        6|    58| 0.36| 0.41|
|MPCD       |DMARD                |        7|    58| 0.41| 0.65|
|MPCD       |DMARD                |        8|     5| 0.68| 0.75|
|MPCD       |DMARD                |        9|     6| 0.78| 0.79|
|MPCD       |DMARD                |       10|     5| 0.84| 0.87|
|MPCD       |NSAID or no exposure |        1|   998| 0.03| 0.17|
|MPCD       |NSAID or no exposure |        2|   414| 0.17| 0.22|
|MPCD       |NSAID or no exposure |        3|   293| 0.22| 0.27|
|MPCD       |NSAID or no exposure |        4|   234| 0.27| 0.31|
|MPCD       |NSAID or no exposure |        5|   187| 0.31| 0.36|
|MPCD       |NSAID or no exposure |        6|   105| 0.36| 0.41|
|MPCD       |NSAID or no exposure |        7|   107| 0.41| 0.66|
|MPCD       |NSAID or no exposure |        8|    30| 0.67| 0.77|
|MPCD       |NSAID or no exposure |        9|    24| 0.77| 0.83|
|MPCD       |NSAID or no exposure |       10|    19| 0.84| 0.90|
|Marketscan |TNF                  |        1|   583| 0.02| 0.18|
|Marketscan |TNF                  |        2|   570| 0.18| 0.22|
|Marketscan |TNF                  |        3|   574| 0.22| 0.26|
|Marketscan |TNF                  |        4|   576| 0.26| 0.30|
|Marketscan |TNF                  |        5|   576| 0.31| 0.37|
|Marketscan |TNF                  |        6|   575| 0.37| 0.55|
|Marketscan |TNF                  |        7|   575| 0.55| 0.78|
|Marketscan |TNF                  |        8|   577| 0.78| 0.83|
|Marketscan |TNF                  |        9|   574| 0.83| 0.87|
|Marketscan |TNF                  |       10|   576| 0.87| 0.96|
|Marketscan |DMARD                |        1|   374| 0.03| 0.18|
|Marketscan |DMARD                |        2|   302| 0.18| 0.22|
|Marketscan |DMARD                |        3|   352| 0.22| 0.26|
|Marketscan |DMARD                |        4|   300| 0.26| 0.30|
|Marketscan |DMARD                |        5|   341| 0.30| 0.37|
|Marketscan |DMARD                |        6|   232| 0.37| 0.55|
|Marketscan |DMARD                |        7|    57| 0.55| 0.78|
|Marketscan |DMARD                |        8|    26| 0.78| 0.83|
|Marketscan |DMARD                |        9|    33| 0.83| 0.87|
|Marketscan |DMARD                |       10|    25| 0.87| 0.96|
|Marketscan |NSAID or no exposure |        1|  4298| 0.02| 0.18|
|Marketscan |NSAID or no exposure |        2|  1990| 0.18| 0.22|
|Marketscan |NSAID or no exposure |        3|  1382| 0.22| 0.26|
|Marketscan |NSAID or no exposure |        4|  1106| 0.26| 0.30|
|Marketscan |NSAID or no exposure |        5|   841| 0.30| 0.37|
|Marketscan |NSAID or no exposure |        6|   483| 0.37| 0.55|
|Marketscan |NSAID or no exposure |        7|   150| 0.55| 0.78|
|Marketscan |NSAID or no exposure |        8|   109| 0.78| 0.83|
|Marketscan |NSAID or no exposure |        9|    85| 0.84| 0.87|
|Marketscan |NSAID or no exposure |       10|    53| 0.87| 0.96|
|Medicare   |TNF                  |        1|   592| 0.01| 0.08|
|Medicare   |TNF                  |        2|   592| 0.08| 0.12|
|Medicare   |TNF                  |        3|   592| 0.12| 0.14|
|Medicare   |TNF                  |        4|   592| 0.14| 0.18|
|Medicare   |TNF                  |        5|   596| 0.18| 0.23|
|Medicare   |TNF                  |        6|   587| 0.23| 0.32|
|Medicare   |TNF                  |        7|   592| 0.32| 0.49|
|Medicare   |TNF                  |        8|   592| 0.49| 0.60|
|Medicare   |TNF                  |        9|   592| 0.60| 0.67|
|Medicare   |TNF                  |       10|   592| 0.67| 0.85|
|Medicare   |DMARD                |        1|  1196| 0.01| 0.08|
|Medicare   |DMARD                |        2|   884| 0.08| 0.12|
|Medicare   |DMARD                |        3|   666| 0.12| 0.14|
|Medicare   |DMARD                |        4|   677| 0.14| 0.18|
|Medicare   |DMARD                |        5|   621| 0.18| 0.23|
|Medicare   |DMARD                |        6|   492| 0.23| 0.32|
|Medicare   |DMARD                |        7|   282| 0.32| 0.49|
|Medicare   |DMARD                |        8|   144| 0.49| 0.60|
|Medicare   |DMARD                |        9|   106| 0.60| 0.67|
|Medicare   |DMARD                |       10|   123| 0.67| 0.85|
|Medicare   |NSAID or no exposure |        1| 12122| 0.01| 0.08|
|Medicare   |NSAID or no exposure |        2|  4612| 0.08| 0.12|
|Medicare   |NSAID or no exposure |        3|  2845| 0.12| 0.14|
|Medicare   |NSAID or no exposure |        4|  2225| 0.14| 0.18|
|Medicare   |NSAID or no exposure |        5|  1755| 0.18| 0.23|
|Medicare   |NSAID or no exposure |        6|   988| 0.23| 0.32|
|Medicare   |NSAID or no exposure |        7|   507| 0.32| 0.49|
|Medicare   |NSAID or no exposure |        8|   344| 0.49| 0.60|
|Medicare   |NSAID or no exposure |        9|   236| 0.60| 0.67|
|Medicare   |NSAID or no exposure |       10|   184| 0.67| 0.85|

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



![covarBalAVRheumEncounters.png](../figures/covarBalAVRheumEncounters.png)



![covarBalBiologics12mPrior.png](../figures/covarBalBiologics12mPrior.png)




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


