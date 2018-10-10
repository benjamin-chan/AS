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


%let var = patid, indexGNN, indexDate, age, sex, asDate, enr_start_date, enr_end_date, obs_end, asCohortDate, death_date;
proc sql;
  create table DT.indexLookup AS
    select "Marketscan" as database, "TNF"   as exposure, &var from DT.ASTNFCohortStdUCB_ex1     union corr
    select "Marketscan" as database, "DMARD" as exposure, &var from DT.ASDMARDCohortStdUCB_ex2   union corr
    select "Marketscan" as database, "NSAID" as exposure, &var from DT.ASNSAIDCohortStdUCB_ex2   union corr
    select "Marketscan" as database, "No exposure" as exposure, &var from DT.ASNoExpCohortStdUCB_ex2   union corr
    select "MPCD"       as database, "TNF"   as exposure, &var from DT.ASTNFCohortStdMPCD_ex1    union corr
    select "MPCD"       as database, "DMARD" as exposure, &var from DT.ASDMARDCohortStdMPCD_ex2  union corr
    select "MPCD"       as database, "NSAID" as exposure, &var from DT.ASNSAIDCohortStdMPCD_ex2  union corr
    select "MPCD"       as database, "No exposure" as exposure, &var from DT.ASNoExpCohortStdMPCD_ex2  union corr
    select "Medicare"   as database, "TNF"   as exposure, &var from DT.ASTNFCohortStd_SABR_ex1   union corr
    select "Medicare"   as database, "DMARD" as exposure, &var from DT.ASDMARDCohortStd_SABR_ex2 union corr
    select "Medicare"   as database, "NSAID" as exposure, &var from DT.ASNSAIDCohortStd_SABR_ex2 union corr
    select "Medicare"   as database, "No exposure" as exposure, &var from DT.ASNoExpCohortStd_SABR_ex2 ;
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
/* 
Check sequence of dates

* In a small number of instances, AS cohort date is BEFORE enrollment start date
* Index date is always at least 183 days BEFORE enrollment start
* Index date is always at least 0 days BEFORE AS cohort date
 */
proc sql;
  select database, 
         exposure, 
         . < ENR_START_DATE <= asCohortDate as indASOnOrAfterEnr,
         . < ENR_START_DATE < indexDate as indIndexAfterEnr,
         . < asCohortDate <= indexDate as indIndexOnOrAfterAS,
         count(distinct patid) format = comma12.0 as countDistinctPatid, 
         count(distinct indexID) format = comma12.0 as countDistinctID, 
         count(*) format = comma12.0 as countRows,
         min(asCohortDate - ENR_START_DATE) as minDaysFromEnrToAS,
         max(asCohortDate - ENR_START_DATE) as maxDaysFromEnrToAS,
         min(indexDate - ENR_START_DATE) as minDaysFromEnrToIndex,
         max(indexDate - ENR_START_DATE) as maxDaysFromEnrToIndex,
         min(indexDate - asCohortDate) as minDaysFromASToIndex,
         max(indexDate - asCohortDate) as maxDaysFromASToIndex
    from DT.indexLookup
    group by database, exposure, calculated indASOnOrAfterEnr, calculated indIndexAfterEnr, calculated indIndexOnOrAfterAS;
quit;
proc sql;
  select * from DT.indexLookup where database = "MPCD" & (. < ENR_START_DATE <= asCohortDate) = 0;
quit;


ods html close;
