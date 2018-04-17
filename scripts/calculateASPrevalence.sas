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
/* Denominator enrolled at any time during year */
  create table Work.denom as
    select "Medicare" as database, 2006 as year, count(distinct patid) * 20 as denom from stdc5p.std_enrollment where year(enr_start_date) <= 2006 <= year(enr_end_date) union corr
    select "Medicare" as database, 2007 as year, count(distinct patid) * 20 as denom from stdc5p.std_enrollment where year(enr_start_date) <= 2007 <= year(enr_end_date) union corr
    select "Medicare" as database, 2008 as year, count(distinct patid) * 20 as denom from stdc5p.std_enrollment where year(enr_start_date) <= 2008 <= year(enr_end_date) union corr
    select "Medicare" as database, 2009 as year, count(distinct patid) * 20 as denom from stdc5p.std_enrollment where year(enr_start_date) <= 2009 <= year(enr_end_date) union corr
    select "Medicare" as database, 2010 as year, count(distinct patid) * 20 as denom from stdc5p.std_enrollment where year(enr_start_date) <= 2010 <= year(enr_end_date) union corr
    select "Medicare" as database, 2011 as year, count(distinct patid) * 20 as denom from stdc5p.std_enrollment where year(enr_start_date) <= 2011 <= year(enr_end_date) union corr
    select "Medicare" as database, 2012 as year, count(distinct patid) * 20 as denom from stdc5p.std_enrollment where year(enr_start_date) <= 2012 <= year(enr_end_date) union corr
    select "Medicare" as database, 2013 as year, count(distinct patid) * 20 as denom from stdc5p.std_enrollment where year(enr_start_date) <= 2013 <= year(enr_end_date) union corr
    select "Medicare" as database, 2014 as year, count(distinct patid) * 20 as denom from stdc5p.std_enrollment where year(enr_start_date) <= 2014 <= year(enr_end_date) ;
/* Numerator is entered AS cohort on or before year & enrolled at any time during year */
  create table Work.numer as
    select "Medicare" as database, 2006 as year, count(distinct patid) as numer from UCB.cohortastd_sabr where year(asDate) <= 2006 & year(enr_start_date) <= 2006 <= year(enr_end_date) union corr
    select "Medicare" as database, 2007 as year, count(distinct patid) as numer from UCB.cohortastd_sabr where year(asDate) <= 2007 & year(enr_start_date) <= 2007 <= year(enr_end_date) union corr
    select "Medicare" as database, 2008 as year, count(distinct patid) as numer from UCB.cohortastd_sabr where year(asDate) <= 2008 & year(enr_start_date) <= 2008 <= year(enr_end_date) union corr
    select "Medicare" as database, 2009 as year, count(distinct patid) as numer from UCB.cohortastd_sabr where year(asDate) <= 2009 & year(enr_start_date) <= 2009 <= year(enr_end_date) union corr
    select "Medicare" as database, 2010 as year, count(distinct patid) as numer from UCB.cohortastd_sabr where year(asDate) <= 2010 & year(enr_start_date) <= 2010 <= year(enr_end_date) union corr
    select "Medicare" as database, 2011 as year, count(distinct patid) as numer from UCB.cohortastd_sabr where year(asDate) <= 2011 & year(enr_start_date) <= 2011 <= year(enr_end_date) union corr
    select "Medicare" as database, 2012 as year, count(distinct patid) as numer from UCB.cohortastd_sabr where year(asDate) <= 2012 & year(enr_start_date) <= 2012 <= year(enr_end_date) union corr
    select "Medicare" as database, 2013 as year, count(distinct patid) as numer from UCB.cohortastd_sabr where year(asDate) <= 2013 & year(enr_start_date) <= 2013 <= year(enr_end_date) union corr
    select "Medicare" as database, 2014 as year, count(distinct patid) as numer from UCB.cohortastd_sabr where year(asDate) <= 2014 & year(enr_start_date) <= 2014 <= year(enr_end_date) ;
  create table Work.prev as
    select A.database, A.year, A.numer, B.denom, A.numer / B.denom as prev
    from Work.numer A inner join
         Work.denom B on (A.database = B.database & A.year = B.year);
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
