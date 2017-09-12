****************************************************************************************

Programmer Lang Chen @UAB
created: 8/24/2016
modiflied :
Project: 
Task: define NMSC with PECORI common data model data
Output: Dataset cancer_NMSC
NMSC definition:
    1) Surgical PX code and same day NMSC DX(any type 173*)code. or
    2) Surgical PX code and NMSC DX(from EM code) code within 90 days (abs(px_date-dx_date)<=90).

TODO: 
****************************************************************************************;

*To edit the following two lines only;
%let indxdat = UCB.tempIncDxAll;
%let inpxdat = UCB.tempIncPxAll;
%let inrxdat = UCB.tempIncRxAll;
proc sort data=&indxdat; by exposureID begin_date;run;
proc sort data=&inpxdat; by exposureID px_date;run;
proc sort data=&inrxdat; by exposureID dispense_date;run;


proc datasets nolist; delete 
_dat_NMSC_DX
_dat_NMSC_PX
_cancer_NMSC
_cancer_NMSC12
_cancer_NMSC3
_dat_NMSC_path
_dat_NMSC_path_dx
_dat_NMSC_path_dxNMSC
_dat_NMSC_path:
Outcome_cancer_nmsc;
quit;
/*
*import the list of CPT/HCPCS/ICD9 code related to NMSC;
PROC IMPORT OUT= NMSC_code DATAFILE= "W:\Users\lchen\lookupdata\cancer\NMSC.xlsx" 
            DBMS=xlsx REPLACE;
     SHEET="NMSC"; 
     GETNAMES=YES;
RUN;
libname lookup "W:\Users\lchen\lookupdata";
data lookup.NMSC_code ;
set NMSC_code;
code=compress(upcase(code),".", "s" ); * also remove space along with ".";
if Biopsy=. then Biopsy=0;
where code^=" ";
run;
*/
data _dat_NMSC_DX;
set &indxdat;
length NMSC_Basal NMSC_Squamous $1;
if compress(DX,".", "s" ) in (
'17301'
'17311'
'17321'
'17331'
'17341'
'17351'
'17361'
'17371'
'17381'
'17391'
) then NMSC_Basal="Y";
if compress(DX,".", "s" ) in (
'17302'
'17312'
'17322'
'17332'
'17342'
'17352'
'17362'
'17372'
'17382'
'17392'
) then NMSC_Squamous="Y";

where substr(compress(DX,".", "s" ),1,3)="173";
run;

proc sort data=_dat_NMSC_DX nodupkey; by PATID begin_date dx ENC_TYPE;run;
data _dat_NMSC_dX ;
set _dat_NMSC_dX ;
by PATID begin_date dx ENC_TYPE;
if first.dx;
run;

data _dat_NMSC_PX(drop=rc) _dat_NMSC_path(drop=rc code biopsy rename=(PX=PX_PATH PX_date=PATH_DATE));
if _n_=1 then do;
  declare hash hpx(dataset:"lookup.NMSC_code(where=(table='PX'))");
  rc=hpx.defineKey("code");
  rc=hpx.defineData("code", "Biopsy");
  rc=hpx.defineDone();
end;
if 0 then set lookup.NMSC_code(keep=code Biopsy);
SET &inpxdat;;
rc=hpx.find(key:PX);
if rc=0 then output _dat_NMSC_PX;
if px in ("88305" "88304") then output _dat_NMSC_path;
run;
proc sort data=_dat_NMSC_PX(keep=PATID px_date px px_type biopsy) nodupkey; by PATID px_date PX;run;
proc sort data= _dat_NMSC_path nodupkey; by patid path_date px_path;run;
proc freq data=_dat_NMSC_path; tables px_path;run;
data _dat_NMSC_path_dx(drop=rc);
/* dx on the day of pathologist PX code */
if _n_=1 then do;
  declare hash hpx(dataset:"_dat_NMSC_path");
  rc=hpx.defineKey("patid", "PATH_date");
  rc=hpx.defineData("patid", "PATH_date", "PX_PATH");
  rc=hpx.defineDone();
end;
if 0 then set _dat_NMSC_path(keep=patid PATH_date PX_PATH);
SET &indxdat;;
rc=hpx.find(key:Patid,key:begin_date);
length NMSC_Basal NMSC_Squamous $1;
if compress(DX,".", "s" ) in (
'17301'
'17311'
'17321'
'17331'
'17341'
'17351'
'17361'
'17371'
'17381'
'17391'
) then NMSC_Basal="Y";
if compress(DX,".", "s" ) in (
'17302'
'17312'
'17322'
'17332'
'17342'
'17352'
'17362'
'17372'
'17382'
'17392'
) then NMSC_Squamous="Y";
if rc=0 then output _dat_NMSC_path_dx;
run;
proc sort data=_dat_NMSC_path_dx ; by patid PATH_date dx pdx;run;
proc sort data=_dat_NMSC_path_dx nodupkey; by patid PATH_date dx;run;

