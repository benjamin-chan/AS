*  University of Alabama at Birmingham                               *
*  AS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=importOutcomeCodebook; * type the name of your program here (without the filename extension);
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


filename f "data\raw\AS Project Codebooks - 20170410\AS Project Cohort Outcome Codebook-20170410.xlsx";

proc sql;
  create table Work.worksheets (worksheet varchar(40), outfile varchar(20));
  insert into Work.worksheets
    values ("Detail Outcome-Cardiac", "defCardiac")
    values ("Detail Outcome-Cancer", "defCancer")
    values ("Detail Outcome-Hospit Infection", "defHospInf")
    values ("Detail Outcome-OI", "defOI")
    values ("Detail Outcome-Spondyloarthri", "defSpondy")
    values ("Detail Outcome-Lung-Neur-Kidn", "defLNK");
quit;

%macro import;
  %do i = 1 %to 6;
    data _null_;
      set Work.worksheets;
      if _n_ = &i then do;
        call symput ("worksheet", strip(worksheet));
        call symput ("outfile", strip(outfile));
      end;        
    run;
    proc import datafile = f dbms = xlsx out = Work.&outfile;
      sheet = "&worksheet";
    run;
  %end;
%mend;

%import;


proc sql;
  create table Work.defOutcomesICD9 as
    select "Cardiac disease" as outcomeCategory, * from Work.defCardiac union corr
    select "Cancer" as outcomeCategory, * from Work.defCancer union corr
    select "Hospitalized infection" as outcomeCategory, *, Descriptions as Description from Work.defHospInf union corr
    select "Opportunistic infection" as outcomeCategory, *, Descriptions as Description from Work.defOI union corr
    select case
             when disease in ("Psoriasis", "Psoriatic arthritis") then "PsO/PsA" 
             when disease in ("Crohn’s Disease", "Ulcerative Colitis") then "Inflammatory bowel disease"
             when prxmatch("/Crohn.s Disease/", disease) then "Inflammatory bowel disease"
             when disease in ("Uveitis") then "Uveitis"
             else ""
             end as outcomeCategory, 
           A.* 
      from Work.defSpondy A;
  alter table Work.defOutcomesICD9 add codeType varchar(7), code varchar(5);
  update Work.defOutcomesICD9
    set codeType = "ICD9-DX";
  update Work.defOutcomesICD9
    set code = dequote(icd9_list);
  alter table Work.defOutcomesICD9 drop icd9_list;
  create table Work.defOutcomes as
    select * from Work.defOutcomesICD9 union corr
    select disease_category as outcomeCategory, disease, code_type as codeType, dequote(codes) as code, description
      from Work.defLNK;
  select outcomeCategory, disease, count(distinct codeType) as countCodeTypes, count(distinct code) as countCodes
    from Work.defOutcomes
    where outcomeCategory ^in ("Cancer", "Hospitalized infection", "Opportunistic infection")
    group by outcomeCategory, disease;
quit;


ods html close;
