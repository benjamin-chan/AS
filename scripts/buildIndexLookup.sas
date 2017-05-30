*  University of Alabama at Birmingham                               *
*  AS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=buildIndexLookup; * type the name of your program here (without the filename extension);
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


%let var = patid, indexGNN, indexDate, age, sex, asDate, enr_start_date, enr_end_date, asCohortDate, death_date;
proc sql;
  create table DT.indexLookup AS
    select "Marketscan" as database, "TNF"   as exposure, &var from UCB.ASTNFCohortStdUCB_ex1     union corr
    select "Marketscan" as database, "DMARD" as exposure, &var from UCB.ASDMARDCohortStdUCB_ex2   union corr
    select "Marketscan" as database, "NSAID or no exposure" as exposure, &var from UCB.ASNSAIDCohortStdUCB_ex2   union corr
    select "Marketscan" as database, "NSAID or no exposure" as exposure, &var from UCB.ASNoExpCohortStdUCB_ex2   union corr
    select "MPCD"       as database, "TNF"   as exposure, &var from UCB.ASTNFCohortStdMPCD_ex1    union corr
    select "MPCD"       as database, "DMARD" as exposure, &var from UCB.ASDMARDCohortStdMPCD_ex2  union corr
    select "MPCD"       as database, "NSAID or no exposure" as exposure, &var from UCB.ASNSAIDCohortStdMPCD_ex2  union corr
    select "MPCD"       as database, "NSAID or no exposure" as exposure, &var from UCB.ASNoExpCohortStdMPCD_ex2  union corr
    select "Medicare"   as database, "TNF"   as exposure, &var from UCB.ASTNFCohortStd_SABR_ex1   union corr
    select "Medicare"   as database, "DMARD" as exposure, &var from UCB.ASDMARDCohortStd_SABR_ex2 union corr
    select "Medicare"   as database, "NSAID or no exposure" as exposure, &var from UCB.ASNSAIDCohortStd_SABR_ex2 union corr
    select "Medicare"   as database, "NSAID or no exposure" as exposure, &var from UCB.ASNoExpCohortStd_SABR_ex2 ;
  alter table DT.indexLookup add indexID numeric;
  update DT.indexLookup
    set indexID = monotonic();
quit;

proc sort data = DT.indexLookup nodupkey;
  by database exposure patid indexGNN indexDate;
run;

proc sql;
  select database, 
         exposure, 
         count(distinct patid) as countDistinctPatid, 
         count(distinct indexID) as countDistinctIndexes, 
         count(*) as countRows
    from DT.indexLookup
    group by database, exposure;
quit;


ods html close;
