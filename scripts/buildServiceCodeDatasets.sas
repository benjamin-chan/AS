*  University of Alabama at Birmingham                               *
*  AS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=buildServiceCodeDatasets; * type the name of your program here (without the filename extension);
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
From: Chen, Lang [mailto:langchen@uabmc.edu] 
Sent: Monday, September 11, 2017 1:59 PM
To: Benjamin Chan <chanb@ohsu.edu>; Curtis, Jeffrey R <jrcurtis@uabmc.edu>; Kevin Winthrop <winthrop@ohsu.edu>
Cc: Atul Deodhar <deodhara@ohsu.edu>; Sarah Siegel <siegels@ohsu.edu>; Yang, Shuo <shuoyang@uabmc.edu>; Xie, Fenglong <fenglongxie@uabmc.edu>
Subject: RE: quick summary of AS call

physician-diagnosed codes is usually define by IP AV ED NH and HH. We usually
do not use provider type field. Provider type is provider specialty and MPCD
and CMS use different coding system.
 */


/* 
Service code data sets for prevalence (non-fracture outcomes)
 */
%let type = Prev;
%let select1 = select A.*, B.enc_type, B.admit_date, B.begin_date, B.discharge_date, B.end_date, B.dx_type, B.dx, B.pdx, "ICD9-DX" as codeType, B.dx as code;
%let on1 = on (A.patid = B.patid);
%let select2 = select A.patid, A.enc_type, A.admit_date, A.begin_date, A.discharge_date, A.end_date, A.dx_type, A.dx, A.pdx;
%let where2 = where A.dx_type = "09" & A.enc_type in ("IP", "AV", "ED", "NH", "HH");
%let selectfrom3 = select * from DT.indexLookup;

%include "lib\buildDx.sas";  /* Call script to query ICD-9 diagnosis codes */

%let select1 = select A.*, 
                      B.admit_date, B.begin_date, B.discharge_date, B.end_date, B.px_date, B.px_type, B.px, 
                      case 
                        when B.px_type = "09" then "ICD9-PX" 
                        when B.px_type = "C1" | ^anyalpha(strip(B.px)) then "CPT" 
                        when B.px_type = "H1" & anyalpha(substr(strip(B.px), 1, 1)) & ^anyalpha(strip(B.px), 2) then "HCPCS" 
                        else "" 
                        end as codeType, 
                      B.px as code;
%let select2 = select patid, admit_date, begin_date, discharge_date, end_date, px_date, px_type, px;

%include "lib\buildPx.sas";  /* Call script to query procedure codes */


/* 
Service code data sets for incidence (non-fracture outcomes)
 */
%let type = Inc;
%let select1 = select A.*, B.enc_type, B.admit_date, B.begin_date, B.discharge_date, B.end_date, B.dx_type, B.dx, B.pdx, "ICD9-DX" as codeType, B.dx as code;
%let on1 = on (A.patid = B.patid & A.exposureStart <= B.begin_date <= A.exposureEnd);
%let select2 = select A.patid, A.enc_type, A.admit_date, A.begin_date, A.discharge_date, A.end_date, A.dx_type, A.dx, A.pdx;
%let where2 = where dx_type = "09" & A.enc_type in ("IP", "AV", "ED", "NH", "HH");
%let selectfrom3 = select * from DT.exposureTimeline;

%include "lib\buildDx.sas";  /* Call script to query ICD-9 diagnosis codes */

%let select1 = select A.*, 
                      B.admit_date, B.begin_date, B.discharge_date, B.end_date, B.px_date, B.px_type, B.px, 
                      case 
                        when B.px_type = "09" then "ICD9-PX" 
                        when B.px_type = "C1" | ^anyalpha(strip(B.px)) then "CPT" 
                        when B.px_type = "H1" & anyalpha(substr(strip(B.px), 1, 1)) & ^anyalpha(strip(B.px), 2) then "HCPCS" 
                        else "" 
                        end as codeType, 
                      B.px as code;
%let select2 = select patid, admit_date, begin_date, discharge_date, end_date, px_date, px_type, px;

%include "lib\buildPx.sas";  /* Call script to query procedure codes */


/* 
Service code data sets for fracture outcomes
Fracture service code data sets are used for both prevalence and incidence;
unlike non-fracture service code data sets
 */
%let type = Frac;
%let select1 = select A.*, 
                      B.encounterID, B.enc_type, B.admit_date, B.begin_date, B.discharge_date, B.end_date, B.dx_type, B.dx, B.pdx, "ICD9-DX" as codeType, B.dx as code,
                      B.diagCodeType;
%let on1 = on (A.patid = B.patid);
%let select2 = select A.patid, A.encounterID, A.enc_type, A.admit_date, A.begin_date, A.discharge_date, A.end_date, A.dx_type, A.dx, A.pdx,
                      case
                        when '800' <= substr(A.dx, 1, 3) <= '829' or substr(A.dx, 1, 4) = '7331' then "Fracture code"
                        when substr(A.dx, 1, 4) in ('V541' 'V542') then "Extended care code"
                        when 'E800' <= substr(A.dx, 1, 4) <= 'E848' or 
                             'E881' <= substr(A.dx, 1, 4) <= 'E884' or 
                             'E908' <= substr(A.dx, 1, 4) <= 'E909' or 
                             'E916' <= substr(A.dx, 1, 4) <= 'E928' 
                          then "Trauma code"
                        else ""
                        end as diagCodeType;
%let where2 = where A.dx_type = "09" & A.enc_type in ("IP", "AV", "ED", "NH", "HH") & ^missing(calculated diagCodeType);
%let selectfrom3 = select * from DT.indexLookup;

%include "lib\buildDx.sas";  /* Call script to query ICD-9 diagnosis codes */

%let select1 = select A.*, 
                      B.encounterID, B.admit_date, B.begin_date, B.discharge_date, B.end_date, B.px_date, B.px_type, B.px, 
                      case 
                        when B.px_type = "09" then "ICD9-PX" 
                        when B.px_type = "C1" | ^anyalpha(strip(B.px)) then "CPT" 
                        when B.px_type = "H1" & anyalpha(substr(strip(B.px), 1, 1)) & ^anyalpha(strip(B.px), 2) then "HCPCS" 
                        else "" 
                        end as codeType, 
                      B.px as code;
%let select2 = select patid, encounterID, admit_date, begin_date, discharge_date, end_date, px_date, px_type, px;

%include "lib\buildPx.sas";  /* Call script to query procedure codes */




ods html close;
