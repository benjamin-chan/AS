*  University of Alabama at Birmingham                               *
*  AS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=CANCER_setoguchi; * type the name of your program here (without the filename extension);
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


libname cancer 'Q:\shared\users\lchen\satoguchi' access = readonly;

**************************************************************************************************;

****************************************************************************************

Programmer Hopiy, taken from Chris Coley
Project: TNF
Task: Using Setoguchi Algrim, Classify each person what definition of cancer
    Uses Look up table created by Kevin
Output: Dataset work.master


TODO:
1) Add complexity for DX_PX tables.. Add code for all diagnosis look at table DX and all procedures look at table PX
2) find kaiser date, merge into the master data
****************************************************************************************;


/* 
proc datasets nolist; 
delete  
malignancy 
malignancy2
cancer_dat_dx
cancer_dat_px
cancer_dat_rx
outcome_cancer
cancer_:
; 
quit;
 */
/*bring in the malignancy table where code clean doen't have the x in it*/
proc import datafile='q:\shared\users\wsmith\malignancy_code_list_20131019.xlsx' out=malignancy replace; run;
proc import datafile='W:\Users\lchen\lookupdata\cancer\Updated SABER2_Cancer_Codes - 10-30-2015 LC 2016.xlsx' 
    out=malignancy replace; 
    sheet="malignancy_code_lists";
run;
/*Making sure that there is a unique key for code clean*/
data malignancy;set malignancy; code=upcase(code);run;
proc sort data=malignancy(where=(code^='')) out=malignancy2 ; by table code anycancer; run;

*these datasets are used to identify subsets of where the datasets are coming from;
*please adjust to point all PX/DX/RX/etc.;


%let indxdat = UCB.tempIncDxAll;
%let inpxdat = UCB.tempIncPxAll;
%let inrxdat = UCB.tempIncRxAll;
proc sort data=&indxdat; by exposureID begin_date;run;
proc sort data=&inpxdat; by exposureID px_date;run;
proc sort data=&inrxdat; by exposureID dispense_date;run;


data cancer_dat_dx(drop=rc);
    if _N_=1 then do;
        declare hash cancer_hash(dataset: "malignancy(where=(upcase(table)='DX'))");
        rc = cancer_hash.definekey("code");
        rc = cancer_hash.definedata(all:"YES");
        rc=cancer_hash.definedone();
    end;
if 0 then set malignancy;
set &indxdat.;
rc = cancer_hash.find(key:DX);
if rc=0;
run;
proc sort data=Cancer_dat_DX nodupkey; by exposureID begin_date dx;run;

data cancer_dat_px(drop=rc);
    if _N_=1 then do;
        declare hash cancer_hash(dataset: "malignancy(where=(upcase(table)='PX'))");
        rc = cancer_hash.definekey("code");
        rc = cancer_hash.definedata(all:"YES");
        rc=cancer_hash.definedone();
    end;
if 0 then set malignancy;
set &inpxdat.;
rc = cancer_hash.find(key:PX);
if rc=0;
run;
proc sort data=Cancer_dat_PX nodupkey; by exposureID px_date px;run;


data cancer_dat_rx(drop=rc);
    if _N_=1 then do;
        declare hash cancer_hash(dataset: "malignancy(where=(upcase(table)='RX'))");
        rc = cancer_hash.definekey("code");
        rc = cancer_hash.definedata(all:"YES");
        rc=cancer_hash.definedone();
    end;
if 0 then set malignancy;
set &inrxdat.;
rc = cancer_hash.find(key:NDC);
if rc=0;
run;
proc sort data=Cancer_dat_RX nodupkey; by exposureID dispense_date ndc;run;

