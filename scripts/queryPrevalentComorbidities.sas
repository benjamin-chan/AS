*  University of Alabama at Birmingham                               *
*  AS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=queryPrevalentComorbidities; * type the name of your program here (without the filename extension);
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
Calculate the prevalence of each comorbidity over various time intervals, by
disease cohort (AS vs. non-AS). We will explore how the prevalence of each
condition varies according to the amount of data available. Outcomes will be
examined in discrete 12 month increments (i.e. using 12 months of data, 24
months, 36 months, etc.) using the 6 months baseline plus an additional 6
(1st year), 18 (1st and 2nd year), 30 (1st, 2nd, and 3rd year), etc. months
of follow-up.
 */


/* 
See the *Compact Outcome Definition* worksheet in `AS Project Cohort Outcome Codebook-20170410.xlsx`
 */


proc sql;
  create table Work.defOutcomes as
    select * 
    from DT.defOutcomes 
    where disease ^in ("Interstitial lung disease");
quit;

%let select1 = select A.*, B.outcomeCategory, B.disease;
%let join1 = inner join Work.defOutcomes B on (A.codeType = B.codeType & A.code = B.code);
%let where1a = where B.disease ^in ("Myocardial infarction", "Hospitalized infection");
%let where1b = | (B.disease in ("Myocardial infarction", "Hospitalized infection") & A.enc_type = "IP");


/* 
Call interstitial lung disease macro
 */
%include "lib\IPP_2IPSOPplusPX_ILD.sas" / source2;
%IPP_2IPSOPplusPX_ILD(outdata = Work.outcome_ILD_All,
                      IDS = patid,
                      Dxs = UCB64.tempPrevDxAll,
                      Pxs = UCB64.tempPrevPxAll);


/* 
Process fracture episodes data set
 */
proc sql;
  create table Work.fractures as
    select database, 
           exposure, 
           patid, 
           ASCohortDate, 
           "Osteoporotic fracture" as outcomeCategory, 
           fractureType as disease, 
           fractureEpisodeStart as begin_date
    from DT.fractureEpisodesPrev
    where ^missing(fractureType);
quit;


proc sql;

  %let select2 = select database, exposure, patid, ASCohortDate, enc_type, "Lung disease" as outcomeCategory, "Interstitial lung disease" as disease, outcome_start_date as begin_date;
  create table DT.comorbiditiesByPatid as
    select C.database, C.patid, C.ASCohortDate,
           C.outcomeCategory,
           case
             when C.disease = "Clinical vertebral fracture" | C.disease = "Non-vertebral osteoporotic fracture"
               then "Clinical vertebral or non-vertebral osteoporotic fracture"
             when C.disease = "Psoriasis" | C.disease = "Psoriatic arthritis"
               then "Psoriasis or psoriatic arthritis"
             when prxmatch("/Crohn/", C.disease) | C.disease = "Ulcerative Colitis"
               then "Crohns disease or ulcerative colitis"
             when C.disease = "Interstitial lung disease" | prxmatch("/Restrictive lung disease/", C.disease)
               then "Interstitial or restrictive lung disease"
             else C.disease
             end as disease,
           sum(C.begin_date < C.ASCohortDate) > 0 as indPrevPriorToCohortEntry,
           sum(0 <= C.ASCohortDate  - C.begin_date <= 183 |
               0 <= C.begin_date - C.ASCohortDate  <= (183 * 1)) > 0 as indPrev12mo,
           sum(0 <= C.ASCohortDate  - C.begin_date <= 183 |
               0 <= C.begin_date - C.ASCohortDate  <= (183 * 3)) > 0 as indPrev24mo,
           sum(0 <= C.ASCohortDate  - C.begin_date <= 183 |
               0 <= C.begin_date - C.ASCohortDate  <= (183 * 5)) > 0 as indPrev36mo
    from (&select1 from UCB64.tempPrevDxAll A &join1 &where1a &where1b union corr
          &select1 from UCB64.tempPrevPxAll A &join1 &where1a union corr
          &select2 from Work.outcome_ILD_All union corr
          select * from Work.fractures) C
    group by C.database, C.patid, C.ASCohortDate,
             C.outcomeCategory,
             calculated disease
    having calculated indPrevPriorToCohortEntry > 0 | 
           calculated indPrev12mo > 0 | 
           calculated indPrev24mo > 0 | 
           calculated indPrev36mo > 0;

quit;


proc sql;

  create table Work.denominator as
    select database, 
           mean(indexDate - ASCohortDate) as meanDaysASCohortToExposure,
           min(indexDate - ASCohortDate) as minDaysASCohortToExposure,
           max(indexDate - ASCohortDate) as maxDaysASCohortToExposure,
           count(distinct patid) as denomPatid
    from DT.indexLookup
    group by database;

  create table Work.prev as
    select A.database, A.outcomeCategory, A.disease,
           B.denomPatid,
           "AS cohort entry to exposure" as timeWindow,
           sum(A.indPrevPriorToCohortEntry) as numer,
           sum(A.indPrevPriorToCohortEntry) / B.denomPatid * 100 as prevPct
    from DT.comorbiditiesByPatid A inner join
         Work.denominator B on (A.database = B.database)
    group by A.database, A.outcomeCategory, A.disease, B.denomPatid
    union corr
    select A.database, A.outcomeCategory, A.disease,
           B.denomPatid,
           "12 months" as timeWindow,
           sum(A.indPrev12mo) as numer,
           sum(A.indPrev12mo) / B.denomPatid * 100 as prevPct
    from DT.comorbiditiesByPatid A inner join
         Work.denominator B on (A.database = B.database)
    group by A.database, A.outcomeCategory, A.disease, B.denomPatid
    union corr
    select A.database, A.outcomeCategory, A.disease,
           B.denomPatid,
           "24 months" as timeWindow,
           sum(A.indPrev24mo) as numer,
           sum(A.indPrev24mo) / B.denomPatid * 100 as prevPct
    from DT.comorbiditiesByPatid A inner join
         Work.denominator B on (A.database = B.database)
    group by A.database, A.outcomeCategory, A.disease, B.denomPatid
    union corr
    select A.database, A.outcomeCategory, A.disease,
           B.denomPatid,
           "36 months" as timeWindow,
           sum(A.indPrev36mo) as numer,
           sum(A.indPrev36mo) / B.denomPatid * 100 as prevPct
    from DT.comorbiditiesByPatid A inner join
         Work.denominator B on (A.database = B.database)
    group by A.database, A.outcomeCategory, A.disease, B.denomPatid;
  select * from Work.prev;
quit;


proc export
  data = Work.prev
  outfile = "data\processed\&cmt.Overall.csv"
  dbms = csv
  replace;
  delimiter = ",";
run;




ods html close;
