*  University of Alabama at Birmingham                               *
*  AS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date :
* Modify date   :
;
%let cmt=buildExposureCohorts; * type the name of your program here (without the filename extension);
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
Load Fenglong's macro
 */
%include "lib\expo.sas" ;

proc copy in = DT out = Work;
  select cohortASTDUCB
         cohortASTDMPCD
         cohortASTD_SABR
         BioUCBSTD
         BioMPSTD
         Biostd_sabr
         DmardUCBSTD
         DmardMPSTD
         Dmardstd_sabr
         NsaidUCBSTD
         NsaidMPSTD
         Nsaidstd_sabr
         TNFUCBSTD
         TNFMPSTD
         TNFstd_sabr;
run;

%expo(source = UCBSTD  , cohort0 = Work.cohortASTDUCB  , stdLib = UCBSTD  , enrData = enroll)
%expo(source = MPSTD   , cohort0 = Work.cohortASTDMPCD , stdLib = MPSTD   , enrData = enroll)
%expo(source = STD_SABR, cohort0 = Work.cohortASTD_SABR, stdLib = STD_SABR, enrData = enroll)

proc datasets lib = Work;
  change ASTNFCohortUCBSTD_ex1   = ASTNFCohortStdUCB_ex1
         ASDMARDCohortUCBSTD_ex2 = ASDMARDCohortStdUCB_ex2
         ASNSAIDCohortUCBSTD_ex2 = ASNSAIDCohortStdUCB_ex2
         ASNoExpCohortUCBSTD_ex2 = ASNoExpCohortStdUCB_ex2
         ASTNFCohortMPSTD_ex1    = ASTNFCohortStdMPCD_ex1
         ASDMARDCohortMPSTD_ex2  = ASDMARDCohortStdMPCD_ex2
         ASNSAIDCohortMPSTD_ex2  = ASNSAIDCohortStdMPCD_ex2
         ASNoExpCohortMPSTD_ex2  = ASNoExpCohortStdMPCD_ex2;
run;

proc copy in = Work out = DT;
  select ASTNFCohortStdUCB_ex1
         ASDMARDCohortStdUCB_ex2
         ASNSAIDCohortStdUCB_ex2
         ASNoExpCohortStdUCB_ex2
         ASTNFCohortStdMPCD_ex1
         ASDMARDCohortStdMPCD_ex2
         ASNSAIDCohortStdMPCD_ex2
         ASNoExpCohortStdMPCD_ex2
         ASTNFCohortStd_SABR_ex1
         ASDMARDCohortStd_SABR_ex2
         ASNSAIDCohortStd_SABR_ex2
         ASNoExpCohortStd_SABR_ex2;
run;



ods html close;
