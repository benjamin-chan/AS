*  University of Alabama at Birmingham                               *
*  AS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=modelIncidenceOutcomes; * type the name of your program here (without the filename extension);
%let pgm=&cmt..sas;
%include "lib\libname.sas" ;
footnote "&pgm.";
* footnote2 "%sysfunc(datetime(),datetime14.)";
title1 '--- AS project ---';
**********************************************************************;
options macrogen mlogic mprint symbolgen;
options nomacrogen nomlogic nomprint nosymbolgen;


ods html
  body = "output\&cmt..html"
  style = Statistical;




/* 
Focusing on the infections (hospitalized and opportunistic) and fractures outcomes,
add corticosteroids to the model (include and exclude from PS model)

From: Kevin Winthrop 
Sent: Friday, January 12, 2018 1:44 PM
To: Benjamin Chan <chanb@ohsu.edu>
Subject: Re: EULAR abstract V9; Final?

What about pulling out AGE and using as a discrete covariate in the model?
Like we discussed doing with steroids. Have you played around with the
hospital infection Outcome yet?


--------------------------------------------------------------------------------

* Check diagnosis codes for OI
                                                                  Cumulative  Cumulative
  Infection_Category                          Frequency  Percent   Frequency    Percent
  --------------------------------------------------------------------------------------
  Candidiasis                                        9     0.38           9       0.38  
  HSV                                                4     0.17          13       0.54  
  aspergillosis                                    140     5.87         153       6.41  
  blastomycosis                                     43     1.80         196       8.21  
  candidiasis                                     1106    46.33        1302      54.55  
  cat-scratch                                        5     0.21        1307      54.75  
  coccidioidomycosis                               129     5.40        1436      60.16  
  cryptococcosis                                     9     0.38        1445      60.54  
  encephalitis                                       4     0.17        1449      60.70  
  endemic mycosis                                   23     0.96        1472      61.67  
  endocarditis                                       7     0.29        1479      61.96  
  filarial or other parasitis                        1     0.04        1480      62.00  
  gastroenteritis                                   13     0.54        1493      62.55  
  herpes                                             6     0.25        1499      62.80  
  histoplasmosis                                   146     6.12        1645      68.91  
  invasive mold                                    231     9.68        1876      78.59  
  listeriosis                                        1     0.04        1877      78.63  
  nontuberculosis mycobacteria                     435    18.22        2312      96.86  
  pneumocystsis                                     42     1.76        2354      98.62  
  progressive multifocal leukoencephalopathy         9     0.38        2363      98.99  
  sporotrichosis                                     8     0.34        2371      99.33  
  toxoplasmosis                                     16     0.67        2387     100.00  
                                Frequency Missing = 92

* Check if double counting Hosp Inf.  
  CONFIRMED: No double-counting of outcomes
 */




/* 
Prepare analytic data set
 */
