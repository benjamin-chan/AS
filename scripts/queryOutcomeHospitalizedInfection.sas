*  University of Alabama at Birmingham                               *
*  AS project                                            *

Programmer Lang Chen @UAB
created: 8/24/2016
modiflied :
Project: 
Task: define outcome for Pfizer Tofacitinib 2016 with PECORI common data model data
Output: Dataset outcome

NOTE RUN queryOutcomeOpportunisticInfection.sas AFTER

TODO: 
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=queryOutcomeHospitalizedInfection; * type the name of your program here (without the filename extension);
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


*To edit the following two lines only;

%let indxdat = UCB.tempIncDxAll;
%let inpxdat = UCB.tempIncPxAll;
%let inrxdat = UCB.tempIncRxAll;
proc sort data = &indxdat; by database exposure patid exposureStart exposureEnd exposureID begin_date;
run;
proc sort data = &inpxdat; by database exposure patid exposureStart exposureEnd exposureID px_date;
run;
proc sort data = &inrxdat; by database exposure patid exposureStart exposureEnd exposureID dispense_date;
run;

/* 
Keep only the HCPCS codes
Re-length the px variable
 */
data Work.tempIncPxAll;
  length px $5;
  set &inpxdat.;
  if px_type = "H1" then output;
run;
proc sql;
  select "Check length of px variable in Work.tempIncPxAll" as table,  px_type, length(px) as lengthPx, count(*) as n
  from Work.tempIncPxAll
  group by px_type, calculated lengthPx;
quit;
%let inpxdat = Work.tempIncPxAll;

/* 
proc datasets nolist; delete 
icd9_infection
icd9_inf
outcome_infection_dx
outcome_rx_TB
NDC_PYRAZINAMIDE
outcome_infection_px
outcome_infection_rx
outcome_infection_trt
outcome_infection
;
quit;
 */
proc import datafile='U:\studies\AS\pgms\bchan\data\raw\AHRQ_CCS.csv' 
    out=icd9_infection dbms = csv replace;
    guessingrows = 1000;
run;
data icd9_infection;
set icd9_infection;
Infection=upcase(Infection);
run;
proc print data=icd9_infection (obs=10);run;

proc print data=icd9_infection ;
  where ICD_9_CM_CODE=:"003";
run;

proc freq data=icd9_infection; tables Infection_Category Infection_Location;
run;
proc freq data=icd9_infection; tables Infection_Category Infection_Location;
where not missing(oi) and Infection^=" " and  Infection_Category not in ("zoster" "tuberculosis");
run;
proc print data=icd9_infection;
var ICD_9_CM_CODE CCS_CATEGORY_DESCRIPTION ICD_9_CM_CODE_DESCRIPTION 
description Infection UABgroup Infection_Category Infection_Location Infectious_Organism OI Viral Fungal bacterial_infection other_types_of_infection;

where Infection_Category in ("zoster" "herpes");
run;

proc print data=icd9_infection;
var ICD_9_CM_CODE CCS_CATEGORY_DESCRIPTION ICD_9_CM_CODE_DESCRIPTION 
description Infection UABgroup Infection_Category Infection_Location Infectious_Organism OI Viral Fungal bacterial_infection other_types_of_infection;

where not missing(oi) and Infection^=" " and  Infection_Category not in ("zoster" "tuberculosis");
run;


data icd9_inf;
length ICD_9_CM_CODE $18;
set icd9_infection;
keep
ICD_9_CM_CODE ICD_9_CM_CODE_DESCRIPTION Infection Infection_Category Infection_Location Infectious_Organism OI Viral Fungal bacterial_infection other_types_of_infection;
where Infection^=" ";
run; 

proc print data=icd9_infection (obs=10);run;
proc freq data=icd9_inf ; tables Infection_Category Infection;run;


/*Infection_Category="tuberculosis";*/

data outcome_infection_dx(drop=rc);
    if _N_=1 then do;
        declare hash HDX(dataset:"icd9_inf");
        rc = HDX.definekey("ICD_9_CM_CODE");
        rc = HDX.definedata(ALL:"YES");
        rc=HDX.definedone();
    end;
if 0 then set icd9_inf;
set &indxdat. ;
by database exposure patid exposureStart exposureEnd exposureID BEGIN_DATE;
/*length outcome $20 outcome_date 4;*/
/*format outcome_date mmddyy10.;*/
        rc =HDX.find(key:DX);
        if rc=0 then output outcome_infection_dx;
where ENC_TYPE in ('IP' 'ER' 'AV' 'NH' 'HH' 'ED');
run;
proc sort data=outcome_infection_dx nodupkey; by database exposure patid exposureStart exposureEnd exposureID BEGIN_DATE DX ENC_TYPE;run;

proc freq data=outcome_infection_dx; tables Infection_Category Infection;run;

data NDC_PYRAZINAMIDE;
set NDC.TB_ALL_2016;
/*NDC=code;*/
where gnn="PYRAZINAMIDE";
run;

