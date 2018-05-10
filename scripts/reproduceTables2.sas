*  University of Alabama at Birmingham                               *
*  AS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=reproduceTables2; * type the name of your program here (without the filename extension);
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


%let var = patid, age, sex, asDate, enr_start_date, enr_end_date, asCohortDate, death_date;
proc sql;
  create table DT.asLookup AS
    select "Marketscan" as database, "AS" as cohort, &var from UCB.cohortastducb   union corr
    select "MPCD"       as database, "AS" as cohort, &var from UCB.cohortastdmpcd  union corr
    select "Medicare"   as database, "AS" as cohort, &var from UCB.cohortastd_sabr ;
quit;


proc sort data = DT.asLookup out = Work.patidCharacteristics nodupkey;
  by database patid;
run;
proc sort data = DT.controlLookup out = Work.controlCharacteristics nodupkey;
  by database patid;
run;
proc sql;
  select cohort,
         database,
         count(*) format = comma9.0 as denom,
         strip(put(mean(age), 8.1)) || " (" || strip(put(std(age), 8.1)) || ")" as age,
         strip(put(sum(sex = "F") / count(*), percent9.1) || "(n = " || strip(put(sum(sex = "F"), comma9.0)) || ")") as female
    from (select cohort, database, patid, age, sex from Work.patidCharacteristics union corr
          select cohort, database, patid, age, sex from Work.controlCharacteristics )
  group by cohort, database;
quit;


proc sort data = DT.indexLookup out = Work.patidCharacteristics nodupkey;
  by database patid;
run;
proc sort data = DT.controlLookup out = Work.controlCharacteristics nodupkey;
  by database patid;
run;
proc sql;
  select cohort,
         database,
         count(*) format = comma9.0 as denom,
         strip(put(mean(age), 8.1)) || " (" || strip(put(std(age), 8.1)) || ")" as age,
         strip(put(sum(sex = "F") / count(*), percent9.1) || "(n = " || strip(put(sum(sex = "F"), comma9.0)) || ")") as female
    from (select "Exposed" as cohort, database, patid, age, sex from Work.patidCharacteristics union corr
          select              cohort, database, patid, age, sex from Work.controlCharacteristics )
  group by cohort, database;
quit;


proc sort data = DT.indexLookup out = Work.patidCharacteristics nodupkey;
  by database exposure patid;
run;
proc sql;
  select database,
         exposure,
         count(*) format = comma9.0 as denom,
         strip(put(mean(age), 8.1)) || " (" || strip(put(std(age), 8.1)) || ")" as age,
         strip(put(sum(sex = "F") / count(*), percent9.1) || "(n = " || strip(put(sum(sex = "F"), comma9.0)) || ")") as female
    from Work.patidCharacteristics
  group by database, exposure;
quit;


ods html close;