proc sql;
  create table Work.incidentDiseaseTimelines as
    select coalesce(A.database, B.database) as database,
           coalesce(A.patid, B.patid) as patid,
           coalesce(A.indexDate, B.exposureStart) as indexDate,
           coalesce(A.indexGNN, B.exposureDrug) as indexGNN,
           A.indexID,
           B.exposureID,
           case
             when A.exposure in ("No exposure", "NSAID", "DMARD") then "DMARD, NSAID, or no exposure"
             else A.exposure
             end as exposure2,
           B.outcomeCategory,
           B.disease,
           B.censor,
           B.daysAtRisk,
           B.exposureStart,
           B.exposureEnd,
           B.outcomeDate,
           B.earliestOutcome
    from DT.indexLookup A inner join
         DT.incidentDiseaseTimelines B on (A.database = B.database & 
                                           A.patid = B.patid &
                                           A.indexDate = B.exposureStart &
                                           A.indexGNN = B.exposureDrug);
  create table Work.analyticDataset as
    select coalesce(A.database, B.database) as database,
           B.patid,
           coalesce(A.indexID, B.indexID) as indexID,
           coalesce(A.exposure, B.exposure2) as exposure,
           A.age,
           A.catAge,
           A.sex,
           A.ps,
           A.iptw,
           A.indCommonSupport,
           A.iptwStabilized,
           A.meanPredEqDoseCat,
           A.indHospInf,
           B.outcomeCategory,
           B.disease,
           B.censor,
           B.daysAtRisk,
           B.exposureStart,
           B.exposureEnd,
           B.outcomeDate,
           B.earliestOutcome
    from DT.ps A inner join
         Work.incidentDiseaseTimelines B on (A.database = B.database &
                                             A.indexID = B.indexID &
                                             A.exposure = B.exposure2)
    where A.indCommonSupport = 1 &
          ((B.disease = "Amyloidosis" & indAmyloidosis ^= 1) |
           (B.disease = "Aortic Insufficiency/Aortic Regurgitation" & indAortInsuffRegurg ^= 1) |
           (B.disease = "Apical Pulmonary fibrosis" & indApicalPulmFib ^= 1) |
           (B.disease = "Cauda Equina syndrome" & indCaudaEquina ^= 1) |
           (B.disease = "Clinical vertebral fracture" & indVertFrac ^= 1) |
           (B.disease = "Conduction Block" & indConductBlock ^= 1) |
           (prxmatch("/Crohn.s Disease/", B.disease) & indCrohnsDis ^= 1) |
           (B.disease = "Hematologic Cancer" & indHematCa ^= 1) |
           (B.disease = "Hospitalized infection" /* & indHospInf ^= 1 */) |
           (B.disease = "IgA nephropathy" & indIgANeph ^= 1) |
           (B.disease = "Interstitial lung disease" & indInterstLungDis ^= 1) |
           (B.disease = "Myocardial infarction" & indMI ^= 1) |
           (B.disease = "Nephrotic syndrome" & indNephSyn ^= 1) |
           (B.disease = "Non Melanoma Skin Cancer" /* & indNMSC ^= 1 */) |
           (B.disease = "Non-vertebral osteoporotic fracture" & indNonVertOsFrac ^= 1) |
           (B.disease = "Opportunistic infection" /* & indOppInf ^= 1 */) |
           (B.disease = "Psoriasis" & indPsoriasis ^= 1) |
           (B.disease = "Psoriatic arthritis" & indPSA ^= 1) |
           (prxmatch("/Restrictive lung disease/", B.disease) & indRestrictLungDis ^= 1) |
           (B.disease = "Solid Cancer" & indSolidCa ^= 1) |
           (B.disease = "Spinal Cord compression" & indSpinalCordComp ^= 1) |
           (B.disease = "Ulcerative Colitis" & indUlcerColitis ^= 1) |
           (B.disease = "Uveitis" & indUveitis ^= 1) )
    order by B.outcomeCategory,
             B.disease,
             calculated database,
             B.censor,
             B.patid,
             B.exposureStart;
  create table DT.crudeIncidence as
    select outcomeCategory,
           disease,
           database,
           exposure,
           count(distinct patid) as nPatid,
           count(*) as nExposures,
           sum(censor = 0) as nEvents,
           sum(daysAtRisk) / 365.25 as personYears,
           calculated nEvents / calculated personYears as incidenceRate
    from Work.analyticDataset
    group by outcomeCategory, disease, database, exposure;
  create table Work.crudeIncidence2 as
    select "exposure " || strip(A.exposure) || " vs " || strip(B.exposure) || " At database=" || strip(coalesce(A.database, B.database)) as description,
           coalesce(A.outcomeCategory, B.outcomeCategory) as outcomeCategory,
           coalesce(A.disease, B.disease) as disease,
           A.nPatid as n1,
           B.nPatid as n2,
           A.incidenceRate as incidenceRate1,
           B.incidenceRate as incidenceRate2
    from DT.crudeIncidence A inner join
         DT.crudeIncidence B on (A.outcomeCategory = B.outcomeCategory &
                                 A.disease = B.disease &
                                 A.database = B.database &
                                 A.exposure ^= B.exposure)
    where B.exposure = "TNF";
