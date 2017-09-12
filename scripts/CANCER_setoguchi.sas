**********************************************************************
*  University of Alabama at Birmingham                               *
*  SABER project                                                      *
**********************************************************************;
options fmtsearch=(MyFormat.formats);
options pagesize=45 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*" fullstimer msglevel=i;
* Programmer    : Wilson Smith
* Creation date : 
* Modify date   : by LC 08/17/2016 for standardized data.
* original code in Q:\pgms\wsmith\CANCER-Amgen psoriasis v01.sas;
%let cmt=CANCER_Setoguchi;
%let pgm=&cmt..sas;
libname cancer 'Q:\shared\users\lchen\satoguchi';

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
footnote "%sysfunc(datetime(),datetime14.)";
*options  nomlogic mprint nosymbolgen FORMDLIM="*" ;
*======================================== START EDIT =================================================================;
%let numdate = %sysfunc(today(),MMDDYY6.);
/*
*/  
*====================================== END EDIT ===================================================================;
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

%let indxdat=UC.Subsetdx;
%let inpxdat=UC.Subsetpx;
%let inrxdat=UC.Subsetrx;
proc sort data=&indxdat; by patid begin_date;run;
proc sort data=&inpxdat; by patid px_date;run;
proc sort data=&inrxdat; by patid dispense_date;run;
proc sql;
  create table UCB.tempIncDxAll as
    select UCB.tempIncDxMPCD union corr
    select UCB.tempIncDxUCB  union corr
    select UCB.tempIncDxSABR ;
  create table UCB.tempIncPxAll as
    select UCB.tempIncPxMPCD union corr
    select UCB.tempIncPxUCB  union corr
    select UCB.tempIncPxSABR ;
  create table UCB.tempIncRxAll as
    select UCB.tempIncRxMPCD union corr
    select UCB.tempIncRxUCB  union corr
    select UCB.tempIncRxSABR ;
quit;



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
proc sort data=Cancer_dat_DX nodupkey; by patid begin_date dx;run;

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
proc sort data=Cancer_dat_PX nodupkey; by patid px_date px;run;


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
proc sort data=Cancer_dat_RX nodupkey; by patid dispense_date ndc;run;

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
        set Cancer_dat_DX(where=(&Current=1) keep= PATID &current in=a); by PATID; if first.PATID;
    run;
    *proc print data=only(obs=15); run;

    data refine_PX(drop=rc);
    if _N_=1 then do;
        declare hash hpatid(dataset: "only");
        rc = hpatid.definekey("PATID");
        rc = hpatid.defineDone();
        *put rc= ;
    end;
        if 0 then set only;
        set cancer_dat_PX( ); by PATID PX_DATE;
        rc =hpatid.find(key:PATID);
        if rc = 0;
    run;

    data refine_DX(drop=rc);
    if _N_=1 then do;
        declare hash hpatid(dataset: "only");
        rc = hpatid.definekey("PATID");
        rc = hpatid.defineDone();
        *put rc= ;
    end;
        if 0 then set only;
        set cancer_dat_DX( ); by PATID BEGIN_DATE;
        rc =hpatid.find(key:PATID);
        if rc = 0;
    run;

    data refine_RX(drop=rc);
    if _N_=1 then do;
        declare hash hpatid(dataset: "only");
        rc = hpatid.definekey("PATID");
        rc = hpatid.defineDone();
        *put rc= ;
    end;
        if 0 then set only;
        set cancer_dat_RX( ); by PATID DISPENSE_DATE;
        rc =hpatid.find(key:PATID);
        if rc = 0;
    run;

