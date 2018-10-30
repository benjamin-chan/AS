*  University of Alabama at Birmingham                               *
*  AS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=LC_UCBSTD; * type the name of your program here (without the filename extension);
%let pgm=&cmt..sas;
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
mkdir Q:\temp64\lchen\UCBASchecktmp1
mkdir R:\temp64\lchen\UCBASchecktmp1
mkdir S:\temp64\lchen\UCBASchecktmp1
mkdir T:\temp64\lchen\UCBASchecktmp1
mkdir U:\temp64\lchen\UCBASchecktmp1
mkdir V:\temp64\lchen\UCBASchecktmp1


proc datasets nolist library=user;
delete _all_;
quit;

*/
%include "lib\libname.sas" ;
%include "lib\expo.sas";
libname ndc_16 "W:\onenote\references\Drug NDCs\SAS Data\List from 2016 FDB";
libname lookup "W:\Users\lchen\lookupdata";
libname UCBcheck spde "Q:\temp64\lchen\UCBASchecktmp1"
                 datapath=("R:\temp64\lchen\UCBASchecktmp1"
                           "S:\temp64\lchen\UCBASchecktmp1"
                           "T:\temp64\lchen\UCBASchecktmp1"
                           "U:\temp64\lchen\UCBASchecktmp1"
                           "V:\temp64\lchen\UCBASchecktmp1")
                 indexpath=("U:\temp64\lchen\UCBASchecktmp1"
                            "V:\temp64\lchen\UCBASchecktmp1")
                  COMPRESS=BINARY;
options user=UCBcheck;
%let source=UCBSTD;


proc datasets nolist library=user kill;
quit;

*******************************************************************************;
* get enrollment into denom
*******************************************************************************;
*ben;
proc sql;
  create table denom as 
    select distinct patid, enr_start_date, enr_end_date, intck("month", enr_start_date, enr_end_date) + 1 as monthsEnrolled
    from UCBSTD.enroll
    where 12 <= calculated monthsEnrolled;
quit;
%let where = dx_type = "09" & dx like "720%" & enc_type = "AV";
%let varlist = patid, begin_date, dx_type, dx, enc_type, prov_type;
proc sql;
  create table temp1 as
    select &varlist from UCBSTD.dx_2010 where &where union corr
    select &varlist from UCBSTD.dx_2011 where &where union corr
    select &varlist from UCBSTD.dx_2012 where &where union corr
    select &varlist from UCBSTD.dx_2013 where &where union corr
    select &varlist from UCBSTD.dx_2014 where &where 
    order by patid, begin_date;
  select dx, count(*) as n from temp1 group by dx;
quit;
proc sql;
  create table temp2 as
    select distinct
           coalesce(A.patid, B.patid) as patid,
           year(B.begin_date) as year,
           A.begin_date format = mmddyy10. as date1,
           B.begin_date format = mmddyy10. as date2,
           A.prov_type as prov_type1,
           B.prov_type as prov_type2,
           C.death_date,
           C.sex,
           int((B.begin_date - C.birth_date) / 365.25) as age
    from temp1 A inner join
         temp1 B on (A.patid = B.patid &
                          intnx("year", B.begin_date, -1, "sameday") < A.begin_date < B.begin_date - 7) inner join
         UCBSTD.demog C on (A.patid = C.patid)
    where (A.prov_type = "300" & B.prov_type = "300");  /* Provider type codes in Marketscan are different than MPCD and Medicare */
  create table cohortASTDUCB as
    select distinct
           A.patid,
           A.dateEarliestDiagnosis format = mmddyy10. as asDate,
           max(A.dateEarliestDiagnosis, C.enr_start_date + 183) format = mmddyy10. as asCohortDate,
           calculated asCohortDate format = mmddyy10. as indexDate,
           C.enr_start_date,
           C.enr_end_date,
           B.death_date,
           B.sex,
           B.age
    from (select patid, min(date2) format = mmddyy10. as dateEarliestDiagnosis from temp2 group by patid) A inner join
         temp2 B on (A.patid = B.patid & A.dateEarliestDiagnosis = B.date2) inner join
         denom C on (A.patid = C.patid & C.enr_start_date <= A.dateEarliestDiagnosis <= C.enr_end_date);
quit;
*LC;
/*AS dx 720.x */
data uab_dx_720;
set 
UCBSTD.dx_2010 - UCBSTD.dx_2014;
where dx=:"720";
run;
proc freq data=uab_dx_720;
tables dx_type   dx  enc_type;
run;
/*AS dx from AV*/
data uab_dx_720_av;
set uab_dx_720;
where dx=:"720" and enc_type="AV"; 
run;
/*deduplicate*/
proc sort data=uab_dx_720_av nodupkey;;
by patid begin_date dx_type dx enc_type prov_type ;
run;
proc freq data=uab_dx_720_av;
tables dx_type   dx  enc_type;
run;
proc freq data=temp1;
tables dx_type   dx  enc_type;
run;

*******************************************************************************;
 /* AS 2 dx from AV and rheumotologist PROV_TYPE=300 and 7 day - 1 year apart*/
data uab_dx_720_av_rheu;
set uab_dx_720_av(where=(PROV_TYPE in ('300')))
;
run;
%macro twodx(indat, datevar);
/*
This code generate cohort with two DX (>=7 days and <730 apart) not include the end point/day;
by Lang Chen
2018/06/27
indat   : input data
datevar : varaible of diagnosis date
*/
data _tmptwodx;
if _n_=1 then do;
    declare hash hPATID(dataset:"&indat.(rename=&datevar.=&datevar.2nd)", ordered: 'a', multidata:"Y");
    rc=hPATID.defineKey("PATID");
    rc=hPATID.defineData("PATID", "&datevar.2nd");
    rc=hPATID.defineDone();
end;
if 0 then set &indat.(rename=&datevar.=&datevar.2nd keep=patid &datevar.);
set &indat.;
 rc=hPATID.find(key:PATID);
 format cohort_date mmddyy10.;
 length cohort_date 4;
 do while (rc = 0);
 cohort_date=&datevar.2nd;
 dx1todx2=&datevar.2nd -  &datevar.;
 dx2eligible=intnx("year", &datevar.2nd, -1, "SAME") < &datevar. < &datevar.2nd - 7;
 if rc=0 and dx2eligible then output;
 rc=hPATID.find_next();
 *hPATID.has_next(result:r);