********************************************************************************************************************************************;
proc format;
    value $ cancer 
        'all'='(ALL) ACUTE LYMPHOID LEUKEMIA'
        'cll'='(CLL) CHR LYMPHOID LEUKEMIA'
        'oth_ll'='(OTH_LL) OTHER LYMPHOID LEUKEMIA'
        'aml'='(AML) ACUTE MYELOID LEUKEMIA'
        'cml'='(CML) CHRONIC MYELOID LEUKEMIA'
        'oth_ml'='(OTH_ML) OTHER MYELOID LEUKEMIA'
        'mono_leuk'='(MONO_LEUK) MONOCYTIC LEUKEMIA'
        'oth_leuk'='(OTH_LEUK) OTHER LEUKEMIA'
        'nhl_nos'='(NHL_NOS) LYMPHOSARCOMA/LYMPHOMA'
        'hodgkin'='(HODGKIN) HODGKINS LYMPHOMA'
        'nodnhl'='(NODNHL) NODULAR LYMPHOMA'
        'mycoses'='(MYCOSES) MYCOSIS FUNGOIDES'
        'histiocyt'='(HISTIOCYT) MALIGNANT HISTIOCYTOSIS'
        'hcl'='(HCL) HAIRY-CELL LEUKEMIA'
        'letterer'='(LETTERER) LETTERER-SIWE DISEASE'
        'mastcell'='(MASTCELL) MALIGNANT MAST CELL TUMORS'
        'periph_tcell'='(PERIPH_TCELL) PERIPHERAL T-CELL LYMPHOMA'
        'lymphoma_nos'='(LYMPHOMA_NOS) LYMPHOMA NOS'
        'otherlymphhisto'='(OTHERLYMPHHISTO) OTHER LYMPHOID MALIGNANCY'
        'mm'='(MM) MULTIPLE MYELOMA'
        'plasma'='(PLASMA) PLASMACYTOMA'
        'wald'='(WALD) MACROGLOBULINEMIA'
        'head_neck'='(HEAD_NECK) HEAD NECK CANCERS'
        'esophagus'='(ESOPHAGUS) MALIGNANT NEOPLASM ESOPHAGUS'
        'stomach'='(STOMACH) MALIGNANT NEOPLASM STOMACH'
        'sm_intest'='(SM_INTEST) SMALL INTESTINES'
        'colon'='(COLON) COLON'
        'rectum'='(RECTUM) RECTUM'
        'anus'='(ANUS) ANUS'
        'liver'='(LIVER) LIVER'
        'gall'='(GALL) GALL BLADDER'
        'pancreas'='(PANCREAS) PANCREAS'
        'perit'='(PERIT) PERITONEUM'
        'digest'='(DIGEST) DIGESTIVE SYSTEM'
        'lung'='(LUNG) LUNG'
        'thoracic'='(THORACIC) THORACIC'
        'bone'='(BONE) BONE'
        'connect'='(CONNECT) SOFT TISSUE'
        'malmel'='(MALMEL) MALIGNANT MELANOMA'
        'female_breast'='(FEMALE_BREAST) FEMALE BREAST'
        'male_breast'='(MALE_BREAST) MALE BREAST'
        'ks'='(KS) KAPOSI SARCOMA'
        'uterus'='(UTERUS) UTERUS'
        'cervix'='(CERVIX) CERVIX'
        'placenta'='(PLACENTA) PLACENTA'
        'ovary'='(OVARY) OVARY'
        'oth_fem'='(OTH_FEM) OTHER FEMALE GENITALIA'
        'prostate'='(PROSTATE) PROSTATE'
        'testis'='(TESTIS) TESTIS'
        'penis'='(PENIS) PENIS'
        'bladder'='(BLADDER) BLADDER'
        'kidney'='(KIDNEY) KIDNEY'
        'oth_urin'='(OTH_URIN) OTHER URINARY'
        'eye'='(EYE) EYE'
        'brain'='(BRAIN) BRAIN'
        'oth_nerv'='(OTH_NERV) OTHER NERVOUS SYSTEM'
        'thyroid'='(THYROID) THYROID'
        'oth_endo'='(OTH_ENDO) OTHER ENDROCRINE'
        'oth_def'='(OTH_DEF) OTHER ILL DEFINED SITES'
        'nmsc'='(NMSC) NON-MELANOMA SKIN CANCER'
        ;
run;

%let Cancer=all cll oth_ll aml cml oth_ml mono_leuk oth_leuk 
nhl_nos hodgkin nodnhl mycoses histiocyt hcl letterer mastcell periph_tcell lymphoma_nos
otherlymphhisto mm  plasma wald head_neck esophagus
stomach sm_intest colon rectum anus liver gall pancreas perit digest lung thoracic bone connect malmel 
female_breast male_breast ks uterus cervix placenta ovary oth_fem prostate testis penis bladder kidney
oth_urin eye brain oth_nerv thyroid oth_endo oth_def; /* nmsc */

%macro cancer_loop;
    /*REFER to setoguchi for goal for each definition*/
/*
>=1 cancer diagnosis  + any diagnosis or procedure codes related to complications of  cancer 
or palliative care in two weeks followed by another diagnosis of cancer within 12 months.  
 1 diagnostic procedure with biopsy followed by >=2 cancer diagnoses at two different 
occasions within 12 months (recorded on different dates from the procedures).
 1 cancer diagnosis + any surgery related to cancer during the same hospitalization and/or 
visit.
 1 cancer diagnosis + any cancer chemotherapy during the same hospitalization and/or visit
 1 cancer diagnosis + any radiation therapy during the same hospitalization and/or visit
 1 cancer diagnosis + hematopoietic cell transplantation during the same hospitalization 
and/or visit (for leukemia only)
 1 cancer diagnosis + oral chemotherapy dispensing within 2 weeks after the diagnosis
 */

%local n comp current;

