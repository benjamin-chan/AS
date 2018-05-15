/* 
Fenglong's macro to define exposure cohorts
 */

%macro expo(source=,cohort0=,stdLib=,enrData=);
proc sql;
create table allBIO1st&source as
select distinct patid,min(DISPENSE_DATE) as allBio1st format=mmddyy10. label=' '
from Bio&source
group by patid;

create table BIO1st&source as
select distinct patid,GNN as indexGNN,min(DISPENSE_DATE) as Bio1st format=mmddyy10. label=' '
from Bio&source
group by patid,indexGNN;

create table TNF1st&source as
select distinct patid,GNN as indexGNN,min(DISPENSE_DATE) as TNF1st format=mmddyy10. label=' '
from TNF&source
group by patid,indexGNN;

create table allDmard1st&source as
select distinct patid,min(DISPENSE_DATE) as allDmard1st format=mmddyy10. label=' '
from Dmard&source
group by patid;

create table Dmard1st&source as
select distinct patid,GNN as indexGNN,min(DISPENSE_DATE) as Dmard1st format=mmddyy10. label=' '
from Dmard&source
group by patid,indexGNN;

create table allNsaid1st&source as
select distinct patid,min(DISPENSE_DATE) as allNsaid1st format=mmddyy10. label=' '
from Nsaid&source
group by patid;

create table Nsaid1st&source as
select distinct patid,GNN as indexGNN,min(DISPENSE_DATE) as Nsaid1st format=mmddyy10. label=' '
from Nsaid&source
group by patid,indexGNN;

create table ASBio0Cohort&source as
select a.*,b.indexGNN,b.Bio1st as indexDate format=mmddyy10.
from &cohort0(drop=enr_start_date enr_end_date) as a
      ,
     BIO1st&source as b
where a.patid=b.patid and
      a.ASdate<=b.Bio1st 
order by patid,indexDate,indexGNN;


create table ASBioCohort&source as
select a.*,b.enr_start_date,b.enr_end_date
from ASBio0Cohort&source as a
      ,
     &stdLib..&enrData as b
where a.patid=b.patid and
      b.enr_start_date+183<=a.indexDate<=b.enr_end_date
order by patid,indexDate,indexGNN;

create table ASTNF0Cohort&source as
select a.*,b.indexGNN,b.TNF1st as indexDate format=mmddyy10.
from &cohort0(drop=enr_start_date enr_end_date) as a
      ,
     TNF1st&source as b
where a.patid=b.patid and
      a.ASdate<=b.TNF1st
order by patid,indexDate,indexGNN;

create table ASTNFCohort&source as
select a.*,b.enr_start_date,b.enr_end_date
from ASTNF0Cohort&source as a
      ,
     &stdLib..&enrData as b
where a.patid=b.patid and
      b.enr_start_date+183<=a.indexDate<=b.enr_end_date
order by patid,indexDate,indexGNN;


create table ASDmard0Cohort&source as
select a.*,b.indexGNN,b.Dmard1st as indexDate format=mmddyy10.
from &cohort0(drop=enr_start_date enr_end_date) as a
      ,
     Dmard1st&source as b
where a.patid=b.patid and
      a.ASdate<=b.Dmard1st      
order by patid,indexDate,indexGNN; 

create table ASDmardCohort&source as
select a.*,b.indexGNN,b.Dmard1st as indexDate format=mmddyy10.
from ASDmard0Cohort&source as a
      ,
     &stdLib..&enrData as b
where a.patid=b.patid and
      b.enr_start_date+183<=a.indexDate<=b.enr_end_date 
order by patid,indexDate,indexGNN; 

create table ASNsaid0Cohort&source as
select a.*,b.indexGNN,b.Nsaid1st as indexDate format=mmddyy10.
from &cohort0(drop=enr_start_date enr_end_date) as a
      ,
     Nsaid1st&source as b
where a.patid=b.patid and
      a.ASdate<=b.Nsaid1st 
order by patid,indexDate,indexGNN; 

create table ASNsaidCohort&source as
select a.*,b.indexGNN,b.Nsaid1st as indexDate format=mmddyy10.
from ASNsaid0Cohort&source as a
      ,
     Nsaid1st&source as b
