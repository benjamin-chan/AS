/* 
Fenglong's macro to define the AS cohort
 */

%macro AScohort(stdLib=,
                specialty=,                           
                enrData=,
                        demoData=
                );
proc sql;
create table oneDX&stdLib as
select distinct patid,min(BEGIN_DATE) as ASdate format=mmddyy10. label=' '
from DX7200&stdLib
group by patid;

create table oneDXEnr&stdLib as
select a.*,b.ENR_START_DATE,b.ENR_END_DATE
from oneDX&stdLib as a
      left join
      &stdLib..&enrData as b
on a.patid=b.patid
order by patid,ENR_START_DATE;

data oneDX183&stdLib(label="One patient could have multipple episodes");
set oneDXEnr&stdLib;
AScohortDate=max(ENR_START_DATE+183,ASdate);
if AScohortDate<=ENR_END_DATE;
format AScohortDate mmddyy10.;
run;

%if "&stdLib" ="stdmpcd" %then %do; 
data work.oneDX183&stdLib._demo(label="One patient could have multipple episodes");
merge  oneDX183&stdLib(in=a)
       &stdLib..&demoData(keep=patid SEX DEATH_DATE);
by patid;
if a;
run;

proc sql;
create table oneDX183&stdLib._demo as
select a.*,b.age
from work.oneDX183&stdLib._demo as a
     left join
       ageCstdmpcd as b
on a.patid=b.patid and 
   a.ASdate=b.BEGIN_DATE;
%end;
%else %do; 
data oneDX183&stdLib._demo(label="One patient could have multipple episodes");
merge  oneDX183&stdLib(in=a)
       &stdLib..&demoData(keep=patid SEX BIRTH_DATE DEATH_DATE);
by patid;
if a;
age=int((ASDate-BIRTH_DATE)/365.25);
run;
%end;

data rheuDX7200&stdLib;
set DX7200&stdLib;
if PROV_TYPE=&specialty or enc_type='IP';
run;

proc sql;
create table oneRheuDX&stdLib as
select distinct patid,min(BEGIN_DATE) as ASdate format=mmddyy10. label=' '
from rheuDX7200&stdLib
group by patid;

create table oneRheuDXEnr&stdLib as
select a.*,b.ENR_START_DATE,b.ENR_END_DATE
from oneRheuDX&stdLib as a
      left join
      &stdLib..&enrData as b
on a.patid=b.patid
order by patid,ENR_START_DATE;

data oneRheuDX183&stdLib(label="One patient could have multipple episodes");
set oneRheuDXEnr&stdLib;
AScohortDate=max(ENR_START_DATE+183,ASdate);
if AScohortDate<=ENR_END_DATE;
format AScohortDate mmddyy10.;
run;

%if "&stdLib" ="stdmpcd" %then %do; 
data work.oneRheuDX183&stdLib._demo(label="One patient could have multipple episodes");
merge  oneRheuDX183&stdLib(in=a)
       &stdLib..&demoData(keep=patid SEX DEATH_DATE);
by patid;
if a;
run;

proc sql;
create table oneRheuDX183&stdLib._demo as
select a.*,b.age
from work.oneRheuDX183&stdLib._demo as a
     left join
       ageCstdmpcd as b
on a.patid=b.patid and 
   a.ASdate=b.BEGIN_DATE;
%end;
%else %do; 
data oneRheuDX183&stdLib._demo(label="One patient could have multipple episodes");
merge  oneRheuDX183&stdLib(in=a)
       &stdLib..&demoData(keep=patid SEX BIRTH_DATE DEATH_DATE);
by patid;
if a;
age=int((ASDate-BIRTH_DATE)/365.25);
run;
%end;

proc sql;
create table twoRheuDX&stdLib as
select a.*,b.BEGIN_DATE as ASDate format=mmddyy10. label=' '
from rheuDX7200&stdLib as a
      ,
      rheuDX7200&stdLib as b
