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


proc sql;

  create table Work.defOutcomes as
    select * 
    from DT.defOutcomes 
    where outcomeCategory ^in ("Cancer", "Hospitalized infection", "Opportunistic infection");
  
  %let select1 = select A.*, B.begin_date, "ICD9-DX" as codeType, B.dx as code;
  %let on1 = on (A.patid = B.patid);
  %let select2 = select patid, begin_date, dx;
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

  %let select1 = select A.*, B.begin_date, case when B.px_type = "09" then "ICD9-PX" when B.px_type = "C1" then "CPT" else "" end as codeType, B.px as code;
  %let on1 = on (A.patid = B.patid);
  %let select2 = select patid, begin_date, px_type, px;
  %let where2 = where px_type in ("09", "C1");
  %let selectfrom3 = select * from DT.indexLookup;
  create table UCB.tempPxMPCD as
    &select1 from (&selectfrom3 where database = "MPCD") A inner join (&select2 from MPSTD.PX_07_10 &where2) B &on1;
  create table UCB.tempPxUCB as
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.PX_2010 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.PX_2011 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.PX_2012 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.PX_2013 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.PX_2014 &where2) B &on1 ;
  create table UCB.tempPxSABR as
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2006 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2007 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2008 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2009 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2010 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2011 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2012 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2013 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2014 &where2) B &on1 ;

  %let select1 = select A.*, B.outcomeCategory, B.disease;
  %let join1 = inner join Work.defOutcomes B on (A.codeType = B.codeType & A.code = B.code);
  create table Work.comorbidities as
    select C.database, C.exposure, C.patid, C.indexGNN, C.indexDate, C.age, C.sex,
           C.outcomeCategory,
           C.disease,
           sum(0 <= C.indexDate  - C.begin_date <= 183 |
               0 <= C.begin_date - C.indexDate  <= (183 * 1)) > 0 as indPrev12mo,
           sum(0 <= C.indexDate  - C.begin_date <= 183 |
               0 <= C.begin_date - C.indexDate  <= (183 * 3)) > 0 as indPrev24mo,
           sum(0 <= C.indexDate  - C.begin_date <= 183 |
               0 <= C.begin_date - C.indexDate  <= (183 * 5)) > 0 as indPrev36mo
    from (&select1 from UCB.tempDxMPCD A &join1 union corr
          &select1 from UCB.tempDxUCB  A &join1 union corr
          &select1 from UCB.tempDxSABR A &join1 union corr
          &select1 from UCB.tempPxMPCD A &join1 union corr
          &select1 from UCB.tempPxUCB  A &join1 union corr
          &select1 from UCB.tempPxSABR A &join1 ) C
    group by C.database, C.exposure, C.patid, C.indexGNN, C.indexDate, C.age, C.sex,
             C.outcomeCategory,
             C.disease
    having calculated indPrev12mo > 0 | 
           calculated indPrev24mo > 0 | 
           calculated indPrev36mo > 0;

  create table Work.denominator as
    select database, 
           exposure, 
           count(distinct patid) as denomPatid,
           count(distinct patid || indexGNN || put(indexDate, mmddyy10.)) as denomIndexExp
    from DT.indexLookup
    group by database, exposure;

  create table Work.prev as
    select A.database, A.exposure, A.outcomeCategory, A.disease,
           B.denomPatid,
           B.denomIndexExp,
           "12 months" as timeWindow,
           sum(A.indPrev12mo) as numer,
           sum(A.indPrev12mo) / B.denomIndexExp * 1000 as prevPer1000
    from Work.comorbidities A inner join
         Work.denominator B on (A.database = B.database & A.exposure = B.exposure)
    group by A.database, A.exposure, A.outcomeCategory, A.disease, B.denomPatid, B.denomIndexExp
    union corr
    select A.database, A.exposure, A.outcomeCategory, A.disease,
           B.denomPatid,
           B.denomIndexExp,
           "24 months" as timeWindow,
           sum(A.indPrev24mo) as numer,
           sum(A.indPrev24mo) / B.denomIndexExp * 1000 as prevPer1000
    from Work.comorbidities A inner join
         Work.denominator B on (A.database = B.database & A.exposure = B.exposure)
    group by A.database, A.exposure, A.outcomeCategory, A.disease, B.denomPatid, B.denomIndexExp
    select A.database, A.exposure, A.outcomeCategory, A.disease,
           B.denomPatid,
           B.denomIndexExp,
           "36 months" as timeWindow,
           sum(A.indPrev36mo) as numer,
           sum(A.indPrev36mo) / B.denomIndexExp * 1000 as prevPer1000
    from Work.comorbidities A inner join
         Work.denominator B on (A.database = B.database & A.exposure = B.exposure)
    group by A.database, A.exposure, A.outcomeCategory, A.disease, B.denomPatid, B.denomIndexExp;
  select * from Work.prev;

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
