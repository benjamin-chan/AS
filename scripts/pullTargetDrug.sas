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

/* 
From: Chen, Lang [mailto:langchen@uabmc.edu] 
Sent: Thursday, October 04, 2018 3:21 PM
To: Kevin Winthrop <winthrop@ohsu.edu>; Benjamin Chan <chanb@ohsu.edu>
Cc: Atul Deodhar <deodhara@ohsu.edu>; Jeffrey.Curtis@ccc.uab.edu; Sarah Siegel <siegels@ohsu.edu>
Subject: RE: Review Reminder: AS Comorbidities Manuscript (CZP-PMA-049255). Please review by 10 August

Ben 

Here is the NDC list in case you need it.

NDC.Ndc_dmard_bio
NDC.Ndc_nsaids
 */

data NDC4targetDrug;
set NDC.Ndc_dmard_bio(where=(CodeType='NDC'))
    NDC.Ndc_nsaids(where=(CodeType='NDC'));
  if gnn in ("CELECOXIB",
             "IBUPROFEN",
             "NAPROXEN",
             "MELOXICAM",
             "INDOMETHACIN",
             "DICLOFENAC",
             "KETOROLAC",
             "KETOPROFEN",
             "ETODOLAC",
             "SALSALATE",
             "FLURBIPROFEN",
             "HYDROXYCHLOROQUINE",
             "LEFLUNOMIDE",
             "METHOTREXATE",
             "SULFASALAZINE",
             "ADALIMUMAB",
             "CERTOLIZUMAB",
             "ETANERCEPT",
             "GOLIMUMAB",
             "INFLIXIMAB",
             "ABATACEPT",
             "ANAKINRA",
             "BELIMUMAB",
             "CANAKINUMAB",
             "IXEKIZUMAB",
             "RITUXIMAB",
             "SECUKINUMAB",
             "TOCILIZUMAB",
             "USTEKINUMAB",
             "VEDOLIZUMAB",
             "APREMILAST",
             "TOFACITINIB") then output;
run;


data J4targetDrug;
set NDC.Ndc_dmard_bio(where=(CodeType='HCPCS'))
    NDC.Ndc_nsaids(where=(CodeType='HCPCS'));
  if gnn in ("CELECOXIB",
             "IBUPROFEN",
             "NAPROXEN",
             "MELOXICAM",
             "INDOMETHACIN",
             "DICLOFENAC",
             "KETOROLAC",
             "KETOPROFEN",
             "ETODOLAC",
             "SALSALATE",
             "FLURBIPROFEN",
             "HYDROXYCHLOROQUINE",
             "LEFLUNOMIDE",
             "METHOTREXATE",
             "SULFASALAZINE",
             "ADALIMUMAB",
             "CERTOLIZUMAB",
             "ETANERCEPT",
             "GOLIMUMAB",
             "INFLIXIMAB",
             "ABATACEPT",
             "ANAKINRA",
             "BELIMUMAB",
             "CANAKINUMAB",
             "IXEKIZUMAB",
             "RITUXIMAB",
             "SECUKINUMAB",
             "TOCILIZUMAB",
             "USTEKINUMAB",
             "VEDOLIZUMAB",
             "APREMILAST",
             "TOFACITINIB") then output;
run;


proc freq data=NDC4targetDrug;
table category * GNN / list;
run;

proc freq data=J4targetDrug;
table GNN / list;
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
create table DT.BioUCBSTD as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from RxtdrugUCBSTD
where NDC in (select Code 
              from NDC.Ndc_dmard_bio 
              where CodeType='NDC' and Category in ('Biologic','sDMARD'))
union
select patid,BEGIN_DATE as DISPENSE_DATE,upcase(GNN) as GNN
from HCPCSTdrugUCBSTD
where PX in (select Code 
              from NDC.Ndc_dmard_bio 
              where CodeType='HCPCS' and Category in ('Biologic','sDMARD'))
;

