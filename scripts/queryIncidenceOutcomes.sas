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
%IPP_2IPSOPplusPX_ILD(outdata = Work.outcome_ILD_MPCD,
                      IDS = exposureID,
                      Dxs = UCB.tempIncDxMPCD,
                      Pxs = UCB.tempIncPxMPCD);
%IPP_2IPSOPplusPX_ILD(outdata = Work.outcome_ILD_UCB,
                      IDS = exposureID,
                      Dxs = UCB.tempIncDxUCB,
                      Pxs = UCB.tempIncPxUCB);
%IPP_2IPSOPplusPX_ILD(outdata = Work.outcome_ILD_SABR,
                      IDS = exposureID,
                      Dxs = UCB.tempIncDxSABR,
                      Pxs = UCB.tempIncPxSABR);


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
quit;


proc sql;

  create table Work.defOutcomes as
    select * 
    from DT.defOutcomes 
    where disease ^in ("Interstitial lung disease");
  create table Work.lookupDisease as
    select distinct outcomeCategory, disease
    from DT.defOutcomes;
  insert into Work.lookupDisease (outcomeCategory, disease)
    values ("Osteoporotic fracture", "Clinical vertebral fracture")
    values ("Osteoporotic fracture", "Non-vertebral osteoporotic fracture");
  
  %let select1 = select A.*, B.outcomeCategory, B.disease;
  %let join1 = inner join Work.defOutcomes B on (A.codeType = B.codeType & A.code = B.code);
  %let where1a = where B.disease ^in ("Myocardial infarction", "Hospitalized infection");
  %let where1b = | (B.disease in ("Myocardial infarction", "Hospitalized infection") & A.enc_type = "IP");
  %let select2 = select database, exposure, patid, exposureID, exposureStart, exposureEnd, enc_type, "Lung disease" as outcomeCategory, "Interstitial lung disease" as disease, outcome_start_date as begin_date;
  create table Work.incidentDisease as
    select C.database, C.exposureID, C.patid, C.exposure, C.exposureStart, C.exposureEnd,
           C.outcomeCategory,
           C.disease,
           C.begin_date
    from (&select1 from UCB.tempIncDxMPCD A &join1 &where1a &where1b union corr
          &select1 from UCB.tempIncDxUCB  A &join1 &where1a &where1b union corr
          &select1 from UCB.tempIncDxSABR A &join1 &where1a &where1b union corr
          &select1 from UCB.tempIncPxMPCD A &join1 &where1a union corr
          &select1 from UCB.tempIncPxUCB  A &join1 &where1a union corr
          &select1 from UCB.tempIncPxSABR A &join1 &where1a union corr
          &select2 from Work.outcome_ILD_MPCD union corr
          &select2 from Work.outcome_ILD_UCB  union corr
          &select2 from Work.outcome_ILD_SABR union corr
          select * from Work.fractures) C
    order by C.database, C.exposureID, C.outcomeCategory, C.disease, C.begin_date;
quit;

/* 
Take first occurrence of outcome
 */
proc sort data = Work.incidentDisease nodupkey;
  by database exposureID outcomeCategory disease;
run;

/* 
Join incident disease outcomes to exposure timelines
Summarize
 */
proc sql;
  create table DT.incidentDiseaseTimelines as
    select A.*, 
           B.begin_date format = mmddyy10. as outcomeDate,
           missing(B.begin_date) as censor,
           case
             when missing(B.begin_date) then daysExposed
             when ^missing(B.begin_date) then B.begin_date - A.exposureStart + 1
             else .
             end as daysToOutcome
    from (select A.*, B.*
          from DT.exposureTimeline A, 
               Work.lookupDisease B) A left join
         Work.incidentDisease B on (A.exposureID = B.exposureID & 
                                    A.outcomeCategory = B.outcomeCategory & 
                                    A.disease = B.disease);
  create table Work.incidence as
    select database, exposure, outcomeCategory, disease,
         count(distinct exposureID) as n,
           sum(censor = 0) as incidence,
           sum(daysToOutcome) / 365.25 as personYears,
           sum(censor = 0) / (sum(daysToOutcome) / 365.25) * 1000 as incidencePer1000PY
    from DT.incidentDiseaseTimelines
    group by database, exposure, outcomeCategory, disease;
  select * from Work.incidence;

quit;


proc export
  data = Work.incidence
  outfile = "data\processed\&cmt..csv"
  dbms = csv
  replace;
  delimiter = ",";
run;


ods html close;
