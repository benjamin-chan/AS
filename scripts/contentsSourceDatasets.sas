*  University of Alabama at Birmingham                               *
*  AS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=contentsSourceDatasets; * type the name of your program here (without the filename extension);
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


%macro exportContents;
  proc sql;
    create table Work.libs (libname varchar(8), desc varchar(20), yearRange varchar(9), note varchar(80));
    insert into Work.libs
      values ("stdc5p", "Medicare 5% Sample", "2006-2014", "Data can track back to 1999, but only use from 2006 in this project")
      values ("std_SABR", "Medicare SABER2", "2006-2014", "Standardization data are in server 1 in SAS lib Std_sabr")
      values ("MPSTD", "MPCD", "2007-2010", "Only RA(SP) & Healthy(CP2) population from 'Commercial' (eg. not Medicaid) coverage included)")
      values ("UCBSTD", "MarketScan", "2010-2014", "");
  quit;
  %do i = 1 %to 4;
    data _null_;
      set Work.libs;
      if _n_ = &i then call symput ("lib", strip(libname));
    run;
    proc contents data = &lib.._all_ order = varnum out = Work.contents_&lib;
    run;
    proc export
      data = Work.contents_&lib
      outfile = "data\processed\contentsSourceDatasets_&lib..csv"
      dbms = csv
      replace;
      delimiter = ",";
    run;
  %end;
%mend;

%exportContents;


proc export
  data = Work.libs
  outfile = "data\processed\contentsSourceDatasets.csv"
  dbms = csv
  replace;
  delimiter = ",";
run;



ods html close;
