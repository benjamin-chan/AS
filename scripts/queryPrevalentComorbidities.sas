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

  %let select1 = select A.*, B.enc_type, B.admit_date, B.begin_date, B.discharge_date, B.end_date, B.dx_type, B.dx, B.pdx, "ICD9-DX" as codeType, B.dx as code;
  %let on1 = on (A.patid = B.patid);
  %let select2 = select patid, enc_type, admit_date, begin_date, discharge_date, end_date, dx_type, dx, pdx;
  %let where2 = where dx_type = "09";
  %let selectfrom3 = select * from DT.indexLookup;
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
  %let on1 = on (A.patid = B.patid);
  %let select2 = select patid, admit_date, begin_date, discharge_date, end_date, px_date, px_type, px;
  %let selectfrom3 = select * from DT.indexLookup;
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
                      IDS = indexID,
                      Dxs = UCB.tempDxMPCD,
                      Pxs = UCB.tempPxMPCD);
%IPP_2IPSOPplusPX_ILD(outdata = Work.outcome_ILD_UCB,
                      IDS = indexID,
                      Dxs = UCB.tempDxUCB,
                      Pxs = UCB.tempPxUCB);
%IPP_2IPSOPplusPX_ILD(outdata = Work.outcome_ILD_SABR,
                      IDS = indexID,
                      Dxs = UCB.tempDxSABR,
                      Pxs = UCB.tempPxSABR);


proc sql;

  create table Work.defOutcomes as
    select * 
    from DT.defOutcomes 
    where outcomeCategory ^in ("Hospitalized infection", "Opportunistic infection") & 
          disease ^in ("Interstitial lung disease");
  
  %let select1 = select A.*, B.outcomeCategory, B.disease;
  %let join1 = inner join Work.defOutcomes B on (A.codeType = B.codeType & A.code = B.code);
  %let where1a = where B.disease ^= "Myocardial infarction";
  %let where1b = | (B.disease = "Myocardial infarction" & A.enc_type = "IP");
  %let select2 = select database, exposure, patid, ASCohortDate, indexGNN, indexDate, indexID, enc_type, age, sex, "Lung disease" as outcomeCategory, "Interstitial lung disease" as disease, outcome_start_date as begin_date;
  create table Work.comorbidities as
    select C.database, C.exposure, C.patid, C.ASCohortDate, C.indexGNN, C.indexDate, C.indexID, C.age, C.sex,
           C.outcomeCategory,
           C.disease,
           sum(C.ASCohortDate <= C.begin_date <= C.indexDate) > 0 as indPrevPriorToIndex,
           sum(0 <= C.indexDate  - C.begin_date <= 183 |
               0 <= C.begin_date - C.indexDate  <= (183 * 1)) > 0 as indPrev12mo,
           sum(0 <= C.indexDate  - C.begin_date <= 183 |
               0 <= C.begin_date - C.indexDate  <= (183 * 3)) > 0 as indPrev24mo,
           sum(0 <= C.indexDate  - C.begin_date <= 183 |
               0 <= C.begin_date - C.indexDate  <= (183 * 5)) > 0 as indPrev36mo
    from (&select1 from UCB.tempDxMPCD A &join1 &where1a &where1b union corr
          &select1 from UCB.tempDxUCB  A &join1 &where1a &where1b union corr
          &select1 from UCB.tempDxSABR A &join1 &where1a &where1b union corr
          &select1 from UCB.tempPxMPCD A &join1 &where1a union corr
          &select1 from UCB.tempPxUCB  A &join1 &where1a union corr
          &select1 from UCB.tempPxSABR A &join1 &where1a union corr
          &select2 from Work.outcome_ILD_MPCD union corr
          &select2 from Work.outcome_ILD_UCB  union corr
          &select2 from Work.outcome_ILD_SABR ) C
    group by C.database, C.exposure, C.patid, C.ASCohortDate, C.indexGNN, C.indexDate, C.indexID, C.age, C.sex,
             C.outcomeCategory,
             C.disease
    having calculated indPrevPriorToIndex > 0 | 
           calculated indPrev12mo > 0 | 
           calculated indPrev24mo > 0 | 
           calculated indPrev36mo > 0;

  create table Work.denominator as
    select database, 
           exposure, 
           mean(indexDate - ASCohortDate) as meanDaysASCohortToExposure,
           min(indexDate - ASCohortDate) as minDaysASCohortToExposure,
           max(indexDate - ASCohortDate) as maxDaysASCohortToExposure,
           count(distinct patid) as denomPatid,
           count(distinct indexID) as denomIndexExp
    from DT.indexLookup
    group by database, exposure;

  create table Work.prev as
    select A.database, A.exposure, A.outcomeCategory, A.disease,
           B.denomPatid,
           B.denomIndexExp,
           "AS cohort entry to exposure" as timeWindow,
           sum(A.indPrevPriorToIndex) as numer,
           sum(A.indPrevPriorToIndex) / B.denomIndexExp * 100 as prevPct
    from Work.comorbidities A inner join
         Work.denominator B on (A.database = B.database & A.exposure = B.exposure)
    group by A.database, A.exposure, A.outcomeCategory, A.disease, B.denomPatid, B.denomIndexExp
    union corr
    select A.database, A.exposure, A.outcomeCategory, A.disease,
           B.denomPatid,
           B.denomIndexExp,
           "12 months" as timeWindow,
           sum(A.indPrev12mo) as numer,
           sum(A.indPrev12mo) / B.denomIndexExp * 100 as prevPct
    from Work.comorbidities A inner join
         Work.denominator B on (A.database = B.database & A.exposure = B.exposure)
    group by A.database, A.exposure, A.outcomeCategory, A.disease, B.denomPatid, B.denomIndexExp
    union corr
    select A.database, A.exposure, A.outcomeCategory, A.disease,
           B.denomPatid,
           B.denomIndexExp,
           "24 months" as timeWindow,
           sum(A.indPrev24mo) as numer,
           sum(A.indPrev24mo) / B.denomIndexExp * 100 as prevPct
    from Work.comorbidities A inner join
         Work.denominator B on (A.database = B.database & A.exposure = B.exposure)
    group by A.database, A.exposure, A.outcomeCategory, A.disease, B.denomPatid, B.denomIndexExp
    union corr
    select A.database, A.exposure, A.outcomeCategory, A.disease,
           B.denomPatid,
           B.denomIndexExp,
           "36 months" as timeWindow,
           sum(A.indPrev36mo) as numer,
           sum(A.indPrev36mo) / B.denomIndexExp * 100 as prevPct
    from Work.comorbidities A inner join
         Work.denominator B on (A.database = B.database & A.exposure = B.exposure)
    group by A.database, A.exposure, A.outcomeCategory, A.disease, B.denomPatid, B.denomIndexExp;
  select * from Work.prev;