/*Lists out all the cancers*/
%do n = 1 %to 59;
    %let current = %scan(&cancer,&n);
    /* wipe/reset for all the interim datasets change to proc dataset if you want*/
    proc datasets nolist; delete def_1a def_1b def_1c def_1d def_1e def_1f def_1g def_2 
only refine_dx refine_px refine_rx 
def_1a_comp
def_1a_dx_1st_comp_dx 
def_1a_dx_1st 
def_1a_dx_1st_comp
def_1b_PX
def_1b_PX_DX
def_1b_PX_DX_DX
def_1c_px_dx
def_1d_px_dx
def_1e_px_dx
def_1f_px_dx
def_1g_dx_rx
def_2_dx_dx
;
    quit;

    /*Pulls in the Specific Complication list for each cancer*/
    *proc print data=cancer.comp(obs=10); run;
    data _null_;
        set cancer.comp(where=(cancer= "&current"));
         call symputx("comp", comma);
    run;
%put &comp.;

    /*Creating a Cancer specific DX/PX table - select benes with ever &current cancer diagnosis */
    /* bene_id for those with this cancer ever */
    data only (drop=&current); 
        set Cancer_dat_DX(where=(&Current=1) keep= exposureID &current in=a); by exposureID; if first.exposureID;
    run;
    *proc print data=only(obs=15); run;

    data refine_PX(drop=rc);
    if _N_=1 then do;
        declare hash hexposureID(dataset: "only");
        rc = hexposureID.definekey("exposureID");
        rc = hexposureID.defineDone();
        *put rc= ;
    end;
        if 0 then set only;
        set cancer_dat_PX( ); by exposureID PX_DATE;
        rc =hexposureID.find(key:exposureID);
        if rc = 0;
    run;

    data refine_DX(drop=rc);
    if _N_=1 then do;
        declare hash hexposureID(dataset: "only");
        rc = hexposureID.definekey("exposureID");
        rc = hexposureID.defineDone();
        *put rc= ;
    end;
        if 0 then set only;
        set cancer_dat_DX( ); by exposureID BEGIN_DATE;
        rc =hexposureID.find(key:exposureID);
        if rc = 0;
    run;

    data refine_RX(drop=rc);
    if _N_=1 then do;
        declare hash hexposureID(dataset: "only");
        rc = hexposureID.definekey("exposureID");
        rc = hexposureID.defineDone();
        *put rc= ;
    end;
        if 0 then set only;
        set cancer_dat_RX( ); by exposureID DISPENSE_DATE;
        rc =hexposureID.find(key:exposureID);
        if rc = 0;
    run;

/*
    definition 1a
>=1 cancer diagnosis  + any diagnosis or procedure codes related to complications of  cancer 
or palliative care in two weeks followed by another diagnosis of cancer within 12 months. 
Note it seems to me that there is not V66.7 Encounter for palliative care in the code list (LC 8/18/2016)

*/

    Data def_1a_comp(keep = exposureID DATE2 PX DX_COMP);  *any diagnosis or procedure codes related to complications of  cancer or palliative care;
        set refine_PX(rename=(PX_DATE=DATE2) where=(sum(&comp)>=1))
             refine_DX(rename=(BEGIN_DATE=DATE2 DX=DX_COMP) where=(sum(&comp)>=1)); 
    run; 
    proc sort data= def_1a_comp nodupkey; by exposureID DATE2; run;


    data def_1a_dx_1st; * >=1 cancer diagnosis;
        set refine_DX( where=(&Current=1));
        length DATE1 4; format DATE1 mmddyy10.;
        DATE1=BEGIN_DATE;
    run;
proc sort data=def_1a_dx_1st nodupkey; by exposureID DATE1;run;
    data def_1a_dx_1st_comp(keep=exposureID DX: DATE1 DATE2); *+ any diagnosis or procedure codes related to complications of  cancer 
or palliative care;
    if _N_=1 then do;
        declare hash hexposureID(dataset: "def_1a_comp", multidata:"Y");
        rc = hexposureID.definekey("exposureID");
        rc = hexposureID.defineData(all:"YES");
        rc = hexposureID.defineDone();
        *put rc= ;
    end;
        if 0 then set def_1a_comp;
        set def_1a_dx_1st( ); by exposureID DATE1;
        rc =hexposureID.find(key:exposureID);
         do while (rc = 0);
            if rc = 0 and 0<=DATE2-date1<=14 then output;;
            rc=hexposureID.find_next();
         end;        
    run;
