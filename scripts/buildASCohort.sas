*  University of Alabama at Birmingham                               *
*  AS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=buildASCohort; * type the name of your program here (without the filename extension);
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
  create table Work.numerASCohort as
    select "Old cohort, single 720.0 rheumatologist code" as cohort, "MPCD"       as database, count(distinct patid) as numerASCohort from UCB.cohortastdmpcd  union corr
    select "Old cohort, single 720.0 rheumatologist code" as cohort, "Marketscan" as database, count(distinct patid) as numerASCohort from UCB.cohortastducb   union corr
    select "Old cohort, single 720.0 rheumatologist code" as cohort, "Medicare"   as database, count(distinct patid) as numerASCohort from UCB.cohortastd_sabr ;
  select * from Work.numerASCohort;
quit;


/* 
Two 720.0 diagnosis codes between 7-365 days apart
Both from rheumatologists
Both from ambulatory visits
 */
%let where = dx_type = "09" & dx = "7200" & enc_type = "AV";


/* 
MPCD
 */
proc sql;
  create table Work.denom as 
    select distinct patid, enr_start_date, enr_end_date, intck("month", enr_start_date, enr_end_date) + 1 as monthsEnrolled
    from MPSTD.enroll
    where 12 <= calculated monthsEnrolled;
quit;
%let varlist = patid, begin_date, dx_type, dx, enc_type, prov_type format = $3. as prov_type, age;
proc sql;
  create table Work.temp1 as
    select &varlist from MPSTD.dx_07_10 where &where union corr
    select &varlist from MPSTD.dx_ip_07_10 where &where union corr
    select &varlist from MPSTD.dx_op_07_10 where &where
    order by patid, begin_date;
  select dx, count(*) as n from Work.temp1 group by dx;
quit;
proc sort data = Work.temp1 (keep = patid begin_date age) out = Work.ageCstdmpcd nodupkey;
  by patid begin_date age;
run;
data Work.ageCstdmpcd;
  set Work.ageCstdmpcd (rename = (age = ageC));
  by patid begin_date;
  age = scan(ageC, 1, "-") * 1;
  drop ageC;
  if first.begin_date then output;
run;
proc sql;
  create table Work.temp2 as
    select distinct
           coalesce(A.patid, B.patid) as patid,
           year(B.begin_date) as year,
           A.begin_date format = mmddyy10. as date1,
           B.begin_date format = mmddyy10. as date2,
           A.prov_type as prov_type1,
           B.prov_type as prov_type2,
           C.death_date,
           C.sex,
           D.age
    from Work.temp1 A inner join
         Work.temp1 B on (A.patid = B.patid &
                          intnx("year", B.begin_date, -1, "sameday") < A.begin_date < B.begin_date - 7) inner join
         MPSTD.demog C on (A.patid = C.patid) inner join
         Work.ageCstdmpcd D on (A.patid = D.patid &
                                B.begin_date = D.begin_date)
    where (A.prov_type = "66" & B.prov_type = "66");
  create table DT.cohortASTDMPCD as
    select distinct
           A.patid,
           A.dateEarliestDiagnosis format = mmddyy10. as asDate,
           max(A.dateEarliestDiagnosis, C.enr_start_date + 183) format = mmddyy10. as asCohortDate,
           calculated asCohortDate format = mmddyy10. as indexDate,
           C.enr_start_date,
           C.enr_end_date,
           B.death_date,
           B.sex,
           B.age
    from (select patid, min(date2) format = mmddyy10. as dateEarliestDiagnosis from Work.temp2 group by patid) A inner join
         Work.temp2 B on (A.patid = B.patid & A.dateEarliestDiagnosis = B.date2) inner join
         Work.denom C on (A.patid = C.patid & C.enr_start_date <= A.dateEarliestDiagnosis <= C.enr_end_date);
quit;


/* 
Marketscan
 */
proc sql;
  create table Work.denom as 
    select distinct patid, enr_start_date, enr_end_date, intck("month", enr_start_date, enr_end_date) + 1 as monthsEnrolled
    from UCBSTD.enroll
    where 12 <= calculated monthsEnrolled;
quit;
%let varlist = patid, begin_date, dx_type, dx, enc_type, prov_type;
proc sql;
  create table Work.temp1 as
    select &varlist from UCBSTD.dx_2010 where &where union corr
    select &varlist from UCBSTD.dx_2011 where &where union corr
    select &varlist from UCBSTD.dx_2012 where &where union corr
    select &varlist from UCBSTD.dx_2013 where &where union corr
    select &varlist from UCBSTD.dx_2014 where &where 
    order by patid, begin_date;
  select dx, count(*) as n from Work.temp1 group by dx;
