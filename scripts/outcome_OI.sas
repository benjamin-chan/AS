****************************************************************************************

Programmer Lang Chen @UAB
created: 8/30/2016
modiflied :
Project: 
Task: define outcome Opportunistic infections for Pfizer Tofacitinib 2016 with PECORI common data model data
Output: Dataset outcome
Note run outcome_infection.sas first
TODO: 
****************************************************************************************;

*To edit the following two lines only;
%let indxdat=psa.Subsetdx;
%let inpxdat=psa.Subsetpx;
%let inrxdat=psa.Subsetrx;
proc sort data=&indxdat; by patid begin_date;run;
proc sort data=&inpxdat; by patid px_date;run;
proc sort data=&inrxdat; by patid dispense_date;run;

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
by PATID DISPENSE_DATE;
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
on a.patid=b.patid and 180>=b.begin_date-a.begin_date>=7
order by patid, outcome_date ;
quit;

proc sort data=outcome_OI_dx1 nodupkey ;by patid  begin_date;run;

proc sql;
create table outcome_OI_dx_rx_1 as
select *
from outcome_OI_dx1 a
join outcome_OI_rx b
on a.patid=b.patid and abs(a.begin_date-b.DISPENSE_DATE)<=30
order by patid, begin_date, DISPENSE_DATE ;

create table outcome_OI_dx_rx_2(keep=patid  begin_date DISPENSE_DATE outcome: total_sup DISPENSE_SUP NDC Infection_Category dx dx_type date1 date2 ) as
select *, sum(DISPENSE_SUP) as total_sup, 
    min(begin_date,DISPENSE_DATE) as date1 format=mmddyy10., max(begin_date,DISPENSE_DATE) as date2 format=mmddyy10.,
    min(calculated date1) as outcome_start_date length=4 format=mmddyy10.,
    max(calculated date2) as outcome_date length=4 format=mmddyy10. 
from outcome_OI_dx_rx_1
group by patid, begin_date
order by patid, begin_date, DISPENSE_DATE;
quit;

proc sort data=outcome_OI_dx_rx_2 
    out=outcome_OI_dx_rx(keep=patid outcome_date begin_date outcome_start_date total_sup Infection_Category dx dx_type)
    nodupkey; 
by patid outcome_date descending outcome_start_date; 
where total_sup>=30;
run;

data outcome_OI_dx_only(keep=patid outcome_date begin_date outcome_start_date Infection_Category dx dx_type);
set outcome_OI_dx_only;
length outcome_start_date outcome_date 4;
format outcome_start_date outcome_date mmddyy10.;
outcome_date=begin_date;
outcome_start_date=begin_date;
run;

data outcome_OI(keep=patid outcome_date begin_date outcome_start_date Infection_Category outcome dx dx_type);
set outcome_OI_dx_only 
outcome_OI_dx_rx
outcome_OI_dx_mycobacteria;
length outcome $20;
outcome="OI";
run;


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








