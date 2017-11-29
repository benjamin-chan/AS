*  University of Alabama at Birmingham                               *
*  AS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=queryOtherComorbidities; * type the name of your program here (without the filename extension);
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




proc import out = Work.comorbidityLookup
            datafile = "U:\studies\AS\pgms\bchan\data\raw\AS Project Codebooks - 20170410\AS Project Covariates Codebook-20170410.xlsx" 
            dbms = xlsx 
            replace;
  sheet = "Comorbidity"; 
  getnames = yes;
  datarow = 2;
run;
proc sql;
  alter table Work.comorbidityLookup
    add code varchar;
  update Work.comorbidityLookup
    set code = dequote(icd9_list);
  alter table Work.comorbidityLookup
    drop compact_definion, icd9_list, billable, description, F;
  delete from Work.comorbidityLookup
    where missing(code);
  insert into Work.comorbidityLookup
    values ("COPD or emphysema", "4910" )
    values ("COPD or emphysema", "4911" )
    values ("COPD or emphysema", "49120")
    values ("COPD or emphysema", "49121")
    values ("COPD or emphysema", "49122")
    values ("COPD or emphysema", "4918" )
    values ("COPD or emphysema", "4919" )
    values ("COPD or emphysema", "4920" )
    values ("COPD or emphysema", "4928" )
    values ("COPD or emphysema", "496"  )
    values ("COPD or emphysema", "49320")
    values ("COPD or emphysema", "49321")
    values ("COPD or emphysema", "49322");
quit;


proc sql;

  %let select1 = select A.*, B.comorbidity;
  %let join1 = inner join Work.comorbidityLookup B on (A.code = B.code);
  create table DT.comorbiditiesOther as
    select distinct
           C.database, C.exposure, C.patid, C.ASCohortDate, C.indexGNN, C.indexDate, C.indexID, 
           C.age, C.sex,
           C.comorbidity,
           1 as indPreExposure
    from (&select1 from UCB.tempPrevDxAll A &join1) C;

  select comorbidity, database, exposure, sum(indPreExposure) as sumIndPreExposure
    from DT.comorbiditiesOther
    group by comorbidity, database, exposure;

quit;




ods html close;