where a.patid=b.patid and
      a.BEGIN_DATE+7<=b.BEGIN_DATE<=a.BEGIN_DATE+365
order by patid,ASDate;

data twoRheuDX&stdLib;
set twoRheuDX&stdLib;
by patid ASDate;
if first.patid;
keep patid ASDate;
run;

proc sql;
create table twoRheuDXEnr&stdLib as
select a.*,b.ENR_START_DATE,b.ENR_END_DATE
from twoRheuDX&stdLib as a
      left join
      &stdLib..&enrData as b
on a.patid=b.patid
order by patid,ENR_START_DATE;
quit;

data twoRheuDX183&stdLib(label="One patient could have multipple episodes");
set twoRheuDXEnr&stdLib;
AScohortDate=max(ENR_START_DATE+183,ASdate);
if AScohortDate<=ENR_END_DATE;
format AScohortDate mmddyy10.;
run;

%if "&stdLib" = "stdmpcd" %then %do; 
data work.twoRheuDX183&stdLib._demo(label="One patient could have multipple episodes");
merge  twoRheuDX183&stdLib(in=a)
       &stdLib..&demoData(keep=patid SEX DEATH_DATE);
by patid;
if a;
run;

proc sql;
create table twoRheuDX183&stdLib._demo as
select a.*,b.age
from work.twoRheuDX183&stdLib._demo as a
     left join
       ageCstdmpcd as b
on a.patid=b.patid and 
   a.ASdate=b.BEGIN_DATE;
%end;
%else %do; 
data twoRheuDX183&stdLib._demo(label="One patient could have multipple episodes");
merge  twoRheuDX183&stdLib(in=a)
       &stdLib..&demoData(keep=patid SEX BIRTH_DATE DEATH_DATE);
by patid;
if a;
age=int((ASDate-BIRTH_DATE)/365.25);
run;
%end;

proc sql;
title "&stdLib";
title2 "Patient with at least one DX (any enctype:IF OT etc )for AS";
select count(distinct patid) as number
from allDX7200&stdLib;
title2 "Patient with at least one DX for AS";
select count(distinct patid) as number
from DX7200&stdLib;
title2 "Patient with at least one DX from rheu for AS";
select count(distinct patid) as number
from oneRheuDX&stdLib;
title2 "Patient with at least one DX from rheu for AS and 183 days observable";
select count(distinct patid) as number          
from oneRheuDX183&stdLib;
title2 "Patient with at least one DX from rheu for AS and 183 days observable and >=20 at AS date";
select count(distinct patid) as number        
from oneRheuDX183&stdLib._demo
where age>=20;
title2 "Patient with at least one DX from rheu for AS and 183 days observable, >=20 at AS date and with>=30 days follow up";
select count(distinct patid) as number
from oneRheuDX183&stdLib._demo
where age>=20 and enr_end_date-AScohortDate>=30;

title2 "Patient with at least two DX from rheu for AS";
select count(distinct patid) as number 
from twoRheuDX&stdLib;
title2 "Patient with at least two DX from rheu for AS and 183 days observable";
select count(distinct patid) as number 
from twoRheuDX183&stdLib;
title2 "Patient with at least two DX from rheu for AS and 183 days observable and >=20 at AS date";
select count(distinct patid) as number
from twoRheuDX183&stdLib._demo
where age>=20;
title2 "Patient with at least two DX from rheu for AS and 183 days observable, >=20 at AS date and with>=30 days follow up";
select count(distinct patid) as number
from twoRheuDX183&stdLib._demo
where age>=20 and enr_end_date-AScohortDate>=30;
title ' ';
title2 ' ';

data cohortA&stdLib;
set oneRheuDX183&stdLib._demo;
if age>=20;
indexDate=AScohortDate;
format indexdate mmddyy10.;
run;

proc sort data=cohortA&stdLib;
by patid indexdate;
run;

data cohortA&stdLib;
set cohortA&stdLib;
by patid indexdate;
if first.patid;
run;
%mend;