where a.patid=b.patid and
      b.enr_start_date+183<=a.indexDate<=b.enr_end_date  
order by patid,indexDate,indexGNN;

data ASNoExpCohort0&source;
set cohortA&source;
indexGNn='NoExp';
indexDate=AScohortDate;
format indexdate mmddyy10.;
run;

proc sql;
create table Biocen4Bio&source as
select a.Patid,a.indexdate,a.indexGNN,b.DISPENSE_DATE as Cen1 format=mmddyy10.
from ASBioCohort&source as a
      ,
      Bio&source as b
where a.patid=b.patid and
      a.indexDate<=b.DISPENSE_DATE<=a.enr_end_date and
      a.indexGNn ne b.GNN
order by patid,indexDate,indexGNN,cen1;

create table Biocen4TNF&source as
select a.Patid,a.indexdate,a.indexGNN,b.DISPENSE_DATE as Cen1 format=mmddyy10.
from ASTNFCohort&source as a
      ,
      Bio&source as b
where a.patid=b.patid and
      a.indexDate<=b.DISPENSE_DATE<=a.enr_end_date and
      a.indexGNn ne b.GNN
order by patid,indexDate,indexGNN,cen1;

create table Biocen4DMARD&source as
select a.Patid,a.indexdate,a.indexGNN,b.DISPENSE_DATE as Cen1 format=mmddyy10.
from ASDMARDCohort&source as a
      ,
      Bio&source as b
where a.patid=b.patid and
      a.indexDate<=b.DISPENSE_DATE<=a.enr_end_date
order by patid,indexDate,indexGNN,cen1;

create table Biocen4NSAID&source as
select a.Patid,a.indexdate,a.indexGNN,b.DISPENSE_DATE as Cen1 format=mmddyy10.
from ASNSAIDCohort&source as a
      ,
      Bio&source as b
where a.patid=b.patid and
      a.indexDate<=b.DISPENSE_DATE<=a.enr_end_date
order by patid,indexDate,indexGNN,cen1;

create table Biocen4NoExp&source as
select a.Patid,a.indexdate,a.indexGNN,b.DISPENSE_DATE as Cen1 format=mmddyy10.
from ASNoExpCohort0&source as a
      ,
      Bio&source as b
where a.patid=b.patid and
      a.indexDate<=b.DISPENSE_DATE<=a.enr_end_date
order by patid,indexDate,indexGNN,cen1;

create table Dmardcen4NSAID&source as
select a.Patid,a.indexdate,a.indexGNN,b.DISPENSE_DATE as Cen2 format=mmddyy10.
from ASNSAIDCohort&source as a
      ,
      Dmard&source as b
where a.patid=b.patid and
      a.indexDate<=b.DISPENSE_DATE<=a.enr_end_date
order by patid,indexDate,indexGNN,cen2;

create table DMARDcen4NoExp&source as
select a.Patid,a.indexdate,a.indexGNN,b.DISPENSE_DATE as Cen2 format=mmddyy10.
from ASNoExpCohort0&source as a
      ,
      DMARD&source as b
where a.patid=b.patid and
      a.indexDate<=b.DISPENSE_DATE<=a.enr_end_date
order by patid,indexDate,indexGNN,cen2;

create table NSAIDcen4NoExp&source as
select a.Patid,a.indexdate,a.indexGNN,b.DISPENSE_DATE as Cen3 format=mmddyy10.
from ASNoExpCohort0&source as a
      ,
      NSAID&source as b
where a.patid=b.patid and
      a.indexDate<=b.DISPENSE_DATE<=a.enr_end_date
order by patid,indexDate,indexGNN,cen3;

data Biocen4Bio&source;
set Biocen4Bio&source;
by  patid indexDate indexGNN cen1;
if first.indexGNN;
run;

data Biocen4TNF&source;
set Biocen4TNF&source;
by  patid indexDate indexGNN cen1;
if first.indexGNN;
run;

data Biocen4DMARD&source;
set Biocen4DMARD&source;
by  patid indexDate indexGNN cen1;
if first.indexGNN;
run;

data Biocen4NoExp&source;
set Biocen4NoExp&source;
by  patid indexDate indexGNN cen1;
if first.indexGNN;
run;

