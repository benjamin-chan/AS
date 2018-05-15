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

%pullTargetDrug(stdLib=stducb,
                pxdata=px,
                rxData=rx,
                YearStart=2010,
                nYear=5);

%pullTargetDrug(stdLib=stdmpcd,                   
                pxdata=px_07,
                rxData=rx_07,
                YearStart=10,
                nYear=1);

%pullTargetDrug(stdLib=std_sabr,                   
                pxdata=std_px,
                rxData=std_rx,
                YearStart=2006,
                nYear=9);


proc freq data=Rxtdrugstducb;
table GNN;
run;

proc freq data=HCPCStdrugstducb;
table GNN;
run;

proc sql;
create table Biostducb as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from Rxtdrugstducb
where NDC in (select Code 
              from NDC.Ndc_dmard_bio_all 
              where CodeType='NDC' and Category in ('Biologic','sDMARD'))
union
select patid,BEGIN_DATE as DISPENSE_DATE,upcase(GNN) as GNN
from HCPCSTdrugstducb
where PX in (select Code 
              from NDC.Ndc_dmard_bio_all 
              where CodeType='HCPCS' and Category in ('Biologic','sDMARD'))
;

create table Biostdmpcd as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from Rxtdrugstdmpcd
where NDC in (select Code 
              from NDC.Ndc_dmard_bio_all 
              where CodeType='NDC' and Category in ('Biologic','sDMARD'))
union
select patid,BEGIN_DATE as DISPENSE_DATE,upcase(GNN) as GNN
from HCPCSTdrugstdmpcd
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

create table Dmardstducb as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from Rxtdrugstducb
where NDC in (select Code 
              from NDC.Ndc_dmard_bio_all 
              where CodeType='NDC' and Category in ('cDMARD'))
union
select patid,BEGIN_DATE as DISPENSE_DATE,upcase(GNN) as GNN
from HcpcsTdrugstducb
where PX in (select Code 
              from NDC.Ndc_dmard_bio_all 
              where CodeType='HCPCS' and Category in ('cDMARD'));

create table Dmardstdmpcd as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from Rxtdrugstdmpcd
where NDC in (select Code 
              from NDC.Ndc_dmard_bio_all 
              where CodeType='NDC' and Category in ('cDMARD'))
union
select patid,BEGIN_DATE as DISPENSE_DATE,upcase(GNN) as GNN
from HcpcsTdrugstdmpcd
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

create table Nsaidstducb as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from Rxtdrugstducb
where NDC in (select Code from NDC.Ndc_nsaidcox where CodeType='NDC' union
                    select Code from NDC.Ndc_nsaidnoncox where CodeType='NDC')
;

create table Nsaidstdmpcd as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from Rxtdrugstdmpcd
where NDC in (select Code from NDC.Ndc_nsaidcox where CodeType='NDC' union
                    select Code from NDC.Ndc_nsaidnoncox where CodeType='NDC')
;

create table Nsaidstd_sabr as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from Rxtdrugstd_sabr
where NDC in (select Code from NDC.Ndc_nsaidcox where CodeType='NDC' union
                    select Code from NDC.Ndc_nsaidnoncox where CodeType='NDC')
;

proc freq data=Biostducb;
table GNN;
run;

data TNFstducb;
set Biostducb;
if GNN in ('ADALIMUMAB','CERTOLIZUMAB','ETANERCEPT','GOLIMUMAB','INFLIXIMAB');
run;

data TNFstdmpcd;
set Biostdmpcd;
if GNN in ('ADALIMUMAB','CERTOLIZUMAB','ETANERCEPT','GOLIMUMAB','INFLIXIMAB');
run;

data TNFstd_sabr;
set Biostd_sabr;
if GNN in ('ADALIMUMAB','CERTOLIZUMAB','ETANERCEPT','GOLIMUMAB','INFLIXIMAB');
run;