end;
run;
proc means data=_tmptwodx  n nmiss mean std mode min p1 p5 p10 p25 median p75 p90 p95 p99 max;
var  dx1todx2;
run;
proc sort data=_tmptwodx; by patid cohort_date  &datevar.; run;
data &indat.2;
set _tmptwodx(keep=patid cohort_date  &datevar. &datevar.2nd dx1todx2 );
by patid cohort_date  &datevar.; 
year=year(cohort_date);
if first.patid;
run;
proc datasets nolist; delete _tmptwodx; quit;
%mend twodx;

%twodx(indat=uab_dx_720_av_rheu, datevar=begin_date);
/*with at least one year enrollment*/
proc sql;
  create table denom as 
    select distinct patid, enr_start_date, enr_end_date, intck("month", enr_start_date, enr_end_date) + 1 as monthsEnrolled
    from UCBSTD.enroll
    where 12 <= calculated monthsEnrolled;
quit;

proc sql;
create table cohort1 as
select * from UAB_DX_720_AV_RHEU2 a
 inner join denom b
on a.patid=b.patid;
quit;
proc means data=UAB_DX_720_AV_RHEU2  n nmiss mean std mode min p1 p5 p10 p25 median p75 p90 p95 p99 max;
var  dx1todx2;
run;
/* set index date to fulfill 1) disease defintion 2) 183 day of enrollment */
data cohort2;
set cohort1;
format indexDate mmddyy10.; 
indexDate=max(cohort_date, enr_start_date + 183);
if ENR_START_DATE<=cohort_date <=ENR_END_DATE;
run;


/*check*/
/* proc freq data=cohort1;
tables dx2eligible;
run; */
proc freq data=temp2;
tables sex age prov_type1 prov_type2;
run;
proc sql;
select count(distinct patid) from temp2;
select count(distinct patid) from cohort1;
select count(distinct patid) from UAB_DX_720_AV_RHEU2;
/*check the cohort AS number should match*/
select count(distinct patid) from cohort2;
select count(distinct patid) from DT.cohortASTDUCB;
select count(distinct patid) from cohortASTDUCB;


proc sql outobs=100;
select * from UAB_DX_720_AV_RHEU2
where patid not in (select distinct patid from temp2);

select * from temp2
where patid not in (select distinct patid from UAB_DX_720_AV_RHEU2);


select * from cohort2
where patid not in (select distinct patid from DT.cohortASTDUCB);

select * from DT.cohortASTDUCB
where patid not in (select distinct patid from cohort2);

quit;

proc print data=UAB_DX_720_AV_RHEU;
where patid in ('2874004101');
run;
proc print data=temp1;
where patid in ('2874004101');
run;
proc print data=denom;
where patid in ('2874004101');
run;

proc sql;
create table tmp1 as 
select * from UAB_DX_720_AV_RHEU2
where patid in (
				select patid from  temp2
				where patid not in (select distinct patid from cohort1)
)
order by patid, begin_date;
quit;



************************************************************************************************;

************************************************************************************************;
/*LC*/
proc freq data=NDC.Ndc_dmard_bio(where=(CodeType='NDC')); 
tables  gnn*rt*Category /list missing nopercent;
run;
proc freq data=NDC.Ndc_nsaids(where=(CodeType='NDC')); 
tables  gnn*rt  /list missing nopercent;
run;
/*NDC and HCPCS code for BIO/DMARD/NSAID*/
data NDC4targetDrug;
set NDC.Ndc_dmard_bio(where=(CodeType='NDC'))
    NDC.Ndc_nsaids(where=(CodeType='NDC' and rt="ORAL"))
	;
run;

data J4targetDrug;
set NDC.Ndc_dmard_bio(where=(CodeType='HCPCS'))
    NDC.Ndc_nsaids(where=(CodeType='HCPCS'))
	;
run;
proc freq data=NDC4targetDrug; tables rt;run;
proc print data=NDC4targetDrug;where rt=" ";run;
/*data NDC4targetDrug;*/
/*set NDC4targetDrug;*/
/*where rt not in (*/
/*'INTRAOCULR'*/
/*'MUCOUS MEM'*/
/*'NASAL'*/
/*'OPHTHALMIC'*/
/*'RECTAL'*/
/*'TOPICAL'*/
/*'TRANSDERM'*/
/*'VAGINAL'*/
/*);*/
/*run;*/
proc freq data=NDC4targetDrug; tables rt Category*gnn/missing list ;run;
proc freq data=J4targetDrug; tables rt Category*gnn/missing list ;run;


/*RX and PX claim BIO/DMARD/NSAID*/
data dat_rx_expo(drop=rc);
if _n_=1 then do;
    declare hash hNDC(dataset:"NDC4targetDrug", ordered: 'a', multidata:"N");
    rc=hNDC.defineKey("code");
    rc=hNDC.definedata("code", "rt", "GNN");
    rc=hNDC.defineDone();
end;
if 0 then set NDC4targetDrug(keep=code rt GNN);
set UCBSTD.Rx_2010 - UCBSTD.Rx_2014;
rc=hNDC.find(key:NDC);
if rc=0;
run;

data dat_px_expo(drop=rc);
if _n_=1 then do;
    declare hash hNDC(dataset:"J4targetDrug", ordered: 'a', multidata:"N");
    rc=hNDC.defineKey("code");
    rc=hNDC.definedata("code", "rt", "GNN" );
    rc=hNDC.defineDone();
end;
if 0 then set J4targetDrug(keep=code rt GNN);
set UCBSTD.px_2010 - UCBSTD.px_2014;
rc=hNDC.find(key:px);
if rc=0;
run;
 


proc sql;
select count(*) from dat_rx_expo;
/* select count(*) from Rxtdrugucbstd; */

select count(*) from dat_px_expo;
/* select count(*) from Hcpcstdrugucbstd; */
quit;
proc freq data=NDC.Ndc_dmard_bio ; tables gnn;run;


/*ben*/
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
create table RXTdrug&stdLib.&YR as
select a.patid,a.NDC,a.DISPENSE_DATE,b.GNN
from &stdLib..&rxData._&YR as a
      ,
     NDC4targetDrug as b
