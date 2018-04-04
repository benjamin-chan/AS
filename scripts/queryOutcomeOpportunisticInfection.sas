*  University of Alabama at Birmingham                               *
*  AS project                                            *

Programmer Lang Chen @UAB
created: 8/24/2016
modiflied :
Project: 
Task: define outcome for Pfizer Tofacitinib 2016 with PECORI common data model data
Output: Dataset outcome

NOTE RUN queryOutcomeHospitalizedInfection.sas FIRST

TODO: 
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=queryOutcomeOpportunisticInfection; * type the name of your program here (without the filename extension);
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
proc datasets nolist; delete 
outcome_OI_dx
outcome_OI_dx_mycobacteria
outcome_OI_dx_only 
outcome_OI_dx1
outcome_OI_mycobacteria
outcome_OI_rx
Outcome_oi_dx_rx_1
Outcome_oi_dx_rx_2
outcome_OI_dx_rx
outcome_OI
;
quit;
 */

/* 
Copy data sets from permanent library
 */
proc copy out = Work in = DT;
  select icd9_infection outcome_infection_dx;
run;


/* 
Override OI designation of some of the infection categories
Source lookup table is "W:\Users\lchen\lookupdata\AHRQ_CCS.xlsx",
which was converted to CSV as "U:\studies\AS\pgms\bchan\data\raw\AHRQ_CCS.csv"
See commit ceaac8
 */
proc sql;
  select "Work.icd9_infection" as table, "BEFORE" as when, upcase(oi) as oi, upcase(infection_category) as infection_category, count(*) as records
    from Work.icd9_infection
    where upcase(infection_category) = "TUBERCULOSIS" |
          upcase(infection_category) = "ACTINOMYCOSIS" |
          upcase(infection_category) = "ZOSTER" |
          icd_9_cm_code = "48284" |
          prxmatch("/^003((1)|(2[1234]))/", icd_9_cm_code)
    group by calculated oi, calculated infection_category;
  update Work.icd9_infection
    set oi = case
               when upcase(infection_category) = "TUBERCULOSIS" then "OI"
               when upcase(infection_category) = "ACTINOMYCOSIS" then "OI"
               when upcase(infection_category) = "ZOSTER" then "OI"
               when icd_9_cm_code = "48284" then "OI"
               when prxmatch("/^003((1)|(2[1234]))/", icd_9_cm_code) then "OI"
               else oi
               end;
  select "Work.icd9_infection" as table, "AFTER" as when, upcase(oi) as oi, upcase(infection_category) as infection_category, count(*) as records
    from Work.icd9_infection
    where upcase(infection_category) = "TUBERCULOSIS" |
          upcase(infection_category) = "ACTINOMYCOSIS" |
          upcase(infection_category) = "ZOSTER" |
          icd_9_cm_code = "48284" |
          prxmatch("/^003((1)|(2[1234]))/", icd_9_cm_code)
    group by calculated oi, calculated infection_category;
  select "Work.outcome_infection_dx" as table, "BEFORE" as when, upcase(oi) as oi, upcase(infection_category) as infection_category, count(*) as records
    from Work.outcome_infection_dx
    where upcase(infection_category) = "TUBERCULOSIS" |
          upcase(infection_category) = "ACTINOMYCOSIS" |
          upcase(infection_category) = "ZOSTER" |
          icd_9_cm_code = "48284" |
          prxmatch("/^003((1)|(2[1234]))/", icd_9_cm_code)
    group by calculated oi, calculated infection_category;
  update Work.outcome_infection_dx
    set oi = case
               when upcase(infection_category) = "TUBERCULOSIS" then "OI"
               when upcase(infection_category) = "ACTINOMYCOSIS" then "OI"
               when upcase(infection_category) = "ZOSTER" then "OI"
               when icd_9_cm_code = "48284" then "OI"
               when prxmatch("/^003((1)|(2[1234]))/", icd_9_cm_code) then "OI"
               else oi
               end;
  select "Work.outcome_infection_dx" as table, "AFTER" as when, upcase(oi) as oi, upcase(infection_category) as infection_category, count(*) as records
    from Work.outcome_infection_dx
    where upcase(infection_category) = "TUBERCULOSIS" |
          upcase(infection_category) = "ACTINOMYCOSIS" |
          upcase(infection_category) = "ZOSTER" |
          icd_9_cm_code = "48284" |
          prxmatch("/^003((1)|(2[1234]))/", icd_9_cm_code)
    group by calculated oi, calculated infection_category;
quit;


proc freq data=icd9_infection; tables Infection_Category Infection_Location OI ;
tables Infection_Category*description/missing list;
where OI^=" " and OI^="N" and OI^="NO";
run;
data outcome_OI_dx(label="DX of Opportunistic infections");
set outcome_infection_dx;
where OI^=" " and OI^="N" and OI^="NO" and lowcase(Infection_Category) not in ("tuberculosis" "zoster");
run;
proc freq data=outcome_OI_dx; tables Infection_Category ENC_TYPE;
run;

proc print data=outcome_OI_dx(obs=10);;
where  Infection_Category=" ";
run;

proc freq data=NDC.Anti_fungal_all_2016; table gnn;run;


data outcome_OI_rx(drop=rc:);
    if _N_=1 then do;
        declare hash HRX(dataset:"NDC.Anti_fungal_all_2016");
        rc = HRX.definekey("Code");
/*        rc = HRX.definedata(ALL:"YES");*/
        rc=HRX.definedone();
    end;
