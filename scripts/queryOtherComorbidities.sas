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



proc sql;
/* 
Oral corticosteroid use
Mean outpatient prescribed daily dose of prednisone equivalents in the 6
months prior to index date: less than 5 mg/d (low dose), 5 to less than 10
mg/d (medium dose), and 10 mg/d or more (high dose)
 */
  create table DT.rxOralCorticosteroid as
    select C.database, C.patid, C.indexID,
           1 as indOralCorticosteroid,
           sum(C.daysAtRisk * C.prednisodeEquivalentDose) as sumPredEq,
           sum(C.daysAtRisk) as sumDaysSupply,
           sum(C.daysAtRisk * C.prednisodeEquivalentDose) / 183 as meanPredEqDose,
           case 
             when 0 <= sum(C.daysAtRisk * C.prednisodeEquivalentDose) / 183 < 2.5 then "Low (<2.5 mg/d)"
             when 2.5 <= sum(C.daysAtRisk * C.prednisodeEquivalentDose) / 183 < 5 then "Medium-Low (2.5-5 mg/d)"
             when 5 <= sum(C.daysAtRisk * C.prednisodeEquivalentDose) / 183 < 10 then "Medium-High (5-10 mg/d)"
             when 10 <= sum(C.daysAtRisk * C.prednisodeEquivalentDose) / 183 then "High (10+ mg/d)"
             else ""
             end as meanPredEqDoseCat
    from (select A.database, A.patid, A.indexID, 
                 A.indexDate - 183 format = mmddyy10. as riskStart, 
                 A.indexDate, 
                 A.dispense_date, 
                 A.dispense_date + A.dispense_sup - 1 format = mmddyy10. as dispense_end, 
                 A.dispense_sup, 
                 case
                   /* Rx completely in at-risk period */
                   when (A.indexDate - 183 <= A.dispense_date) & ((A.dispense_date + A.dispense_sup - 1) <= A.indexDate) 
                     then A.dispense_sup 
                   /* Rx begins before at-risk period */
                   when (A.dispense_date < A.indexDate - 183) 
                     then A.dispense_sup - (A.indexDate - 183 - A.dispense_date) 
                   /* Rx ends after at-risk period */
                   when (A.indexDate < (A.dispense_date + A.dispense_sup - 1)) 
                     then A.dispense_sup - (A.dispense_date + A.dispense_sup - 1 - A.indexDate) 
                   else .
                   end as daysAtRisk,
                 B.prednisodeEquivalentDose
          from UCB.tempPrevRxAll A inner join
               DT.lookupNDC B on (A.ndc = B.ndc)
          where ^missing(B.prednisodeEquivalentDose) & 
                ((A.indexDate - 183 <= A.dispense_date <= A.indexDate) | 
                  (A.indexDate - 183 <= (A.dispense_date + A.dispense_sup - 1) <= A.indexDate))) C
    group by C.database, C.patid, C.indexID;
quit;




ods html close;
