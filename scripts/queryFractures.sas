*  University of Alabama at Birmingham                               *
*  AS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=queryFractures; * type the name of your program here (without the filename extension);
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
FRACTURES

See "ALGORITHMS TO ENHANCE SPECIFICITY OF FRACTURE IDENTIFICATION_ 100316.docx"

Adapted from Lang's code in "001_fx_data.sas"
 */


proc sql;

  %let select1 = select A.*, 
                        B.enc_type, B.admit_date, B.begin_date, B.discharge_date, B.end_date, B.dx_type, B.dx, B.pdx, "ICD9-DX" as codeType, B.dx as code,
                        B.diagCodeType;
  %let on1 = on (A.patid = B.patid);
  %let select2 = select patid, enc_type, admit_date, begin_date, discharge_date, end_date, dx_type, dx, pdx,
                        case
                          when '800' <= substr(dx, 1, 3) <= '829' or substr(dx, 1, 4) = '7331' then "DX fx claim"
                          when substr(dx, 1, 4) in ('V541' 'V542') then "DX extend care claim"
                          when 'E800' <= substr(dx, 1, 4) <= 'E848' or 
                               'E881' <= substr(dx, 1, 4) <= 'E884' or 
                               'E908' <= substr(dx, 1, 4) <= 'E909' or 
                               'E916' <= substr(dx, 1, 4) <= 'E928' 
                            then "Only keeping patid and claim_date for the Trauma M2M Macro Later"
                          else ""
                          end as diagCodeType;
  %let where2 = where dx_type = "09" & ^missing(calculated diagCodeType);
  %let selectfrom3 = select * from DT.indexLookup;
  create table UCB.tempFracDxMPCD as
    &select1 from (&selectfrom3 where database = "MPCD") A inner join (&select2 from MPSTD.DX_07_10 &where2) B &on1;
  create table UCB.tempFracDxUCB as
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.DX_2010 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.DX_2011 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.DX_2012 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.DX_2013 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.DX_2014 &where2) B &on1 ;
  create table UCB.tempFracDxSABR as
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2006    &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2007    &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2008_V2 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2009    &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2010    &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2011    &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2012    &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2013    &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2014    &where2) B &on1 ;

quit;




proc sql;
  drop table UCB.tempFracDxMPCD;
  drop table UCB.tempFracDxUCB;
  drop table UCB.tempFracDxSABR;
quit;


proc export
  data = Work.prev
  outfile = "data\processed\&cmt..csv"
  dbms = csv
  replace;
  delimiter = ",";
run;


ods html close;