proc sort data=def_1a_dx_1st_comp; by exposureID DATE1 DATE2; run;
data def_1a_dx_1st_comp;
set def_1a_dx_1st_comp;
by exposureID DATE1 DATE2;
if first.DATE1;
run;


    data def_1a_dx_1st_comp_dx(keep=exposureID DX: DATE1 DATE2 DATE3); *followed by another diagnosis of cancer within 12 months.;
    if _N_=1 then do;
        declare hash hexposureID(dataset: "def_1a_dx_1st(rename=(date1=date3 dx=dx2)) " , multidata:"Y");
        rc = hexposureID.definekey("exposureID");
        rc = hexposureID.defineData("date3","DX2");
        rc = hexposureID.defineDone();
        *put rc= ;
    end;
        if 0 then set def_1a_dx_1st(rename=(date1=date3  dx=dx2));
        set def_1a_dx_1st_comp; by exposureID DATE1;
        rc =hexposureID.find(key:exposureID);
         do while (rc = 0);
            if rc = 0 and 0 <= intck('month',date1, date3)<=12 and date1^=date3 then output;
            rc=hexposureID.find_next();
         end;
    run;

data def_1a;
set def_1a_dx_1st_comp_dx;
length Def_1a 3 outcome_date outcome_start_date 4; format outcome_date outcome_start_date mmddyy10.;
by exposureID DATE1 DATE2 DATE3;
Def_1a=1;
outcome_start_date=min(DATE1, DATE2, DATE3);
outcome_date=DATE3;
run;
proc sort data=def_1a;by exposureID outcome_date descending outcome_start_date;run;
data def_1a;
set def_1a;
by exposureID outcome_date descending outcome_start_date;
if first.outcome_date;
run;

    /*REFER to setoguchi for goal for each definition*/

/*
definiton 1b 
 1 diagnostic procedure with biopsy followed by >=2 cancer diagnoses at two different 
occasions within 12 months (recorded on different dates from the procedures).
 */

    /*Works BIOPSIES!!!!!!!!*/
    data def_1b_PX; *1 diagnostic procedure with biopsy;
    set refine_PX;
    where &current in (1,3);
    run;

    data def_1b_px_dx(keep=exposureID DX: DATE1 PX_DATE); *followed by >=2 cancer diagnoses at two different 
