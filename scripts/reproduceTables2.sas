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


proc sort data = DT.indexLookup out = Work.patidCharacteristics nodupkey;
  by database exposure patid;
run;
proc sql;
  select database,
         exposure,
         strip(put(mean(age), 8.0)) || " (" || strip(put(std(age), 8.0)) || ")" as age,
         strip(put(sum(sex = "F") / count(*), percent9.2)) as female
    from Work.patidCharacteristics
  group by database, exposure;
quit;


ods html close;
