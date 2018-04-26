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


proc sql;
  create table Work.denom1 as
    select distinct 2006 as year, patid from stdc5p.std_enrollment where 6 <= intck("month", max(enr_start_date, "01JAN2006"D), min("31DEC2006"D, enr_end_date)) union corr
    select distinct 2007 as year, patid from stdc5p.std_enrollment where 6 <= intck("month", max(enr_start_date, "01JAN2007"D), min("31DEC2007"D, enr_end_date)) union corr
    select distinct 2008 as year, patid from stdc5p.std_enrollment where 6 <= intck("month", max(enr_start_date, "01JAN2008"D), min("31DEC2008"D, enr_end_date)) union corr
    select distinct 2009 as year, patid from stdc5p.std_enrollment where 6 <= intck("month", max(enr_start_date, "01JAN2009"D), min("31DEC2009"D, enr_end_date)) union corr
    select distinct 2010 as year, patid from stdc5p.std_enrollment where 6 <= intck("month", max(enr_start_date, "01JAN2010"D), min("31DEC2010"D, enr_end_date)) union corr
    select distinct 2011 as year, patid from stdc5p.std_enrollment where 6 <= intck("month", max(enr_start_date, "01JAN2011"D), min("31DEC2011"D, enr_end_date)) union corr
    select distinct 2012 as year, patid from stdc5p.std_enrollment where 6 <= intck("month", max(enr_start_date, "01JAN2012"D), min("31DEC2012"D, enr_end_date)) union corr
    select distinct 2013 as year, patid from stdc5p.std_enrollment where 6 <= intck("month", max(enr_start_date, "01JAN2013"D), min("31DEC2013"D, enr_end_date)) union corr
    select distinct 2014 as year, patid from stdc5p.std_enrollment where 6 <= intck("month", max(enr_start_date, "01JAN2014"D), min("31DEC2014"D, enr_end_date)) 
    order by patid, year;
  create table Work.numer1 as
    select distinct B.year, B.patid
    from (select distinct 2006 as year, patid from stdc5p.std_dx_2006 where dx_type = "09" & dx = "7200" & enc_type ^in ("IF", "OT", "") & prov_type = "66" union corr
          select distinct 2007 as year, patid from stdc5p.std_dx_2007 where dx_type = "09" & dx = "7200" & enc_type ^in ("IF", "OT", "") & prov_type = "66" union corr
          select distinct 2008 as year, patid from stdc5p.std_dx_2008 where dx_type = "09" & dx = "7200" & enc_type ^in ("IF", "OT", "") & prov_type = "66" union corr
          select distinct 2009 as year, patid from stdc5p.std_dx_2009 where dx_type = "09" & dx = "7200" & enc_type ^in ("IF", "OT", "") & prov_type = "66" union corr
          select distinct 2010 as year, patid from stdc5p.std_dx_2010 where dx_type = "09" & dx = "7200" & enc_type ^in ("IF", "OT", "") & prov_type = "66" union corr
          select distinct 2011 as year, patid from stdc5p.std_dx_2011 where dx_type = "09" & dx = "7200" & enc_type ^in ("IF", "OT", "") & prov_type = "66" union corr
          select distinct 2012 as year, patid from stdc5p.std_dx_2012 where dx_type = "09" & dx = "7200" & enc_type ^in ("IF", "OT", "") & prov_type = "66" union corr
          select distinct 2013 as year, patid from stdc5p.std_dx_2013 where dx_type = "09" & dx = "7200" & enc_type ^in ("IF", "OT", "") & prov_type = "66" union corr
          select distinct 2014 as year, patid from stdc5p.std_dx_2014 where dx_type = "09" & dx = "7200" & enc_type ^in ("IF", "OT", "") & prov_type = "66" ) A inner join
         Work.denom1 B on (A.patid = B.patid & A.year <= B.year)
    order by B.patid, B.year;
  create table Work.prev1 as
    select "Medicare" as database, A.year, A.numer, B.denom, A.numer / B.denom as prev
    from (select year, count(distinct patid) as numer from Work.numer1 group by year) A inner join
         (select year, count(distinct patid) as denom from Work.denom1 group by year) B on (A.year = B.year);
  create table Work.denom2 as
    select distinct "OVERALL 2006-2014" as year, patid, enr_start_date, enr_end_date from stdc5p.std_enrollment where 6 <= intck("month", max(enr_start_date, "01JAN2006"D), min("31DEC2014"D, enr_end_date)) ;
  create table Work.numer2 as
    select distinct B.year, B.patid
    from (select distinct begin_date, patid from stdc5p.std_dx_2006 where dx_type = "09" & dx = "7200" & enc_type ^in ("IF", "OT", "") & prov_type = "66" union corr
          select distinct begin_date, patid from stdc5p.std_dx_2007 where dx_type = "09" & dx = "7200" & enc_type ^in ("IF", "OT", "") & prov_type = "66" union corr
          select distinct begin_date, patid from stdc5p.std_dx_2008 where dx_type = "09" & dx = "7200" & enc_type ^in ("IF", "OT", "") & prov_type = "66" union corr
          select distinct begin_date, patid from stdc5p.std_dx_2009 where dx_type = "09" & dx = "7200" & enc_type ^in ("IF", "OT", "") & prov_type = "66" union corr
          select distinct begin_date, patid from stdc5p.std_dx_2010 where dx_type = "09" & dx = "7200" & enc_type ^in ("IF", "OT", "") & prov_type = "66" union corr
          select distinct begin_date, patid from stdc5p.std_dx_2011 where dx_type = "09" & dx = "7200" & enc_type ^in ("IF", "OT", "") & prov_type = "66" union corr
          select distinct begin_date, patid from stdc5p.std_dx_2012 where dx_type = "09" & dx = "7200" & enc_type ^in ("IF", "OT", "") & prov_type = "66" union corr
          select distinct begin_date, patid from stdc5p.std_dx_2013 where dx_type = "09" & dx = "7200" & enc_type ^in ("IF", "OT", "") & prov_type = "66" union corr
          select distinct begin_date, patid from stdc5p.std_dx_2014 where dx_type = "09" & dx = "7200" & enc_type ^in ("IF", "OT", "") & prov_type = "66" ) A inner join
         Work.denom2 B on (A.patid = B.patid & B.enr_start_date <= A.begin_date <= B.enr_end_date);
  create table Work.prev2 as
    select "Medicare" as database, A.year, A.numer, B.denom, A.numer / B.denom as prev
    from (select year, count(distinct patid) as numer from Work.numer2 group by year) A,
         (select year, count(distinct patid) as denom from Work.denom2 group by year) B;
  create table Work.prev as
    select database, put(year, 4.) as year, numer, denom, prev from Work.prev1 union corr
    select database,                  year, numer, denom, prev from Work.prev2 ;
  select database, year, numer format = comma10.0, denom format = comma10.0, prev format = percent10.3 from Work.prev;
quit;
/* 
database  year                    numer       denom        prev
---------------------------------------------------------------
Medicare  2006                      188     866,963     0.022%
Medicare  2007                      263     881,582     0.030%
Medicare  2008                      355     892,067     0.040%
Medicare  2009                      426     895,012     0.048%
Medicare  2010                      509     912,148     0.056%
Medicare  2011                      595     947,119     0.063%
Medicare  2012                      700     993,250     0.070%
Medicare  2013                      858   1,114,786     0.077%
Medicare  2014                      952   1,135,170     0.084%
Medicare  OVERALL 2006-2014       1,061   1,846,811     0.057%
 */



proc export
  data = Work.prev
  outfile = "data\processed\prevalenceAS.csv"
  dbms = csv
  replace;
  delimiter = ",";
run;




ods html close;
