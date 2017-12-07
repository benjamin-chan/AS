*  University of Alabama at Birmingham                               *
*  AS project                                                        *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=codeCharlson; * type the name of your program here (without the filename extension);
%let pgm=&cmt..sas;
%include "lib\libname.sas" ;
%include "lib\remove.ruleout.dxcodes.macro.sas" / source2;
%include "lib\charlson.comorbidity.macro.sas" / source2;
footnote "&pgm.";
* footnote2 "%sysfunc(datetime(),datetime14.)";
title1 '--- AS project ---';
**********************************************************************;
options macrogen mlogic mprint symbolgen;
options nomacrogen nomlogic nomprint nosymbolgen;



ods html
  body = "output\&cmt..html"
  style = Statistical;


proc sql;
  create table Work.maxNumberDiagCodes as
    select max(C.ndx) as maxNumberDiagCodes
    from (select B.ndx, count(B.encounterID) as freqNDX
          from (select A.encounterID, count(distinct A.dx) as ndx
                from WRK.diagcodesICD912mPrior A
                where A.enc_type in ("AV", "IP")
                group by A.encounterID) B
          group by B.ndx) C;
quit;
data _null_;
  set Work.maxNumberDiagCodes;
  call symput ("maxNumberDiagCodes", put(maxNumberDiagCodes, 2.));
run;
%put maxNumberDiagCodes = &maxNumberDiagCodes;


proc sort data = WRK.diagcodesICD912mPrior out = WRK.diagcodesICD912mPriorSorted;
  where enc_type in ("AV", "IP");
  by patid episodeID episodeStartDate encounterID begin_date enc_type;
run;
proc transpose data = WRK.diagcodesICD912mPriorSorted out = WRK.diagcodesICD912mPriorWide prefix = dx;
  by patid episodeID episodeStartDate encounterID begin_date enc_type;
  var dx;
run;
proc sort data = WRK.diagcodesICD912mPriorWide out = WRK.diagcodesICD912mPriorWide;
  by encounterID;
run;
data WRK.diagcodesICD912mPriorWide;
  set WRK.diagcodesICD912mPriorWide;
  by encounterID;
  array dx {*} dx1 - dx&maxNumberDiagCodes;
  array flag {*} flag1 - flag&maxNumberDiagCodes;
  do i = 1 to &maxNumberDiagCodes;
    flag[i] = length(dx[i]) > 1;
  end;
  ndx = sum(of flag(*));
  drop _name_ i flag1 - flag&maxNumberDiagCodes;
run;
proc freq data = WRK.diagcodesICD912mPriorWide;
  table ndx;
run;


proc sql;
  create table Work.maxNumberProcCodes as
    select max(C.nsx) as maxNumberProcCodes
    from (select B.nsx, count(B.encounterID) as freqNSX
          from (select A.encounterID, count(A.px) as nsx
                from DT.proccodesICD9 A
                group by A.encounterID) B
          group by B.nsx) C;
quit;
data _null_;
  set Work.maxNumberProcCodes;
  call symput ("maxNumberProcCodes", put(maxNumberProcCodes, 2.));
run;
%put maxNumberProcCodes = &maxNumberProcCodes;


proc sort data = DT.proccodesICD9 out = DT.proccodesICD9Sorted;
  by patid episodeID episodeStartDate encounterID begin_date;
run;
proc transpose data = DT.proccodesICD9Sorted out = DT.proccodesICD9Wide prefix = surg;
  by patid episodeID episodeStartDate encounterID begin_date;
  var px;
run;
proc sort data = DT.proccodesICD9Wide out = DT.proccodesICD9Wide;
  by encounterID;
run;
data DT.proccodesICD9Wide;
  set DT.proccodesICD9Wide;
  by encounterID;
  array surg {*} surg1 - surg&maxNumberProcCodes;
  array flag {*} flag1 - flag&maxNumberProcCodes;
  do i = 1 to &maxNumberProcCodes;
    flag[i] = length(surg[i]) > 1;
  end;
  nsx = sum(of flag(*));
  drop _name_ i flag1 - flag&maxNumberProcCodes;
run;
proc freq data = DT.proccodesICD9Wide;
  table nsx;
run;