proc freq data=_dat_NMSC_path_dx order=freq;format dx $icd9dx.; table dx;run;

proc sort data=_dat_NMSC_path_dx out=_dat_NMSC_path_dxNMSC nodupkey; by patid PATH_date dx; where dx in :("173");run;
proc sql outobs=50;
title "pat can have both DX Squamous and Basal on the same day";
select *, count(*) as n from _dat_NMSC_path_dxNMSC(drop=PROV_ID PROV_ID_TYPE FACILITY_ID ADMIT_DATE DISCHARGE_DATE DISCHARGE_STATUS)
group by patid, path_date
having n>1;
title;
quit;

proc freq data=_dat_NMSC_path_dxNMSC; tables NMSC_Basal *NMSC_Squamous/missing;run;
proc freq data=_dat_NMSC_DX; tables NMSC_Basal*NMSC_Squamous dx/missing;run;
proc freq data=_dat_NMSC_PX; tables PX_TYPE;run;

data _cancer_NMSC12(keep=PATID NMSC_def1 NMSC_def2 begin_date DX PX px_type dx_type px_date outcome_date outcome_start_date NMSC_Basal NMSC_Squamous ENC_TYPE);
if _n_=1 then do;
  declare hash hpx(dataset:"_dat_NMSC_PX(where=(biopsy^=1))", multidata:"Y");
  rc=hpx.defineKey("PATID");
  rc=hpx.defineData("px_date", "PX", "px_type");
  rc=hpx.defineDone();
end;
if 0 then set _dat_NMSC_PX(keep=PATID px_date PX px_type);
set _dat_NMSC_DX;
by PATID begin_date;
length NMSC_def1 NMSC_def2 $1 outcome_date outcome_start_date 4;
format outcome_date outcome_start_date mmddyy10.;
        rc =hpx.find(key:PATID);
         do while (rc = 0);
            if begin_date=px_date then NMSC_def1="Y"; 
                else NMSC_def1="N"; 
            if abs(begin_date-px_date)<=90 and ENC_TYPE in ("IP","AV","ER","ED","HH","NH") then NMSC_def2="Y"; 
                else NMSC_def2="N"; 
            outcome_date=max(px_date,begin_date);
            outcome_start_date=min(px_date,begin_date);
            if NMSC_def1="Y" or NMSC_def2="Y" then output;
            rc = hpx.find_next();
         end;
run;
proc sql;
create table _cancer_NMSC3 as
select * from _dat_NMSC_PX(where=(biopsy=1)) a
join _dat_NMSC_path_dxNMSC(keep=PATID Path_date PX_path DX NMSC_Basal 
    NMSC_Squamous ENC_TYPE dx_type begin_date)  b
on a.patid=b.patid and a.px_date<=b.path_date<=a.px_date+14;
quit;
data _cancer_NMSC3(keep=PATID NMSC_def3 begin_date DX PX px_type dx_type px_date outcome_date outcome_start_date 
NMSC_Basal NMSC_Squamous ENC_TYPE path_date px_path);
set _cancer_NMSC3;
length NMSC_def3 $1 outcome_date outcome_start_date 4;
format outcome_date outcome_start_date mmddyy10.;
outcome_date=max(px_date , path_date , begin_date);
outcome_start_date=min(px_date , path_date , begin_date);
NMSC_def3="Y"; 
outcome="NMSC";
run;
proc freq data=_cancer_NMSC3; tables NMSC_def3 NMSC_Basal*NMSC_Squamous/missing;run;
data _cancer_NMSC;
set _cancer_NMSC12 _cancer_NMSC3;
run;


proc sort data=_cancer_NMSC nodupkey;
by PATID outcome_date descending outcome_start_date NMSC_def1 NMSC_def2 NMSC_def3 NMSC_Basal NMSC_Squamous;run;

data Outcome_cancer_nmsc(keep=PATID NMSC_def1 NMSC_def2 NMSC_def3 begin_date PX px_date outcome_date 
outcome_start_date NMSC_Basal NMSC_Squamous DX ENC_TYPE Path_date PX_path dx_type px_type);
set _cancer_NMSC;
length cancer $10;
by PATID outcome_date descending outcome_start_date;
/*if first.outcome_date;*/
cancer="NMSC";
run; 

proc sql outobs=50;
select *, count(*) as n from _cancer_NMSC
group by PATID, outcome_date
having n>1;
quit;

proc datasets nolist; delete 
_dat_NMSC_DX
_dat_NMSC_PX
_cancer_NMSC
_cancer_NMSC12
_cancer_NMSC3
_dat_NMSC_path
_dat_NMSC_path_dx
_dat_NMSC_path_dxNMSC
;
quit;
