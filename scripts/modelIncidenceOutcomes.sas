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
             when B.exposure in ("No exposure", "NSAID") then "NSAID or no exposure"
             else B.exposure
             end as exposure3,
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
           coalesce(A.exposure, B.exposure3) as exposure,
           A.age,
           A.catAge,
           A.sex,
           A.ps,
           A.iptw,
           A.indCommonSupport,
           A.iptwStabilized,
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
                                             A.exposure = B.exposure3)
    where A.indCommonSupport = 1
    order by B.outcomeCategory,
             B.disease,
             calculated database,
             B.censor,
             B.patid,
             B.exposureStart;
  select distinct outcomeCategory, disease from Work.analyticDataset;
quit;




%macro model(outcomeCategory, disease, len);
  /* Unweighted */
  ods output HazardRatios = Work.temp;
  proc phreg data = Work.analyticDataset covsandwich(aggregate);
    where disease = "&disease";
    class exposure (ref = "TNF")
          database (ref = "Medicare");
    model daysAtRisk * censor(1) = exposure database exposure*database
      / ties = efron risklimits;
    id patid;
    hazardratio exposure / at (database = all) diff = ref;
  run;
  proc sql;
    alter table Work.temp add model varchar(47);
    update Work.temp set model = "Unweighted, no covariates";
    alter table Work.temp add outcomeCategory varchar(&len);
    update Work.temp set outcomeCategory = "&outcomeCategory";
    alter table Work.temp add disease varchar(&len);
    update Work.temp set disease = "&disease";
  quit;
  data Work.phregHazardRatios;
    set Work.phregHazardRatios Work.temp;
  run;
  /* Weighted */
  ods output HazardRatios = Work.temp;
  proc phreg data = Work.analyticDataset covsandwich(aggregate);
    where disease = "&disease";
    class exposure (ref = "TNF")
          database (ref = "Medicare");
    model daysAtRisk * censor(1) = exposure database exposure*database
      / ties = efron risklimits;
    id patid;
    weight iptw;
    hazardratio exposure / at (database = all) diff = ref;
  run;
  proc sql;
    alter table Work.temp add model varchar(47);
    update Work.temp set model = "Weighted, no covariates";
    alter table Work.temp add outcomeCategory varchar(&len);
    update Work.temp set outcomeCategory = "&outcomeCategory";
    alter table Work.temp add disease varchar(&len);
    update Work.temp set disease = "&disease";
  quit;
  data Work.phregHazardRatios;
    set Work.phregHazardRatios Work.temp;
  run;
  /* Weighted stabilized */
  ods output HazardRatios = Work.temp;
  proc phreg data = Work.analyticDataset covsandwich(aggregate);
    where disease = "&disease";
    class exposure (ref = "TNF")
          database (ref = "Medicare");
    model daysAtRisk * censor(1) = exposure database exposure*database
      / ties = efron risklimits;
    id patid;
    weight iptwStabilized;
    hazardratio exposure / at (database = all) diff = ref;
  run;
  proc sql;
    alter table Work.temp add model varchar(47);
    update Work.temp set model = "Weighted, stabilized, no covariates";
    alter table Work.temp add outcomeCategory varchar(&len);
    update Work.temp set outcomeCategory = "&outcomeCategory";
    alter table Work.temp add disease varchar(&len);
    update Work.temp set disease = "&disease";
  quit;
  data Work.phregHazardRatios;
    set Work.phregHazardRatios Work.temp;
  run;
%mend model;


%macro foo;
  proc sql;
    create table Work.tempDisease as
      select distinct outcomeCategory, disease, length(disease) as len 
      from DT.incidentDiseaseTimelines
      where disease ^= "Apical Pulmonary fibrosis";
    create table Work.tempN as select count(*) as n, max(len) as maxlen from Work.tempDisease;
  quit;
  data _null_;
    set Work.tempN end = eof;
    call symput("n", put(n, best2.));
    call symput("maxlen", put(maxlen, best2.));
  run;
  proc sql;
    create table Work.phregHazardRatios (model varchar(&maxlen));
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
    %model(&outcomeCategory, &disease, &maxlen);
  %end;
  proc sql;
    drop table Work.tempN;
    drop table Work.tempDisease;
  quit;
%mend foo;

%foo;


proc datasets;
  copy out = DT in = Work;
  select phregHazardRatios;
run;

proc sql;
  create table DT.phregHazardRatios as
    select outcomeCategory,
           disease,
           model,
           case
             when prxmatch("/DMARD vs TNF/", Description) then "DMARD vs TNF"
             when prxmatch("/NSAID or no exposure vs TNF/", Description) then "NSAID or no exposure vs TNF"
             else ""
             end as comparison,
           case
             when prxmatch("/MPCD/", Description) then "MPCD"
             when prxmatch("/Marketscan/", Description) then "Marketscan"
             when prxmatch("/Medicare/", Description) then "Medicare"
             else ""
             end as database,
           HazardRatio,
           RobustWaldLower,
           RobustWaldUpper,
           1e-3 < HazardRatio < 1e3 as indValidHR,
           (1.0 < RobustWaldLower | RobustWaldUpper < 1.0) & (calculated indValidHR = 1) as indSigHR
    from Work.phregHazardRatios
    order by outcomeCategory, disease, model, calculated comparison, calculated database;
quit;

proc export
  data = DT.phregHazardRatios (where (model ^= "Unweighted, no covariates"))
  outfile = "data\processed\phregHazardRatios.csv"
  dbms = csv
  replace;
  delimiter = ",";
run;




ods html close;
