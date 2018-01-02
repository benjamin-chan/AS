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
    select "AS" as cohort, database, patid, min(year(indexDate)) as year  /* Only count the first instance of AS cohort membership */
    from DT.indexLookup
    where database in ("MPCD", "Medicare")
    group by database, patid
    union corr
    select cohort, database, patid, year(indexDate) as year
    from DT.controlLookup;
  create table Work.temp1 as
    select database,
           count(distinct patid) as n
    from Work.temp0
    group by database;
  create table Work.temp2 as
    select database,
           year,
           count(distinct patid) as n
    from Work.temp0
    group by database, year;
  create table Work.temp3 as
    select cohort,
           database,
           count(distinct patid) as n
    from Work.temp0
    where cohort = "AS"
    group by cohort, database;
  create table Work.temp4 as
    select cohort,
           database,
           year,
           count(distinct patid) as n
    from Work.temp0
    where cohort = "AS"
    group by cohort, database, year;
  create table Work.temp5 as
    select coalesce(A.database, B.database) as database,
           "OVERALL" as year,
           B.n as y,
           A.n as n,
           B.n / A.n as prevalence
    from Work.temp1 A inner join
         Work.temp3 B on (A.database = B.database)
    union corr
    select coalesce(A.database, B.database) as database,
           put(coalesce(A.year, B.year), 4.) as year,
           B.n as y,
           A.n as n,
           B.n / A.n as prevalence
    from Work.temp2 A inner join
         Work.temp4 B on (A.database = B.database & A.year = B.year);
  select database,
         year,
         y format = comma12.0,
         n format = comma12.0,
         prevalence format = percent8.2
    from Work.temp5;
quit;


proc export
  data = Work.temp5
  outfile = "data\processed\prevalenceAS.csv"
  dbms = csv
  replace;
  delimiter = ",";
run;




ods html close;