/* Check */
  /* select "Check exclusions for any prior solid cancer (yes, exclude) and NMSC (no, don't exclude)" as table,
         disease,
         censor,
         indSolidCa,
         indNMSC,
         count(*) as n
  from Work.analyticDataset
  where disease = "Uveitis"
  group by disease, censor, indSolidCa, indNMSC; */
quit;




%macro model(model, outcomeCategory, disease, len, weight, covar);
  ods output HazardRatios = Work.temp;
  proc phreg data = Work.analyticDataset covsandwich(aggregate);
    where disease = "&disease";
    class exposure (ref = "TNF")
          database (ref = "Medicare")
          meanPredEqDoseCat (ref = "None")
          catAge (ref = "60-69")
          sex (ref = "M");
    model daysAtRisk * censor(1) = exposure database exposure*database &covar
      / ties = efron risklimits;
    id patid;
    %if %length(&weight) ^= 0 %then %do;
      weight &weight;
    %end;
    hazardratio exposure / at (database = all) diff = ref;
  run;
  proc sql;
    alter table Work.temp add model varchar(72);
    update Work.temp set model = "&model";
    alter table Work.temp add outcomeCategory varchar(&len);
    update Work.temp set outcomeCategory = "&outcomeCategory";
    alter table Work.temp add disease varchar(&len);
    update Work.temp set disease = "&disease";
    create table Work.temp3 as
      select A.*, B.n1, B.n2, B.incidenceRate1, B.incidenceRate2
      from Work.temp A inner join
           Work.crudeIncidence2 B on (A.description = B.description & 
                                      A.outcomeCategory = B.outcomeCategory & 
                                      A.disease = B.disease);
  quit;
  data Work.phregHazardRatios;
    set Work.phregHazardRatios Work.temp3;
  run;
  proc sql;
    drop table Work.temp;
    drop table Work.temp3;
  quit;
%mend model;