if 0 then set NDC.Anti_fungal_all_2016(keep=Code);
set &inrxdat. ;
by database exposure patid exposureStart exposureEnd exposureID DISPENSE_DATE;
/*length outcome $20 outcome_date 4;*/
/*format outcome_date mmddyy10.;*/
        rc1 =HRX.find(key:NDC);

        if rc1=0 then output outcome_OI_rx;
run;


data outcome_OI_dx_mycobacteria outcome_OI_dx_only outcome_OI_dx1;
set outcome_OI_dx;
if lowcase(Infection_Category) in ("nontuberculosis mycobacteria") then output outcome_OI_dx_mycobacteria;
    else if lowcase(Infection_Category) in ("aspergillosis"
"blastomycosis" "coccidioidomycosis" "cryptococcosis" "endemic mycosis" "histoplasmosis") then output outcome_OI_dx1;
    else output outcome_OI_dx_only;
run;
/*proc freq data=outcome_OI_dx1; tables Infection_Category;run;*/

proc sql;
create table outcome_OI_mycobacteria as
select a.*,
    a.begin_date as outcome_start_date length=4 format=mmddyy10.,
    b.begin_date as outcome_date length=4 format=mmddyy10. 
from outcome_OI_dx_mycobacteria a
join outcome_OI_dx_mycobacteria b
on a.exposureID=b.exposureID and 180>=b.begin_date-a.begin_date>=7
order by database, exposure, patid, exposureStart, exposureEnd, exposureID, outcome_date ;
quit;

proc sort data=outcome_OI_dx1 nodupkey ;by database exposure patid exposureStart exposureEnd exposureID begin_date;run;

proc sql;
create table outcome_OI_dx_rx_1 as
select *
from outcome_OI_dx1 a
join outcome_OI_rx b
on a.exposureID=b.exposureID and abs(a.begin_date-b.DISPENSE_DATE)<=30
order by database, exposure, patid, exposureStart, exposureEnd, exposureID, begin_date, DISPENSE_DATE ;

create table outcome_OI_dx_rx_2(keep=database exposure patid exposureStart exposureEnd exposureID begin_date DISPENSE_DATE outcome: total_sup DISPENSE_SUP NDC Infection_Category dx dx_type date1 date2 ) as
select *, sum(DISPENSE_SUP) as total_sup, 
    min(begin_date,DISPENSE_DATE) as date1 format=mmddyy10., max(begin_date,DISPENSE_DATE) as date2 format=mmddyy10.,
    min(calculated date1) as outcome_start_date length=4 format=mmddyy10.,
    max(calculated date2) as outcome_date length=4 format=mmddyy10. 
from outcome_OI_dx_rx_1
group by database, exposure, patid, exposureStart, exposureEnd, exposureID, begin_date
order by database, exposure, patid, exposureStart, exposureEnd, exposureID, begin_date, DISPENSE_DATE;
quit;

proc sort data=outcome_OI_dx_rx_2 
    out=outcome_OI_dx_rx(keep=database exposure patid exposureStart exposureEnd exposureID outcome_date begin_date outcome_start_date total_sup Infection_Category dx dx_type)
    nodupkey; 
by database exposure patid exposureStart exposureEnd exposureID outcome_date descending outcome_start_date; 
where total_sup>=30;
run;

data outcome_OI_dx_only(keep=database exposure patid exposureStart exposureEnd exposureID outcome_date begin_date outcome_start_date Infection_Category dx dx_type);
set outcome_OI_dx_only;
length outcome_start_date outcome_date 4;
format outcome_start_date outcome_date mmddyy10.;
outcome_date=begin_date;
outcome_start_date=begin_date;
run;

data outcome_OI(keep=database exposure patid exposureStart exposureEnd exposureID outcome_date begin_date outcome_start_date Infection_Category outcome dx dx_type);
set outcome_OI_dx_only 
outcome_OI_dx_rx
outcome_OI_dx_mycobacteria;
length outcome $20;
outcome="OI";
run;


/* 
Check
 */
proc sql;
  select "Summary of Work.outcome_oi" as table,
         A.database,
         A.infection_category,
         count(distinct A.patid) as countDistinctPatid,
         count(*) as countRows,
         count(*) / denom format = percent8.1 as pctWithinDatabase
    from Work.outcome_oi A inner join
         (select database, count(*) as denom from Work.outcome_oi group by database) B  on (A.database = B.database)
    group by A.database, A.infection_category;
quit;


proc datasets nolist; delete 
outcome_OI_dx
outcome_OI_dx_mycobacteria
outcome_OI_dx_only 
outcome_OI_dx1
outcome_OI_mycobacteria
outcome_OI_rx
Outcome_oi_dx_rx_1
Outcome_oi_dx_rx_2
outcome_OI_dx_rx
;
quit;


/* 
Write to permanent SAS library
 */
proc sql;
  create table DT.opportunInfectionEpisodesInc as
    select * from Work.outcome_OI;
quit;


/* 
Data checks
 */
proc contents data = DT.opportunInfectionEpisodesInc order = varnum;
run;
proc sql;
  select "Summary of DT.opportunInfectionEpisodesInc" as table, 
         database, 
         count(*) as denom 
    from DT.opportunInfectionEpisodesInc 
    group by database;
  select "Summary of DT.opportunInfectionEpisodesInc" as table,
         A.database,
         A.infection_category,
         count(distinct A.patid) as countDistinctPatid,
         count(*) as countRows,
         count(*) / denom format = percent8.1 as pctWithinDatabase
    from DT.opportunInfectionEpisodesInc A inner join
         (select database, count(*) as denom from Work.outcome_OI group by database) B  on (A.database = B.database)
    group by A.database, A.infection_category;
quit;




ods html close;
