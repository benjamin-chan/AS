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
/* 
database exposure indASOnOrAfterEnr indIndexAfterEnr indIndexOnOrAfterAS countDistinctPatid countDistinctID countRows minDaysFromEnrToAS maxDaysFromEnrToAS minDaysFromEnrToIndex maxDaysFromEnrToIndex minDaysFromASToIndex maxDaysFromASToIndex 
MPCD DMARD 1 1 1 421 481 481 183 1449 184 1450 0 1230 
MPCD NSAID or no exposure 1 1 1 2,083 2,593 2,593 183 1457 183 1457 0 1268 
MPCD TNF 0 1 1 7 8 8 -972 -177 218 917 568 1235 
MPCD TNF 1 1 1 1,101 1,271 1,271 183 1417 183 1460 0 1201 
Marketscan DMARD 1 1 1 1,799 2,045 2,045 183 1811 183 1825 0 1627 
Marketscan NSAID or no exposure 1 1 1 8,025 10,589 10,589 183 1825 183 1825 0 1642 
Marketscan TNF 0 1 1 30 31 31 -1278 -90 197 920 359 1616 
Marketscan TNF 1 1 1 4,776 5,748 5,748 183 1810 183 1825 0 1634 
Medicare DMARD 1 1 1 4,231 5,193 5,193 183 3215 183 3281 0 3088 
Medicare NSAID or no exposure 1 1 1 17,983 26,122 26,122 183 3278 183 3284 0 3088 
Medicare TNF 0 1 1 140 162 162 -2638 -32 184 2463 287 3101 
Medicare TNF 1 1 1 4,754 5,767 5,767 183 3158 183 3278 0 3080 
 */
proc sql;
  select * from DT.indexLookup where database = "MPCD" & (. < ENR_START_DATE <= asCohortDate) = 0;
quit;


ods html close;