where a.NDC=b.code;

create table HCPCSTdrug&stdLib.&YR as
select a.patid,a.px,a.BEGIN_DATE,b.GNN
from &stdLib..&pxdata._&YR as a
      ,
      J4targetDrug as b
where a.px=b.code;

proc datasets nolist;
append data=RXTdrug&stdLib.&YR out=RXTdrug&stdLib;
quit;run;

proc datasets nolist;
append data=HCPCSTdrug&stdLib.&YR out=HCPCSTdrug&stdLib;
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

proc sql;
create table BioUCBSTD as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from RxtdrugUCBSTD
where NDC in (select Code 
              from NDC.Ndc_dmard_bio 
              where CodeType='NDC' and gnn in (
'ABATACEPT'
'ADALIMUMAB'
'ANAKINRA'
'APREMILAST'
'BELIMUMAB'
'CANAKINUMAB'
'CERTOLIZUMAB'
'ETANERCEPT'
'GOLIMUMAB'
'INFLIXIMAB'
'IXEKIZUMAB'
'RITUXIMAB'
'SECUKINUMAB'
'TOCILIZUMAB'
'TOFACITINIB'
'USTEKINUMAB'
'VEDOLIZUMAB'))
union
select patid,BEGIN_DATE as DISPENSE_DATE,upcase(GNN) as GNN
from HCPCSTdrugUCBSTD
where PX in (select Code 
              from NDC.Ndc_dmard_bio 
              where CodeType='HCPCS' and gnn in (
'ABATACEPT'
'ADALIMUMAB'
'ANAKINRA'
'APREMILAST'
'BELIMUMAB'
'CANAKINUMAB'
'CERTOLIZUMAB'
'ETANERCEPT'
'GOLIMUMAB'
'INFLIXIMAB'
'IXEKIZUMAB'
'RITUXIMAB'
'SECUKINUMAB'
'TOCILIZUMAB'
'TOFACITINIB'
'USTEKINUMAB'
'VEDOLIZUMAB'))
;
quit;

proc sort data=Bioucbstd nodupkey; by patid gnn DISPENSE_DATE;run;


data TNFUCBSTD;
set BioUCBSTD;
if GNN in ('ADALIMUMAB','CERTOLIZUMAB','ETANERCEPT','GOLIMUMAB','INFLIXIMAB');
run;
/*
Adalimumab(Humira)
Certolizumab (Cimzia)
Etanercept (Enbrel)
Golimumab (Simponi)
Infliximab (Remicade)

Abatacept(Orencia)
Anakinra(Kineret)
Belimumab(Benlysta)
Canakinumab(Ilaris)
Ixekizumab (Taltz)
Rituximab(Rituxan)
Secukinumab (Cosentyx)
Tocilizumab(Actemra)
Ustekinumab (Stelara)
Vedolizumab(Entyvio)
Apremilast (Otezla)
Tofacitinib (Xeljanz)
*/

/*LC*/
data dat_expo_bio1;
set dat_rx_expo dat_px_expo;
where upcase(gnn) in (
'ABATACEPT'
'ADALIMUMAB'
'ANAKINRA'
'APREMILAST'
'BELIMUMAB'
'CANAKINUMAB'
'CERTOLIZUMAB'
'ETANERCEPT'
'GOLIMUMAB'
'INFLIXIMAB'
'IXEKIZUMAB'
'RITUXIMAB'
'SECUKINUMAB'
'TOCILIZUMAB'
'TOFACITINIB'
'USTEKINUMAB'
'VEDOLIZUMAB'
);
run;
proc freq data=dat_expo_bio1; tables gnn;run;
data dat_expo_bio2; set dat_expo_bio1;
if DISPENSE_DATE=. then DISPENSE_DATE=BEGIN_DATE ;
run;

proc sort data=dat_expo_bio2 out=dat_expo_bio3 nodupkey; by patid gnn DISPENSE_DATE;run;
proc sort data=dat_expo_bio2 out=dat_expo_bio nodupkey; by patid gnn DISPENSE_DATE;run;
proc freq data=dat_expo_bio3; tables gnn;run;
/* proc freq data=tmp; tables gnn;run; */
proc freq data=dt.Bioucbstd; tables gnn;run;
ods html close;
ods html;
proc freq data=Bioucbstd; tables gnn;run;
proc freq data=dat_expo_bio; tables gnn;run;

data dat_expo_tnf;
set dat_expo_bio3;
if GNN in ('ADALIMUMAB','CERTOLIZUMAB','ETANERCEPT','GOLIMUMAB','INFLIXIMAB');
run;

************************************************************************************************;

************************************************************************************************;
/*LC*/
data dat_expo_dmard1;
set dat_rx_expo dat_px_expo;
where upcase(gnn) in (
'HYDROXYCHLOROQUINE' 
'LEFLUNOMIDE' 
'METHOTREXATE' 
'SULFASALAZINE'
);
run;
;
data dat_expo_dmard2; set dat_expo_dmard1;
if DISPENSE_DATE=. then DISPENSE_DATE=BEGIN_DATE ;
run;

proc sort data=dat_expo_dmard2 out=dat_expo_dmard nodupkey; by patid gnn DISPENSE_DATE;run;

/*ben*/
proc sql;

create table DmardUCBSTD as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from RxtdrugUCBSTD
where NDC in (select Code 
              from NDC.Ndc_dmard_bio
              where CodeType='NDC' and 
			  upcase(gnn) in (
'HYDROXYCHLOROQUINE' 
'LEFLUNOMIDE' 
'METHOTREXATE' 
'SULFASALAZINE'
)
			  )
union
select patid,BEGIN_DATE as DISPENSE_DATE,upcase(GNN) as GNN
from HcpcsTdrugUCBSTD
where PX in (select Code 
              from NDC.Ndc_dmard_bio
              where CodeType='HCPCS' and upcase(gnn) in (
'HYDROXYCHLOROQUINE' 
'LEFLUNOMIDE' 
'METHOTREXATE' 
'SULFASALAZINE'
)
			);


quit;


ods html close;
ods html;
proc freq data=dt.DmardUCBSTD;
tables gnn;
run;
proc freq data=DmardUCBSTD;
tables gnn;
run;

