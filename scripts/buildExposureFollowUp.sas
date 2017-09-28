*  University of Alabama at Birmingham                               *
*  AS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=buildExposureFollowUp; * type the name of your program here (without the filename extension);
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
See the *Compact Outcome Definition* worksheet in `AS Project Cohort Outcome Codebook-20170410.xlsx`
 */


/* 
From: Xie, Fenglong [mailto:fenglongxie@uabmc.edu] 
Sent: Wednesday, May 17, 2017 7:03 AM
To: Benjamin Chan <chanb@ohsu.edu>
Subject: RE: AS project data

Hi, Ben

The data are stored at UCB library defined as below email.

Attached please find the cohort list.

No exclusion was done except excluded for higher level exposure in six month
baseline.

You need to do appropriate censor (such as censor for discontinues of
exposure, switch to same level or higher lever exposure ...).

If you have question, please let me know.
 */


proc sql;
  create table Work.indexLookup as
    select case
             when A.exposure = "No exposure" then 0
             when A.exposure = "NSAID" then 1
             when A.exposure = "DMARD" then 2
             when A.exposure = "TNF" then 3
             else .
             end as exposureClass,
           A.* 
    from DT.indexLookup A
    order by A.database, A.patid, A.indexDate;
/* 
Attach exposure end dates to exposure segments
 */  
  create table Work.temp0 as
    select A.database,
           A.patid,
           A.enr_end_date,
           A.death_date,
           A.exposureClass as exposureClassA,
           A.exposure as exposureA,
           A.indexGNN as exposureDrugA,
           A.indexDate format = mmddyy10. as indexStartA,
           min(B.indexDate - 1, A.enr_end_date, A.death_date) format = mmddyy10. as indexEndA,
           B.exposureClass as exposureClassB,
           B.exposure as exposureB,
           B.indexGNN as exposureDrugB,
           B.indexDate format = mmddyy10. as indexStartB
    from Work.indexLookup A left join
         Work.indexLookup B on (A.database = B.database &
                                A.patid = B.patid &
                                A.indexDate < B.indexDate);
  create table Work.tempLookup as
    select database,
           patid,
           indexStartA,
           min(indexEndA) as earliestIndexEndA
    from Work.temp0
    group by database,
             patid,
             indexStartA;
  create table Work.tempExposureSegments as
    select A.database,
           A.patid,
           A.enr_end_date,
           A.death_date,
           A.exposureClassA as exposureClass,
           A.exposureA as exposure,
           A.exposureDrugA as exposureDrug,
           A.indexStartA as exposureStart,
           A.indexEndA as exposureEnd
    from Work.temp0 A inner join
         Work.tempLookup B on (A.database = B.database &
                               A.patid = B.patid &
                               A.indexStartA = B.indexStartA &
                               A.indexEndA = B.earliestIndexEndA)
    order by A.database,
             A.patid,
             A.indexStartA;
quit;


/* 
Collapse exposure segments

See *Starts and Stops: Processing Episode Data With Beginning and Ending Dates*
http://www2.sas.com/proceedings/sugi29/260-29.pdf
 */
data DT.exposureTimeline;
  set Work.tempExposureSegments;
  by database patid exposureClass exposure exposureDrug notsorted;
  format holdPeriodStart mmddyy10.;
  drop holdPeriodStart;
  retain holdPeriodStart;
  if first.exposureDrug then do;  /* Check the last variable in the BY group */
    holdPeriodStart = exposureStart;
  end;
  if last.exposureDrug then do;  /* Check the last variable in the BY group */
    exposureStart = holdPeriodStart;
    output;
  end;
run;
proc sql;
  alter table DT.exposureTimeline add daysExposed numeric;
  update DT.exposureTimeline
    set daysExposed = exposureEnd - exposureStart + 1;
  alter table DT.exposureTimeline add exposureID numeric;
  update DT.exposureTimeline
    set exposureID = monotonic();
quit ;


proc means data = DT.exposureTimeline n sum mean std min q1 median q3 max maxdec = 1;
  class database exposure;
  var daysExposed;
run;


ods html close;