data outcome_infection_rx(drop=rc:)  outcome_rx_TB(drop=rc:);
    if _N_=1 then do;
        declare hash HRX(dataset:"NDC.Antibiotics_parenteral_ndc");
        rc = HRX.definekey("NDC");
/*        rc = HRX.definedata(ALL:"YES");*/
        rc=HRX.definedone();

        declare hash HTB(dataset:"NDC_PYRAZINAMIDE");
        rc = HTB.definekey("code");
/*        rc = HTB.definedata(all:"YES");*/
        rc=HTB.definedone();

    end;
if 0 then set NDC.Antibiotics_parenteral_ndc(keep=NDC) NDC_PYRAZINAMIDE(keep=code);
set &inrxdat. ;
by database exposure patid exposureStart exposureEnd exposureID DISPENSE_DATE;
/*length outcome $20 outcome_date 4;*/
/*format outcome_date mmddyy10.;*/
        rc1 =HRX.find(key:NDC);
        rc2 =HTB.find(key:NDC);

        if rc1=0 then output outcome_infection_rx;
        if rc2=0 then output outcome_rx_TB;
run;


data outcome_infection_px(drop=rc:);
    if _N_=1 then do;
        declare hash HPX(dataset:"NDC.Antibiotics_parenteral_hcpcs");
        rc = HPX.definekey("HCPCS_CD");
        rc = HPX.definedata(ALL:"YES");
        rc=HPX.definedone();
    end;
if 0 then set NDC.Antibiotics_parenteral_hcpcs;
set &inpxdat. ;
by database exposure patid exposureStart exposureEnd exposureID PX_DATE;
/*length outcome $20 outcome_date 4;*/
/*format outcome_date mmddyy10.;*/
        rc1 =HPX.find(key:PX);

        if rc1=0 then output outcome_infection_Px;
run;


data outcome_infection_trt(label="parenteral antibiotics(PX+RX) for Infection");
set outcome_infection_px outcome_infection_rx;
length trt_date 4;
format trt_date mmddyy10.;
trt_date=coalesce(PX_DATE , DISPENSE_DATE);
run;



data outcome_infection(keep=database exposure patid exposureStart exposureEnd exposureID outcome_date dx TRT_DATE BEGIN_DATE ADMIT_DATE ENC_TYPE Infection_Category Infection outcome_start_date PDX) ;
if _N_=1 then do;
        declare hash HTRT(dataset:"outcome_infection_trt");
        rc = HTRT.definekey("database", "exposure", "PATID", "exposureStart", "exposureEnd", "exposureID", "TRT_DATE");
/*        rc = HTRT.definedata(ALL:"YES");*/
        rc=HTRT.definedone();
    end;
if 0 then set outcome_infection_trt(keep=database exposure patid exposureStart exposureEnd exposureID TRT_DATE);
set outcome_infection_dx;
length outcome_date outcome_start_date 4;
format outcome_date outcome_start_date mmddyy10.;
        rc=HTRT.find(key:database, key:exposure, key:patid, key:exposureStart, key:exposureEnd, key:exposureID, key:BEGIN_DATE);
        outcome_date=BEGIN_DATE;
        outcome_start_date=outcome_date;
        if rc=0  then do;
            output; 
        end; else do;
        TRT_DATE=.;
        if ENC_TYPE in ( 'IP') then output;
        end;
run;

proc sort data=outcome_infection nodupkey; by database exposure patid exposureStart exposureEnd exposureID outcome_date dx pdx;run;
data outcome_infection ; set outcome_infection; by database exposure patid exposureStart exposureEnd exposureID outcome_date dx;  /* format dx $Icd9fmt.; */  run;

proc sort data=outcome_infection nodupkey; by database exposure patid exposureStart exposureEnd exposureID outcome_date ;run;

proc datasets nolist; delete 
/* icd9_infection */
icd9_inf
/* outcome_infection_dx */
outcome_rx_TB
NDC_PYRAZINAMIDE
outcome_infection_px
outcome_infection_rx
outcome_infection_trt
;
quit;


/* 
Write to permanent SAS library
 */
proc sql;
  create table DT.hospitalizedInfectionEpisodesInc as
    select * from Work.outcome_infection;
quit;


/* 
Data checks
 */
proc contents data = DT.hospitalizedInfectionEpisodesInc order = varnum;
run;
proc sql;
  select "Summary of DT.hospitalizedInfectionEpisodesInc" as table, 
         database, 
         count(*) as denom 
    from DT.hospitalizedInfectionEpisodesInc 
    group by database;
  select "Summary of DT.hospitalizedInfectionEpisodesInc" as table,
         A.database,
         A.infection_category,
         count(distinct A.patid) as countDistinctPatid,
         count(*) as countRows,
         count(*) / denom format = percent8.1 as pctWithinDatabase
    from DT.hospitalizedInfectionEpisodesInc A inner join
         (select database, count(*) as denom from Work.outcome_infection group by database) B  on (A.database = B.database)
    group by A.database, A.infection_category;
quit;


/* 
Copy data sets to permanent library for use later
 */
proc copy out = DT in = Work;
  select icd9_infection outcome_infection_dx;
run;




ods html close;
