# Propensity score

November 29, 2017


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
|FALSE            |MPCD       |TNF                  |    30| 0.024| 0.963|   1.039|  41.863|
|FALSE            |MPCD       |NSAID or no exposure |    81| 0.011| 0.883|   1.011|   8.544|
|FALSE            |Marketscan |TNF                  |     1| 0.903| 0.903|   1.107|   1.107|
|FALSE            |Marketscan |DMARD                |     2| 0.013| 0.023|   1.013|   1.024|
|FALSE            |Marketscan |NSAID or no exposure |    41| 0.007| 0.881|   1.007|   8.429|
|FALSE            |Medicare   |TNF                  |    23| 0.015| 0.737|   1.356|  68.502|
|FALSE            |Medicare   |NSAID or no exposure |    91| 0.013| 0.694|   1.013|   3.269|
|TRUE             |MPCD       |TNF                  |  1248| 0.051| 0.749|   1.335|  19.704|
|TRUE             |MPCD       |DMARD                |   481| 0.043| 0.752|   1.045|   4.030|
|TRUE             |MPCD       |NSAID or no exposure |  2512| 0.043| 0.732|   1.045|   3.724|
|TRUE             |Marketscan |TNF                  |  5778| 0.031| 0.868|   1.151|  32.655|
|TRUE             |Marketscan |DMARD                |  2043| 0.040| 0.869|   1.042|   7.646|
|TRUE             |Marketscan |NSAID or no exposure | 10548| 0.032| 0.868|   1.033|   7.603|
|TRUE             |Medicare   |TNF                  |  5906| 0.027| 0.675|   1.481|  37.100|
|TRUE             |Medicare   |DMARD                |  5193| 0.025| 0.675|   1.026|   3.079|
|TRUE             |Medicare   |NSAID or no exposure | 26031| 0.025| 0.670|   1.026|   3.032|
|NA               |MPCD       |TNF                  |     1|    NA|    NA|      NA|      NA|

\newline


|database   | commonSupportLowerBound| commonSupportUpperBound|
|:----------|-----------------------:|-----------------------:|
|MPCD       |               0.0427553|               0.7518709|
|Marketscan |               0.0306231|               0.8692118|
|Medicare   |               0.0252691|               0.6752485|

Create propensity score deciles cutpoints.






## Covariate balance

Include only episodes with propensity scores in the common support region.



**Propensity of TNF.**
Create propensity score deciles.


