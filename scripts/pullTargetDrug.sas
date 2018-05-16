*  University of Alabama at Birmingham                               *
*  AS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=pullTargetDrug; * type the name of your program here (without the filename extension);
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


/* 
Fenglong's code to build target drug data sets
 */

data NDC4targetDrug;
set NDC.Ndc_dmard_bio_all(where=(CodeType='NDC'))
    NDC.Ndc_nsaidcox(where=(CodeType='NDC'))
    NDC.Ndc_nsaidnoncox(where=(CodeType='NDC'));
run;

data J4targetDrug;
set NDC.Ndc_dmard_bio_all(where=(CodeType='HCPCS'))
    NDC.Ndc_nsaidcox(where=(CodeType='HCPCS'))
    NDC.Ndc_nsaidnoncox(where=(CodeType='HCPCS'));
run;

%macro pullTargetDrug(stdLib=,                   
                      enrData=,
                      pxdata=,
                      rxData=,
                      YearStart=,
                      nYear=);
proc datasets nolist;delete RXTdrug&stdLib HCPCSTdrug&stdLib;quit;run;
%do i=1 %to &nYear;
%let YR=%eval(&YearStart+&i-1);
proc sql;
create table work.RXTdrug&stdLib.&YR as
select a.patid,a.NDC,a.DISPENSE_DATE,b.GNN
from &stdLib..&rxData._&YR as a
      ,
     NDC4targetDrug as b
where a.NDC=b.code;

create table work.HCPCSTdrug&stdLib.&YR as
select a.patid,a.px,a.BEGIN_DATE,b.GNN
from &stdLib..&pxdata._&YR as a
      ,
      J4targetDrug as b
where a.px=b.code;

proc datasets nolist;
append data=work.RXTdrug&stdLib.&YR out=RXTdrug&stdLib;
quit;run;

proc datasets nolist;
append data=work.HCPCSTdrug&stdLib.&YR out=HCPCSTdrug&stdLib;
quit;run;

proc datasets nolist library=work;
delete RXTdrug&stdLib.&YR HCPCSTdrug&stdLib.&YR;
quit;run;
%end;
%mend;

%pullTargetDrug(stdLib=UCBSTD,
                pxdata=px,
                rxData=rx,
                YearStart=2010,
                nYear=5);

%pullTargetDrug(stdLib=MPSTD,                   
                pxdata=px_07,
                rxData=rx_07,
                YearStart=10,
                nYear=1);

%pullTargetDrug(stdLib=std_sabr,                   
                pxdata=std_px,
                rxData=std_rx,
                YearStart=2006,
                nYear=9);


proc freq data=RxtdrugUCBSTD;
table GNN;
run;

proc freq data=HCPCStdrugUCBSTD;
table GNN;
run;

proc sql;
create table BioUCBSTD as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from RxtdrugUCBSTD
where NDC in (select Code 
              from NDC.Ndc_dmard_bio_all 
              where CodeType='NDC' and Category in ('Biologic','sDMARD'))
union
select patid,BEGIN_DATE as DISPENSE_DATE,upcase(GNN) as GNN
from HCPCSTdrugUCBSTD
where PX in (select Code 
              from NDC.Ndc_dmard_bio_all 
              where CodeType='HCPCS' and Category in ('Biologic','sDMARD'))
;

create table BioMPSTD as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from RxtdrugMPSTD
where NDC in (select Code 
              from NDC.Ndc_dmard_bio_all 
              where CodeType='NDC' and Category in ('Biologic','sDMARD'))
union
select patid,BEGIN_DATE as DISPENSE_DATE,upcase(GNN) as GNN
from HCPCSTdrugMPSTD
where PX in (select Code 
              from NDC.Ndc_dmard_bio_all 
              where CodeType='HCPCS' and Category in ('Biologic','sDMARD'));

create table Biostd_sabr as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from Rxtdrugstd_sabr
where NDC in (select Code 
              from NDC.Ndc_dmard_bio_all 
              where CodeType='NDC' and Category in ('Biologic','sDMARD'))
union
select patid,BEGIN_DATE as DISPENSE_DATE,upcase(GNN) as GNN
from Hcpcstdrugstd_sabr
where PX in (select Code 
              from NDC.Ndc_dmard_bio_all 
              where CodeType='HCPCS' and Category in ('Biologic','sDMARD'))
union
select substr(pid,1,20) as patid length=20,rxdate as DISPENSE_DATE,upcase(GNN) as GNN
from std_sabr.Nonspecific_jcode_biologic
;

create table DmardUCBSTD as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from RxtdrugUCBSTD
where NDC in (select Code 
              from NDC.Ndc_dmard_bio_all 
              where CodeType='NDC' and Category in ('cDMARD'))
union
select patid,BEGIN_DATE as DISPENSE_DATE,upcase(GNN) as GNN
from HcpcsTdrugUCBSTD
where PX in (select Code 
              from NDC.Ndc_dmard_bio_all 
              where CodeType='HCPCS' and Category in ('cDMARD'));

create table DmardMPSTD as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from RxtdrugMPSTD
where NDC in (select Code 
              from NDC.Ndc_dmard_bio_all 
              where CodeType='NDC' and Category in ('cDMARD'))
union
select patid,BEGIN_DATE as DISPENSE_DATE,upcase(GNN) as GNN
from HcpcsTdrugMPSTD
where PX in (select Code 
              from NDC.Ndc_dmard_bio_all 
              where CodeType='HCPCS' and Category in ('cDMARD'));

create table Dmardstd_sabr as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from Rxtdrugstd_sabr
where NDC in (select Code 
              from NDC.Ndc_dmard_bio_all 
              where CodeType='NDC' and Category in ('cDMARD'))
union
select patid,BEGIN_DATE as DISPENSE_DATE,upcase(GNN) as GNN
from HcpcsTdrugstd_sabr
where PX in (select Code 
              from NDC.Ndc_dmard_bio_all 
              where CodeType='HCPCS' and Category in ('cDMARD'));

create table NsaidUCBSTD as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from RxtdrugUCBSTD
where NDC in (select Code from NDC.Ndc_nsaidcox where CodeType='NDC' union
                    select Code from NDC.Ndc_nsaidnoncox where CodeType='NDC')
;

create table NsaidMPSTD as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from RxtdrugMPSTD
where NDC in (select Code from NDC.Ndc_nsaidcox where CodeType='NDC' union
                    select Code from NDC.Ndc_nsaidnoncox where CodeType='NDC')
;

create table Nsaidstd_sabr as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from Rxtdrugstd_sabr
where NDC in (select Code from NDC.Ndc_nsaidcox where CodeType='NDC' union
                    select Code from NDC.Ndc_nsaidnoncox where CodeType='NDC')
;

proc freq data=BioUCBSTD;
table GNN;
run;

data TNFUCBSTD;
set BioUCBSTD;
if GNN in ('ADALIMUMAB','CERTOLIZUMAB','ETANERCEPT','GOLIMUMAB','INFLIXIMAB');
run;

data TNFMPSTD;
set BioMPSTD;
if GNN in ('ADALIMUMAB','CERTOLIZUMAB','ETANERCEPT','GOLIMUMAB','INFLIXIMAB');
run;

data TNFstd_sabr;
set Biostd_sabr;
if GNN in ('ADALIMUMAB','CERTOLIZUMAB','ETANERCEPT','GOLIMUMAB','INFLIXIMAB');
run;




ods html close;
