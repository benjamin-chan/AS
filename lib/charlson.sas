/* 
From: Xie, Fenglong [mailto:fenglongxie@uabmc.edu] 
Sent: Wednesday, November 29, 2017 1:32 PM
To: Benjamin Chan <chanb@ohsu.edu>
Subject: Attachment from my EndNote Library

Hi, Ben

Here are variable list included in our infection risk score model.

Hinfect agec preddose cpd Invisit heartFailure diabs antidepres nsaid HTN narcotics fracture lipid malign dem outInfect 
ulcer fungus sex op_bisphosp BENE_ENTLMT_RSN_ORIG thiazide Hypertension psa inflamMarker anticoagulant mammo;

please refer to table 2 in the attached reference for full name of these variables and the attached text file for definition of these variables.

Definition for some variables (such as ICD 9 codes for infection) may changed, please use most recent ICD 9 list. 

Please let me know if you have any question.


Fenglong
 */


%macro charlson(inputds=,idVar=, IndexDateVarName=, outputds=,IndexVarName=, inpatonly=, malig=);/*Dr. Curtis ask to change from I to B*/

**********************************************/
/*Define and format diagnosis codes           */
/**********************************************/;

PROC FORMAT;
   VALUE $ICD9CF(multilabel)
/* Myocardial infarction */
	"410"-"41099",
	"412"-"42199" = "MI"      
/* Coronary heart disease *//*changed according to Dr. Curtis"*/
    "410"-"41099",/*changed according to Dr. Curtis"*/
	"411"-"41499",        /*changed according to Dr. Curtis"*/
	"4292"-"42929"= "CHD"
/* Peripheral vascular disorder */
	"44020"-"44024",
	"44031"-"44032",
	"4408"-"44089",
	"4409"-"44099",
	"4439"-"44399",
	"441"-"44199",
	"7854"-"78549",
    "V434"-"V4349",
  "V434"-"V4349"= "PVD"
/* Cerebrovascular disease */
    "430"-"43899" = "CVD"
/* Dementia */
	"290"-"29099" = "DEM"
/* Chronic pulmonary disease */
	"490"-"49699",
	"500"-"50599",
	"5064"-"50649" =  "CPD"
/* Rheumatologic disease */
	"7100"-"71009",
    "7101"-"71019",
 	"7104"-"71049",
   /* "714.0 "-"714.2 ",
    "714.81", exclude RA*/
    "725"-"72599" = "RHD"
/* Peptic ulcer disease */
	"531"-"53499" = "PUD"
/* Mild liver disease */
	"5712"-"57129",
	"5715"-"57159",
	"5716"-"57169",
	"5714"-"57149" = "MLIVD"
/* Diabetes */
	"250"-"25039",
	"2507"-"25079" = "DIAB"
/* Diabetes with chronic complications */
	"2504"-"25069" = "DIABC"
/* Hemiplegia or paraplegia */
	"3441"-"34419",
	"342"-"34299" = "PLEGIA"
/* Renal Disease */
	"582"-"58299",
	"583"-"58379",
	"585"-"58599",
	"586"-"58699",
	"588"-"58899" = "REN"
/*Malignancy, including leukemia and lymphoma */
	"140"-"17299",
	"174"-"19589",
	"200"-"20899" = "MALIGN"
/* Moderate or severe liver disease */
	"5722"-"57289",
	"4560"-"45621" = "SLIVD"
/* Metastatic solid tumor */
	"196"-"19919" = "MST"
/* AIDS */
	"042"-"04499" = "AIDS"
/* Other */
   other   = "other"
;
run;

* For debugging. ;
%let sqlopts = feedback sortmsg stimer ;
%*let sqlopts = ;