|database   |exposure             | psDecile|    n|  min|  max|
|:----------|:--------------------|--------:|----:|----:|----:|
|MPCD       |TNF                  |        1|  125| 0.05| 0.20|
|MPCD       |TNF                  |        2|  148| 0.20| 0.27|
|MPCD       |TNF                  |        3|  105| 0.27| 0.29|
|MPCD       |TNF                  |        4|  122| 0.29| 0.31|
|MPCD       |TNF                  |        5|  195| 0.31| 0.33|
|MPCD       |TNF                  |        6|   56| 0.33| 0.36|
|MPCD       |TNF                  |        7|  123| 0.37| 0.43|
|MPCD       |TNF                  |        8|  119| 0.43| 0.46|
|MPCD       |TNF                  |        9|  130| 0.46| 0.57|
|MPCD       |TNF                  |       10|  125| 0.58| 0.75|
|MPCD       |DMARD                |        1|   89| 0.04| 0.20|
|MPCD       |DMARD                |        2|   69| 0.20| 0.27|
|MPCD       |DMARD                |        3|   28| 0.27| 0.29|
|MPCD       |DMARD                |        4|   34| 0.29| 0.31|
|MPCD       |DMARD                |        5|   48| 0.32| 0.33|
|MPCD       |DMARD                |        6|   26| 0.33| 0.36|
|MPCD       |DMARD                |        7|   47| 0.37| 0.43|
|MPCD       |DMARD                |        8|   55| 0.43| 0.46|
|MPCD       |DMARD                |        9|   59| 0.46| 0.57|
|MPCD       |DMARD                |       10|   26| 0.58| 0.75|
|MPCD       |NSAID or no exposure |        1|  881| 0.04| 0.20|
|MPCD       |NSAID or no exposure |        2|  393| 0.20| 0.27|
|MPCD       |NSAID or no exposure |        3|  255| 0.27| 0.29|
|MPCD       |NSAID or no exposure |        4|  186| 0.29| 0.31|
|MPCD       |NSAID or no exposure |        5|  330| 0.31| 0.33|
|MPCD       |NSAID or no exposure |        6|   77| 0.33| 0.36|
|MPCD       |NSAID or no exposure |        7|  132| 0.37| 0.43|
|MPCD       |NSAID or no exposure |        8|  112| 0.43| 0.46|
|MPCD       |NSAID or no exposure |        9|  106| 0.46| 0.57|
|MPCD       |NSAID or no exposure |       10|   40| 0.58| 0.73|
|Marketscan |TNF                  |        1|  597| 0.03| 0.23|
|Marketscan |TNF                  |        2|  567| 0.23| 0.27|
|Marketscan |TNF                  |        3|  702| 0.27| 0.28|
|Marketscan |TNF                  |        4|  572| 0.28| 0.30|
|Marketscan |TNF                  |        5|  451| 0.30| 0.32|
|Marketscan |TNF                  |        6|  715| 0.32| 0.39|
|Marketscan |TNF                  |        7|  485| 0.39| 0.41|
|Marketscan |TNF                  |        8|  533| 0.41| 0.47|
|Marketscan |TNF                  |        9|  578| 0.47| 0.56|
|Marketscan |TNF                  |       10|  578| 0.56| 0.87|
|Marketscan |DMARD                |        1|  324| 0.04| 0.23|
|Marketscan |DMARD                |        2|  190| 0.23| 0.27|
|Marketscan |DMARD                |        3|  229| 0.27| 0.28|
|Marketscan |DMARD                |        4|  185| 0.28| 0.30|
|Marketscan |DMARD                |        5|  101| 0.30| 0.32|
|Marketscan |DMARD                |        6|  345| 0.32| 0.39|
|Marketscan |DMARD                |        7|  199| 0.39| 0.41|
|Marketscan |DMARD                |        8|  189| 0.41| 0.47|
|Marketscan |DMARD                |        9|  161| 0.47| 0.56|
|Marketscan |DMARD                |       10|  120| 0.56| 0.87|
|Marketscan |NSAID or no exposure |        1| 2663| 0.03| 0.23|
|Marketscan |NSAID or no exposure |        2| 1433| 0.23| 0.27|
|Marketscan |NSAID or no exposure |        3| 1811| 0.27| 0.28|
|Marketscan |NSAID or no exposure |        4| 1265| 0.28| 0.30|
|Marketscan |NSAID or no exposure |        5|  831| 0.30| 0.32|
|Marketscan |NSAID or no exposure |        6|  922| 0.32| 0.39|
|Marketscan |NSAID or no exposure |        7|  579| 0.39| 0.41|
|Marketscan |NSAID or no exposure |        8|  487| 0.41| 0.46|
|Marketscan |NSAID or no exposure |        9|  349| 0.47| 0.56|
|Marketscan |NSAID or no exposure |       10|  208| 0.56| 0.87|
|Medicare   |TNF                  |        1|  613| 0.03| 0.09|
|Medicare   |TNF                  |        2|  642| 0.09| 0.12|
|Medicare   |TNF                  |        3|  562| 0.12| 0.15|
|Medicare   |TNF                  |        4|  555| 0.15| 0.17|
|Medicare   |TNF                  |        5|  583| 0.18| 0.21|
|Medicare   |TNF                  |        6|  600| 0.21| 0.24|
|Medicare   |TNF                  |        7|  579| 0.24| 0.27|
|Medicare   |TNF                  |        8|  591| 0.27| 0.33|
|Medicare   |TNF                  |        9|  590| 0.33| 0.41|
|Medicare   |TNF                  |       10|  591| 0.41| 0.68|
|Medicare   |DMARD                |        1| 1031| 0.03| 0.09|
|Medicare   |DMARD                |        2|  784| 0.09| 0.12|
|Medicare   |DMARD                |        3|  585| 0.12| 0.15|
|Medicare   |DMARD                |        4|  504| 0.15| 0.17|
|Medicare   |DMARD                |        5|  445| 0.18| 0.21|
|Medicare   |DMARD                |        6|  410| 0.21| 0.24|
|Medicare   |DMARD                |        7|  362| 0.24| 0.27|
|Medicare   |DMARD                |        8|  419| 0.27| 0.33|
|Medicare   |DMARD                |        9|  344| 0.33| 0.41|
|Medicare   |DMARD                |       10|  309| 0.41| 0.68|
|Medicare   |NSAID or no exposure |        1| 9484| 0.03| 0.09|
|Medicare   |NSAID or no exposure |        2| 4661| 0.09| 0.12|
|Medicare   |NSAID or no exposure |        3| 2944| 0.12| 0.15|
|Medicare   |NSAID or no exposure |        4| 2165| 0.15| 0.17|
|Medicare   |NSAID or no exposure |        5| 1786| 0.18| 0.21|
|Medicare   |NSAID or no exposure |        6| 1559| 0.21| 0.24|
|Medicare   |NSAID or no exposure |        7| 1331| 0.24| 0.27|
|Medicare   |NSAID or no exposure |        8|  995| 0.27| 0.33|
|Medicare   |NSAID or no exposure |        9|  676| 0.33| 0.40|
|Medicare   |NSAID or no exposure |       10|  430| 0.41| 0.67|

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