data Dmardcen4NSAID&source;
set Dmardcen4NSAID&source;
by  patid indexDate indexGNN cen2;
if first.indexGNN;
run;

data DMARDcen4NoExp&source;
set DMARDcen4NoExp&source;
by  patid indexDate indexGNN cen2;
if first.indexGNN;
run;

data NSAIDcen4NoExp&source;
set NSAIDcen4NoExp&source;
by  patid indexDate indexGNN cen3;
if first.indexGNN;
run;

data ASBioCohort&source._ex1;
merge ASBioCohort&source
      Biocen4Bio&source;
by patid indexDate indexGNN;
obs_end=min(enr_end_date,Cen1-1,DEATH_DATE);
if indexDate>obs_end then delete;
drop cen1;
format obs_end mmddyy10.;
run;

data ASTNFCohort&source._ex1;
merge ASTNFCohort&source
      Biocen4TNF&source   ;
by patid indexDate indexGNN;
obs_end=min(enr_end_date,Cen1-1,DEATH_DATE);
if indexDate>obs_end then delete;
drop cen1;
format obs_end mmddyy10.;
run;

data ASDmardCohort&source._ex1;
merge ASDmardCohort&source(in=a)
      allBIO1st&source(in=b);
by patid;
if a;
obs_end=min(enr_end_date,DEATH_DATE);
if .<allBio1st<=indexDate or indexDate>obs_end then delete;
run;

data ASDmardCohort&source._ex1;
merge ASDmardCohort&source._ex1(in=a)      
      Biocen4DMARD&source;
by patid indexDate indexGNN ;
if a;
obs_end=min(obs_end,Cen1-1);
if indexDate>obs_end then delete;
drop cen1;
format obs_end mmddyy10.;
run;

data ASNsaidCohort&source._ex1;
merge ASNsaidCohort&source(in=a)
      allBIO1st&source(in=b)
      allDMARD1st&source(in=c);
by patid;
if a;
obs_end=min(enr_end_date,DEATH_DATE);
if .<allBio1st<=indexDate or .<allDmard1st<=indexDate or indexDate>obs_end then delete;
run;

data ASNsaidCohort&source._ex1;
merge ASNsaidCohort&source._ex1(in=a)      
      Biocen4NSAID&source
      Dmardcen4NSAID&source
      ;
by patid indexDate indexGNN ;
if a;
obs_end=min(obs_end,Cen1-1,Cen2-1);
if indexDate>obs_end then delete;
drop cen1 Cen2;
format obs_end mmddyy10.;
run;


data ASNoBDCohort&source._ex1;
merge ASNoExpCohort0&source(in=a)
      allBio1st&source 
      allDmard1st&source
      ;
by patid;
if a;
obs_end=min(enr_end_date,DEATH_DATE);
if .<allBio1st<=indexDate or .<allDmard1st<=indexDate or indexDate>obs_end then delete;
run;

data ASNoBDCohort&source._ex1;
merge ASNoBDCohort&source._ex1(in=a)
      Biocen4NoExp&source
      DMARDcen4NoExp&source;
by patid indexdate indexGNN;
if a;
obs_end=min(obs_end,Cen1-1,Cen2-1);
if indexDate>obs_end then delete;
drop cen1 cen2;
format obs_end mmddyy10.;
run;

proc sort data=ASNoBDCohort&source._ex1;
by patid indexdate;
run;

data ASNoBDCohort&source._ex1;
set ASNoBDCohort&source._ex1;
by patid indexDate;
if first.patid;
run;

data ASNoExpCohort&source._ex1;
merge ASNoExpCohort0&source(in=a)
      allBio1st&source 
      allDmard1st&source
      allNsaid1st&source
      ;
by patid;
if a;
obs_end=min(enr_end_date,DEATH_DATE);
if .<allBio1st<=indexDate or .<allDmard1st<=indexDate or .<allNsaid1st<=indexDate or
   indexDate>obs_end then delete;
run;

data ASNoExpCohort&source._ex1;
merge ASNoExpCohort&source._ex1(in=a)
      Biocen4NoExp&source
      DMARDcen4NoExp&source
      NSAIDcen4NoExp&source;