/*
    definition 1a
>=1 cancer diagnosis  + any diagnosis or procedure codes related to complications of  cancer 
or palliative care in two weeks followed by another diagnosis of cancer within 12 months. 
Note it seems to me that there is not V66.7 Encounter for palliative care in the code list (LC 8/18/2016)

*/

    Data def_1a_comp(keep = PATID DATE2 PX DX_COMP);  *any diagnosis or procedure codes related to complications of  cancer or palliative care;
        set refine_PX(rename=(PX_DATE=DATE2) where=(sum(&comp)>=1))
             refine_DX(rename=(BEGIN_DATE=DATE2 DX=DX_COMP) where=(sum(&comp)>=1)); 
    run; 
    proc sort data= def_1a_comp nodupkey; by PATID DATE2; run;


    data def_1a_dx_1st; * >=1 cancer diagnosis;
        set refine_DX( where=(&Current=1));
        length DATE1 4; format DATE1 mmddyy10.;
        DATE1=BEGIN_DATE;
    run;
proc sort data=def_1a_dx_1st nodupkey; by PATID DATE1;run;
    data def_1a_dx_1st_comp(keep=PATID DX: DATE1 DATE2); *+ any diagnosis or procedure codes related to complications of  cancer 
or palliative care;
    if _N_=1 then do;
        declare hash hpatid(dataset: "def_1a_comp", multidata:"Y");
        rc = hpatid.definekey("PATID");
        rc = hpatid.defineData(all:"YES");
        rc = hpatid.defineDone();
        *put rc= ;
    end;
        if 0 then set def_1a_comp;
        set def_1a_dx_1st( ); by PATID DATE1;
        rc =hpatid.find(key:PATID);
         do while (rc = 0);
            if rc = 0 and 0<=DATE2-date1<=14 then output;;
            rc=hpatid.find_next();
         end;        
    run;
proc sort data=def_1a_dx_1st_comp; by PATID DATE1 DATE2; run;
data def_1a_dx_1st_comp;
set def_1a_dx_1st_comp;
by PATID DATE1 DATE2;
if first.DATE1;
run;


    data def_1a_dx_1st_comp_dx(keep=PATID DX: DATE1 DATE2 DATE3); *followed by another diagnosis of cancer within 12 months.;
    if _N_=1 then do;
        declare hash hpatid(dataset: "def_1a_dx_1st(rename=(date1=date3 dx=dx2)) " , multidata:"Y");
        rc = hpatid.definekey("PATID");
        rc = hpatid.defineData("date3","DX2");
        rc = hpatid.defineDone();
        *put rc= ;
    end;
        if 0 then set def_1a_dx_1st(rename=(date1=date3  dx=dx2));
        set def_1a_dx_1st_comp; by PATID DATE1;
        rc =hpatid.find(key:PATID);
         do while (rc = 0);
            if rc = 0 and 0 <= intck('month',date1, date3)<=12 and date1^=date3 then output;
            rc=hpatid.find_next();
         end;
    run;

data def_1a;
set def_1a_dx_1st_comp_dx;
length Def_1a 3 outcome_date outcome_start_date 4; format outcome_date outcome_start_date mmddyy10.;
by PATID DATE1 DATE2 DATE3;
Def_1a=1;
outcome_start_date=min(DATE1, DATE2, DATE3);
outcome_date=DATE3;
run;
proc sort data=def_1a;by PATID outcome_date descending outcome_start_date;run;
data def_1a;
set def_1a;
by PATID outcome_date descending outcome_start_date;
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

    data def_1b_px_dx(keep=PATID DX: DATE1 PX_DATE); *followed by >=2 cancer diagnoses at two different 
