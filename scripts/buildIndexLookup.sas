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


%let var = patid, indexDate, min(age) as ageAtIndex, sex;
%let group_by = group by patid, indexDate, sex;
proc sql;
  create table DT.indexLookup AS
    select "Marketscan" as database, "TNF"   as exposure, &var from UCB.ASTNFCohortStdUCB_ex1     &group_by union corr
    select "Marketscan" as database, "DMARD" as exposure, &var from UCB.ASDMARDCohortStdUCB_ex2   &group_by union corr
    select "Marketscan" as database, "NSAID" as exposure, &var from UCB.ASNSAIDCohortStdUCB_ex2   &group_by union corr
    select "Marketscan" as database, "None"  as exposure, &var from UCB.ASNoExpCohortStdUCB_ex2   &group_by union corr
    select "MPCD"       as database, "TNF"   as exposure, &var from UCB.ASTNFCohortStdMPCD_ex1    &group_by union corr
    select "MPCD"       as database, "DMARD" as exposure, &var from UCB.ASDMARDCohortStdMPCD_ex2  &group_by union corr
    select "MPCD"       as database, "NSAID" as exposure, &var from UCB.ASNSAIDCohortStdMPCD_ex2  &group_by union corr
    select "MPCD"       as database, "None"  as exposure, &var from UCB.ASNoExpCohortStdMPCD_ex2  &group_by union corr
    select "Medicare"   as database, "TNF"   as exposure, &var from UCB.ASTNFCohortStd_SABR_ex1   &group_by union corr
    select "Medicare"   as database, "DMARD" as exposure, &var from UCB.ASDMARDCohortStd_SABR_ex2 &group_by union corr
    select "Medicare"   as database, "NSAID" as exposure, &var from UCB.ASNSAIDCohortStd_SABR_ex2 &group_by union corr
    select "Medicare"   as database, "None"  as exposure, &var from UCB.ASNoExpCohortStd_SABR_ex2 &group_by ;
  select database, 
         exposure, 
         count(distinct patid) as countDistinctPatid, 
         count(distinct patid || put(indexDate, mmddyy10.)) as countDistinctIndexes, 
         count(*) as countRows
    from DT.indexLookup
    group by database, exposure;
quit;


ods html close;
