/*all the claims to define episode sequence */
data _dat0(keep=
PATID ENCOUNTERID ADMIT_DATE DISCHARGE_DATE BEGIN_DATE END_DATE DX DX_TYPE PDX  SOURCE ENC_TYPE fx_site px px_date
site cq spine_image trauma_date trauma );
set fx_dgns_&firstyr._&lastyr._4 fx_excare_&firstyr._&lastyr Fx_prcd(rename=tx_site=fx_site);
run;
proc sort data=_dat0; by PATID fx_site BEGIN_DATE END_DATE; run;
/*for each claim define start and end date applicable to IP NH and NH*/
data _dat1;
set _dat0;
length start_date end_date 4;
format start_date end_date mmddyy10.;
by PATID fx_site BEGIN_DATE END_DATE; 
start_date=min(ADMIT_DATE, BEGIN_DATE);
end_date=max(DISCHARGE_DATE, End_DATE);
run;
proc sort data=_dat1; by PATID fx_site start_date end_date; run;

/* generate unique episode sequence ID */
data _dat2(drop=end_date_max lag_end_date_max _gap);
set _dat1;
length lag_end_date_max end_date_max 4;
format lag_end_date_max end_date_max mmddyy10.;

by PATID fx_site start_date end_date; 
retain seq 0;

/*if current claims end date > all previouse claim end date in sequence, then update*/
end_date_max=max(end_date,end_date_max); 
lag_end_date_max=lag(end_date_max);

if first.fx_site then lag_end_date_max=.;
_gap=start_date-lag_end_date_max;

/*if current claims start date >90 days after all previouse claim end date in sequence,
then start new sequence*/
if first.fx_site or start_date-lag_end_date_max>90 then do;
    end_date_max=end_date;

    seq+1;
end;
run;
proc sort data=_dat2; by seq;run;
proc sql;
/*episode sequence start date*/
create table seq_start as 
select patid, seq, min(start_date) as seq_start_date length=4 format=mmddyy10.
 from _dat2
 where substr(dx,1,4) not in ('V541' 'V542')
 group by patid, seq
 order by patid, seq;
/*episode sequence end date*/
create table seq_end as 
select patid, seq, 
 max(start_date) as seq_end_date length=4 format=mmddyy10. from _dat2
 group by patid, seq
 order by patid, seq;
quit;
/*episode sequence case qualifier indicator and trauma*/
data seq_cq(keep=patid seq seq_cq seq_trauma fx_site);
set _dat2;
by patid seq;
length seq_cq $4 seq_trauma $1;
retain seq_cq seq_trauma;
if first.seq then do;
    seq_cq="0000";
    seq_trauma="0";
end;
if trauma="1" then seq_trauma=trauma;
do i=1 to 4;
if substr(cq,i,1)>substr(seq_cq,i,1) then substr(seq_cq,i,1)=substr(cq,i,1);
end;
if last.seq then output;
run;
proc freq data=seq_cq; tables seq_cq seq_trauma fx_site; run;

data seq_cq_date;
merge seq_cq seq_start seq_end;
by patid seq;
length site_order $1;
if fx_site='(820, 73314) hip' then site_order='1';
if fx_site='(821, 73315) femur' then site_order='2';
if fx_site='(808) pelvis' then site_order='3';
if fx_site='(805, 806, 73313) spine' then site_order='4';
if fx_site='(812, 73311) humerus' then site_order='5';
if fx_site='(813, 73312) radius_ulna' then site_order='6';
if fx_site='(823, 73316) tib_fib' then site_order='7';
if fx_site='(824) ankle' then site_order='8';
if fx_site='(810) clavicle' then site_order='9';
run;

data _tmp_combo;
set seq_cq_date;
where site_order^=" " and seq_cq^="0000" and seq_cq^=" ";
run;

* define combo or alone fx;
data seq_COMBO(
keep=patid seq seq_cq seq_start_date alone_combo fx_site site_order)
;
if _n_=1 then do;
    declare hash hpid(dataset:"_tmp_combo(where=(seq_cq^='0000' and seq_cq^=' ') 
            rename=(seq_start_date=seq_start_date2  fx_site= fx_site_combo seq=seq_COMBO))", ordered: 'a', multidata:"Y");
    rc=hpid.defineKey("patid");
    rc=hpid.defineData("patid","seq_start_date2", "fx_site_combo", "seq_COMBO");
    rc=hpid.defineDone();
end;
if 0 then set _tmp_combo(rename=(seq_start_date=seq_start_date2 fx_site= fx_site_combo seq=seq_COMBO));
set _tmp_combo(where=(seq_cq^="0000" and seq_cq^=" ") );
by patid seq;
length  index_fx_begin 4 alone_combo $5;
alone_combo="alone";
    format index_fx_begin mmddyy10.;
    index_fx_begin=seq_start_date;

 rc=hpid.find(key:patid);

 do while (rc = 0);
 if rc=0 and abs(seq_start_date-seq_start_date2) <=30 and fx_site_combo^=fx_site then alone_combo= 'combo';
 rc=hpid.find_next();
 *hpid.has_next(result:r);
end;
if alone_combo="alone" then do;
    seq_start_date2=.; fx_site_combo=" "; seq_COMBO=.;
end;
run;
proc freq data=seq_COMBO; tables alone_combo; run;

data combo_seq;
set seq_COMBO;
by patid seq_start_date;
length combo_fx_site $30. combo_seq 4;
retain combo_seq 0 combo_fx_site;
if first.patid or seq_start_date-lag(seq_start_date) then combo_seq=1+combo_seq;
where seq_cq^='0000' and seq_cq^=' ';
if combo_fx_site=" " or ""<site_order<lag(site_order) then combo_fx_site=fx_site;
run;

data FX_CLM_DB_&firstyear._&lastyear.;
merge _dat2 seq_start seq_end seq_cq(drop=fx_site) seq_COMBO(keep=patid seq alone_combo);
by patid seq;
run;

proc sql;
select count(distinct seq) from FX_CLM_DB_&firstyear._&lastyear.;
quit;