occasions within 12 months (recorded on different dates from the procedures;
    if _N_=1 then do;
        declare hash hpatid(dataset: "def_1a_dx_1st", multidata:"Y");
        rc = hpatid.definekey("PATID");
        rc = hpatid.defineData(all:"YES");
        rc = hpatid.defineDone();
        *put rc= ;
    end;
    if 0 then set def_1a_dx_1st;
    set def_1b_PX; by PATID PX_DATE;
        rc =hpatid.find(key:PATID);
         do while (rc = 0);
            if rc = 0 and date1>px_date and yrdif(PX_DATE,DATE1,'actual')<1 then output;;
            rc=hpatid.find_next();
         end; ;
    run;
proc sort data=def_1b_px_dx; by PATID PX_DATE DATE1; run;
    data def_1b_px_dx;
    set def_1b_px_dx;
    by PATID PX_DATE DATE1;
    if first.PX_DATE;
    run;

    data def_1b_px_dx_dx(keep=PATID DX: DATE1 PX_DATE DATE2); *followed by >=2 cancer diagnoses at two different 
occasions within 12 months (recorded on different dates from the procedures;
    if _N_=1 then do;
        declare hash hpatid(dataset: "def_1a_dx_1st(rename=(DATE1= DATE2))", multidata:"Y");
        rc = hpatid.definekey("PATID");
        rc = hpatid.defineData(all:"YES");
        rc = hpatid.defineDone();
        *put rc= ;
    end;
    if 0 then set def_1a_dx_1st(rename=(DATE1= DATE2));
    set def_1b_PX_DX; by PATID PX_DATE;
        rc =hpatid.find(key:PATID);
         do while (rc = 0);
            if rc = 0 and date2>date1 and yrdif(PX_DATE,DATE2,'actual')<1 then output;;
            rc=hpatid.find_next();
         end; ;
    run;
    data def_1b;
    set def_1b_px_dx_dx;
    length Def_1b 3 outcome_start_date outcome_date 4; format outcome_start_date outcome_date mmddyy10.;
/*    by PATID PX_DATE DATE2;*/
    Def_1b=1;
    outcome_date=DATE2;
    outcome_start_date=min(PX_DATE, DATE1, DATE2);
    run;
    proc sort data =def_1b; by PATID outcome_date descending outcome_start_date;run;
    data def_1b;
    set def_1b;
    by PATID outcome_date descending outcome_start_date;
    if first.outcome_date;
    run;


/*
    def_1a_dx_1st
    data def_1b;
    set dx_px;
    by PATID;
    length biop_date diag_1 diag_2 4;
    retain biop_date diag_1 diag_2;
    if first.PATID then do; biop_date=.; diag_1=.; diag_2=.;  end;
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
    select a.PATID, a.begin_date, a.ADMIT_DATE, a.DX, b.PX, coalesce(a.begin_date, a.ADMIT_DATE) as outcome_date length=4 format=mmddyy10.  from def_1a_dx_1st(where=(&current=1)) a
    join refine_PX(where=(&current in (2,3))) b
    on a.PATID=b.PATID and (a.begin_date=b.begin_date>. or a.ADMIT_DATE=b.ADMIT_DATE>.);
quit;
    proc sort data=def_1c_px_dx; by PATID outcome_date ;run;
    data def_1c;
    set def_1c_px_dx;
    length Def_1c 3 outcome_start_date 4; format outcome_start_date mmddyy10.;
    by PATID outcome_date ;
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
    select a.PATID, a.begin_date, a.ADMIT_DATE, a.DX, b.PX, coalesce(a.begin_date, a.ADMIT_DATE) as outcome_date length=4 format=mmddyy10.  from def_1a_dx_1st(where=(&current=1)) a
    join refine_PX(where=(cpt_chemo=1)) b
    on a.PATID=b.PATID and (a.begin_date=b.begin_date>. or a.ADMIT_DATE=b.ADMIT_DATE>.);
quit;
    proc sort data=def_1d_px_dx; by PATID outcome_date ;run;
    data def_1d;
    set def_1d_px_dx;
    length Def_1d 3 outcome_start_date 4; format outcome_start_date mmddyy10.;
    by PATID outcome_date;
    Def_1d=1;
    outcome_start_date=outcome_date;
    if first.outcome_date;
    run;

/*
    definition 1e
 1 cancer diagnosis + any radiation therapy during the same hospitalization and/or visit

    data def_1e;
    set dx_px;
    by PATID;
    if &current=1 then  Dx_malig_date=outcome_dt; retain Dx_malig_date ;
    if first.PATID and &current ^=1 then Dx_malig_date=.;
    def_1e = 0;
    if radiation =1 and (Dx_malig_date=outcome_dt) then def_1e =1;
    if def_1e=1;
    format dx_malig_date mmddyy10.;
    run;

*/

PROC SQL;
    create table def_1e_px_dx as 
    select a.PATID, a.begin_date, a.ADMIT_DATE, a.DX, b.PX, coalesce(a.begin_date, a.ADMIT_DATE) as outcome_date length=4 format=mmddyy10.  from def_1a_dx_1st(where=(&current=1)) a
    join refine_PX(where=(radiation =1)) b
    on a.PATID=b.PATID and (a.begin_date=b.begin_date>. or a.ADMIT_DATE=b.ADMIT_DATE>.);
quit;
    proc sort data=def_1e_px_dx; by PATID outcome_date ;run;
    data def_1e;
    set def_1e_px_dx;
    length Def_1e 3 outcome_start_date 4; format outcome_start_date mmddyy10.;
    by PATID outcome_date;
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
            by PATID;
            if &current=1 then  Dx_Leuk_date=outcome_dt; retain Dx_Leuk_date ;
            if first.PATID and &current^=1 then dx_leuk_date=.;
            def_1f =0;
            if hema_stem_trans =1 and (dx_leuk_date=outcome_dt) then def_1f =1;
            format dx_leuk_date mmddyy10.;
        run;
 */



    %if &n <8 %then %do;
PROC SQL;
    create table def_1f_px_dx as 
    select a.PATID, a.begin_date, a.ADMIT_DATE, a.DX, b.PX, 
    coalesce(a.begin_date, a.ADMIT_DATE) as outcome_date length=4 format=mmddyy10.  from def_1a_dx_1st(where=(&current=1)) a
    join refine_PX(where=(hema_stem_trans =1)) b
    on a.PATID=b.PATID and (a.begin_date=b.begin_date>. or a.ADMIT_DATE=b.ADMIT_DATE>.);
quit;
    proc sort data=DEF_1F_PX_DX; by PATID outcome_date; run;
    data def_1f;
    set def_1f_px_dx;
    length Def_1f 3 ;
    by PATID outcome_date;
    Def_1f=1;
    outcome_start_date=outcome_date;
    if first.outcome_date;
    run;
    %end; %else %do;
    data def_1f(keep=PATID outcome_date Def_1f outcome_start_date);
    set def_1a_dx_1st(rename=begin_date=outcome_date);
    length Def_1f 3 ;
    Def_1f=1;
    outcome_start_date=outcome_date;
    if 0;
    run;
    %end;
proc sort data=def_1f; by PATID outcome_date;run;

/*
    definition 1g
 1 cancer diagnosis + oral chemotherapy dispensing within 2 weeks after the diagnosis

    data def_1G;
        set dx_rx;
        by PATID;
        retain dx_&current;
        if table='DX' and &current= 1 then Dx_&current=outcome_dt;
        if first.PATID and &current^= 1 then dx_&current=.;
        def_1G=0;
        if (table='RX' and &current= 1 ) and (0< (outcome_dt-dx_&current) <=14) then def_1G =1;
        if def_1g=1;
            format Dx_&current mmddyy10.;
    run; 
*/


PROC SQL;
    create table def_1g_dx_rx as 
    select a.PATID, a.begin_date, a.ADMIT_DATE, b.DISPENSE_DATE, a.DX, b.NDC, 
    max(b.DISPENSE_DATE, a.begin_date) as outcome_date length=4 format=mmddyy10.,
    min(b.DISPENSE_DATE, a.begin_date) as outcome_start_date length=4 format=mmddyy10.
    from def_1a_dx_1st(where=(&current=1)) a
    join refine_RX(where=(&current= 1)) b
    on a.PATID=b.PATID and ( 0<= (b.DISPENSE_DATE-a.begin_date) <=14 );
quit;
    proc sort data=def_1g_dx_rx; by PATID outcome_date descending outcome_start_date;run;
    data def_1g;
    set def_1g_dx_rx;
    length Def_1g 3 ;
    by PATID outcome_date descending outcome_start_date;
    Def_1g=1;
    if first.outcome_date;
    run;

    /* WORKS FOR !!!*/
/* definiton 2;
 2 diagnoses of cancer within 2 months;
    data def_2;
        set Cancer_dat_DX(where=(&current=1)  rename=(BEGIN_DATE=outcome_dt));
        by PATID;
        retain date1 date2 first_&current; 
        if first.PATID then do; first_&current=outcome_dt; date1 =.; date2=.; end;
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
    select a.PATID, a.begin_date, max(a.begin_date, b.begin_date) as outcome_date length=4 format=mmddyy10.,
    min(a.begin_date, b.begin_date) as outcome_start_date length=4 format=mmddyy10. from def_1a_dx_1st(where=(&current=1)) a
    join def_1a_dx_1st(where=(&current=1)) b
    on a.PATID=b.PATID and  0 <= intck('month',b.begin_date, a.begin_date)<=2 and 0< (b.begin_date-a.begin_date) ;
quit;
    proc sort data=def_2_dx_dx; by PATID outcome_date descending outcome_start_date;run;
    data def_2;
    set def_2_dx_dx;
    length Def_2 3 ;
    by PATID outcome_date descending outcome_start_date;
    Def_2=1;
    if first.outcome_date;
    run;

data cancer_&current.(keep=PATID outcome_date def: cancer outcome_start_date:);
merge 
def_1a(rename=outcome_start_date=outcome_start_date1a) 
def_1b(rename=outcome_start_date=outcome_start_date1b) 
def_1c(drop=outcome_start_date) def_1d(drop=outcome_start_date) def_1e(drop=outcome_start_date) def_1f(drop=outcome_start_date)
def_1g(rename=outcome_start_date=outcome_start_date1g) 
def_2(rename=outcome_start_date=outcome_start_date2);
length cancer $20 outcome_start_date 4;
format outcome_start_date mmddyy10.;
by PATID outcome_date;
outcome_start_date=max(outcome_start_date1a, outcome_start_date1b, outcome_start_date1g, outcome_start_date2, outcome_date);
cancer="&current.";
run;
proc freq data=cancer_&current.; tables def_:;run;
%end;
%mend cancer_loop;
%cancer_loop;

data outcome_cancer;
set  cancer_all cancer_cll cancer_oth_ll cancer_aml cancer_cml cancer_oth_ml cancer_mono_leuk cancer_oth_leuk
 cancer_nhl_nos cancer_hodgkin cancer_nodnhl cancer_mycoses cancer_histiocyt cancer_hcl cancer_letterer cancer_mastcell cancer_periph_tcell cancer_lymphoma_nos
 cancer_otherlymphhisto cancer_mm cancer_plasma cancer_wald cancer_head_neck cancer_esophagus
 cancer_stomach cancer_sm_intest cancer_colon cancer_rectum cancer_anus cancer_liver cancer_gall cancer_pancreas cancer_perit cancer_digest cancer_lung cancer_thoracic cancer_bone cancer_connect cancer_malmel
 cancer_female_breast cancer_male_breast cancer_ks cancer_uterus cancer_cervix cancer_placenta cancer_ovary cancer_oth_fem cancer_prostate cancer_testis cancer_penis cancer_bladder cancer_kidney
 cancer_oth_urin cancer_eye cancer_brain cancer_oth_nerv cancer_thyroid cancer_oth_endo cancer_oth_def;
length outcome $20;
outcome="cancer";
run;

