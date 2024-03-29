*  University of Alabama at Birmingham                               *
*  AS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=queryIncidenceOutcomes; * type the name of your program here (without the filename extension);
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
See the *Compact Outcome Definition* worksheet in `AS Project Cohort Outcome Codebook-20170410.xlsx`
 */


/* 
From: Xie, Fenglong [mailto:fenglongxie@uabmc.edu] 
Sent: Wednesday, May 17, 2017 7:03 AM
To: Benjamin Chan <chanb@ohsu.edu>
Subject: RE: AS project data

Hi, Ben

The data are stored at UCB library defined as below email.

Attached please find the cohort list.

No exclusion was done except excluded for higher level exposure in six month
baseline.

You need to do appropriate censor (such as censor for discontinues of
exposure, switch to same level or higher lever exposure ...).

If you have question, please let me know.
 */


/* 
Call interstitial lung disease macro
 */
%include "lib\IPP_2IPSOPplusPX_ILD.sas" / source2;
%IPP_2IPSOPplusPX_ILD(outdata = Work.outcome_ILD_All,
                      IDS = exposureID,
                      Dxs = UCB64.tempIncDxAll,
                      Pxs = UCB64.tempIncPxAll);
proc sql;
  create table Work.ILD as
    select database, 
           exposure, 
           patid, 
           exposureStart,
           exposureEnd,
           exposureID,
           "Lung disease" as outcomeCategory,
           "Interstitial lung disease" as disease, 
           outcome_start_date as begin_date
    from Work.outcome_ILD_All;
  select database, exposure, disease, count(distinct exposureID) as n
    from Work.ILD
    group by database, exposure, disease;
quit;


/* 
Process fracture episodes data set
 */
proc sql;
  create table Work.fractures as
    select database, 
           exposure, 
           patid, 
           exposureStart,
           exposureEnd,
           exposureID,
           "Osteoporotic fracture" as outcomeCategory, 
           fractureType as disease, 
           fractureEpisodeStart as begin_date
    from DT.fractureEpisodesInc
    where ^missing(fractureType);
  select database, exposure, disease, count(distinct exposureID) as n
    from Work.fractures
    group by database, exposure, disease;
quit;


/* 
Process hospitalized infection data set
 */
proc sql;
  create table Work.hospInf as
    select database, 
           exposure, 
           patid, 
           exposureStart,
           exposureEnd,
           exposureID,
           "Infection" as outcomeCategory, 
           "Hospitalized infection" as disease, 
           outcome_start_date as begin_date
    from DT.hospitalizedInfectionEpisodesInc;
  select database, exposure, disease, count(distinct exposureID) as n
    from Work.hospInf
    group by database, exposure, disease;
quit;


/* 
Process opportunistic infection data set
 */
proc sql;
  create table Work.oppInf as
    select database, 
           exposure, 
           patid, 
           exposureStart,
           exposureEnd,
           exposureID,
           "Infection" as outcomeCategory, 
           "Opportunistic infection" as disease, 
           outcome_start_date as begin_date
    from DT.opportunInfectionEpisodesInc;
  select database, exposure, disease, count(distinct exposureID) as n
    from Work.oppInf
    group by database, exposure, disease;
quit;


/* 
Query for incident MI

* Requires at least a 1-day inpatient admission
 */
proc sql;
  create table Work.incidentMI as
    select C.database, C.exposureID, C.patid, C.exposure, C.exposureStart, C.exposureEnd,
           C.outcomeCategory,
           C.disease,
           C.begin_date
    from (select A.*, B.outcomeCategory, B.disease 
          from UCB64.tempIncDxAll A inner join 
               (select * from DT.defOutcomes where disease = "Myocardial infarction") B on (A.codeType = B.codeType & A.code = B.code) 
          where B.disease = "Myocardial infarction"  & 
                A.enc_type = "IP" &
                . < A.admit_date < A.discharge_date) C
    order by C.database, C.exposureID, C.outcomeCategory, C.disease, C.begin_date;
  select database, exposure, disease, count(distinct exposureID) as n
    from Work.incidentMI
    group by database, exposure, disease;
quit;


/* 
Process the data sets created by the cancer scripts
 */
proc sql;
  create table Work.cancer as
    select database, 
           exposure, 
           patid, 
           exposureStart,
           exposureEnd,
           exposureID,
           "Cancer" as outcomeCategory, 
           cancer as disease, 
           outcome_start_date as begin_date
    from (select * from DT.cancerSetoguchiEpisodesInc union corr
          select * from DT.cancerNMSCEpisodesInc );
  select database, exposure, disease, 
         count(distinct patid) as countDistinctPatid, 
         count(distinct exposureID) as countDistinctEpisodes
    from Work.cancer
    group by database, exposure, disease;
quit;