by patid indexdate indexGNN;
if a;
obs_end=min(obs_end,Cen1-1,Cen2-1, Cen3-1);
if indexDate>obs_end then delete;
drop cen1 cen2 cen3;
format obs_end mmddyy10.;
run;


proc sort data=ASNoExpCohort&source._ex1;
by patid indexdate;
run;

data ASNoExpCohort&source._ex1;
set ASNoExpCohort&source._ex1;
by patid indexDate;
if first.patid;
run;

proc sql;
create table Bioexc6mDMARD&source as
select a.Patid,a.indexdate,a.indexGNn
from ASDmardCohort&source as a
      ,
      Bio&source as b
where a.patid=b.patid and
      a.indexDate-183<=b.DISPENSE_DATE<=a.indexDate
order by patid,indexDate,indexGNN;

create table Bioexc6mNSAID&source as
select a.Patid,a.indexdate,a.indexGNn
from ASNsaidCohort&source as a
      ,
      Bio&source as b
where a.patid=b.patid and
      a.indexDate-183<=b.DISPENSE_DATE<=a.indexDate
order by patid,indexDate,indexGNN;

create table Bioexc6mNoExp&source as
select a.Patid,a.indexdate,a.indexGNN
from ASNoExpCohort0&source as a
      ,
      Bio&source as b
where a.patid=b.patid and
      a.indexDate-183<=b.DISPENSE_DATE<=a.indexDate
order by patid,indexDate,indexGNN;


create table Dmardexc6mNSAID&source as
select a.Patid,a.indexdate,a.indexGNN
from ASNSAIDCohort&source as a
      ,
      Dmard&source as b
where a.patid=b.patid and
      a.indexDate-183<=b.DISPENSE_DATE<=a.indexDate
order by patid,indexDate,indexGNN;


create table Dmardexc6mNoExp&source as
select a.Patid,a.indexdate,a.indexGNN
from ASNoExpCohort0&source as a
      ,
      Dmard&source as b
where a.patid=b.patid and
      a.indexDate-183<=b.DISPENSE_DATE<=a.indexDate
order by patid,indexDate,indexGNN;

create table Nsaidexc6mNoExp&source as
select a.Patid,a.indexdate,a.indexGNN
from ASNoExpCohort0&source as a
      ,
      Nsaid&source as b
where a.patid=b.patid and
      a.indexDate-183<=b.DISPENSE_DATE<=a.indexDate
order by patid,indexDate,indexGNN;
quit;

data ASDmardCohort&source._ex2;
merge ASDmardCohort&source(in=a)
      Bioexc6mDMARD&source(in=b)
      Biocen4DMARD&source;
by patid indexDate indexGNN;
if a;
obs_end=min(enr_end_date,Cen1-1,DEATH_DATE);
if b or indexDate>obs_end then delete;
drop cen1;
format obs_end mmddyy10.;
run; 

data ASNsaidCohort&source._ex2;
merge ASNsaidCohort&source(in=a)
      Bioexc6mNSAID&source(in=b)
      Dmardexc6mNSAID&source(in=c)
      Biocen4NSAID&source
      Dmardcen4NSAID&source;
by patid indexDate indexGNN;
if a;
obs_end=min(enr_end_date,Cen1-1,cen2-1,DEATH_DATE);
if b or c or indexDate>obs_end then delete;
drop cen1 cen2;
format obs_end mmddyy10.;
run; 

data ASNoBDCohort&source._ex2;
merge ASNoExpCohort0&source(in=a)
      Bioexc6mNoExp&source(in=b)
      Dmardexc6mNoExp&source(in=c)
      Biocen4NoExp&source
      DMARDcen4NoExp&source
;
by patid;
if a;
obs_end=min(enr_end_date,cen1-1,cen2-1,DEATH_DATE);
if b or c  or indexDate>obs_end then delete;
drop cen1 cen2;
format obs_end mmddyy10.;
run;

proc sort data=ASNoBDCohort&source._ex2;
by patid indexdate;
run;

data ASNoBDCohort&source._ex2;
set ASNoBDCohort&source._ex2;
by patid indexDate;
if first.patid;
run;

