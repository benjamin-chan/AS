****************************************************************************************

Programmer Lang Chen @UAB
created: 8/24/2016
modiflied :
Project: 
Task: define outcome for Pfizer Tofacitinib 2016 with PECORI common data model data
Output: Dataset outcome

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
outcome_rx_TB
NDC_PYRAZINAMIDE
_outcome_OP_TB
outcome_OP_TB
outcome_TB
outcome_HerpesSimplex

outcome_STROKE
outcome_TIA
outcome_MI
outcome_ZOSTER
outcome_DX_TB
;
quit;

*
Interstitial Lung Disease
MI
STROKE (both ischemic and hemo)
TIA
PML
ZOSTER
TB

;

data outcome_STROKE
outcome_TIA
outcome_MI
outcome_ZOSTER
outcome_HerpesSimplex
outcome_DX_TB
;
set &indxdat. ;
length outcome $20 outcome_date  outcome_start_date 4;
format outcome_date outcome_start_date mmddyy10.;
if ENC_TYPE in ('IP') then do;
/*    if compress(DX,".","s") in :('515', '5163', '5168', '51889') then outcome="ILD";*/
    if compress(DX,".","s") in :('41001', '41011', '41021', '41031', '41041', '41051', '41061', '41071', '41081', '41091') and DISCHARGE_DATE>ADMIT_DATE then outcome="MI";

    if compress(DX,".","s") in :('434') and LENGTH(DX)>=5 AND substr(compress(DX,".","s"),5,1)="1"  then  outcome="STROKE";
    if compress(DX,".","s") in :('433') and LENGTH(DX)>=5 AND substr(compress(DX,".","s"),5,1)="1" then  outcome="STROKE";
    if compress(DX,".","s") in :('436') and LENGTH(DX)>=5 AND substr(compress(DX,".","s"),5,1)="1" then  outcome="STROKE";
    if compress(DX,".","s") in :('435')  then  outcome="TIA";
    if compress(DX,".","s") in :('430', '431')  then  outcome="STROKE";
    if compress(DX,".","s") in :('0463')  then  outcome="PML";
end; 
    if compress(DX,".","s") in :('053')  then  outcome="ZOSTER";
    if compress(DX,".","s") in :('010', '011', '012', '013', '014', '015', '016', '017', '018', '6473')  then  outcome="TB";


 if        substr(compress(&DxCode. ,'.'),1,3)         =   "054"                                               then outcome="HerpesSimplex";
  if        substr(compress(&DxCode. ,'.'),1,5)         in :(
                                                             "0540"
                                                             "0541"
                                                             "05410"
                                                             "05411"
                                                             "05412"
                                                             "05413"
                                                             "05419"
                                                             "0542"
                                                             "0544"
                                                             "05440"
                                                             "05441"
                                                             "05442"
                                                             "05443"
                                                             "05444"
                                                             "05449"
                                                             "0546"
                                                             "0549"
                                                             )                                                  then HerpesSimplexUncomp=1; 
  if        substr(compress(&DxCode. ,'.'),1,5)         in :(
                                                             "0547"
                                                             "05471"
                                                             "05472"
                                                             "05473"
                                                             "05474"
                                                             "05479"
                                                             "0548"
                                                             "0543"
                                                             "0545"
                                                             )                                                  then HerpesSimplexComp=1;

outcome_date=min(ADMIT_DATE, BEGIN_DATE);
outcome_start_date=outcome_date;
if outcome="TIA" then output outcome_TIA; 
    else if outcome="STROKE" then output outcome_STROKE; 
    else if outcome="MI" then output outcome_MI; 
    else if outcome="ZOSTER" then output outcome_ZOSTER; 
    else if outcome="TB" then output outcome_DX_TB; 
    else if outcome="HerpesSimplex" then output outcome_HerpesSimplex; 