occasions within 12 months (recorded on different dates from the procedures;
    if _N_=1 then do;
        declare hash hexposureID(dataset: "def_1a_dx_1st", multidata:"Y");
        rc = hexposureID.definekey("exposureID");
        rc = hexposureID.defineData(all:"YES");
        rc = hexposureID.defineDone();
        *put rc= ;
    end;
    if 0 then set def_1a_dx_1st;
    set def_1b_PX; by exposureID PX_DATE;
        rc =hexposureID.find(key:exposureID);
         do while (rc = 0);
            if rc = 0 and date1>px_date and yrdif(PX_DATE,DATE1,'actual')<1 then output;;
            rc=hexposureID.find_next();
         end; ;
    run;
proc sort data=def_1b_px_dx; by exposureID PX_DATE DATE1; run;
    data def_1b_px_dx;
    set def_1b_px_dx;
    by exposureID PX_DATE DATE1;
    if first.PX_DATE;
    run;

    data def_1b_px_dx_dx(keep=exposureID DX: DATE1 PX_DATE DATE2); *followed by >=2 cancer diagnoses at two different 
occasions within 12 months (recorded on different dates from the procedures;
    if _N_=1 then do;
        declare hash hexposureID(dataset: "def_1a_dx_1st(rename=(DATE1= DATE2))", multidata:"Y");
        rc = hexposureID.definekey("exposureID");
        rc = hexposureID.defineData(all:"YES");
        rc = hexposureID.defineDone();
        *put rc= ;
    end;
    if 0 then set def_1a_dx_1st(rename=(DATE1= DATE2));
    set def_1b_PX_DX; by exposureID PX_DATE;
        rc =hexposureID.find(key:exposureID);
         do while (rc = 0);
            if rc = 0 and date2>date1 and yrdif(PX_DATE,DATE2,'actual')<1 then output;;
            rc=hexposureID.find_next();
         end; ;
    run;
    data def_1b;
    set def_1b_px_dx_dx;
    length Def_1b 3 outcome_start_date outcome_date 4; format outcome_start_date outcome_date mmddyy10.;
/*    by exposureID PX_DATE DATE2;*/
    Def_1b=1;
    outcome_date=DATE2;
    outcome_start_date=min(PX_DATE, DATE1, DATE2);
    run;
    proc sort data =def_1b; by exposureID outcome_date descending outcome_start_date;run;
    data def_1b;
    set def_1b;
    by exposureID outcome_date descending outcome_start_date;
    if first.outcome_date;
    run;


/*
    def_1a_dx_1st
    data def_1b;
    set dx_px;
    by exposureID;
    length biop_date diag_1 diag_2 4;
    retain biop_date diag_1 diag_2;
    if first.exposureID then do; biop_date=.; diag_1=.; diag_2=.;  end;
    if table='PX' and &current in (1,3) then biop_date =outcome_dt;
    if table='DX' and &current=1 then do;  diag_2=diag_1; diag_1=outcome_dt; end;
    def_1b=0;
    if nmiss(biop_date,diag_1,diag_2)=0 and yrdif(Biop_date,diag_1,'actual')<1 then def_1b=1;
    format diag_1 diag_2 Biop_date mmddyy10.;
    run;
*/

    /* Works!!!!*/
    /*cancer +SURG*/
/*
    definition 1c
 1 cancer diagnosis + any surgery related to cancer during the same hospitalization and/or 
visit.
*/

    PROC SQL;
    create table def_1c_px_dx as 
    select a.exposureID, a.begin_date, a.ADMIT_DATE, a.DX, b.PX, coalesce(a.begin_date, a.ADMIT_DATE) as outcome_date length=4 format=mmddyy10.  from def_1a_dx_1st(where=(&current=1)) a
    join refine_PX(where=(&current in (2,3))) b
    on a.exposureID=b.exposureID and (a.begin_date=b.begin_date>. or a.ADMIT_DATE=b.ADMIT_DATE>.);
quit;
    proc sort data=def_1c_px_dx; by exposureID outcome_date ;run;
    data def_1c;
    set def_1c_px_dx;
    length Def_1c 3 outcome_start_date 4; format outcome_start_date mmddyy10.;
    by exposureID outcome_date ;
    Def_1c=1;
    outcome_start_date=outcome_date;
    if first.outcome_date;
    run;
/*
    definition 1d
 1 cancer diagnosis + any cancer chemotherapy during the same hospitalization and/or visit
*/

PROC SQL;
    create table def_1d_px_dx as 
    select a.exposureID, a.begin_date, a.ADMIT_DATE, a.DX, b.PX, coalesce(a.begin_date, a.ADMIT_DATE) as outcome_date length=4 format=mmddyy10.  from def_1a_dx_1st(where=(&current=1)) a
    join refine_PX(where=(cpt_chemo=1)) b
    on a.exposureID=b.exposureID and (a.begin_date=b.begin_date>. or a.ADMIT_DATE=b.ADMIT_DATE>.);
quit;
    proc sort data=def_1d_px_dx; by exposureID outcome_date ;run;
    data def_1d;
    set def_1d_px_dx;
    length Def_1d 3 outcome_start_date 4; format outcome_start_date mmddyy10.;
    by exposureID outcome_date;
    Def_1d=1;
    outcome_start_date=outcome_date;
    if first.outcome_date;
    run;

/*
    definition 1e
 1 cancer diagnosis + any radiation therapy during the same hospitalization and/or visit

    data def_1e;
    set dx_px;
    by exposureID;
    if &current=1 then  Dx_malig_date=outcome_dt; retain Dx_malig_date ;
    if first.exposureID and &current ^=1 then Dx_malig_date=.;
    def_1e = 0;
    if radiation =1 and (Dx_malig_date=outcome_dt) then def_1e =1;
    if def_1e=1;
    format dx_malig_date mmddyy10.;
    run;

*/

PROC SQL;
    create table def_1e_px_dx as 
    select a.exposureID, a.begin_date, a.ADMIT_DATE, a.DX, b.PX, coalesce(a.begin_date, a.ADMIT_DATE) as outcome_date length=4 format=mmddyy10.  from def_1a_dx_1st(where=(&current=1)) a
    join refine_PX(where=(radiation =1)) b
    on a.exposureID=b.exposureID and (a.begin_date=b.begin_date>. or a.ADMIT_DATE=b.ADMIT_DATE>.);
quit;
    proc sort data=def_1e_px_dx; by exposureID outcome_date ;run;
    data def_1e;
    set def_1e_px_dx;
    length Def_1e 3 outcome_start_date 4; format outcome_start_date mmddyy10.;
    by exposureID outcome_date;
    Def_1e=1;
    outcome_start_date=outcome_date;
    if first.outcome_date;
    run;
/*
    definition 1f
    1 cancer diagnosis + hematopoietic cell transplantation during the same hospitalization 
and/or visit (for leukemia only)

        data def_1F;
            set dx_px;
            by exposureID;
            if &current=1 then  Dx_Leuk_date=outcome_dt; retain Dx_Leuk_date ;
            if first.exposureID and &current^=1 then dx_leuk_date=.;
            def_1f =0;
            if hema_stem_trans =1 and (dx_leuk_date=outcome_dt) then def_1f =1;
            format dx_leuk_date mmddyy10.;
        run;
 */



    %if &n <8 %then %do;
PROC SQL;
    create table def_1f_px_dx as 
    select a.exposureID, a.begin_date, a.ADMIT_DATE, a.DX, b.PX, 
    coalesce(a.begin_date, a.ADMIT_DATE) as outcome_date length=4 format=mmddyy10.  from def_1a_dx_1st(where=(&current=1)) a
    join refine_PX(where=(hema_stem_trans =1)) b
    on a.exposureID=b.exposureID and (a.begin_date=b.begin_date>. or a.ADMIT_DATE=b.ADMIT_DATE>.);
quit;
    proc sort data=DEF_1F_PX_DX; by exposureID outcome_date; run;
    data def_1f;
    set def_1f_px_dx;
    length Def_1f 3 ;
    by exposureID outcome_date;
    Def_1f=1;
    outcome_start_date=outcome_date;
    if first.outcome_date;
    run;
    %end; %else %do;
    data def_1f(keep=exposureID outcome_date Def_1f outcome_start_date);
    set def_1a_dx_1st(rename=begin_date=outcome_date);
    length Def_1f 3 ;
    Def_1f=1;
    outcome_start_date=outcome_date;
    if 0;
    run;
    %end;
proc sort data=def_1f; by exposureID outcome_date;run;

/*
    definition 1g
 1 cancer diagnosis + oral chemotherapy dispensing within 2 weeks after the diagnosis

    data def_1G;
        set dx_rx;
        by exposureID;
        retain dx_&current;
        if table='DX' and &current= 1 then Dx_&current=outcome_dt;
        if first.exposureID and &current^= 1 then dx_&current=.;
        def_1G=0;
        if (table='RX' and &current= 1 ) and (0< (outcome_dt-dx_&current) <=14) then def_1G =1;
        if def_1g=1;
            format Dx_&current mmddyy10.;
    run; 
*/


PROC SQL;
    create table def_1g_dx_rx as 
    select a.exposureID, a.begin_date, a.ADMIT_DATE, b.DISPENSE_DATE, a.DX, b.NDC, 
    max(b.DISPENSE_DATE, a.begin_date) as outcome_date length=4 format=mmddyy10.,
    min(b.DISPENSE_DATE, a.begin_date) as outcome_start_date length=4 format=mmddyy10.
    from def_1a_dx_1st(where=(&current=1)) a
    join refine_RX(where=(&current= 1)) b
    on a.exposureID=b.exposureID and ( 0<= (b.DISPENSE_DATE-a.begin_date) <=14 );
quit;
    proc sort data=def_1g_dx_rx; by exposureID outcome_date descending outcome_start_date;run;
    data def_1g;
    set def_1g_dx_rx;
    length Def_1g 3 ;
    by exposureID outcome_date descending outcome_start_date;
    Def_1g=1;
    if first.outcome_date;
    run;

    /* WORKS FOR !!!*/
/* definiton 2;
 2 diagnoses of cancer within 2 months;
    data def_2;
        set Cancer_dat_DX(where=(&current=1)  rename=(BEGIN_DATE=outcome_dt));
        by exposureID;
        retain date1 date2 first_&current; 
        if first.exposureID then do; first_&current=outcome_dt; date1 =.; date2=.; end;
        if &current=1 then do; date2=date1;   date1=outcome_dt; end;
        def_2=0;
        if date2 ne . then do; 
            if (date1-date2) <=60 then def_2=1; end;
        if def_2=1;
            format date1 date2 first_&current mmddyy10.;
    run;
*/

PROC SQL;
    create table def_2_dx_dx as 
    select a.exposureID, a.begin_date, max(a.begin_date, b.begin_date) as outcome_date length=4 format=mmddyy10.,
    min(a.begin_date, b.begin_date) as outcome_start_date length=4 format=mmddyy10. from def_1a_dx_1st(where=(&current=1)) a
    join def_1a_dx_1st(where=(&current=1)) b
    on a.exposureID=b.exposureID and  0 <= intck('month',b.begin_date, a.begin_date)<=2 and 0< (b.begin_date-a.begin_date) ;
quit;
    proc sort data=def_2_dx_dx; by exposureID outcome_date descending outcome_start_date;run;
    data def_2;
    set def_2_dx_dx;
    length Def_2 3 ;
    by exposureID outcome_date descending outcome_start_date;
    Def_2=1;
    if first.outcome_date;
    run;

data cancer_&current.(keep=exposureID outcome_date def: cancer outcome_start_date:);
merge 
def_1a(rename=outcome_start_date=outcome_start_date1a) 
def_1b(rename=outcome_start_date=outcome_start_date1b) 
def_1c(drop=outcome_start_date) def_1d(drop=outcome_start_date) def_1e(drop=outcome_start_date) def_1f(drop=outcome_start_date)
def_1g(rename=outcome_start_date=outcome_start_date1g) 
def_2(rename=outcome_start_date=outcome_start_date2);
length cancer $20 outcome_start_date 4;
format outcome_start_date mmddyy10.;
by exposureID outcome_date;
outcome_start_date=max(outcome_start_date1a, outcome_start_date1b, outcome_start_date1g, outcome_start_date2, outcome_date);
cancer="&current.";
run;
proc freq data=cancer_&current.; tables def_:;run;
%end;
%mend cancer_loop;
%cancer_loop;

data Work.outcome_cancer;
set  cancer_all cancer_cll cancer_oth_ll cancer_aml cancer_cml cancer_oth_ml cancer_mono_leuk cancer_oth_leuk
 cancer_nhl_nos cancer_hodgkin cancer_nodnhl cancer_mycoses cancer_histiocyt cancer_hcl cancer_letterer cancer_mastcell cancer_periph_tcell cancer_lymphoma_nos
 cancer_otherlymphhisto cancer_mm cancer_plasma cancer_wald cancer_head_neck cancer_esophagus
 cancer_stomach cancer_sm_intest cancer_colon cancer_rectum cancer_anus cancer_liver cancer_gall cancer_pancreas cancer_perit cancer_digest cancer_lung cancer_thoracic cancer_bone cancer_connect cancer_malmel
 cancer_female_breast cancer_male_breast cancer_ks cancer_uterus cancer_cervix cancer_placenta cancer_ovary cancer_oth_fem cancer_prostate cancer_testis cancer_penis cancer_bladder cancer_kidney
 cancer_oth_urin cancer_eye cancer_brain cancer_oth_nerv cancer_thyroid cancer_oth_endo cancer_oth_def;
length outcome $20;
outcome="cancer";
run;


/* 
Group cancer categories

From: Atul Deodhar 
Sent: Monday, September 18, 2017 10:49 PM
To: Benjamin Chan <chanb@ohsu.edu>
Subject: Re: AS Comorbitidies Study - Analysis 

Hi Ben,

Yes, #1 through 22 are hematologic malignancies.  #60 is non-melanoma skin
cancer, and #23 to #58 are solid tumors.  I would disregard # 59

1 (ALL) ACUTE LYMPHOID LEUKEMIA
2 (CLL) CHR LYMPHOID LEUKEMIA
3 (OTH_LL) OTHER LYMPHOID LEUKEMIA
4 (AML) ACUTE MYELOID LEUKEMIA
5 (CML) CHRONIC MYELOID LEUKEMIA
6 (OTH_ML) OTHER MYELOID LEUKEMIA
7 (MONO_LEUK) MONOCYTIC LEUKEMIA
8 (OTH_LEUK) OTHER LEUKEMIA
9 (NHL_NOS) LYMPHOSARCOMA/LYMPHOMA
10 (HODGKIN) HODGKINS LYMPHOMA
11 (NODNHL) NODULAR LYMPHOMA
12 (MYCOSES) MYCOSIS FUNGOIDES
13 (HISTIOCYT) MALIGNANT HISTIOCYTOSIS
14 (HCL) HAIRY-CELL LEUKEMIA
15 (LETTERER) LETTERER-SIWE DISEASE
16 (MASTCELL) MALIGNANT MAST CELL TUMORS
17 (PERIPH_TCELL) PERIPHERAL T-CELL LYMPHOMA
18 (LYMPHOMA_NOS) LYMPHOMA NOS
19 (OTHERLYMPHHISTO) OTHER LYMPHOID MALIGNANCY
20 (MM) MULTIPLE MYELOMA
21 (PLASMA) PLASMACYTOMA
22 (WALD) MACROGLOBULINEMIA
23 (HEAD_NECK) HEAD NECK CANCERS
24 (ESOPHAGUS) MALIGNANT NEOPLASM ESOPHAGUS
25 (STOMACH) MALIGNANT NEOPLASM STOMACH
26 (SM_INTEST) SMALL INTESTINES
27 (COLON) COLON
28 (RECTUM) RECTUM
29 (ANUS) ANUS
30 (LIVER) LIVER
31 (GALL) GALL BLADDER
32 (PANCREAS) PANCREAS
33 (PERIT) PERITONEUM
34 (DIGEST) DIGESTIVE SYSTEM
35 (LUNG) LUNG
36 (THORACIC) THORACIC
37 (BONE) BONE
38 (CONNECT) SOFT TISSUE
39 (MALMEL) MALIGNANT MELANOMA
40 (FEMALE_BREAST) FEMALE BREAST
41 (MALE_BREAST) MALE BREAST
42 (KS) KAPOSI SARCOMA
43 (UTERUS) UTERUS
44 (CERVIX) CERVIX
45 (PLACENTA) PLACENTA
46 (OVARY) OVARY
47 (OTH_FEM) OTHER FEMALE GENITALIA
48 (PROSTATE) PROSTATE
49 (TESTIS) TESTIS
50 (PENIS) PENIS
51 (BLADDER) BLADDER
52 (KIDNEY) KIDNEY
53 (OTH_URIN) OTHER URINARY
54 (EYE) EYE
55 (BRAIN) BRAIN
56 (OTH_NERV) OTHER NERVOUS SYSTEM
57 (THYROID) THYROID
58 (OTH_ENDO) OTHER ENDROCRINE
59 (OTH_DEF) OTHER ILL DEFINED SITES
60 (NMSC) NON-MELANOMA SKIN CANCER
 */
proc sql;
/* 
Group cancers
 */
  create table Work.cancerSetoguchiEpisodesInc as
    select A.database, A.exposure, A.patid, A.exposureStart, A.exposureEnd,
           cancer as site,
           case
             when site = "all" then "Hematologic Cancer"
             when site = "cll" then "Hematologic Cancer"
             when site = "oth_ll" then "Hematologic Cancer"
             when site = "aml" then "Hematologic Cancer"
             when site = "cml" then "Hematologic Cancer"
             when site = "oth_ml" then "Hematologic Cancer"
             when site = "mono_leuk" then "Hematologic Cancer"
             when site = "oth_leuk" then "Hematologic Cancer"
             when site = "nhl_nos" then "Hematologic Cancer"
             when site = "hodgkin" then "Hematologic Cancer"
             when site = "nodnhl" then "Hematologic Cancer"
             when site = "mycoses" then "Hematologic Cancer"
             when site = "histiocyt" then "Hematologic Cancer"
             when site = "hcl" then "Hematologic Cancer"
             when site = "letterer" then "Hematologic Cancer"
             when site = "mastcell" then "Hematologic Cancer"
             when site = "periph_tcell" then "Hematologic Cancer"
             when site = "lymphoma_nos" then "Hematologic Cancer"
             when site = "otherlymphhisto" then "Hematologic Cancer"
             when site = "mm" then "Hematologic Cancer"
             when site = "plasma" then "Hematologic Cancer"
             when site = "wald" then "Hematologic Cancer"
             when site = "head_neck" then "Solid Cancer"
             when site = "esophagus" then "Solid Cancer"
             when site = "stomach" then "Solid Cancer"
             when site = "sm_intest" then "Solid Cancer"
             when site = "colon" then "Solid Cancer"
             when site = "rectum" then "Solid Cancer"
             when site = "anus" then "Solid Cancer"
             when site = "liver" then "Solid Cancer"
             when site = "gall" then "Solid Cancer"
             when site = "pancreas" then "Solid Cancer"
             when site = "perit" then "Solid Cancer"
             when site = "digest" then "Solid Cancer"
             when site = "lung" then "Solid Cancer"
             when site = "thoracic" then "Solid Cancer"
             when site = "bone" then "Solid Cancer"
             when site = "connect" then "Solid Cancer"
             when site = "malmel" then "Solid Cancer"
             when site = "female_breast" then "Solid Cancer"
             when site = "male_breast" then "Solid Cancer"
             when site = "ks" then "Solid Cancer"
             when site = "uterus" then "Solid Cancer"
             when site = "cervix" then "Solid Cancer"
             when site = "placenta" then "Solid Cancer"
             when site = "ovary" then "Solid Cancer"
             when site = "oth_fem" then "Solid Cancer"
             when site = "prostate" then "Solid Cancer"
             when site = "testis" then "Solid Cancer"
             when site = "penis" then "Solid Cancer"
             when site = "bladder" then "Solid Cancer"
             when site = "kidney" then "Solid Cancer"
             when site = "oth_urin" then "Solid Cancer"
             when site = "eye" then "Solid Cancer"
             when site = "brain" then "Solid Cancer"
             when site = "oth_nerv" then "Solid Cancer"
             when site = "thyroid" then "Solid Cancer"
             when site = "oth_endo" then "Solid Cancer"
             else ""
             end as cancer,
           B.*
    from DT.exposureTimeline A inner join
         Work.outcome_cancer B on (A.exposureID = B.exposureID);
  select cancer, site, count(*) as n
    from Work.cancerSetoguchiEpisodesInc
    group by cancer, site;
/* 
Per protocol, keep only the FIRST cancer type for each patient ID
 */
  create table Work.cancerLookup as
    select patid, cancer, min(outcome_start_date) format = mmddyy10. as earliestCancer
    from Work.cancerSetoguchiEpisodesInc
    where ^missing(cancer)
    group by patid, cancer;
  create table DT.cancerSetoguchiEpisodesInc as
    select A.earliestCancer, B.*
    from Work.cancerLookup A inner join
         Work.cancerSetoguchiEpisodesInc B on (A.patid = B.patid &
                                               A.cancer = B.cancer &
                                               A.earliestCancer = B.outcome_start_date);
  select A.cancer, A.database, A.exposure, 
         count(distinct A.patid) as countDistinctPatid,
         count(distinct A.exposureID) as countDistinctExposureID
    from DT.cancerSetoguchiEpisodesInc A
    group by A.cancer, A.database, A.exposure;
quit;
proc contents data = DT.cancerSetoguchiEpisodesInc order = varnum;
run;




ods html close;
