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
  create table Work.temp0 as
    select "AS" as cohort, database, patid
    from DT.indexLookup
    where database in ("MPCD", "Medicare")
    union corr
    select cohort, database, patid
    from DT.controlLookup;
  create table Work.temp1 as
    select database,
           count(distinct patid) as n
    from Work.temp0
    group by database;
  create table Work.temp2 as
    select cohort,
           database,
           count(distinct patid) as n
    from Work.temp0
    where cohort = "AS"
    group by cohort, database;
  create table Work.prevOverall as
    select coalesce(A.database, B.database) as database,
           "OVERALL" as year,
           B.n format = comma12.0 as y,
           A.n format = comma12.0 as n,
           B.n / A.n format = percent8.2 as prevalence
    from Work.temp1 A inner join
         Work.temp2 B on (A.database = B.database);
  select database,
         year,
         y,
         n,
         prevalence
    from Work.prevOverall;
quit;


%macro foo (yyyy);
  select "AS" as cohort, database, patid, &yyyy as year
  from DT.indexLookup
  where database in ("MPCD", "Medicare") & 
        year(indexDate) <= &yyyy
  union corr
  select cohort, database, patid, &yyyy as year
  from DT.controlLookup
  where database in ("MPCD", "Medicare") & 
        year(indexDate) <= &yyyy
%mend foo;

proc sql;
  create table Work.temp0 as
    %foo(2006) union corr
    %foo(2007) union corr
    %foo(2009) union corr
    %foo(2009) union corr
    %foo(2010) union corr
    %foo(2011) union corr
    %foo(2012) union corr
    %foo(2013) union corr
    %foo(2014) ;
  create table Work.temp1 as
    select database,
           year,
           count(distinct patid) as n
    from Work.temp0
    group by database, year;
  create table Work.temp2 as
    select cohort,
           database,
           year,
           count(distinct patid) as n
    from Work.temp0
    where cohort = "AS"
    group by cohort, database, year;
  create table Work.prevAnnual as
    select coalesce(A.database, B.database) as database,
           put(coalesce(A.year, B.year), 4.) as year,
           B.n format = comma12.0 as y,
           A.n format = comma12.0 as n,
           B.n / A.n format = percent8.2 as prevalence
    from Work.temp1 A inner join
         Work.temp2 B on (A.database = B.database & A.year = B.year) inner join
         (select database, max(year(indexDate)) as year
          from DT.controlLookup
          group by database) C on (B.database = C.database &
                                   B.year <= C.year);
  select database,
         year,
         y,
         n,
         prevalence
    from Work.prevAnnual;
quit;


proc sql;
  create table Work.prev as
    select * from Work.prevOverall union corr
    select * from Work.prevAnnual 
    order by database, year;
  select * from Work.prev;
quit;


proc export
  data = Work.prev
  outfile = "data\processed\prevalenceAS.csv"
  dbms = csv
  replace;
  delimiter = ",";
run;

/* 
libname UCB spde "q:\studies\AS\data\UCB"
                 datapath=("q:\studies\AS\data\UCB"
                           "r:\studies\AS\data\UCB"
                           "s:\studies\AS\data\UCB"
                           "t:\studies\AS\data\UCB"
                           "u:\studies\AS\data\UCB"
                           "v:\studies\AS\data\UCB")
                 indexpath=("t:\studies\AS\data\UCB"
                            "u:\studies\AS\data\UCB"
                            "v:\studies\AS\data\UCB")
                 bysort=no;

proc freq data = UCB.cntlCohortStdC5P;
  format indexDate enr_start_date enr_end_date year4.;
  table indexDate enr_start_date enr_end_date;
run;
 */

ods html close;
