*  University of Alabama at Birmingham                               *
*  AS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=contentsWorkingDatasets; * type the name of your program here (without the filename extension);
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


data Work.WorkingDatasets;
  length lib $8 mem $40;
  input lib mem;
  dataset = strip(lib) || "." || strip(mem);
  call symput ("n", put(_n_, best8.));
  cards;
UCB CohortAStdUCB
UCB CohortAStdMPCD
UCB CohortAStd_SABR
UCB ASTNFCohortStdUCB_ex1
UCB ASDMARDCohortStdUCB_ex2
UCB ASNSAIDCohortStdUCB_ex2
UCB ASNoExpCohortStdUCB_ex2
UCB ASTNFCohortStdMPCD_ex1
UCB ASDMARDCohortStdMPCD_ex2
UCB ASNSAIDCohortStdMPCD_ex2
UCB ASNoExpCohortStdMPCD_ex2
UCB ASTNFCohortStd_SABR_ex1
UCB ASDMARDCohortStd_SABR_ex2
UCB ASNSAIDCohortStd_SABR_ex2
UCB ASNoExpCohortStd_SABR_ex2
UCB CntlCohortStdC5P
UCB CntlCohortStdMPCD
DT defOutcomes
DT indexLookup
DT controlLookup
DT exposureTimeline
DT incidentDiseaseTimelines
DT fractureEpisodesPrev
DT fractureEpisodesPrevControl
DT fractureEpisodesInc
DT comorbidities
DT comorbiditiesControl
DT comorbiditiesOther
DT comorbiditiesAll
  ;
run;
proc sort data = Work.WorkingDatasets;
  by lib mem;
run;


%macro contents;
  %let list = ;
  %do i = 1 %to &n;
    data _null_;
      set Work.WorkingDatasets;
      if _n_ = &i then call symput ("dataset", dataset);
    run;
    proc contents data = &dataset order = varnum out = Work.contents&i noprint;
    run;
    %let list = &list Work.contents&i;
  %end;
  data Work.contentsAll;
    set &list;
  run;
%mend contents;

%contents;



ods html close;

proc export
  data = Work.contentsAll
  outfile = "data\processed\&cmt..csv"
  dbms = csv
  replace;
  delimiter = ",";
run;


ods html close;
