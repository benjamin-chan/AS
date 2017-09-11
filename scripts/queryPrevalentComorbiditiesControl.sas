*  University of Alabama at Birmingham                               *
*  AS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=queryPrevalentComorbiditiesControl; * type the name of your program here (without the filename extension);
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


/* 
Call interstitial lung disease macro
 */
%include "lib\IPP_2IPSOPplusPX_ILD.sas" / source2;
%IPP_2IPSOPplusPX_ILD(outdata = Work.outcome_ILD_MPCD,
                      IDS = controlID,
                      Dxs = UCB.tempPrevDxMPCDControl,
                      Pxs = UCB.tempPrevPxMPCDControl);
%IPP_2IPSOPplusPX_ILD(outdata = Work.outcome_ILD_SABR,
                      IDS = controlID,
                      Dxs = UCB.tempPrevDxSABRControl,
                      Pxs = UCB.tempPrevPxSABRControl);

/* 
Process fracture episodes data set
 */
proc sql;
  create table Work.fractures as
    select database, 
           cohort, 
           patid, 
           indexDate, 
           controlID, 
           age, 
           sex, 
           "Osteoporotic fracture" as outcomeCategory, 
           fractureType as disease, 
           fractureEpisodeStart as begin_date
    from DT.fractureEpisodesPrevControl
    where ^missing(fractureType);
quit;




proc sql;

  create table Work.defOutcomes as
    select * 
    from DT.defOutcomes 
    where disease ^in ("Interstitial lung disease");
  
  %let select1 = select A.*, B.outcomeCategory, B.disease;
  %let join1 = inner join Work.defOutcomes B on (A.codeType = B.codeType & A.code = B.code);
  %let where1a = where B.disease ^in ("Myocardial infarction", "Hospitalized infection");
  %let where1b = | (B.disease in ("Myocardial infarction", "Hospitalized infection") & A.enc_type in ("IF", "IP"));
  %let select2 = select database, cohort, patid, indexDate, controlID, enc_type, age, sex, "Lung disease" as outcomeCategory, "Interstitial lung disease" as disease, outcome_start_date as begin_date;
  create table DT.comorbiditiesControl as
    select C.database, C.cohort, C.patid, C.indexDate, C.controlID, C.age, C.sex,
           C.outcomeCategory,
           C.disease,
           sum(C.begin_date <= C.indexDate) > 0 as indPrevPriorToIndex,
           sum(0 <= C.indexDate  - C.begin_date <= 183 |
               0 <= C.begin_date - C.indexDate  <= (183 * 1)) > 0 as indPrev12mo,
           sum(0 <= C.indexDate  - C.begin_date <= 183 |
               0 <= C.begin_date - C.indexDate  <= (183 * 3)) > 0 as indPrev24mo,
           sum(0 <= C.indexDate  - C.begin_date <= 183 |
               0 <= C.begin_date - C.indexDate  <= (183 * 5)) > 0 as indPrev36mo
    from (&select1 from UCB.tempPrevDxMPCDControl A &join1 &where1a &where1b union corr
          &select1 from UCB.tempPrevDxSABRControl A &join1 &where1a &where1b union corr
          &select1 from UCB.tempPrevPxMPCDControl A &join1 &where1a union corr
          &select1 from UCB.tempPrevPxSABRControl A &join1 &where1a union corr
          &select2 from Work.outcome_ILD_MPCD union corr
          &select2 from Work.outcome_ILD_SABR union corr
          select * from Work.fractures) C
    group by C.database, C.cohort, C.patid, C.indexDate, C.controlID, C.age, C.sex,
             C.outcomeCategory,
             C.disease
    having calculated indPrevPriorToIndex > 0 | 
           calculated indPrev12mo > 0 | 
           calculated indPrev24mo > 0 | 
           calculated indPrev36mo > 0;

  create table Work.denominator as
    select database, 
           cohort, 
           count(distinct patid) as denomPatid,
           count(distinct controlID) as denomControlCohort
    from DT.controlLookup
    group by database, cohort;

  create table Work.prev as
    select A.database, A.cohort, A.outcomeCategory, A.disease,
           B.denomPatid,
           B.denomControlCohort,
           "Prior to index" as timeWindow,
           sum(A.indPrevPriorToIndex) as numer,
           sum(A.indPrevPriorToIndex) / B.denomControlCohort * 100 as prevPct
    from DT.comorbiditiesControl A inner join
         Work.denominator B on (A.database = B.database & A.cohort = B.cohort)
    group by A.database, A.cohort, A.outcomeCategory, A.disease, B.denomPatid, B.denomControlCohort
    union corr
    select A.database, A.cohort, A.outcomeCategory, A.disease,
           B.denomPatid,
           B.denomControlCohort,
           "12 months" as timeWindow,
           sum(A.indPrev12mo) as numer,
           sum(A.indPrev12mo) / B.denomControlCohort * 100 as prevPct
    from DT.comorbiditiesControl A inner join
         Work.denominator B on (A.database = B.database & A.cohort = B.cohort)
    group by A.database, A.cohort, A.outcomeCategory, A.disease, B.denomPatid, B.denomControlCohort
    union corr
    select A.database, A.cohort, A.outcomeCategory, A.disease,
           B.denomPatid,
           B.denomControlCohort,
           "24 months" as timeWindow,
           sum(A.indPrev24mo) as numer,
           sum(A.indPrev24mo) / B.denomControlCohort * 100 as prevPct
    from DT.comorbiditiesControl A inner join
         Work.denominator B on (A.database = B.database & A.cohort = B.cohort)
    group by A.database, A.cohort, A.outcomeCategory, A.disease, B.denomPatid, B.denomControlCohort
    union corr
    select A.database, A.cohort, A.outcomeCategory, A.disease,
           B.denomPatid,
           B.denomControlCohort,
           "36 months" as timeWindow,
           sum(A.indPrev36mo) as numer,
           sum(A.indPrev36mo) / B.denomControlCohort * 100 as prevPct
    from DT.comorbiditiesControl A inner join
         Work.denominator B on (A.database = B.database & A.cohort = B.cohort)
    group by A.database, A.cohort, A.outcomeCategory, A.disease, B.denomPatid, B.denomControlCohort;
  select * from Work.prev;
quit;


proc export
  data = Work.prev
  outfile = "data\processed\&cmt..csv"
  dbms = csv
  replace;
  delimiter = ",";
run;


ods html close;
