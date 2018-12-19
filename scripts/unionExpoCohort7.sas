*  University of Alabama at Birmingham                               *
*  AS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=unionExpoCohort7; * type the name of your program here (without the filename extension);
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
  create table Work.exposureTimeline as
    select database,
           patid,
           case
             when exposure = "NO" then 0
             when exposure = "NSAID" then 1
             when exposure = "DMARD" then 2
             when exposure = "TNF" then 3
             else .
             end as exposureClass,
           case
             when exposure = "NO" then "No exposure"
             else exposure
             end as exposure,
           case
             when exposure = "NO" then ""
             else GNN 
             end as exposureDrug,
           indexDate format = mmddyy10. as exposureStart,
           enr_end_date format = mmddyy10.,
           death_date format = mmddyy10.,
           censor_rx format = mmddyy10.,
           stop_date format = mmddyy10.,
           obs_end format = mmddyy10.,
           followupenddate format = mmddyy10. as exposureEnd,
           followupday as daysExposed,
           min(stop_date - 1, 
               enr_end_date, 
               censor_rx - 1, 
               DEATH_DATE) - indexDate + 1 as cohortDay
    from (select * from DT.expo_cohort7_UCBSTD  union corr
          select * from DT.expo_cohort7_MPSTD   union corr
          select * from DT.expo_cohort7_SABRSTD );
  alter table Work.exposureTimeline add exposureID numeric;
  update Work.exposureTimeline
    set exposureID = monotonic();
  select database, count(*) as n from Work.exposureTimeline group by database;
  select database, exposureClass, exposure, count(*) as n from Work.exposureTimeline group by database, exposureClass, exposure;
quit;


proc means data = Work.exposureTimeline n sum mean std min q1 median q3 max maxdec = 1;
  class database exposureClass exposure;
  var daysExposed;
run;
proc means data = Work.exposureTimeline n sum mean std min q1 median q3 max maxdec = 1;
  class database exposureClass exposure;
  var cohortDay;
run;


proc copy in = Work out = DT;
  select exposureTimeline;
run;
proc contents data = DT.exposureTimeline order = varnum;
run;


ods html close;