data ASNoExpCohort&source._ex2a;
merge ASNoExpCohort0&source(in=a)      
      Biocen4NoExp&source
      DMARDcen4NoExp&source
      NSAIDcen4NoExp&source;
by patid;
if a;
obs_end=min(enr_end_date,cen1-1,cen2-1,cen3-1,DEATH_DATE);
if indexDate>obs_end then delete;
drop cen1 cen2 cen3;
format obs_end mmddyy10.;
run;


data ASNoExpCohort&source._ex2;
merge ASNoExpCohort0&source2a(in=a)
      Bioexc6mNoExp&source(in=b)
      Dmardexc6mNoExp&source(in=c)
      Nsaidexc6mNoExp&source(in=d)
     ;
by patid;
if a;
if b or c  or d then delete;
run;

proc sort data=ASNoExpCohort&source._ex2;
by patid indexdate;
run;

data ASNoExpCohort&source._ex2;
set ASNoExpCohort&source._ex2;
by patid indexDate;
if first.patid;
run;

proc sql;
title "&source";
title2 "Patient with at least one initiation for biologic after AS date";
select count(distinct patid) as number
from ASBio0Cohort&source;

title2 "Patient with at least one initiation for biologic after AS date and with 183 days observable";
select count(distinct patid) as number
from ASBioCohort&source._ex1;

title2 "Patient with at least one initiation for TNFi after AS date";
select count(distinct patid) as number
from ASTNF0Cohort&source;

title2 "Patient with at least one initiation for TNFi after AS date and with 183 days observable";
select count(distinct patid) as number
from ASTNFCohort&source._ex1;

title2 "Patient with at least one initiation for DMARD after AS date";
select count(distinct patid) as number
from ASDmard0Cohort&source;

title2 "Patient with at least one initiation for DMARD after AS date and with 183 days observable";
select count(distinct patid) as number
from ASDmardCohort&source;

title2 "Patient with at least one initiation for DMARD after AS date and with 183 days observable and no biologic before DMARD";
select count(distinct patid) as number       
from ASDmardCohort&source._ex1;

title2 "Patient with at least one initiation for DMARD after AS date and with 183 days observable and no biologic within 6 month before DMARD";
select count(distinct patid) as number       
from ASDmardCohort&source._ex2;

title2 "Patient with at least one initiation for NSAID after AS date";
select count(distinct patid) as number
from ASNsaid0Cohort&source;

title2 "Patient with at least one initiation for NSAID after AS date and with 183 days observable";
select count(distinct patid) as number
from ASNsaidCohort&source;

title2 "Patient with at least one initiation for NSAID after AS date and with 183 days observable and no biologic no DMARD before Nsaid";
select count(distinct patid) as number       
from ASNsaidCohort&source._ex1;

title2 "Patient with at least one initiation for NSAID after AS date and with 183 days observable and no biologic, no DMARD within 6 month before Nsaids";
select count(distinct patid) as number       
from ASNsaidCohort&source._ex2;


title2 "Patient with no biologic, no dmard after index date and no biologic no DMARD before index date";
select count(distinct patid) as number       
from ASNoBDCohort&source._ex1;

title2 "Patient with no Biologic, no Dmard after index date and no biologic no DMARD within 6 month before index date";
select count(distinct patid) as number       
from ASNoBDCohort&source._ex2;

title2 "Patient with no exposure after index date and exposure before index date";
select count(distinct patid) as number       
from ASNoExpCohort&source._ex1;

title2 "Patient with no exposure at index date";
select count(distinct patid) as number       
from ASNoExpCohort&source._ex2a;

title2 "Patient with no exposure after index date and no exposure within 6 month before index date";
select count(distinct patid) as number       
from ASNoExpCohort&source._ex2;
%mend;

/* 
ods html file="Q:\shared\users\fxie\RTF result\AS comorbidity\&sysdate exposure chart.html";
%expo(source=stducb,cohort0=Onerheudx183stducb_demo,stdLib=stducb,enrData=enroll)
%expo(source=stdmpcd,cohort0=Onerheudx183stdmpcd_demo,stdLib=stdmpcd,enrData=enroll)
%expo(source=std_sabr,cohort0=Onerheudx183std_sabr_demo,stdLib=std_sabr,enrData=Std_enrollment)
ods html close;
 */