proc sql;
  create table WRK.tempComorbidityIndex as
    select coalesce(A.patid, B.patid, C.patid, D.patid) as patid,
           coalesce(A.episodeID, B.episodeID, C.episodeID, D.episodeID) as episodeID,
           coalesce(A.encounterID, B.encounterID, C.encounterID, D.encounterID) as encounterID,
           coalesce(A.begin_date, B.begin_date, C.begin_date, D.begin_date) format = mmddyy10. as clmdte,
           "P" as idxpri,
           intnx("year", 
                 coalesce(A.episodeStartDate, B.episodeStartDate, C.episodeStartDate, D.episodeStartDate), 
                 -1, 
                 "same") 
             format = mmddyy10. 
             as start,
           coalesce(A.episodeStartDate, B.episodeStartDate, C.episodeStartDate, D.episodeStartDate) - 1 format = mmddyy10. as finish,
           A.admit_date format = mmddyy10. as admit_date,
           A.discharge_date format = mmddyy10. as discharge_date,
           A.discharge_date - A.admit_date + 1 as los,
           case B.enc_type
             when "IP" then "M"
             else ""
             end as filetype,
           C.px as hcpcs,
           A.drg,
           case
             when missing(B.dx1) then 0
             else B.ndx
             end as ndx,
           B.dx1, B.dx2, B.dx3, B.dx4, B.dx5, B.dx6, B.dx7, B.dx8, B.dx9, B.dx10,
           B.dx11, B.dx12, B.dx13, B.dx14, B.dx15, B.dx16, B.dx17, B.dx18, B.dx19, B.dx20,
           B.dx21, B.dx22, B.dx23, B.dx24, B.dx25, B.dx26, B.dx27,
           case
             when missing(D.surg1) then 0
             else D.nsx
             end as nsx,
           D.surg1, D.surg2, D.surg3, D.surg4, D.surg5, D.surg6, D.surg7, D.surg8, D.surg9, D.surg10,
           D.surg11, D.surg12, D.surg13, D.surg14, D.surg15, D.surg16, D.surg17, D.surg18, D.surg19, D.surg20,
           D.surg21, D.surg22, D.surg23, D.surg24
    from DT.drgcodes A full join
         WRK.diagcodesICD912mPriorWide B on (A.encounterID = B.encounterID) full join
         WRK.proccodesHCPCS C on (B.encounterID = C.encounterID) full join
         DT.proccodesICD9Wide D on (C.encounterID = D.encounterID);
  select ^missing(drg) as hasDRG,
         ^missing(hcpcs) as hasHCPCS,
         ndx,
         nsx,
         count(*) as n
    from WRK.tempComorbidityIndex
    group by calculated hasDRG, calculated hasHCPCS, ndx, nsx;
quit;


%ruleout(WRK.tempComorbidityIndex,
         episodeID,
         clmdte,
         start,
         finish,
         dx1-dx27,
         ndx,
         hcpcs,
         filetype);
* %MACRO RULEOUT(SETIN,PATID,CLMDTE,START,FINISH,DXVARSTR,NDXVAR,HCPCS,FILETYPE);
   /**********************************************************************
    SETIN:    Dataset name: a dataset that contains the following:
    PATID:    Variable name: Unique ID for each patient.  &SETIN must be
              sorted by &PATID.  There may be more than 1 record per patient.
    CLMDTE:   Variable name: Date of the claim found on the claim file.
              Should be a SAS date format.
    START:    Variable name: Date the comorbidity window opens, ie DX-12
              Should be a SAS date format.
    FINISH:   Variable name: Date the comorbidity window closes, ie DX-1
              Should be a SAS date format.
    DXVARSTR: Variable names: the diagnosis codes, ie 'DX01-DX10'
    NDXVAR:   Number: the actual number of diagnosis codes in DXVARSTR
    HCPCS:    Variable name: the SAF and NCH file procedure codes in CPT-4.
    FILETYPE: Variable name: the source of the claim record.  Only important
              value is 'M' for MEDPAR (inpatient hospital records).  If this
              is 'M', all ICD-9 diagnosis codes are accepted.
   **********************************************************************/

%comorb(WRK.CLMRECS,
        episodeID,
        idxpri,
        days,
        dx1-dx27,
        ndx,
        surg1-surg24,
        nsx,
        hcpcs,
        filetype);
* %MACRO COMORB(SETIN,PATID,IDXPRI,DAYS,DXVARSTR,NDXVAR,SXVARSTR,NSXVAR,HCPCS,FILETYPE);
   /**********************************************************************
    SETIN:    Dataset name: a dataset that contains the following:
    PATID:    Variable name: Unique ID for each patient.  &SETIN must be
              sorted by &PATID.  There may be more than 1 record per patient.
    IDXPRI:   Variable name: indicates for each record if the Dx and Surg 
            codes are Index 'I' or Prior 'P' to the event of interest.
            If the variable does not equal I or P, the record will not be
            used.  This variable should be set by the calling program.
    DAYS:     Variable name: contains the length of stay for hospital visits.
    DXVARSTR: Variable names: the diagnosis codes in ICD-9, ie 'DX01-DX10'
    NDXVAR:   Number: the actual number of diagnosis codes in DXVARSTR
    SXVARSTR: Variable names: the surgery codes in ICD-9, ie 'SURG01-SURG10'
    NSXVAR:   Number: the actual number of surgery codes in SXVARSTR
    HCPCS:    Variable name: the SAF and NCH file procedure codes in CPT-4.
    FILETYPE: Variable name: the source of the claim record.  Only important
            value is 'M' for MEDPAR (inpatient hospital records).  If this
            is 'M', the check for Acute MI will include &DAYS > 2.
   **********************************************************************/
proc corr data = Work.Comorb;
  var pchrlson chrlson xchrlson;
run;


proc copy in = Work out = DT;
  select Comorb;
run; 


ods html close;