/* 
FRACTURES

See "ALGORITHMS TO ENHANCE SPECIFICITY OF FRACTURE IDENTIFICATION_ 100316.docx"
 */
proc sql;
  create table Work.fractureDiagnosis as
    select C.database, C.exposure, C.patid, C.ASCohortDate, C.indexGNN, C.indexDate, C.indexID, C.age, C.sex,
           "Osteoporotic fracture" as outcomeCategory,
           case
             when substr(code, 1, 3) in ("805", "806") | code = "73313" then "Clinical vertebral fracture"
             else                                                            "Non-vertebral osteoporotic fracture"
             end as disease,
           case
             when substr(code, 1, 3) in ("805", "806") | code = "73313" then "Spine, Incident"
             when substr(code, 1, 3) in ("808"       )                  then "Pelvis"
             when substr(code, 1, 3) in ("810"       )                  then "Clavicle"
             when substr(code, 1, 3) in ("811"       )                  then "Scapula"
             when substr(code, 1, 3) in ("812"       ) | code = "73311" then "Humerus"
             when substr(code, 1, 3) in ("813"       ) | code = "73312" then "Radius_ulna"
             when substr(code, 1, 3) in ("814"       )                  then "Carpal"
             when substr(code, 1, 3) in ("820"       ) | code = "73314" then "Hip"
             when substr(code, 1, 3) in ("821"       ) | code = "73315" then "Other femur"
             when substr(code, 1, 3) in ("822"       )                  then "Patella"
             when substr(code, 1, 3) in ("823"       ) | code = "73316" then "Tibia/fibula"
             when substr(code, 1, 3) in ("824"       )                  then "Ankle"
             else ""
             end as fractureSite,
           case
             when substr(code, 1, 4) in ("8050", "8052", "8054", "8058") | code = "73313" then 1
             when substr(code, 1, 4) in ("8080", "8082", "8084", "8088")                  then 1
             when substr(code, 1, 4) in ("8100")                                          then 1
             when substr(code, 1, 4) in ("8120", "8122", "8124"        ) | code = "73311" then 1
             when substr(code, 1, 4) in ("8200", "8202",         "8208") | code = "73314" then 1
             when substr(code, 1, 4) in ("8210", "8212"                ) | code = "73315" then 1
             when substr(code, 1, 4) in ("8230", "8232",         "8238") | code = "73316" then 1
             else 0
             end as indFractureClosed,
           sum(C.ASCohortDate <= C.begin_date <= C.indexDate) > 0 as indPrevPriorToIndex,
           sum(0 <= C.indexDate  - C.begin_date <= 183 |
               0 <= C.begin_date - C.indexDate  <= (183 * 1)) > 0 as indPrev12mo,
           sum(0 <= C.indexDate  - C.begin_date <= 183 |
               0 <= C.begin_date - C.indexDate  <= (183 * 3)) > 0 as indPrev24mo,
           sum(0 <= C.indexDate  - C.begin_date <= 183 |
               0 <= C.begin_date - C.indexDate  <= (183 * 5)) > 0 as indPrev36mo
    from (select A.* from UCB.tempDxMPCD A union corr
          select A.* from UCB.tempDxUCB  A union corr
          select A.* from UCB.tempDxSABR A ) C
    group by C.database, C.exposure, C.patid, C.ASCohortDate, C.indexGNN, C.indexDate, C.indexID, C.age, C.sex,
             outcomeCategory,
             disease,
             fractureSite,
             indFractureClosed
    having ^missing(fractureSite) & 
           (calculated indPrevPriorToIndex > 0 | 
            calculated indPrev12mo > 0 | 
            calculated indPrev24mo > 0 | 
            calculated indPrev36mo > 0 );
quit;


  drop table UCB.tempDxMPCD;
  drop table UCB.tempDxUCB;
  drop table UCB.tempDxSABR;
  drop table UCB.tempPxMPCD;
  drop table UCB.tempPxUCB;
  drop table UCB.tempPxSABR;

quit;


proc export
  data = Work.prev
  outfile = "data\processed\&cmt..csv"
  dbms = csv
  replace;
  delimiter = ",";
run;


ods html close;