proc sql;

  create table Work.defOutcomes as
    select * 
    from DT.defOutcomes 
    where disease ^in ("Interstitial lung disease", 
                       "Myocardial infarction", 
                       "Hospitalized infection", 
                       "Opportunistic infection");
  create table Work.lookupDisease as
    select distinct outcomeCategory, disease
    from DT.defOutcomes;
  insert into Work.lookupDisease (outcomeCategory, disease)
    values ("Osteoporotic fracture", "Clinical vertebral fracture")
    values ("Osteoporotic fracture", "Non-vertebral osteoporotic fracture");
  alter table Work.lookupDisease
    modify disease char(57) format = $51.;
  update Work.lookupDisease
    set disease = 
      case
        when disease = "Clinical vertebral fracture" | disease = "Non-vertebral osteoporotic fracture"
          then "Clinical vertebral or non-vertebral osteoporotic fracture"
        when disease = "Psoriasis" | disease = "Psoriatic arthritis"
          then "Psoriasis or psoriatic arthritis"
        when prxmatch("/Crohn/", disease) | disease = "Ulcerative Colitis"
          then "Crohns disease or ulcerative colitis"
        else disease
        end;
  create table Work.temp as
    select distinct * from Work.lookupDisease;
  drop table Work.lookupDisease;
  create table Work.lookupDisease as
    select * from Work.temp;
  drop table Work.temp;
  
  %let select1 = select A.*, B.outcomeCategory, B.disease;
  %let join1 = inner join Work.defOutcomes B on (A.codeType = B.codeType & A.code = B.code);
  create table Work.incidentDisease as
    select C.database, C.exposureID, C.patid, C.exposure, C.exposureStart, C.exposureEnd,
           C.outcomeCategory,
           case
             when C.disease = "Clinical vertebral fracture" | C.disease = "Non-vertebral osteoporotic fracture"
               then "Clinical vertebral or non-vertebral osteoporotic fracture"
             when C.disease = "Psoriasis" | C.disease = "Psoriatic arthritis"
               then "Psoriasis or psoriatic arthritis"
             when prxmatch("/Crohn/", C.disease) | C.disease = "Ulcerative Colitis"
               then "Crohns disease or ulcerative colitis"
             else C.disease
             end as disease,
           C.begin_date
    from (&select1 from UCB64.tempIncDxAll A &join1 union corr
          &select1 from UCB64.tempIncPxAll A &join1 union corr
          select * from Work.cancer union corr
          select * from Work.ILD union corr
          select * from Work.incidentMI union corr
          select * from Work.hospInf union corr
          select * from Work.oppInf  union corr
          select * from Work.fractures) C
    order by C.database, C.exposureID, C.outcomeCategory, C.disease, C.begin_date;

quit;

/* 
Take first occurrence of outcome
 */
proc sort data = Work.incidentDisease nodupkey;
  by database exposureID outcomeCategory disease;
run;
proc sql;
  select distinct 
         outcomeCategory,
         disease
    from Work.incidentDisease;
quit;

/* 
For all but NMSC and infection (hospitalized and opportunistic),
keep first incident outcome within patient ID
 */
data Work.incidentDiseaseSubsetA Work.incidentDiseaseSubsetB;
  set Work.incidentDisease;
  if disease in ("Non Melanoma Skin Cancer", 
                 "Hospitalized infection") then output Work.incidentDiseaseSubsetA;
  else output Work.incidentDiseaseSubsetB;
run;
proc sort data = Work.incidentDiseaseSubsetB;
  by database patid outcomeCategory disease begin_date;
run;
proc sort data = Work.incidentDiseaseSubsetB nodupkey;
  by database patid outcomeCategory disease;
run;
proc sql;
  create table Work.incidentDisease as
    select * from Work.incidentDiseaseSubsetA union corr
    select * from Work.incidentDiseaseSubsetB ;
quit;


/* 
Join incident disease outcomes to exposure timelines
Summarize
 */
proc sql;
  create table DT.incidentDiseaseTimelines as
    select A.*, 
           D.begin_date format = mmddyy10. as outcomeDate,
           F.earliestOutcome,
           case
             when ^missing(D.begin_date) & missing(F.earliestOutcome) then 0
             when ^missing(D.begin_date) & A.exposureStart <= F.earliestOutcome <= A.exposureEnd then 0
             when . < F.earliestOutcome < A.exposureStart then 1
             when missing(D.begin_date) then 1
             else .
             end as censor,
           case
             when ^missing(D.begin_date) & missing(F.earliestOutcome) then D.begin_date - A.exposureStart + 1
             when ^missing(D.begin_date) & A.exposureStart <= F.earliestOutcome <= A.exposureEnd then D.begin_date - A.exposureStart + 1
             when . < F.earliestOutcome < A.exposureStart then 0
             when missing(D.begin_date) then daysExposed
             else .
             end as daysAtRisk
    from (select B.*, C.*
          from DT.exposureTimeline B, 
               Work.lookupDisease C) A left join
         Work.incidentDisease D on (A.database = D.database & 
                                    A.patid = D.patid & 
                                    A.exposure = D.exposure & 
                                    A.exposureStart = D.exposureStart & 
                                    A.outcomeCategory = D.outcomeCategory & 
                                    A.disease = D.disease) left join
         (select E.database, E.patid, E.outcomeCategory, E.disease,
                 min(E.begin_date) format = mmddyy10. as earliestOutcome
          from Work.incidentDisease E
          where E.disease ^in ("Non Melanoma Skin Cancer", 
                               "Hospitalized infection")
          group by E.database, E.patid, E.outcomeCategory, E.disease) F on (A.database = F.database &
                                                                            A.patid = F.patid &
                                                                            A.outcomeCategory = F.outcomeCategory &
                                                                            A.disease = F.disease)
    order by A.database, A.patid, A.outcomeCategory, A.disease, A.exposureStart;
  create table Work.incidence as
    select database, exposure, outcomeCategory, disease,
           count(distinct exposureID) as n,
           sum(censor = 0) as incidence,
           sum(daysAtRisk) / 365.25 as personYears,
           100 as scale,
           sum(censor = 0) / (sum(daysAtRisk) / 365.25) * calculated scale as incidenceRate
    from DT.incidentDiseaseTimelines
    group by database, exposure, outcomeCategory, disease;
  select * from Work.incidence;
quit;


ods html close;