%macro foo;
  proc sql;
    create table Work.tempDisease as
      select distinct outcomeCategory, disease, length(disease) as len 
      from DT.incidentDiseaseTimelines;
    create table Work.tempN as select count(*) as n, max(len) as maxlen from Work.tempDisease;
  quit;
  data _null_;
    set Work.tempN end = eof;
    call symput("n", put(n, best2.));
    call symput("maxlen", put(maxlen, best2.));
  run;
  proc sql;
    create table Work.phregHazardRatios (disease varchar(&maxlen), model varchar(75));
  quit;
  %do i = 1 %to &n;
    data _null_;
      set Work.tempDisease;
      if _n_ = &i then call symput("outcomeCategory", outcomeCategory);
      if _n_ = &i then call symput("disease", disease);
    run;
    %put ********************************************************************************;
    %put *** ITERATION &i OUT OF &n: &outcomeCategory: &disease;
    %put ********************************************************************************;
    options mlogic;
    data _null_;
      disease = strip("&disease");
      test = tranwrd(disease, "/", "\/");
      put disease " --> " test;
      call symput ("test", test);
    run;
    %let regex = %sysfunc(prxparse(/%cmpres(&test)/));
    %if %sysfunc(prxmatch(&regex, Amyloidosis)) = 1 %then %do;
      %model(%quote(0 Unweighted, no covariates), &outcomeCategory, &disease, &maxlen, , );
      %model(%quote(a Weighted, no covariates), &outcomeCategory, &disease, &maxlen, iptw, );
      %model(%quote(b Weighted, covariates (6-month daily steroid dose)), &outcomeCategory, &disease, &maxlen, iptw, meanPredEqDoseCat);
      %model(%quote(c Weighted, covariates (sex)), &outcomeCategory, &disease, &maxlen, iptw, sex);
      %model(%quote(d Weighted, covariates (indHospInf)), &outcomeCategory, &disease, &maxlen, iptw, indHospInf);
      * %model(%quote(e Weighted, covariates (6-month daily steroid dose, sex, indHospInf)), &outcomeCategory, &disease, &maxlen, iptw, meanPredEqDoseCat sex indHospInf);
      * %model(%quote(f Weighted (stabilized), covariates (6-month daily steroid dose)), &outcomeCategory, &disease, &maxlen, iptwStabilized, meanPredEqDoseCat);
    %end;
    %else %if %sysfunc(prxmatch(&regex, Apical Pulmonary fibrosis)) = 1 %then %do;
    %end;
    %else %if %sysfunc(prxmatch(&regex, Cauda Equina syndrome)) = 1 %then %do;
      * %model(%quote(0 Unweighted, no covariates), &outcomeCategory, &disease, &maxlen, , );
      %model(%quote(a Weighted, no covariates), &outcomeCategory, &disease, &maxlen, iptw, );
      %model(%quote(b Weighted, covariates (6-month daily steroid dose)), &outcomeCategory, &disease, &maxlen, iptw, meanPredEqDoseCat);
      %model(%quote(c Weighted, covariates (sex)), &outcomeCategory, &disease, &maxlen, iptw, sex);
      %model(%quote(d Weighted, covariates (indHospInf)), &outcomeCategory, &disease, &maxlen, iptw, indHospInf);
      %model(%quote(e Weighted, covariates (6-month daily steroid dose, sex, indHospInf)), &outcomeCategory, &disease, &maxlen, iptw, meanPredEqDoseCat sex indHospInf);
      %model(%quote(f Weighted (stabilized), covariates (6-month daily steroid dose)), &outcomeCategory, &disease, &maxlen, iptwStabilized, meanPredEqDoseCat);
    %end;
    %else %do;
      %model(%quote(0 Unweighted, no covariates), &outcomeCategory, &disease, &maxlen, , );
      %model(%quote(a Weighted, no covariates), &outcomeCategory, &disease, &maxlen, iptw, );
      %model(%quote(b Weighted, covariates (6-month daily steroid dose)), &outcomeCategory, &disease, &maxlen, iptw, meanPredEqDoseCat);
      %model(%quote(c Weighted, covariates (sex)), &outcomeCategory, &disease, &maxlen, iptw, sex);
      %model(%quote(d Weighted, covariates (indHospInf)), &outcomeCategory, &disease, &maxlen, iptw, indHospInf);
      %model(%quote(e Weighted, covariates (6-month daily steroid dose, sex, indHospInf)), &outcomeCategory, &disease, &maxlen, iptw, meanPredEqDoseCat sex indHospInf);
      %model(%quote(f Weighted (stabilized), covariates (6-month daily steroid dose)), &outcomeCategory, &disease, &maxlen, iptwStabilized, meanPredEqDoseCat);
    %end;
    options nomlogic;
  %end;
  proc sql;
    drop table Work.tempN;
    drop table Work.tempDisease;
  quit;
%mend foo;

%foo;


proc sql;
  create table DT.phregHazardRatios as
    select outcomeCategory,
           disease,
           model,
           case
             when prxmatch("/DMARD, NSAID, or no exposure vs TNF/", Description) then "TNF vs DMARD, NSAID, or no exposure"
             else ""
             end as comparison,
           case
             when prxmatch("/MPCD/", Description) then "MPCD"
             when prxmatch("/Marketscan/", Description) then "Marketscan"
             when prxmatch("/Medicare/", Description) then "Medicare"
             else ""
             end as database,
           n2 as nTNF,
           n1 as nComparator,
           1 / HazardRatio as HazardRatio,
           1 / RobustWaldUpper as RobustWaldLower,
           1 / RobustWaldLower as RobustWaldUpper,
           1e-3 < HazardRatio < 1e3 as indValidHR,
           (1.0 < RobustWaldLower | RobustWaldUpper < 1.0) & (calculated indValidHR = 1) as indSigHR
    from Work.phregHazardRatios
    order by outcomeCategory, disease, model, calculated comparison, calculated database;
quit;

proc export
  data = DT.phregHazardRatios
  outfile = "data\processed\phregHazardRatios.csv"
  dbms = csv
  replace;
  delimiter = ",";
run;
proc export
  data = DT.crudeIncidence
  outfile = "data\processed\crudeIncidence.csv"
  dbms = csv
  replace;
  delimiter = ",";
run;




ods html close;