proc freq data=dat_expo_dmard;
tables gnn;
run;

************************************************************************************************;

************************************************************************************************;
/*LC*/
data dat_expo_NSAID1;
set dat_rx_expo ;
where rt="ORAL" and upcase(gnn) in (
'CELECOXIB' 
'IBUPROFEN' 
'NAPROXEN' 
'MELOXICAM' 
'INDOMETHACIN' 
'DICLOFENAC' 
'KETOROLAC' 
'KETOPROFEN' 
'ETODOLAC' 
'SALSALATE' 
'FLURBIPROFEN' 
);
run;
;

proc sort data=dat_expo_NSAID1 out=dat_expo_NSAID nodupkey; by patid gnn DISPENSE_DATE;run;


/*ben*/
proc sql;
create table NsaidUCBSTD as
select patid,DISPENSE_DATE,upcase(GNN) as GNN
from RxtdrugUCBSTD
where NDC in (select Code from NDC.Ndc_nsaids where CodeType='NDC' and rt="ORAL" and
upcase(gnn) in (
'CELECOXIB' 
'IBUPROFEN' 
'NAPROXEN' 
'MELOXICAM' 
'INDOMETHACIN' 
'DICLOFENAC' 
'KETOROLAC' 
'KETOPROFEN' 
'ETODOLAC' 
'SALSALATE' 
'FLURBIPROFEN' 
)
)
;
quit;
proc sort data=NsaidUCBSTD nodupkey; by patid gnn DISPENSE_DATE;run;

proc freq data=dt.NSAIDUCBSTD;
tables gnn;
run;

proc freq data=dat_expo_NSAID1;
tables gnn;
run;
ods html close;
ods html;
proc freq data=dat_expo_NSAID;
tables gnn;
run;
proc freq data=NSAIDUCBSTD;
tables gnn;
run;


************************************************************************************************;

************************************************************************************************;

ods html close;
ods html;

/*ben*/
%expo(source = UCBSTD  , cohort0 = cohortASTDUCB  , stdLib = UCBSTD  , enrData = enroll)


/*LC first exposure of bio/TNF/DMARD/NSAID*/
data Dat_expo_bio_1st(rename=DISPENSE_DATE=indexdate);
set Dat_expo_bio;
by patid gnn DISPENSE_DATE;
if first.gnn;
run;

data Dat_expo_tnf_1st(rename=DISPENSE_DATE=indexdate);
set Dat_expo_tnf;
by patid gnn DISPENSE_DATE;
if first.gnn;
run;

data Dat_expo_dmard_1st(rename=DISPENSE_DATE=indexdate);
set Dat_expo_dmard;
by patid gnn DISPENSE_DATE;
if first.gnn;
run;

data dat_expo_NSAID_1st(rename=DISPENSE_DATE=indexdate);
set dat_expo_NSAID;
by patid gnn DISPENSE_DATE;
if first.gnn;
run;

* DMARD exposure cohort exclusion and censor for any bio or other DMARDs;
data _null_;
if _n_=1 then do;
    declare hash hPATID(multidata: "Y");
    rc=hPATID.defineKey("patid");
    rc=hPATID.defineData("patid", "indexdate", "hx_rx", "hx_rx_date", "GNN", "censor_rx");
    rc=hPATID.defineDone();
end;
label hx_rx="HX of RX exclude patient from cohort";
format censor_rx hx_rx_date mmddyy10.;
       do while(not last);
         set Dat_expo_dmard_1st(keep=patid indexdate gnn) end=last;
		 hx_rx=0; hx_rx_date=.;
		 censor_rx=.;
		 rc=hPATID.add();
       end;
set Dat_expo_bio(rename=gnn=expo_gnn in=a) Dat_expo_dmard(rename=gnn=expo_gnn) end=end2;
rc=hPATID.find();
do while (rc = 0) ;
	if .<DISPENSE_DATE<=indexdate and a then do; 
			hx_rx=1; hx_rx_date=max(DISPENSE_DATE, hx_rx_date);	
	end;
	if .<indexdate<DISPENSE_DATE and gnn^=expo_gnn then do; 
		censor_rx=min(DISPENSE_DATE, censor_rx);	
	end;
	rc=hPATID.replacedup();
	rc = hPATID.find_next() ;
end ;
if end2 then hPATID.output(dataset: "Dat_expo_dmard_2") ; 
run;
proc freq data=Dat_expo_dmard_2;format censor_rx year4.; tables hx_rx censor_rx;run; 

/*
proc sql;
create table tmp2 as
select patid, min(indexdate) as biodate format=mmddyy10. from Dat_expo_bio_1st
group by patid;

create table _tmp1 as
select *, .< biodate<= indexdate as hx_rx  from Dat_expo_dmard_1st a
left join tmp2 b
on a.patid=b.patid ;
quit;

proc freq data=_tmp1;  tables hx_rx ;run; 
proc freq data=Dat_expo_dmard_2;format censor_rx year4.; tables hx_rx censor_rx;run; 

data tmp_check;
merge _tmp1(rename=hx_rx=hx_rxsql) Dat_expo_dmard_2;
by patid gnn indexdate;
run;

proc print data=tmp_check(obs=10);
var patid gnn indexdate hx_rx hx_rxsql biodate;
where hx_rx^=hx_rxsql;
run;
*/
* NSAID exposure cohort exclusion and censor for any bio/dmard/other NSAIDS;
data _null_;
if _n_=1 then do;
    declare hash hPATID(multidata: "Y");
    rc=hPATID.defineKey("patid");
    rc=hPATID.defineData("patid", "indexdate", "hx_rx", "hx_rx_date", "GNN", "censor_rx");
    rc=hPATID.defineDone();
end;
label hx_rx="HX of RX exclude patient from cohort";
format censor_rx hx_rx_date mmddyy10.;
       do while(not last);
         set Dat_expo_nsaid_1st(keep=patid indexdate gnn) end=last;
		 hx_rx=0; hx_rx_date=.;
		 censor_rx=.;
		 rc=hPATID.add();
       end;
set Dat_expo_bio(rename=gnn=expo_gnn in=a) 
	Dat_expo_dmard(rename=gnn=expo_gnn in=b) 
	Dat_expo_nsaid(rename=gnn=expo_gnn in=c) end=end2;
