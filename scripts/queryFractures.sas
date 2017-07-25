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
                        B.encounterID, B.enc_type, B.admit_date, B.begin_date, B.discharge_date, B.end_date, B.dx_type, B.dx, B.pdx, "ICD9-DX" as codeType, B.dx as code,
                        B.diagCodeType;
  %let on1 = on (A.patid = B.patid);
  %let select2 = select patid, encounterID, enc_type, admit_date, begin_date, discharge_date, end_date, dx_type, dx, pdx,
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


/*Assign "Broad" fracture site (fx_site) for all ICD9 diagnoses, outputting separately, so some records are cloned, then combining into one file */
/*No longer using matched trauma files here*/

%macro comballfxdgns;
    data fx_dgns;
        set UCB.tempFracDxMPCD (where = (diagCodeType = "DX fx claim"))
            UCB.tempFracDxUCB (where = (diagCodeType = "DX fx claim"))
            UCB.tempFracDxSABR (where = (diagCodeType = "DX fx claim"));
            length fx_site $30 ;
            fx_site = '';
            if strip(DX) in: ('800' '801' '802' '803' '804') then           do; fx_site='(800-804) skull/face'; output; end;
            if strip(DX) in: ('805', '806') or strip(DX)='73313' then       do; fx_site='(805, 806, 73313) spine'; output; end;
            if strip(DX) in: ('807') then                                           do; fx_site='(807) rib/sternum/trachea'; output; end;
            if strip(DX) in: ('808') then                                           do; fx_site='(808) pelvis'; output; end;
            if strip(DX) in: ('809') then                                           do; fx_site='(809) trunk bones'; output; end;
            if strip(DX) in: ('810') then                                           do; fx_site='(810) clavicle'; output; end;
            if strip(DX) in: ('811') then                                           do; fx_site='(811) scapula'; output; end;
            if strip(DX) in: ('812') or strip(DX)='73311' then              do; fx_site='(812, 73311) humerus'; output; end;
            if strip(DX) in: ('813') or strip(DX)='73312' then              do; fx_site='(813, 73312) radius_ulna'; output; end;
            if strip(DX) in: ('814') then                                           do; fx_site='(814) carpal'; output; end;
            if strip(DX) in: ('815' '816' '817') then                           do; fx_site='(815-817) hand/fingers'; output; end;
            if strip(DX) in: ('818' '819') then                                     do; fx_site='(818-819) arms mult'; output; end;
            if strip(DX) in: ('820') or strip(DX) = '73314' then                do; fx_site='(820, 73314) hip'; output; end;
            if strip(DX) in: ('821') or strip(DX)='73315' then              do; fx_site='(821, 73315) femur'; output; end;
            if strip(DX) in: ('822') then                                           do; fx_site='(822) patella'; output; end;
            if strip(DX) in: ('823') or strip(DX)='73316' then              do; fx_site='(823, 73316) tib_fib'; output; end;
            if strip(DX) in: ('824') then                                           do; fx_site='(824) ankle'; output; end;
            if strip(DX) in: ('825') then                                           do; fx_site='(825) tarsal_metatarsal'; output; end;
            if strip(DX) in: ('826') then                                           do; fx_site='(826) foot_phalanges'; output; end;
            if strip(DX) in: ('827') then                                           do; fx_site='(827) lower_limb'; output; end;
            if strip(DX) in: ('828') then                                           do; fx_site='(828) legs+arm/rib'; output; end;
            if strip(DX) in: ('829') then                                           do; fx_site='(829) fx_nos'; output; end;
            if strip(DX) in ('73310' '73319' '7331') then                 do; fx_site='(7331) pathologic nos/nec'; output; end;
    data fx_excare;
        set UCB.tempFracDxMPCD (where = (diagCodeType = "DX extend care claim"))
            UCB.tempFracDxUCB (where = (diagCodeType = "DX extend care claim"))
            UCB.tempFracDxSABR (where = (diagCodeType = "DX extend care claim"));
            length fx_site $30 ;
            fx_site = '';
            /*Expanded Diagnosis Codes - Fracture Aftercare Codes*/
            if strip(DX) in ('V5410' 'V5420') then                          do; fx_site='(812, 73311) humerus'; output; 
                                                                                             fx_site='(813, 73312) radius_ulna'; output; end;
            if strip(DX) in ('V5411' 'V5421') then                          do; fx_site='(812, 73311) humerus'; output; end;
            if strip(DX) in ('V5412' 'V5422') then                          do; fx_site='(813, 73312) radius_ulna'; output; 
                                                                                             fx_site='(814) carpal'; output; end;
            if strip(DX) in ('V5413' 'V5423') then                          do; fx_site='(820, 73314) hip'; output; end;
            if strip(DX) in ('V5414' 'V5424') then                          do; fx_site='(820, 73314) hip'; output; 
                                                                                             fx_site='(821, 73315) femur'; output;
                                                                                             fx_site='(822) patella'; output;
                                                                                             fx_site='(824) ankle'; output; 
                                                                                             fx_site='(823, 73316) tib_fib'; output; end;
            if strip(DX) in ('V5415' 'V5425') then                          do; fx_site='(820, 73314) hip'; output; 
                                                                                             fx_site='(821, 73315) femur'; output;
                                                                                             fx_site='(822) patella'; output; end;
            if strip(DX) in ('V5416' 'V5426') then                          do; fx_site='(824) ankle'; output; 
                                                                                             fx_site='(822) patella'; output;
                                                                                             fx_site='(823, 73316) tib_fib'; output; end;
            if strip(DX) in ('V5417' 'V5427') then                          do; fx_site='(805, 806, 73313) spine'; output; end;
            if strip(DX) in: ('V542') then                                       do; fx_site='(7331) pathologic nos/nec'; output; end;
            if strip(DX) in: ('V541') then                                       do; fx_site='(829) fx_nos'; output; end;
    run;

    /* proc sort data=fx_dgns; by patid BEGIN_DATE fx_site; run;
    proc sort data=fx_excare; by patid BEGIN_DATE fx_site; run; */