create table DT.BioMPSTD as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from RxtdrugMPSTD
where NDC in (select Code 
              from NDC.Ndc_dmard_bio 
              where CodeType='NDC' and Category in ('Biologic','sDMARD'))
union
select patid,BEGIN_DATE as DISPENSE_DATE,upcase(GNN) as GNN
from HCPCSTdrugMPSTD
where PX in (select Code 
              from NDC.Ndc_dmard_bio 
              where CodeType='HCPCS' and Category in ('Biologic','sDMARD'));

create table DT.Biostd_sabr as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from Rxtdrugstd_sabr
where NDC in (select Code 
              from NDC.Ndc_dmard_bio 
              where CodeType='NDC' and Category in ('Biologic','sDMARD'))
union
select patid,BEGIN_DATE as DISPENSE_DATE,upcase(GNN) as GNN
from Hcpcstdrugstd_sabr
where PX in (select Code 
              from NDC.Ndc_dmard_bio 
              where CodeType='HCPCS' and Category in ('Biologic','sDMARD'))
union
select substr(pid,1,20) as patid length=20,rxdate as DISPENSE_DATE,upcase(GNN) as GNN
from std_sabr.Nonspecific_jcode_biologic
;

create table DT.DmardUCBSTD as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from RxtdrugUCBSTD
where NDC in (select Code 
              from NDC.Ndc_dmard_bio 
              where CodeType='NDC' and Category in ('cDMARD'))
union
select patid,BEGIN_DATE as DISPENSE_DATE,upcase(GNN) as GNN
from HcpcsTdrugUCBSTD
where PX in (select Code 
              from NDC.Ndc_dmard_bio 
              where CodeType='HCPCS' and Category in ('cDMARD'));

create table DT.DmardMPSTD as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from RxtdrugMPSTD
where NDC in (select Code 
              from NDC.Ndc_dmard_bio 
              where CodeType='NDC' and Category in ('cDMARD'))
union
select patid,BEGIN_DATE as DISPENSE_DATE,upcase(GNN) as GNN
from HcpcsTdrugMPSTD
where PX in (select Code 
              from NDC.Ndc_dmard_bio 
              where CodeType='HCPCS' and Category in ('cDMARD'));

create table DT.Dmardstd_sabr as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from Rxtdrugstd_sabr
where NDC in (select Code 
              from NDC.Ndc_dmard_bio 
              where CodeType='NDC' and Category in ('cDMARD'))
union
select patid,BEGIN_DATE as DISPENSE_DATE,upcase(GNN) as GNN
from HcpcsTdrugstd_sabr
where PX in (select Code 
              from NDC.Ndc_dmard_bio 
              where CodeType='HCPCS' and Category in ('cDMARD'));

create table DT.NsaidUCBSTD as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from RxtdrugUCBSTD
where NDC in (select Code from NDC.Ndc_nsaids where CodeType='NDC')
;

create table DT.NsaidMPSTD as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from RxtdrugMPSTD
where NDC in (select Code from NDC.Ndc_nsaids where CodeType='NDC')
;

create table DT.Nsaidstd_sabr as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from Rxtdrugstd_sabr
where NDC in (select Code from NDC.Ndc_nsaids where CodeType='NDC')
;

proc freq data=DT.BioUCBSTD;
table GNN;
run;

data DT.TNFUCBSTD;
set DT.BioUCBSTD;
if GNN in ('ADALIMUMAB','CERTOLIZUMAB','ETANERCEPT','GOLIMUMAB','INFLIXIMAB');
run;

data DT.TNFMPSTD;
set DT.BioMPSTD;
if GNN in ('ADALIMUMAB','CERTOLIZUMAB','ETANERCEPT','GOLIMUMAB','INFLIXIMAB');
run;

data DT.TNFstd_sabr;
set DT.Biostd_sabr;
if GNN in ('ADALIMUMAB','CERTOLIZUMAB','ETANERCEPT','GOLIMUMAB','INFLIXIMAB');
run;

proc freq data=DT.TNFUCBSTD;
table GNN;
run;



ods html close;
