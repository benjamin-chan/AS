*  University of Alabama at Birmingham                               *
*  AS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=buildControlLookup; * type the name of your program here (without the filename extension);
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


%let var = patid, indexDate, age, sex, enr_start_date, enr_end_date;
proc sql;
  create table DT.controlLookup AS
    select "MPCD"       as database, "Non-AS" as cohort, &var from UCB.cntlCohortStdMPCD union corr
    select "Medicare"   as database, "Non-AS" as cohort, &var from UCB.cntlCohortStdC5P ;
  alter table DT.controlLookup add controlID numeric;
  update DT.controlLookup
    set controlID = monotonic();
quit;

proc sort data = DT.controlLookup nodupkey;
  by database cohort patid indexDate;
run;

proc sql;
  select database, 
         cohort, 
         count(distinct patid) as countDistinctPatid, 
         count(distinct indexID) as countDistinctIndexes, 
         count(*) as countRows
    from DT.indexLookup
    group by database, cohort;
quit;


ods html close;
