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


/* 
NEED TO OPERATIONALIZE

The outcome definition for osteoporotic fracture is complex.
See *ALGORITHMS TO ENHANCE SPECIFICITY OF FRACTURE IDENTIFICATION_ 100316.docx*

Osteoporotic fracture Clinical vertebral fracture
Non-vertebral osteoporotic fracture (hip, pelvis, femur, humerus, distal radius/ulna)
 */


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
    select "Cardiac disease" as outcomeCategory, disease, icd9_list, description from Work.defCardiac union corr
    select "Cancer" as outcomeCategory, disease, icd9_list, description from Work.defCancer union corr
    select "Infection" as outcomeCategory, "Hospitalized infection" as disease, icd9_list, Descriptions as description from Work.defHospInf union corr
    select "Infection" as outcomeCategory, "Opportunistic infection" as disease, icd9_list, Descriptions as description from Work.defOI union corr
    select case
             when disease in ("Psoriasis", "Psoriatic arthritis") then "PsO/PsA" 
             when disease in ("Crohn’s Disease", "Ulcerative Colitis") then "Inflammatory bowel disease"
             when prxmatch("/Crohn.s Disease/", disease) then "Inflammatory bowel disease"
             when disease in ("Uveitis") then "Uveitis"
             else ""
             end as outcomeCategory, 
           A.disease,
           A.icd9_list,
           A.description
      from Work.defSpondy A;
  alter table Work.defOutcomesICD9 add codeType varchar(7), code varchar(5), enc_type varchar(2);
  update Work.defOutcomesICD9
    set codeType = "ICD9-DX";
  update Work.defOutcomesICD9
    set code = dequote(icd9_list);
  update Work.defOutcomesICD9
    set enc_type = case when disease = "Myocardial infarction" then "IP" else "" end;
  alter table Work.defOutcomesICD9 drop icd9_list;
  create table DT.defOutcomes as
    select * from Work.defOutcomesICD9 union corr
    select disease_category as outcomeCategory, disease, code_type as codeType, dequote(codes) as code, "" as enc_type, description
      from Work.defLNK;
  select outcomeCategory, disease, count(distinct codeType) as countCodeTypes, count(distinct code) as countCodes
    from DT.defOutcomes
    where outcomeCategory ^in ("Hospitalized infection", "Opportunistic infection")
    group by outcomeCategory, disease;
quit;


ods html close;