rc=hPATID.find();
do while (rc = 0) ;
	if .<DISPENSE_DATE<=indexdate and (a or b) then do; 
			hx_rx=1; hx_rx_date=max(DISPENSE_DATE, hx_rx_date);	
	end;
	if .<indexdate<DISPENSE_DATE and gnn^=expo_gnn then do; 
		censor_rx=min(DISPENSE_DATE, censor_rx);	
	end;
	rc=hPATID.replacedup();
	rc = hPATID.find_next() ;
end ;
if end2 then hPATID.output(dataset: "Dat_expo_nsaid_2") ; 
run;
proc freq data=Dat_expo_nsaid_2;format censor_rx year4.; tables hx_rx censor_rx;run; 

* no exposure cohort exclusion and censor for any bio/dmard/nsaid;
data _null_;
if _n_=1 then do;
    declare hash hPATID(multidata: "Y");
    rc=hPATID.defineKey("patid");
    rc=hPATID.defineData("patid", "indexdate", "hx_rx", "hx_rx_date", "GNN", "censor_rx");
    rc=hPATID.defineDone();
end;
label hx_rx="HX of RX exclude patient from cohort";
format censor_rx hx_rx_date mmddyy10.;
length gnn $30;
       do while(not last);
         set cohort2(keep=patid indexdate ) end=last;
		 gnn="NO";
		 hx_rx=0; hx_rx_date=.;
		 censor_rx=.;
		 rc=hPATID.add();
       end;
set Dat_expo_bio Dat_expo_dmard Dat_expo_nsaid end=end2;
rc=hPATID.find();
do while (rc = 0) ;
	if .<DISPENSE_DATE<=indexdate then do; 
			hx_rx=1; hx_rx_date=max(DISPENSE_DATE, hx_rx_date);	
	end;
	if .<indexdate<DISPENSE_DATE then do; 
		censor_rx=min(DISPENSE_DATE, censor_rx);	
	end;
	rc=hPATID.replacedup();
	rc = hPATID.find_next() ;
end ;
if end2 then hPATID.output(dataset: "Dat_expo_no_2") ; 
run;
proc freq data=Dat_expo_no_2;format censor_rx year4.; tables hx_rx censor_rx;run; 

* TNF exposure cohort exclusion and censor for any other bio/TNF;
data _null_;
if _n_=1 then do;
    declare hash hPATID(multidata: "Y");
    rc=hPATID.defineKey("patid");
    rc=hPATID.defineData("patid", "indexdate", "hx_rx", "hx_rx_date", "GNN", "censor_rx");
    rc=hPATID.defineDone();
end;
label hx_rx="HX of RX exclude patient from cohort";
format censor_rx hx_rx_date mmddyy10.;
       do while(not last);
         set Dat_expo_TNF_1st(keep=patid indexdate gnn) end=last;
		 hx_rx=0; hx_rx_date=.;
		 censor_rx=.;
		 rc=hPATID.add();
       end;
set Dat_expo_bio(rename=gnn=expo_gnn) end=end2;
rc=hPATID.find();
do while (rc = 0) ;
if gnn ^= expo_gnn then do;
	if .<DISPENSE_DATE<=indexdate then do; 
			hx_rx=1; hx_rx_date=max(DISPENSE_DATE, hx_rx_date);	
	end;
	if .<indexdate<DISPENSE_DATE then do; 
		censor_rx=min(DISPENSE_DATE, censor_rx);	
	end;
	rc=hPATID.replacedup();
end ;
	rc = hPATID.find_next() ;
end;
if end2 then hPATID.output(dataset: "Dat_expo_TNF_2") ; 
run;
proc freq data=Dat_expo_TNF_2;format censor_rx year4.; tables hx_rx censor_rx;run; 


data expo_cohort1;
set Dat_expo_TNF_2(in=a)
Dat_expo_dmard_2(in=b)
Dat_expo_nsaid_2(in=c)
Dat_expo_no_2(in=d);
length exposure $5;
if a then exposure="TNF";
if b then exposure="DMARD";
if c then exposure="NSAID";
if d then exposure="NO";
hx6m_rx=(indexdate-183<=hx_rx_date<=indexdate);
run;
proc freq data=expo_cohort1;
tables exposure*gnn/missing list;
tables hx6m_rx*hx6m_rx/missing list;
run;

proc sql;
/* merge with enroll*/
create table expo_cohort2
as select * from expo_cohort1(keep=patid exposure indexdate gnn hx_rx hx_rx_date censor_rx hx6m_rx) a
left join ucbstd.enroll b
on a.patid=b.patid and b.enr_start_date+183<=a.indexdate<=enr_end_date;
/* merge with as cohort*/
create table expo_cohort3
as select a.*, b.cohort_date as asdate, .<b.cohort_date<=a.indexdate as ascohort from expo_cohort2 a
left join cohort2 b
on a.patid=b.patid and b.cohort_date<=a.indexdate;
/* merge with demog data*/
create table expo_cohort4
as select a.*, b.birth_date, b.death_date, int((A.indexdate - B.birth_date) / 365.25) as age, 
			min(enr_end_date,censor_rx-1,DEATH_DATE) as obs_end format=mmddyy10.
from expo_cohort3 a
left join UCBSTD.demog b
on a.patid=b.patid;

quit;

proc freq data=expo_cohort3;
tables exposure*ascohort/missing list;
run;

proc freq data=expo_cohort3;
tables exposure*gnn/missing list;
tables hx6m_rx*hx6m_rx/missing list;
where enr_start_date>. and hx6m_rx^=1;
run;
proc freq data=expo_cohort4;
tables exposure*gnn/missing list;
tables hx6m_rx*hx6m_rx/missing list;
where enr_start_date>. and hx6m_rx^=1;
run;
proc freq data=expo_cohort3;
tables exposure;
where enr_start_date>. and hx6m_rx^=1;
run;
proc sql;
title2 "Patient with at least one initiation for biologic after AS date";
select exposure, count(distinct patid) as number
from expo_cohort3
where ascohort=1
group by exposure;

select exposure, count(distinct patid) as number
from expo_cohort3
where ascohort=1 and hx_rx^=1
group by exposure;