where ENC_TYPE in ('IP' 'ER' 'AV' 'NH' 'HH' 'ED');
run;
proc sort data=outcome_dx_TB nodupkey; by PATID outcome_date outcome;run;
proc sort data=outcome_zoster nodupkey; by PATID outcome_date outcome;run;
proc sort data=outcome_MI nodupkey; by PATID outcome_date outcome;run;
proc sort data=outcome_stroke nodupkey; by PATID outcome_date outcome;run;
proc sort data=outcome_TIA nodupkey; by PATID outcome_date outcome;run;
proc sort data=outcome_dx_TB nodupkey; by PATID outcome_date dx ENC_TYPE outcome;run;



data _outcome_OP_TB(drop=outcome outcome_date);
set outcome_dx_TB;
by PATID BEGIN_DATE;
if first.BEGIN_DATE;
where outcome="TB" and ENC_TYPE in ( 'ER' 'AV' 'NH' 'HH' 'ED');
run;
/*
TB definition 2
    2. Any ICD-9 code (010-018, 6473) outpatient physician visit claim 
    AND pharmacy records indicating prescription for Pyrazinamide(PZA) prescribed  on same day within +/- 90 days 
    of first code date

*/

data NDC_PYRAZINAMIDE;
set NDC.TB_ALL_2016;
/*NDC=code;*/
where gnn="PYRAZINAMIDE";
run;

data  outcome_rx_TB(drop=rc:);
    if _N_=1 then do;
        declare hash HTB(dataset:"NDC_PYRAZINAMIDE");
        rc = HTB.definekey("code");
/*        rc = HTB.definedata(all:"YES");*/
        rc=HTB.definedone();

    end;
if 0 then set NDC.Antibiotics_parenteral_ndc(keep=NDC) NDC_PYRAZINAMIDE(keep=code);
set &inrxdat. ;
by PATID DISPENSE_DATE;
/*length outcome $20 outcome_date 4;*/
/*format outcome_date mmddyy10.;*/
        rc2 =HTB.find(key:NDC);

        if rc2=0 then output outcome_rx_TB;
run;
proc sort data=outcome_rx_TB nodupkey; by PATID DISPENSE_DATE;run;

data outcome_OP_TB(keep=PATID BEGIN_DATE outcome outcome_date DISPENSE_DATE DX ADMIT_DATE ENC_TYPE outcome_start_date);;
    if _N_=1 then do;
        declare hash HTB(dataset:"outcome_rx_TB" , multidata:"Y");
        rc = HTB.definekey("PATID");
        rc = HTB.definedata("PATID","DISPENSE_DATE");
        rc=HTB.definedone();
    end;
if 0 then set outcome_rx_TB(keep=PATID DISPENSE_DATE);
set _outcome_OP_TB ;
by PATID BEGIN_DATE;
length outcome $20 outcome_date outcome_start_date 4;
format outcome_date outcome_start_date mmddyy10.;
        rc =HTB.find(key:PATID);
         do while (rc = 0);
            if abs(begin_date-DISPENSE_DATE)<=90 then do;
                outcome="TB"; 
                outcome_date=max(DISPENSE_DATE,begin_date);
                outcome_start_date=min(DISPENSE_DATE,begin_date);
                output;
            end;
            else do;
                outcome="NULL";
                outcome_date=.;
            end;
            rc = HTB.find_next();
         end; 
run;
/* TB definition1
    1 Any ICD-9 code (010-018, 6473) on an inpatient
  combind def 1 and 2 to outcome_TB;
*/
proc sort data=outcome_OP_TB; by PATID outcome_date descending outcome_start_date; run;
data outcome_TB(keep=PATID BEGIN_DATE outcome outcome_date DISPENSE_DATE DX ADMIT_DATE ENC_TYPE outcome_start_date);
set outcome_OP_TB outcome_dx_TB(where=(outcome="TB" and ENC_TYPE in ( 'IP')));
by PATID outcome_date;
run;


proc datasets nolist; delete 
outcome_rx_TB
Outcome_dx_tb
NDC_PYRAZINAMIDE
_outcome_OP_TB
outcome_OP_TB
outcome_DX_TB
;
quit;

