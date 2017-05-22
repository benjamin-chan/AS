/*
Interstitial lung disease; 
1)  One or more diagnosis codes for ILD from primary discharge
Or
2)  (Two or more diagnosis codes for ILD from secondary discharge or physician EMM ) plus one or more diagnosis tests within 90 days prior to (inclusive) one of the diagnosis code for ILD
*/
%macro IPP_2IPSOPplusPX_ILD(outdata=,ids=,Dxs=, Pxs=);
*DXs=diagnosis code in followup, Pxs=CPT code in follow up;
*do not name outData as IPPILD dxIPSILD dxOPILD dxIPSOPILD pxILD dxpxIPSOPILD IPSOPILD;

data IPPILD dxIPSILD dxOPILD;
set &dxs();
length dx1_date 4;
format dx1_date mmddyy10.;
dx1_date=min(ADMIT_DATE,  BEGIN_DATE);

if dx in :('515','51630','51631','51632','51633','51634','51635','51636','51637',
           '5164','5165','5166','5168','5169','71481');

if enc_type='IP' and pdx='P' 
    then output IPPILD;
if enc_type='IP' and pdx ne 'P' 
    then output dxIPSILD;
if enc_type not in ('IP','IF', 'OT', " ") 
    then output dxOPILD; 
run;

data dxIPSOPILD; *ILD from secondary discharge or physician EMM;
set dxIPSILD dxOPILD;
run;

data pxILD; *diagnosis tests;
set &pxs();
if (px_type='09' and px in ('8741','8742')) or
   (px_type='C1' and px in ('71250','71260','71270','71275','31625','31628',
                             '31629','31632','31633','32095','32096','32097',
                             '32098','32400','32405','32604','32606','32607',
                             '32608','32609'));
run;
proc sort data=pxILD nodupkey; by &IDS px_date;run; * drop duplicate PX date and keep only one;

proc sql;
/*one or more diagnosis tests within 90 days prior to (inclusive) one of the diagnosis code for ILD*/
create table dxpxIPSOPILD as
select a.* , b.px_date
from dxIPSOPILD as a
    ,
     pxILD as b
where a.&IDS=b.&IDS and
      min(b.ADMIT_DATE, b.BEGIN_DATE)-90<=b.px_date<=min(b.ADMIT_DATE, b.BEGIN_DATE);

/* sencond DX code */
create table IPSOPILD as
select a.*, min(b.ADMIT_DATE, b.BEGIN_DATE) as DX2_date length=4 format mmddyy10.
from dxpxIPSOPILD as a
    ,
     dxIPSOPILD(drop=dx1_date) as b
where a.patid=b.patid and
      (a.ADMIT_DATE ne b.ADMIT_DATE and a.BEGIN_DATE ne b.BEGIN_DATE)
order by &IDS,ADMIT_DATE, BEGIN_DATE;
quit;


data &outData;
set IPPILD IPSOPILD;
length outcome $20 outcome_date outcome_start_date 4;
format outcome_date outcome_start_date mmddyy10.;
outcome="ILD";
outcome_date=max(dx1_date, dx2_date, px_date);
outcome_start_date=min(dx1_date, dx2_date, px_date);
drop ADMIT_DATE BEGIN_DATE DISCHARGE_DATE END_DATE;
run;

proc sort data=&outData;
by &IDS outcome_date descending outcome_start_date descending Enc_type;
run;

data &outData;
set &outData;
by &IDS outcome_date descending outcome_start_date;
if first.outcome_date;
run;

proc datasets nolist;
delete IPPILD dxIPSILD dxOPILD dxIPSOPILD pxILD dxpxIPSOPILD IPSOPILD;
quit;run;
%mend IPP_2IPSOPplusPX_ILD;