select exposure, count(distinct patid) as number
from expo_cohort3
where ascohort=1 and hx6m_rx^=1
group by exposure;


select  count(distinct patid) as number
from
ASNoExpCohort&source._ex1;

ods html close;
ods html;

select * from expo_cohort3
where ascohort=1 and hx_rx^=1 and exposure="NO"
and patid not in (select patid from ASNoExpCohort&source._ex1);
select * from ASNoExpCohort&source._ex1
where patid not in (select patid from expo_cohort3
where ascohort=1 and hx_rx^=1 and exposure="NO");


select * from expo_cohort3
where ascohort=1 and hx6m_rx^=1 and exposure="NO"
and patid not in (select patid from ASNoExpCohort&source._ex2);
select * from ASNoExpCohort&source._ex2
where patid not in (select patid from expo_cohort3
where ascohort=1 and hx6m_rx^=1 and exposure="NO");

/*
patient in no exposure group with death date before index date
*/
proc print data=ASNoExpCohort&source._ex1;
where patid in ("28485767001" "27061524501");
run;

proc print data=allBio1st&source ;
where patid in ("28485767001"  "27061524501");
run;
proc print data=allDmard1st&source ;
where patid in ("28485767001"  "27061524501");
run;
proc print data=allNsaid1st&source;
where patid in ("28485767001"  "27061524501");
run;
proc print data=ASNoExpCohort0&source;
where patid in ("28485767001"  "27061524501");
run;


ods html close;
ods html;
proc sql;
title2 "Patient with at least one initiation for biologic after AS date";
select exposure, count(distinct patid) as number
from expo_cohort4
where ascohort=1
group by exposure;

title2 "Patient with at least one initiation for biologic after AS date and not history of higher treatment";
select exposure, count(distinct patid) as number
from expo_cohort4
where ascohort=1 and hx_rx^=1
group by exposure;

title2 "Patient with at least one initiation for biologic after AS date and not history of higher treatment 6m before index date";
select exposure, count(distinct patid) as number
from expo_cohort4
where ascohort=1 and hx6m_rx^=1
group by exposure;


title2 "Patient with at least one initiation for biologic after AS date and not history of higher treatment and 6m baseline";
select exposure, count(distinct patid) as number
from expo_cohort4
where ascohort=1 and hx_rx^=1 and enr_start_date+183<=indexDate<=enr_end_date and indexdate<=censor_rx-1
group by exposure;

title2 "Patient with at least one initiation for biologic after AS date and not history of higher treatment 6m before index date  and 6m baseline";
select exposure, count(distinct patid) as number
from expo_cohort4
where ascohort=1 and hx6m_rx^=1 and enr_start_date+183<=indexDate<=enr_end_date and indexdate<=censor_rx-1
group by exposure;

quit;
ods html close;
ods html;

data expo_cohort5;
set expo_cohort4;
where ascohort=1 and enr_start_date+183<=indexDate<=enr_end_date and (indexdate<=obs_end);
if exposure^="TNF" and hx6m_rx=1 then delete;
if exposure="TNF" and hx_rx_date=indexdate then delete;
run;



************************************************************************************************;

************************************************************************************************;
/*ben*/
%let var = patid, indexGNN, indexDate, age, sex, asDate, enr_start_date, enr_end_date, asCohortDate, death_date;
proc sql;
  create table indexLookup AS
    select "Marketscan" as database, "TNF"   as exposure, &var from ASTNFCohortUCBStd_ex1     union corr
    select "Marketscan" as database, "DMARD" as exposure, &var from ASDMARDCohortUCBStd_ex2   union corr
    select "Marketscan" as database, "NSAID" as exposure, &var from ASNSAIDCohortUCBStd_ex2   union corr
    select "Marketscan" as database, "No exposure" as exposure, &var from ASNoExpCohortUCBStd_ex2  ;
  alter table indexLookup add indexID numeric;
  update indexLookup
    set indexID = monotonic();
quit;
proc sort data = indexLookup nodupkey;
  by database exposure patid indexGNN indexDate;
run;
ods html close;
ods html;
/*check*/
proc sql;
  select database, 
         exposure, 
         count(distinct patid) as countDistinctPatid, 
         count(distinct indexID) as countDistinctIndexes, 
         count(*) as countRows
    from indexLookup
    group by database, exposure;

select exposure, count(distinct patid) as countDistinctPatid, count(  *) as countDistinctIndexes
from expo_cohort5
group by exposure;

  select database, 
         exposure, 
         count(distinct patid) as countDistinctPatid, 
         count(distinct indexID) as countDistinctIndexes, 
         count(*) as countRows
    from dt.indexLookup
    group by database, exposure;

quit;
/*LC*/
options nolabel;

/*find episode in one date not in the other*/
proc sql outobs=10;
select a.* from expo_cohort5(where=(exposure="TNF")) a
left join ASTNFCohortUCBStd_ex1 b
on a.patid=b.patid and a.gnn=b.indexgnn
where b.patid is null and b.indexgnn is null;
quit;


************************************************************************************************;

************************************************************************************************;
/*LC*/
/*
indexdata		: data include three variables, (patient id, timezeor, exposure group).
timezero		: index date/time zero, any exposure after timezero in expodata will used to define exposure
exposuregroup	: variable of exposure, to match both in indexdata and exposure data
expodata
*/
data _null_;
/*
find the exposure discountinue date use both rx/px 

*/
if _n_=1 then do;
    declare hash hPATID(multidata: "Y");
    rc=hPATID.defineKey("patid");
    rc=hPATID.defineData("patid", "indexdate", "GNN", "exposure", "stop_date");
    rc=hPATID.defineDone();
end;
format stop_date mmddyy10.;
       do while(not last);
         set expo_cohort5(keep=patid indexdate gnn exposure) end=last;
		 stop_date=.;
		 rc=hPATID.add();
       end;
set Dat_expo_tnf(rename=(gnn=expo_gnn)) 
Dat_expo_dmard(rename=(gnn=expo_gnn))
Dat_expo_nsaid(rename=(gnn=expo_gnn))
end=end2;
rc=hPATID.find();
do while (rc = 0) ;
	if .<indexdate<=DISPENSE_DATE and gnn=expo_gnn then do; 
		if DISPENSE_DATE<=max(indexdate+90, stop_date) then stop_date=max(stop_date, sum(DISPENSE_DATE,DISPENSE_SUP,90));	
	end;
	rc=hPATID.replacedup();
	rc = hPATID.find_next() ;
