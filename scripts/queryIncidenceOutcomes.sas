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


proc sql;

  %let select1 = select A.*, B.enc_type, B.admit_date, B.begin_date, B.discharge_date, B.end_date, B.dx_type, B.dx, B.pdx, "ICD9-DX" as codeType, B.dx as code;
  %let on1 = on (A.patid = B.patid & A.exposureStart <= B.begin_date <= A.exposureEnd);
  %let select2 = select patid, enc_type, admit_date, begin_date, discharge_date, end_date, dx_type, dx, pdx;
  %let where2 = where dx_type = "09";
  %let selectfrom3 = select * from DT.exposureTimeline;
  create table UCB.tempDxMPCD as
    &select1 from (&selectfrom3 where database = "MPCD") A inner join (&select2 from MPSTD.DX_07_10 &where2) B &on1;
  create table UCB.tempDxUCB as
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.DX_2010 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.DX_2011 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.DX_2012 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.DX_2013 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.DX_2014 &where2) B &on1 ;
  create table UCB.tempDxSABR as
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2006    &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2007    &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2008_V2 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2009    &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2010    &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2011    &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2012    &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2013    &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2014    &where2) B &on1 ;

  %let select1 = select A.*, B.admit_date, B.begin_date, B.discharge_date, B.end_date, B.px_date, B.px_type, B.px, case when B.px_type = "09" then "ICD9-PX" when B.px_type = "C1" then "CPT" when B.px_type = "H1" then "HCPCS" else "" end as codeType, B.px as code;
  %let on1 = on (A.patid = B.patid & A.exposureStart <= B.begin_date <= A.exposureEnd);
  %let select2 = select patid, admit_date, begin_date, discharge_date, end_date, px_date, px_type, px;
  %let selectfrom3 = select * from DT.exposureTimeline;
  create table UCB.tempPxMPCD as
    &select1 from (&selectfrom3 where database = "MPCD") A inner join (&select2 from MPSTD.PX_07_10) B &on1;
  create table UCB.tempPxUCB as
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.PX_2010) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.PX_2011) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.PX_2012) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.PX_2013) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.PX_2014) B &on1 ;
  create table UCB.tempPxSABR as
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2006) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2007) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2008) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2009) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2010) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2011) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2012) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2013) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2014) B &on1 ;

quit;


/* 
Call interstitial lung disease macro
 */
%include "lib\IPP_2IPSOPplusPX_ILD.sas" / source2;
%IPP_2IPSOPplusPX_ILD(outdata = Work.outcome_ILD_MPCD,
                      IDS = exposureID,
                      Dxs = UCB.tempDxMPCD,
                      Pxs = UCB.tempPxMPCD);
%IPP_2IPSOPplusPX_ILD(outdata = Work.outcome_ILD_UCB,
                      IDS = exposureID,
                      Dxs = UCB.tempDxUCB,
                      Pxs = UCB.tempPxUCB);
%IPP_2IPSOPplusPX_ILD(outdata = Work.outcome_ILD_SABR,
                      IDS = exposureID,
                      Dxs = UCB.tempDxSABR,
                      Pxs = UCB.tempPxSABR);


proc sql;

  create table Work.defOutcomes as
    select * 
    from DT.defOutcomes 
    where disease ^in ("Interstitial lung disease");
  create table Work.lookupDisease as
    select distinct outcomeCategory, disease
    from DT.defOutcomes;
  
  %let select1 = select A.*, B.outcomeCategory, B.disease;
  %let join1 = inner join Work.defOutcomes B on (A.codeType = B.codeType & A.code = B.code);
  %let where1a = where B.disease ^= "Myocardial infarction";
  %let where1b = | (B.disease = "Myocardial infarction" & A.enc_type = "IP");
  %let select2 = select database, exposure, patid, exposureID, exposureStart, exposureEnd, enc_type, "Lung disease" as outcomeCategory, "Interstitial lung disease" as disease, outcome_start_date as begin_date;
  create table Work.incidentDisease as
    select C.database, C.exposureID, C.patid, C.exposure, C.exposureStart, C.exposureEnd,
           C.outcomeCategory,
           C.disease,
           C.begin_date
    from (&select1 from UCB.tempDxMPCD A &join1 &where1a &where1b union corr
          &select1 from UCB.tempDxUCB  A &join1 &where1a &where1b union corr
          &select1 from UCB.tempDxSABR A &join1 &where1a &where1b union corr
          &select1 from UCB.tempPxMPCD A &join1 &where1a union corr
          &select1 from UCB.tempPxUCB  A &join1 &where1a union corr
          &select1 from UCB.tempPxSABR A &join1 &where1a union corr
          &select2 from Work.outcome_ILD_MPCD union corr
          &select2 from Work.outcome_ILD_UCB  union corr
          &select2 from Work.outcome_ILD_SABR ) C
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

  drop table UCB.tempDxMPCD;
  drop table UCB.tempDxUCB;
  drop table UCB.tempDxSABR;
  drop table UCB.tempPxMPCD;
  drop table UCB.tempPxUCB;
  drop table UCB.tempPxSABR;

quit;


proc export
  data = Work.incidence
  outfile = "data\processed\&cmt..csv"
  dbms = csv
  replace;
  delimiter = ",";
run;


ods html close;