quit;
proc sql;
  create table Work.temp2 as
    select distinct
           coalesce(A.patid, B.patid) as patid,
           year(B.begin_date) as year,
           A.begin_date format = mmddyy10. as date1,
           B.begin_date format = mmddyy10. as date2,
           A.prov_type as prov_type1,
           B.prov_type as prov_type2,
           C.death_date,
           C.sex,
           int((B.begin_date - C.birth_date) / 365.25) as age
    from Work.temp1 A inner join
         Work.temp1 B on (A.patid = B.patid &
                          intnx("year", B.begin_date, -1, "sameday") < A.begin_date < B.begin_date - 7) inner join
         UCBSTD.demog C on (A.patid = C.patid)
    where (A.prov_type = "300" & B.prov_type = "300");  /* Provider type codes in Marketscan are different than MPCD and Medicare */
  create table DT.cohortASTDUCB as
    select distinct
           A.patid,
           A.dateEarliestDiagnosis format = mmddyy10. as asDate,
           max(A.dateEarliestDiagnosis, C.enr_start_date + 183) format = mmddyy10. as asCohortDate,
           calculated asCohortDate format = mmddyy10. as indexDate,
           C.enr_start_date,
           C.enr_end_date,
           B.death_date,
           B.sex,
           B.age
    from (select patid, min(date2) format = mmddyy10. as dateEarliestDiagnosis from Work.temp2 group by patid) A inner join
         Work.temp2 B on (A.patid = B.patid & A.dateEarliestDiagnosis = B.date2) inner join
         Work.denom C on (A.patid = C.patid & C.enr_start_date <= A.dateEarliestDiagnosis <= C.enr_end_date);
quit;


/* 
Medicare, 65+ year-olds
 */
proc sql;
  create table Work.denom as 
    select distinct 
           A.patid, 
           A.enr_start_date, 
           A.enr_end_date, 
           intck("month", A.enr_start_date, A.enr_end_date) + 1 as monthsEnrolled,
           int((A.enr_start_date - B.birth_date) / 365.25) as ageAtEnrollmentStart
    from std_sabr.enroll A inner join
         std_sabr.demog B on (A.patid = B.patid)
    where 12 <= calculated monthsEnrolled &
          65 <= calculated ageAtEnrollmentStart;
quit;
%let varlist = patid, begin_date, dx_type, dx, enc_type, prov_type;
proc sql;
  create table Work.temp1 as
    select &varlist from std_sabr.std_dx_2006    where &where union corr
    select &varlist from std_sabr.std_dx_2007    where &where union corr
    select &varlist from std_sabr.std_dx_2008_v2 where &where union corr
    select &varlist from std_sabr.std_dx_2009    where &where union corr
    select &varlist from std_sabr.std_dx_2010    where &where union corr
    select &varlist from std_sabr.std_dx_2011    where &where union corr
    select &varlist from std_sabr.std_dx_2012    where &where union corr
    select &varlist from std_sabr.std_dx_2013    where &where union corr
    select &varlist from std_sabr.std_dx_2014    where &where 
    order by patid, begin_date;
  select dx, count(*) as n from Work.temp1 group by dx;
quit;
proc sql;
  create table Work.temp2 as
    select distinct
           coalesce(A.patid, B.patid) as patid,
           year(B.begin_date) as year,
           A.begin_date format = mmddyy10. as date1,
           B.begin_date format = mmddyy10. as date2,
           A.prov_type as prov_type1,
           B.prov_type as prov_type2,
           C.death_date,
           C.sex,
           int((B.begin_date - C.birth_date) / 365.25) as age
    from Work.temp1 A inner join
         Work.temp1 B on (A.patid = B.patid &
                          intnx("year", B.begin_date, -1, "sameday") < A.begin_date < B.begin_date - 7) inner join
         std_sabr.demog C on (A.patid = C.patid)
    where (A.prov_type = "66" & B.prov_type = "66");
  create table DT.cohortASTD_SABR as
    select distinct
           A.patid,
           A.dateEarliestDiagnosis format = mmddyy10. as asDate,
           max(A.dateEarliestDiagnosis, C.enr_start_date + 183) format = mmddyy10. as asCohortDate,
           calculated asCohortDate format = mmddyy10. as indexDate,
           C.enr_start_date,
           C.enr_end_date,
           B.death_date,
           B.sex,
           B.age
    from (select patid, min(date2) format = mmddyy10. as dateEarliestDiagnosis from Work.temp2 group by patid) A inner join
         Work.temp2 B on (A.patid = B.patid & A.dateEarliestDiagnosis = B.date2) inner join
         Work.denom C on (A.patid = C.patid & C.enr_start_date <= A.dateEarliestDiagnosis <= C.enr_end_date);
quit;


proc sql;
  create table Work.numerASCohort as
    select "New cohort, two 720.0 rheumatologist codes between 7-365 days apart" as cohort, "MPCD"       as database, count(distinct patid) as numerASCohort from DT.cohortASTDMPCD  union corr
    select "New cohort, two 720.0 rheumatologist codes between 7-365 days apart" as cohort, "Marketscan" as database, count(distinct patid) as numerASCohort from DT.cohortASTDUCB   union corr
    select "New cohort, two 720.0 rheumatologist codes between 7-365 days apart" as cohort, "Medicare"   as database, count(distinct patid) as numerASCohort from DT.cohortASTD_SABR ;
  select * from Work.numerASCohort;
quit;

proc contents data = DT.cohortASTDMPCD  order = varnum;  run;
proc contents data = DT.cohortASTDUCB   order = varnum;  run;
proc contents data = DT.cohortASTD_SABR order = varnum;  run;




ods html close;