**********************************************************************************************;
*subset to the utilization data of interest (add the people with no visits back at the end   *;
**********************************************************************************************;

**********************************************;
* implement the Inpatient and Outpatient Flags;
********************************************** ;
%if &inpatonly =I %then %let inpatout=('IP');
%else %if &inpatonly =B %then %let inpatout=('IP','IF','AV');
%else %Put ERROR in Inpatonly flag.  Valid values are I for Inpatient and B for both Inpatient and Outpatient;

proc sql;
  create table  _DxSubset as
  select *, put(dx, $icd9cf.) as CodedDx
  from UCB.tempPrevDx12mPrior
  where  enc_type in &inpatout.
  ;

   create table _PxSubset as
  select*
  from UCB.tempPrevPx12mPrior 
  /* where enc_type in &inpatout. */
  ;
 
quit ;

proc sort data = _DxSubset ;
   by &idVar &indexdateVarName;
run ;

proc sort data = _PxSubset ;
   by &idVar &indexdateVarName;
run ;

/**********************************************/
/*** Assing DX based flagsts                ***/
/***                                        ***/
/***                                        ***/
/**********************************************/

%let var_list = MI CHD PVD CVD DEM CPD RHD PUD MLIVD DIAB DIABC PLEGIA REN MALIGN SLIVD MST AIDS ;

data _DxAssign ;
array COMORB (*) &var_list ;

length           &var_list 3 ; *<-- This is host-specific--are we sure we want to do this? ;

retain           &var_list ;
keep   &idVar &indexdateVarName &var_list ;
set _DxSubset;
  format prov_type;
by &idVar &indexdateVarName;
if first.&indexdateVarName then do;
   do I=1 to dim(COMORB);
      COMORB(I) = 0 ;
   end;
end;
select (CodedDx);
   when ('MI')    MI     = 1;
   when ('CHD')   CHD    = 1;
   when ('PVD')   PVD    = 1;
   when ('CVD')   CVD    = 1;
   when ('DEM')   DEM    = 1;
   when ('CPD')   CPD    = 1;
   when ('RHD')   RHD    = 1;
   when ('PUD')   PUD    = 1;
   when ('MLIVD') MLIVD  = 1;
   when ('DIAB')  DIAB   = 1;
   when ('DIABC') DIABC  = 1;
   when ('PLEGIA')PLEGIA = 1;
   when ('REN')   REN    = 1;
   when ('MALIGN')MALIGN = 1;
   when ('SLIVD') SLIVD  = 1;
   when ('MST')   MST    = 1;
   when ('AIDS')  AIDS   = 1;
   otherwise ;
end;
if last.&indexdateVarName then output;
run;

/** Procedures: Peripheral vascular disorder **/
data _PxAssign;
   set _PxSubset;
   by &idVar &indexdateVarName;
   keep &idVar &indexdateVarName PVD;
   if first.&indexdateVarName then PVD = 0;
   if    (codeType = "ICD9-PX" & PX= "3848") or
         (codeType = "CPT" & PX ="93668") or
         (codeType = "CPT" & 
                   PX in ("34201","34203","35454","35456","35459","35470") or
                          "35355" <= PX <= "35381") or
         (codeType = "CPT" & 
                   PX in ("35473","35474","35482","35483","35485","35492","35493",
                          "35495","75962","75992")) or
         (codeType = "CPT" & 
                  PX in ("35521","35533","35541","35546","35548","35549","35551",
                         "35556","35558","35563","35565","35566","35571","35582","35583",
                         "35584","35585","35586","35587","35621","35623","35641","35646",
                         "35647","35651","35654","35656","35661","35663","35665","35666","35671"))
         then PVD=1;
   if last.&indexdateVarName then output;
run;

/** Connect DXs and PROCs together  **/
proc sql &sqlopts ;
  create table _DxPxAssign as
   select  coalesce(D.&idVar, P.&idVar) as &idVar
         , coalesce(D.&indexdateVarName, P.&indexdateVarName) as &indexdateVarName		 
         , D.MI
         , D.CHD
         , max(D.PVD, P.PVD) as PVD
         , D.CVD
         , D.DEM
         , D.CPD
         , D.RHD
         , D.PUD
         , D.MLIVD
         , D.DIAB
         , D.DIABC
         , D.PLEGIA
         , D.REN
         , D.MALIGN
         , D.SLIVD
         , D.MST
         , D.AIDS
   from  _DXASSIGN as D full outer join
         _PXASSIGN P
   on    D.&idVar = P.&idVar and
         D.&indexdateVarName=P.&indexdateVarName 
   ;
quit ;

*****************************************************;
* Assign the weights and compute the index
*****************************************************;

Data _WithCharlson;
  set _DxPxAssign;
  M1=1;M2=1;M3=1;

* implement the MALIG flag;
   %if &malig =N %then %do; O1=1;O2=1; %end;
   %else %if &malig =Y %then  %do; O1=0; O2=0; %end;
   %else %Put ERROR in MALIG flag.  Valid values are Y (Cancer study. Zero weight the cancer vars)  and N (treat cancer normally);

  if SLIVD=1 then M1=0;
  if DIABC=1 then M2=0;
  if MST=1 then M3=0;

&IndexVarName =   MI + CHD + PVD + CVD + DEM + CPD + RHD +
                  PUD + M1*MLIVD + M2*DIAB + 2*DIABC + 2*PLEGIA + 2*REN +
                  O1*2*M3*MALIGN + 3*SLIVD + O2*6*MST + 6*AIDS;

Label
MI= "Myocardial Infarction: "
CHD="Coronary heart disease:" /* "Congestive heart disease: " relabeled */
PVD= "Peripheral vascular disorder: "
CVD= "Cerebrovascular disease: "
DEM= "Dementia: "
CPD= "Chronic pulmonary disease: "
RHD= "Rheumatologic disease: "
PUD= "Peptic ulcer disease: "
MLIVD= "Mild liver disease: "
DIAB= "Diabetes: "
DIABC= "Diabetes with chronic complications: "
PLEGIA= "Hemiplegia or paraplegia: "
REN= "Renal Disease: "
MALIGN= "Malignancy, including leukemia and lymphoma: "
SLIVD= "Moderate or severe liver disease: "
MST= "Metastatic solid tumor: "
AIDS= "AIDS: "
&IndexVarName= "Charlson score: "
;

keep &idVar &indexdateVarName &var_list &IndexVarName ;

run;

/* add the people with no visits back in, and create the final dataset */
/* people with no visits or no comorbidity DXs have all vars set to zero */

proc sql &sqlopts ;
  create table &outputds as
  select distinct w.&idVar
      , w.&IndexDateVarName
      , coalesce(w.MI           , 0) as  MI            label = "Myocardial Infarction: "
      , coalesce(w.CHD          , 0) as  CHD           label = "Congestive heart disease: "
      , coalesce(w.PVD          , 0) as  PVD           label = "Peripheral vascular disorder: "
      , coalesce(w.CVD          , 0) as  CVD           label = "Cerebrovascular disease: "
      , coalesce(w.DEM          , 0) as  DEM           label = "Dementia: "
      , coalesce(w.CPD          , 0) as  CPD           label = "Chronic pulmonary disease: "
      , coalesce(w.RHD          , 0) as  RHD           label = "Rheumatologic disease: "
      , coalesce(w.PUD          , 0) as  PUD           label = "Peptic ulcer disease: "
      , coalesce(w.MLIVD        , 0) as  MLIVD         label = "Mild liver disease: "
      , coalesce(w.DIAB         , 0) as  DIAB          label = "Diabetes: "
      , coalesce(w.DIABC        , 0) as  DIABC         label = "Diabetes with chronic complications: "
      , coalesce(w.PLEGIA       , 0) as  PLEGIA        label = "Hemiplegia or paraplegia: "
      , coalesce(w.REN          , 0) as  REN           label = "Renal Disease: "
      , coalesce(w.MALIGN       , 0) as  MALIGN        label = "Malignancy, including leukemia and lymphoma: "
      , coalesce(w.SLIVD        , 0) as  SLIVD         label = "Moderate or severe liver disease: "
      , coalesce(w.MST          , 0) as  MST           label = "Metastatic solid tumor: "
      , coalesce(w.AIDS         , 0) as  AIDS          label = "AIDS: "
      , coalesce(w.&IndexVarName, 0) as  &IndexVarName label = "Charlson score: "
      , (w.&idVar is null)              as  NoVisitFlag   label = "No visits for this person"
  from  _WithCharlson as w
  ;

/* clean up work sas datasets */
/*proc datasets nolist ;
 delete _DxSubset
        _PxSubset
        _DxAssign
        _PxAssign
        _DxPxAssign       
        _NoVisit
 		_WithCharlson
        ;*/
%mend charlson;
