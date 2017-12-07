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
quit;




proc sql;
  create table Work.phregHazardRatios (model varchar(47));
quit;


%let disease = Hospitalized infection;
/* 
Weighted
 */
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
quit;
data Work.phregHazardRatios;
  set Work.phregHazardRatios Work.temp;
run;
/* 
Weighted stabilized
 */
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
quit;
data Work.phregHazardRatios;
  set Work.phregHazardRatios Work.temp;
run;




ods html close;