end ;
if end2 then hPATID.output(dataset: "Dat_expo_stop") ; 
run;
ods html close;
ods html;
proc freq data=Dat_expo_stop; 
format stop_date year4.;
tables  exposure*gnn*stop_date/missing list;
run;

quit;

proc sql;
create table expo_cohort6 as
select * from expo_cohort5 a
join Dat_expo_stop b
on a.patid=b.patid and a.indexdate=b.indexdate and a.gnn=b.gnn and a.exposure=b.exposure;
quit;

proc freq data=expo_cohort6; 
format stop_date year4.;
tables  exposure*gnn*stop_date/missing list;
run;

data expo_cohort7;
set expo_cohort6; 
format followupenddate mmddyy10.;
followupenddate=min(stop_date-1, obs_end);
followupday=obs_end-indexdate+1;
run;
ods html close;
ods html;
/*those number should match*/
proc sql;
  select database, 
         exposure, 
         count(distinct patid) as countDistinctPatid, 
         count(distinct indexID) as countDistinctIndexes, 
         count(*) as countRows
    from indexLookup
    group by database, exposure;

select exposure, count(distinct patid) as countDistinctPatid, count(  *) as countDistinctIndexes
from expo_cohort7
group by exposure;
quit;

proc means data=expo_cohort7  n nmiss mean std mode min p1 p5 p10 p25 median p75 p90 p95 p99 max;
var followupday ;
run;
proc print data=expo_cohort7(obs=100);
where followupday=0 ;
run;
ods html close;
ods html;


options orientation=landscape;
options papersize=(17in 9in);
%put %sysfunc(datetime(), B8601DT15.);
%put %sysfunc(datetime(), B8601DN.);
footnote "followupday";
footnote2 "%sysfunc(datetime(), B8601DT15.)";
title1 '---   ---';
%let filename=followupday;
%let RTF_file_path=&outputfolder.;
ods html file="&filename.(%sysfunc(datetime(), B8601DT15.)).html" path="W:\Arthritis Studies\UCB_AS";
ods rtf file="W:\Arthritis Studies\UCB_AS\&filename.(%sysfunc(datetime(), B8601DT15.)).rtf" style=EGdefault ;
proc means data=expo_cohort7  n nmiss sum mean std mode min p1 p5 p10 p25 median p75 p90 p95 p99 max maxdec=0;
class exposure gnn;
var followupday;
types exposure exposure*gnn;
run;
ods rtf close;
ods html close;
ods html;
************************************************************************************************;

************************************************************************************************;

/*extract DX PX RX data for the cohort*/
data _dat_dx(drop=rc);
if _n_=1 then do;
    declare hash hPATID(dataset:"expo_cohort7", ordered: 'a', multidata:"N");
    rc=hPATID.defineKey("PATID");
    rc=hPATID.defineDone();
end;
set 
UCBSTD.dx_2010
UCBSTD.dx_2011
UCBSTD.dx_2012
UCBSTD.dx_2013
UCBSTD.dx_2014
;
 rc=hPATID.find(key:PATID);
if rc=0;
run;



data _dat_PX(drop=rc);
if _n_=1 then do;
    declare hash hPATID(dataset:"expo_cohort7", ordered: 'a', multidata:"N");
    rc=hPATID.defineKey("PATID");
    rc=hPATID.defineDone();
end;
set 
UCBSTD.PX_2010
UCBSTD.PX_2011
UCBSTD.PX_2012
UCBSTD.PX_2013
UCBSTD.PX_2014
;
 rc=hPATID.find(key:PATID);
if rc=0;
run;


data _dat_RX(drop=rc);
if _n_=1 then do;
    declare hash hPATID(dataset:"expo_cohort7", ordered: 'a', multidata:"N");
    rc=hPATID.defineKey("PATID");
    rc=hPATID.defineDone();
end;
set 
UCBSTD.RX_2010
UCBSTD.RX_2011
UCBSTD.RX_2012
UCBSTD.RX_2013
UCBSTD.RX_2014
;
 rc=hPATID.find(key:PATID);
if rc=0;
run;

************************************************************************************************;

************************************************************************************************;

/*LC*/
/*find the outcome event*/

proc freq data=_dat_dx; tables enc_type;run;
data outcome_all(drop=rc);
length code $18;
if _n_=1 then do;
    declare hash hDX(dataset:"dt.defOutcomes", ordered: 'a', multidata:"N");
    rc=hDX.defineKey("code");
    rc=hDX.defineData("outcomeCategory", "Disease", "code");
    rc=hDX.defineDone();
end;
if 0 then set dt.defOutcomes(keep=outcomeCategory Disease code);
set _dat_dx();
length outcome_date 4;
format outcome_date mmddyy10.;
outcome_date=begin_date ;
rc=hDX.find(key:DX);
if rc=0;
where enc_type in (
'AV'
'ED'
'HH'
'IP'
'NH'
);
run;

ods html close;
ods html ;
proc freq data=outcome_all;
tables Disease enc_type;
run;

