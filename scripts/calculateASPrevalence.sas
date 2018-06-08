*  University of Alabama at Birmingham                               *
*  AS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=calculateASPrevalence; * type the name of your program here (without the filename extension);
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
    select "MPCD"       as database, count(distinct patid) as numerASCohort from UCB.cohortastdmpcd  union corr
    select "Marketscan" as database, count(distinct patid) as numerASCohort from UCB.cohortastducb   union corr
    select "Medicare"   as database, count(distinct patid) as numerASCohort from UCB.cohortastd_sabr ;
  select * from Work.numerASCohort;
quit;


/* 
Denominator
12 months of continuous enrollment
6+ months enrollment during calendar year
Age 65+ at start of enrollment window
 */
%let varlist = patid, enr_start_date, enr_end_date, intck("month", calculated date1, calculated date2) + 1 as monthsEnrolled;
%let where = 6 <= calculated monthsEnrolled & 12 <= intck("month", enr_start_date, enr_end_date) + 1;
proc sql;
  create table Work.denom1 as
    select A.*,
           int((A.date1 - B.birth_date) / 365.25) as ageAtEnrollmentStart
    from (select distinct 2006 as year, max(enr_start_date, "01JAN2006"D) format = mmddyy10. as date1, min("31DEC2006"D, enr_end_date) format = mmddyy10. as date2, &varlist from stdc5p.std_enrollment where &where union corr
          select distinct 2007 as year, max(enr_start_date, "01JAN2007"D) format = mmddyy10. as date1, min("31DEC2007"D, enr_end_date) format = mmddyy10. as date2, &varlist from stdc5p.std_enrollment where &where union corr
          select distinct 2008 as year, max(enr_start_date, "01JAN2008"D) format = mmddyy10. as date1, min("31DEC2008"D, enr_end_date) format = mmddyy10. as date2, &varlist from stdc5p.std_enrollment where &where union corr
          select distinct 2009 as year, max(enr_start_date, "01JAN2009"D) format = mmddyy10. as date1, min("31DEC2009"D, enr_end_date) format = mmddyy10. as date2, &varlist from stdc5p.std_enrollment where &where union corr
          select distinct 2010 as year, max(enr_start_date, "01JAN2010"D) format = mmddyy10. as date1, min("31DEC2010"D, enr_end_date) format = mmddyy10. as date2, &varlist from stdc5p.std_enrollment where &where union corr
          select distinct 2011 as year, max(enr_start_date, "01JAN2011"D) format = mmddyy10. as date1, min("31DEC2011"D, enr_end_date) format = mmddyy10. as date2, &varlist from stdc5p.std_enrollment where &where union corr
          select distinct 2012 as year, max(enr_start_date, "01JAN2012"D) format = mmddyy10. as date1, min("31DEC2012"D, enr_end_date) format = mmddyy10. as date2, &varlist from stdc5p.std_enrollment where &where union corr
          select distinct 2013 as year, max(enr_start_date, "01JAN2013"D) format = mmddyy10. as date1, min("31DEC2013"D, enr_end_date) format = mmddyy10. as date2, &varlist from stdc5p.std_enrollment where &where union corr
          select distinct 2014 as year, max(enr_start_date, "01JAN2014"D) format = mmddyy10. as date1, min("31DEC2014"D, enr_end_date) format = mmddyy10. as date2, &varlist from stdc5p.std_enrollment where &where ) A inner join
         stdc5p.std_demog_2006_2014 B on (A.patid = B.patid)
    where 65 <= calculated ageAtEnrollmentStart
    order by patid, year;
  create table Work.denom2 as 
    select distinct 
           A.patid, 
           A.enr_start_date, 
           A.enr_end_date, 
           intck("month", A.enr_start_date, A.enr_end_date) + 1 as monthsEnrolled,
           int((A.enr_start_date - B.birth_date) / 365.25) as ageAtEnrollmentStart
    from stdc5p.std_enrollment A inner join
         stdc5p.std_demog_2006_2014 B on (A.patid = B.patid)
    where 12 <= calculated monthsEnrolled &
          65 <= calculated ageAtEnrollmentStart;
quit;

/* 
Two 720.0 diagnosis codes between 7-365 days apart
Both from rheumatologists
Both from ambulatory visits
 */
%let varlist = patid, begin_date, dx_type, dx, enc_type, prov_type;
%let where = dx_type = "09" & dx = "7200" & enc_type = "AV";
proc sql;
  create table Work.temp1 as
    select &varlist from stdc5p.std_dx_2006 where &where union corr
    select &varlist from stdc5p.std_dx_2007 where &where union corr
    select &varlist from stdc5p.std_dx_2008 where &where union corr
    select &varlist from stdc5p.std_dx_2009 where &where union corr
    select &varlist from stdc5p.std_dx_2010 where &where union corr
    select &varlist from stdc5p.std_dx_2011 where &where union corr
    select &varlist from stdc5p.std_dx_2012 where &where union corr
    select &varlist from stdc5p.std_dx_2013 where &where union corr
    select &varlist from stdc5p.std_dx_2014 where &where 
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
           int((B.begin_date - C.birth_date) / 365.25) as ageAtASDate
    from Work.temp1 A inner join
         Work.temp1 B on (A.patid = B.patid &
                          intnx("year", B.begin_date, -1, "sameday") < A.begin_date < B.begin_date - 7) inner join
         stdc5p.std_demog_2006_2014 C on (A.patid = C.patid)
    where (A.prov_type = "66" & B.prov_type = "66");
  create table Work.numer1 as
    select A.*, B.year, B.ageAtEnrollmentStart
    from (select patid, min(year) as yearEarliestDiagnosis from Work.temp2 group by patid) A inner join
         Work.denom1 B on (A.patid = B.patid & A.yearEarliestDiagnosis <= B.year);
  create table Work.numer2 as
    select A.*, B.ageAtEnrollmentStart
    from (select patid, min(date2) format = mmddyy10. as dateEarliestDiagnosis from Work.temp2 group by patid) A inner join
         Work.denom2 B on (A.patid = B.patid & B.enr_start_date <= A.dateEarliestDiagnosis <= B.enr_end_date);
  select "Work.numer1" as table, min(ageAtEnrollmentStart) as minAge, max(ageAtEnrollmentStart) as maxAge, count(*) as countRows from Work.numer1 union corr
  select "Work.numer2" as table, min(ageAtEnrollmentStart) as minAge, max(ageAtEnrollmentStart) as maxAge, count(*) as countRows from Work.numer2 ;
quit;

/* 
Prevalence
 */
proc sql;
  create table Work.prev as
    select put(coalesce(A.year, B.year), 4.) as year, 
           A.numer as numer5pct, 
           B.denom as denom5pct,
           A.numer * 20 as numerEstimated,
           B.denom * 20 as denomEstimated,
           A.numer / B.denom format = percent10.3 as prev
    from (select year, count(distinct patid) as numer from Work.numer1 group by year) A inner join
         (select year, count(distinct patid) as denom from Work.denom1 group by year) B on (A.year = B.year)
    union corr
    select "OVERALL 2006-2014" as year, 
           A.numer as numer5pct, 
           B.denom as denom5pct,
           A.numer * 20 as numerEstimated,
           B.denom * 20 as denomEstimated,
           A.numer / B.denom format = percent10.3 as prev
    from (select count(distinct patid) as numer from Work.numer2) A,
         (select count(distinct patid) as denom from Work.denom2) B;
  select * from Work.prev;
quit;


proc export
  data = Work.prev
  outfile = "data\processed\prevalenceAS.csv"
  dbms = csv
  replace;
  delimiter = ",";
run;




ods html close;
