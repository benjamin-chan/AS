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
  /* create table Work.countDistinctIndexes as
    select patid,
           count(distinct indexID) as countDistinctIndexes
    from DT.indexLookup
    group by patid;
  select countDistinctIndexes, count(*) as n from Work.countDistinctIndexes group by countDistinctIndexes;
  create table Work.oneIndex as
    select A.*
    from DT.indexLookup A inner join
         Work.countDistinctIndexes B on (A.patid = B.patid)
    where B.countDistinctIndexes = 1;
  select database, exposure, count(distinct patid) as countDistinctPatid
    from Work.oneIndex
    group by database, exposure;
  create table Work.multipleIndexes as
    select A.*
    from DT.indexLookup A inner join
         Work.countDistinctIndexes B on (A.patid = B.patid)
    where B.countDistinctIndexes > 1
    order by A.patid, A.indexDate; */

  create table Work.indexLookup as
    select patid, indexDate, exposure
    from DT.indexLookup
    order by patid, indexDate;

quit;


ods html close;