%mend;
%comballfxdgns;

/*Now, assign a more specific fracture site (e.g., closed, other) (site) that is used in the CQ algorithms*/
/*Since Expanded Diagnosis Codes (V Codes) apply to sub-categories of each broad fracture site, clone records for these so they appear in both places*/

data fx_dgns_2;
    set fx_dgns;

    length site $30;

    site="";

    *Spine-closed and Spine-other;  
    if fx_site='(805, 806, 73313) spine' then
        do;
            site = 'spine_cls'; /*Includes V Codes and 73313 here*/
            if substr(strip(DX),1,3) in ('805' '806') and substr(strip(DX),1,4) ^in ('8050', '8052', '8054', '8058') then
                site = 'spine_oth';
        end;

    *Pelvis-closed and Pelvis-other... No V Codes;
    if fx_site='(808) pelvis' then
        do;
            site = 'pelvis_cls';
            if substr(strip(DX),1,3)='808' and substr(strip(DX),1,4) ^in ('8080', '8082', '8084', '8088') then
                site = 'pelvis_oth';
        end;

    *Clavicle-closed and Clavicle-other.... No V Codes;
    if fx_site='(810) clavicle' then
        do;
            site = 'clv_cls';
            if substr(strip(DX),1,3) = '810' and substr(strip(DX),1,4) ^in ('8100') then
                site = 'clv_oth'; 
        end;

    *Humerus-closed and Humerus-other;
    if fx_site='(812, 73311) humerus' then
        do;
            site = 'hmrs_cls'; /*Includes V Codes and 73311 here*/
            if substr(strip(DX),1,3)= '812' and substr(strip(DX),1,4) ^in ('8120', '8122', '8124') then
                site = 'hmrs_oth'; 
        end;

    *Distal radius/ulna and Radius/ulna-other;
    if fx_site='(813, 73312) radius_ulna' then
        do;
         site = 'dist4arm'; /*Includes V Codes and 73312 here*/
            if substr(strip(DX),1,3) = '813' and substr(strip(DX),1,4) ^in ('8134', '8135') then
                site = 'rad_ul_oth'; 
        end;

    *Carpal... V Codes present but only one category;
    if fx_site='(814) carpal' then
        do;
            site = 'carpal';
         end;

    *Hip-closed and Hip-other;
    if fx_site='(820, 73314) hip' then
            do;
            site = 'hip_cls'; /*Includes V Codes and 73314 here*/
            if substr(strip(DX),1,3)='820' and substr(strip(DX),1,4) ^in ('8200', '8202', '8208') then
                site = 'hip_oth'; 
        end;

    *Other femur-closed and Other femur-other;     
    if fx_site='(821, 73315) femur' then
        do;
            site = 'oth_fem_cls'; /*Includes V Codes and 73315 here*/
            if substr(strip(DX),1,3)='821' and substr(strip(DX),1,4) ^in ('8210', '8212') then
                site = 'oth_fem_oth'; 
        end;

    *Tib/fib-closed and Tib/fib-other;
    if fx_site='(823, 73316) tib_fib' then
        do;
            site = 'tib_fib_cls'; /*Includes V Codes and 73316 here*/
            if substr(strip(DX),1,3)='823' and substr(strip(DX),1,4) ^in ('8230', '8232', '8238') then
                site = 'tib_fib_oth'; 
        end;

    *Ankle... V Codes present but only one category;
    if fx_site='(824) ankle' then
        do;
            site = 'ankle'; 
        end;

    /*Assign site for other fx_sites that do not have CQ algorithm and thus no sub categories*/
    if site = "" then do;
        site = fx_site;
    end;     

    label site = 'CQ Algorithm Fracture Site (Specific)';  

run;

/*###########################################################################################################*/
/***************************************************Intermediate Fracture Diagnosis File**********************/
/*Combine CQ diagnosis files*******************************************************/
data fx_dgns_3;
    set fx_dgns_2
/*    fx_excare_*/
        ;
run;

proc freq data=fx_dgns_3;
    tables fx_site site;
run;

proc sort data=fx_dgns_3;
    by patid ENCOUNTERID fx_site site;
run;


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