proc freq data=dt.Defoutcomes;
tables Disease ;
run;
data 
outcome_Amyloidosis
outcome_AorticInsufficiency
outcome_Pulmonaryfibrosis
outcome_CaudaEquinasyndrome
outcome_ConductionBlock
outcome_CrohnDisease
/*outcome_HematologicCancer*/
outcome_IPinfection
outcome_IgAnephropathy
/*outcome_Interstitiallung*/
/*outcome_Myocardialinfarction*/
outcome_Nephroticsyndrome
/*outcome_NMSC*/
outcome_Psoriasis
outcome_Psoriaticarthritis
outcome_Restrictivelung
/*outcome_SolidCancer*/
outcome_SpinalCord
outcome_UlcerativeColitis
outcome_uveitis
;
set outcome_all;
if disease="Amyloidosis" then output outcome_Amyloidosis;
if disease="Aortic Insufficiency/Aortic Regurgitation" then output outcome_AorticInsufficiency;
if disease="Apical Pulmonary fibrosis" then output outcome_Pulmonaryfibrosis;
if disease="Cauda Equina syndrome" then output outcome_CaudaEquinasyndrome;
if disease="Conduction Block" then output outcome_ConductionBlock;
if disease="Crohn�s Disease" then output outcome_CrohnDisease;
/*if disease="Hematologic Cancer" then output outcome_HematologicCancer;*/
if disease="Hospitalized infection" and enc_type in (
'IP' 
) then output outcome_IPinfection;
if disease="IgA nephropathy" then output outcome_IgAnephropathy;
/*if disease="Interstitial lung disease" then output outcome_Interstitiallung;*/
/*if disease="Myocardial infarction" then output outcome_Myocardialinfarction;*/
if disease="Nephrotic syndrome" then output outcome_Nephroticsyndrome;
/*if disease="Non Melanoma Skin Cancer" then output outcome_NMSC;*/
if disease="Psoriasis" then output outcome_Psoriasis;
if disease="Psoriatic arthritis" then output outcome_Psoriaticarthritis;
if disease='Restrictive lung disease�' then output outcome_Restrictivelung;
/*if disease="Solid Cancer" then output outcome_SolidCancer;*/
if disease="Spinal Cord compression" then output outcome_SpinalCord;
if disease="Ulcerative Colitis" then output outcome_UlcerativeColitis;
if disease="Uveitis" then output outcome_uveitis;
where enc_type in (
'AV' 
'ED' 
'HH' 
'IP' 
'NH' 
);
run;

%let outcome=Psoriaticarthritis;
%macro outcomedata(outcome=Psoriaticarthritis);
proc datasets nolist; delete cohortas_&outcome.1 cohortas_&outcome.; quit;
data cohortas_&outcome.1;
if _n_=1 then do;
    declare hash houtcome(dataset:"outcome_&outcome.", ordered: 'a', multidata:"Y");
    rc=houtcome.defineKey("PATID");
    rc=houtcome.defineData("PATID", "outcome_date");
    rc=houtcome.defineDone();
end;
if 0 then set outcome_&outcome.(keep=PATID outcome_date);
set expo_cohort6;
by patid  indexdate gnn;
retain hx_ot_&outcome. bl_ot_&outcome. outcome_&outcome.;
format outcome_&outcome._date followupenddate mmddyy10.;
if first.gnn then do;
	hx_ot_&outcome.=0 ; bl_ot_&outcome.=0; outcome_&outcome.=0; outcome_&outcome._date=.;
end;
rc=houtcome.find(key:PATID);
if rc^=0 then call missing(outcome_date);	
     do while (rc = 0);
		if .<outcome_date<indexdate then hx_ot_&outcome.=1;
		if .<indexdate-365<=outcome_date<indexdate then bl_ot_&outcome.=1;
		if  .<indexdate<= outcome_date<=min(stop_date-1, enr_end_date, censor_rx-1, DEATH_DATE)  then 
			do;
				outcome_&outcome.=1;
				outcome_&outcome._date=min(outcome_&outcome._date, outcome_date);
			end;
     rc=houtcome.find_next(key:PATID);
 end; 

followupenddate=min(stop_date-1, enr_end_date, censor_rx-1, DEATH_DATE, outcome_&outcome._date);
followupday=followupenddate-indexdate+1;
personyear=followupday/365.25;

run;
proc freq data=cohortas_&outcome.1; 
format outcome_&outcome._date followupenddate year4.;
tables outcome_&outcome.;
run;
proc freq data=cohortas_&outcome.1; 
format outcome_&outcome._date followupenddate year4.;
tables outcome_&outcome.*outcome_&outcome._date*followupenddate/missing list;
run;
proc means data= cohortas_&outcome.1 n nmiss mean std mode min p1 p5 p10 p25 median p75 p90 p95 p99 max;
var followupday ;
run;

data cohortas_&outcome.;
set cohortas_&outcome.1;
by patid  indexdate GNN;
indexgnn=gnn;
%if %upcase(&outcome)^=%upcase(IPinfection) and 
	%upcase(&outcome)^=%upcase(OI) and 
	%upcase(&outcome)^=%upcase(cancer_NMSC) %then %do;
		if hx_OT_&outcome=1 then delete ;
		;;;
%end;
run;
%mend outcomedata;;



%macro rawrate(outcome=Psoriaticarthritis);
proc datasets nolist;
delete
rawrate_&outcome.1
rawrate_&outcome.2
rawrate_&outcome. 
;
quit;
ods trace off;
/*raw rate*/
proc sql;
create table rawrate_&outcome.1 as
select exposure, indexgnn, count(distinct patid) as n_pat, count(*) as n_epi, sum(outcome_&outcome.) as n_event, 
  sum(personyear) as personyear, (calculated n_event/ calculated personyear)*100 as rate100
  from cohortas_&outcome.
  group by exposure, indexgnn
  order by exposure, indexgnn;
quit;
data rawrate_&outcome.1;set rawrate_&outcome.1;
ln_py=log(personyear);
run;
ods select LSMeans;
ods output LSMeans=rawrate_&outcome.2;
proc genmod data=rawrate_&outcome.1;
class indexgnn;
model n_event=indexgnn /offset=ln_py dist=poisson cl;
lsmeans indexgnn / ilink cl;
run;
ods select all;

proc sql;
create table rawrate_&outcome.  as
select "&outcome." as outcome length=50, * from rawrate_&outcome.1 a
join rawrate_&outcome.2(rename=(mu=rawrate LowerMu=LowerCI upperMu=UpperCI)) b
on a.indexgnn=b.indexgnn
order by exposure;
quit;

proc print data=rawrate_&outcome. ;
format n_pat	n_epi	n_event comma8.	 rate100 rawrate LowerCI	UpperCI 8.4;
var exposure indexGNN	n_pat	n_epi	n_event	personyear	rate100	rawrate LowerCI	UpperCI;
run;

%mend rawrate;

%outcomedata;;
%rawrate;


proc sql;
  create table DT.expo_cohort7_UCBSTD as
  select "Marketscan" as database, * from expo_cohort7;
quit;
proc contents data = DT.expo_cohort7_UCBSTD order = varnum;
run;



ods html close;
