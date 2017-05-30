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
    select * from DT.indexLookup 
    order by database, patid, indexDate;
/* 
Attach exposure end dates to exposure segments
 */  
  create table Work.temp0 as
    select A.database,
           A.patid,
           A.enr_end_date,
           A.death_date,
           A.exposure as exposureA,
           A.indexDate format = mmddyy10. as indexStartA,
           min(B.indexDate - 1, A.enr_end_date, A.death_date) format = mmddyy10. as indexEndA,
           B.exposure as exposureB,
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
           A.exposureA as exposure,
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
Build therapy exposure timelines
See *Starts and Stops: Processing Episode Data With Beginning and Ending Dates*
http://www2.sas.com/proceedings/sugi29/260-29.pdf
 */
/* 
Since Work.episodeStarts will have up to 2 rows per patid,
the message
"NOTE: MERGE statement has more than one data set with repeats of BY values."
is expected.
 */
data Work.statusChangeDates (keep = patid rxClass statusChangeDate death_date);
  merge Work.candidateDispenses
        Work.episodeStarts (in = in keep = patid rxClass cleanPeriodBegin);
  by patid rxClass;
  format statusChangeDate mmddyy10.;
  if in then do;
    if first.rxClass then do;
      statusChangeDate = min(indexBronchDate, cleanPeriodBegin);
      output;
    end;
    statusChangeDate = dispense_date;
    output;
    if rxEnd < min(death_date, "&studyEndDate"D) then do;
      statusChangeDate = rxEnd + 1;
      output;
    end;
  end;
run;
proc sort data = Work.statusChangeDates out = Work.statusChangeDatesSorted nodupkey;
  by patid rxClass statusChangeDate;
run;
options mergenoby = nowarn;
data Work.timelineDates (keep = patid rxClass death_date periodStart periodEnd);
  merge Work.statusChangeDatesSorted (rename = (statusChangeDate = periodStart))
        Work.statusChangeDatesSorted (firstobs = 2
                                      rename = (patid = nextPatid
                                                rxClass = nextRxClass
                                                statusChangeDate = nextStartDate
                                                death_date = nextDeathDate));
  format periodStart periodEnd mmddyy10.;
  if patid = nextPatid & rxClass = nextRxClass then periodEnd = nextStartDate - 1;
  else periodEnd = min(death_date, "&studyEndDate"D);
run;
options mergenoby = error;
proc sql;
  create table Work.uncollapsedTimeline as
    select
      A.patid,
      A.rxClass,
      A.death_date,
      A.periodStart,
      A.periodEnd,
      max(A.rxClass = B.rxClass) as onTherapy
    from
      Work.timelineDates A left join
      Work.candidateDispenses B on
        A.patid = B.patid and
        A.rxClass = B.rxClass and 
        not (B.rxEnd < A.periodStart | A.periodEnd < B.dispense_date)
    group by A.patid, A.rxClass, A.death_date, A.periodStart, A.periodEnd
    order by A.patid, A.rxClass, A.death_date, A.periodStart, A.periodEnd;
quit;
data DT.rxTimeline;
  set Work.uncollapsedTimeline;
  by patid rxClass onTherapy notsorted;
  format holdPeriodStart mmddyy10.;
  drop holdPeriodStart;
  retain holdPeriodStart;
  if first.onTherapy then do;  /* Check the last variable in the BY group */
    holdPeriodStart = periodStart;
  end;
  if last.onTherapy then do;  /* Check the last variable in the BY group */
    periodStart = holdPeriodStart;
    output;
  end;
run;


ods html close;
