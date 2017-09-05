*  University of Alabama at Birmingham                               *
*  AS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=queryFracturesControl; * type the name of your program here (without the filename extension);
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


From: Chen, Lang [mailto:langchen@uabmc.edu] 
Sent: Monday, July 24, 2017 8:56 AM
To: Benjamin Chan <chanb@ohsu.edu>
Subject: RE: fracture identification algorithm

Here it is. 
For 001_fx_data, find all fx related claim and run the algorithm.
Please ignore any code after line 476
Modify code from line 1 -50

For 002_fx_epi_data
Define fx episode.

Final output data is fx_dgns_&firstyr._&lastyr._4. Please let me if you have any questions.
 */


/* 
START OF 001_fx_data.sas
 */


/*Assign "Broad" fracture site (fx_site) for all ICD9 diagnoses, outputting separately, so some records are cloned, then combining into one file */
/*No longer using matched trauma files here*/

%macro comballfxdgns;
    data fx_dgns;
        set UCB.tempFracDxMPCDControl (where = (diagCodeType = "Fracture code"))
            /* UCB.tempFracDxSABRControl (where = (diagCodeType = "Fracture code")) */;
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
        set UCB.tempFracDxMPCDControl (where = (diagCodeType = "Extended care code"))
            /* UCB.tempFracDxSABRControl (where = (diagCodeType = "Extended care code")) */;
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


/*###########################################################################################################*/
/*************************************************************************************************************/
/*Look for repair procedures and assign treatment site*******************/
/*This code has been updated to include hip/femur replacement with matching diagnosis code, also looked in claim strip(DX) not just primary strip(DX) 
/*Not accepting contiguous sites until later*/
/*Excluding procedures from DME files*/
/*******************************Select All Spine Imaging Codes from STD Procedure Files for CQ=4/5 algorithms*/

%macro fx_prcd;
    data fx_prcd spine_xray;
        set UCB.tempFracPxMPCDControl
            /* UCB.tempFracPxSABRControl */;

            length tx_site $30;
            length HLAT $1;

            if strip(px) in ('21300' '21310' '21315' '21320' '21325' '21330' '21335' '21336' '21337' '21338' '21339' '21340' '21343' '21344' '21345' '21346' '21347' '21348' 
                                 '21355' '21356' '21360' '21365' '21366' '21385' '21386' '21387' '21390' '21395' '21400' '21401' '21406' '21407' '21408' '21421' '21422' '21423' 
                                 '21431' '21432' '21433' '21435' '21436' '21440' '21445' '21450' '21451' '21452' '21453' '21454' '21461' '21462' '21465' '21470'
                                 '62000' '62005' '62010')  and lengthn(strip(px)) = 5 then do; 
                tx_site='(800-804) skull/face'; output fx_prcd; end; 

            if strip(px) in ('22305' '22310' '22315' '22318' '22319' '22325' '22326' '22327' '22328' '22520' '22521' '22522' '22523' '22524' '22525' '76012' '76013' 
                                 'S2360' 'S2361' 'S2362' 'S2363' '72291' '72292')  and lengthn(strip(px)) = 5 then do;
                tx_site = '(805, 806, 73313) spine'; output fx_prcd; end;
     
            if  strip(px) in ('21493' '21494' '21495' '21800' '21805' '21810' '21820' '21825' ) then do;
                tx_site='(807) rib/sternum/trachea'; output fx_prcd; end;

            if strip(px) in ('27193' '27194' '27215' '27216' '27217' '27218' '27220' '27222' '27226' '27227' '27228')  and lengthn(strip(px)) = 5 then do;
                tx_site = '(808) pelvis'; output fx_prcd; end;

            if strip(px) in ('23500' '23505' '23515')  and lengthn(strip(px)) = 5 then do;
                tx_site = '(810) clavicle'; output fx_prcd; end;

            if strip(px) in ('23570' '23575' '23585') then do;
                tx_site= '(811) scapula'; output fx_prcd; end;  

            if strip(px) in ('23600' '23605' '23615' '23616' '23620' '23625' '23630' '23665' '24500' '24505' '24515' '24516' '24530' '24535' '24538' '24545' '24546' '24560'
                         '24565' '24566' '24575' '24576' '24577' '24579' '24582')  and lengthn(strip(px)) = 5 then do;
                tx_site = '(812, 73311) humerus'; output fx_prcd; end;
                    
            if strip(px) in ('25600' '25605' '25606' '25607' '25608' '25609' '25620' '25650' '25651' '25652')  and lengthn(strip(px)) = 5 then do;
                tx_site = '(813, 73312) radius_ulna'; output fx_prcd; end; /*Procedure codes are the same for both categories*/
        
            if strip(px) in ('24650' '24655' '24665' '24666' '24670' '24675' '24685' '25500' '25505' '25515' '25520' '25525' '25526' '25530' '25535' '25545' '25560' '25565'
                         '25574' '25575')  and lengthn(strip(px)) = 5 then do;
                tx_site = '(813, 73312) radius_ulna'; output fx_prcd; end; /*Procedure codes are the same for both categories*/
           
            if strip(px) in ('25622' '25624' '25628' '25630' '25635' '25645' '25680' '25685')  and lengthn(strip(px)) = 5 then do;
                tx_site = '(814) carpal'; output fx_prcd; end;   
        
            if strip(px) in ('26600' '26605' '26607' '26608' '26615' '26645' '26650' '26665' '26720' '26725' '26727' '26735' '26740' '26742' '26746' '26750' '26755' '26756' '26765' )
                       and lengthn(strip(px)) = 5 then do;
                tx_site='(815-817) hand/fingers'; output fx_prcd; end;  

            if '27230' <= strip(px) <= '27248' and lengthn(strip(px)) = 5 then do;
                tx_site = '(820, 73314) hip'; output fx_prcd; end;

            if '27500' <= strip(px) <= '27514'  and lengthn(strip(px)) = 5 then do;
                tx_site = '(821, 73315) femur'; output fx_prcd; end;

            if strip(px) in ('27520' '27524')  and lengthn(strip(px)) = 5 then do;
                tx_site = '(822) patella'; output fx_prcd; end;  

            if ('27530' <= strip(px) <= '27536' or '27750' <= strip(px) <= '27759' or '27780' <= strip(px) <= '27784' or '27824' <= strip(px) <= '27828') and lengthn(strip(px)) = 5  then do;
                tx_site = '(823, 73316) tib_fib'; output fx_prcd; end;

            if strip(px) in ('27760' '27762' '27766' '27786' '27788' '27792' '27808' '27810' '27814' '27816' '27818' '27822' '27823' '28430' '28435' '28436' '28445')  and lengthn(strip(px)) = 5 then do;
                tx_site = '(824) ankle'; output fx_prcd; end;
 
            if strip(px) in ('28320' '28322' '28400' '28405' '28406' '28415' '28420' ) and lengthn(strip(px)) = 5 then do; 
                tx_site='(825) tarsal_metatarsal'; output fx_prcd; end;

         /********************************Hip/Femur Additions - must be matched with DGNS to be included*/
         /*Hip replacement codes*/
            /*Hip*/
            if strip(px) in ('27130' '27125') and lengthn(strip(px)) = 5  then do;
                HLAT='1'; tx_site = '(820, 73314) hip'; output fx_prcd; end;
    
            /*Codes below are the only ICD9 Procedure Codes that we are using for "repair"*/
            if strip(px) in ('8151' '8152') and lengthn(strip(px)) = 4 then do;
                HLAT = '1'; tx_site = '(820, 73314) hip'; output fx_prcd; end;
     
            /*Femur repair codes, assigned to both Hip and Femur treatment sites... CHECK - MAYBE WE NEED TO DO THIS THE OTHER WAY AS WELL*/
            /*Hip*/
            if strip(px) in ('7855' '7905' '7915' '7925' '7935' '7965') and lengthn(strip(px)) = 4 then do;
                HLAT = '1'; tx_site = '(820, 73314) hip'; output fx_prcd; end;
        
            /*Femur*/
            if strip(px) in ('7855' '7905' '7915' '7925' '7935' '7965') and lengthn(strip(px)) = 4 then do;
                HLAT = '1'; tx_site = '(821, 73315) femur'; output fx_prcd; end;
             /*spine image*/
                if '72010' <= strip(px) <= '72159' or '72240' <= strip(px) <= '72285' or strip(px) = '72295' then do;   /*Spine Imaging Codes*/
                tx_site='(805, 806, 73313) spine';
                output spine_xray; end;  
 
    run;

    data fx_prcd;
        set fx_prcd;
        /*To add laterality info*/
/*        array hcpcs{*} hcpcs_1st_mdfr_cd hcpcs_2nd_mdfr_cd hcpcs_3rd_mdfr_cd hcpcs_4th_mdfr_cd ; */
        if HLAT='1' then do;
            repair_right='0'; repair_left='0'; 
        end;
/*        if HLAT='1' then */
/*            do i=1 to dim(hcpcs);*/
/*                if hcpcs{i} = 'RT' then repair_right='1';*/
/*                else if hcpcs{i} = 'LT' then repair_left='1';*/
/*            end;*/
    run;
    proc sort data=fx_prcd nodupkey; by patid ENCOUNTERID px_date tx_site; run;
 
    data spine_xray;
        set spine_xray;
        keep patid px_date tx_site  ENCOUNTERID begin_date;
    run;
    proc sort data=spine_xray nodupkey; by patid px_date; run;
%mend;
%fx_prcd; 



data trauma (rename=(begin_date=trauma_dt));
        set UCB.tempFracDxMPCDControl (where = (diagCodeType = "Trauma code"))
            /* UCB.tempFracDxSABRControl (where = (diagCodeType = "Trauma code")) */;
run;
proc sort data= trauma(keep=patid trauma_dt) nodupkey; by patid trauma_dt;run;


/*subset the spine xray procedure claim for patients with fx diagnosis code only*/
/*so SAS will not run out of memory*/
data fx_spine_xray(keep=patid tx_site px_date ENCOUNTERID begin_date);
if _n_=1 then do;
  declare hash hid(dataset:"fx_dgns_3(where=(fx_site='(805, 806, 73313) spine')))", multidata:"N", hashexp:20);
  rc=hid.defineKey("patid");
  rc=hid.defineDone();
end;
set spine_xray;
rc=hid.find();
if rc=0;
run;
/*subset the Trauma code for patients with fx diagnosis code only*/
/*so SAS will not run out of memory*/
data fx_trauma(drop=rc);
if _n_=1 then do;
  declare hash hid(dataset:"fx_dgns_3", multidata:"N", hashexp:20);
  rc=hid.defineKey("patid");
  rc=hid.defineDone();
end;
set trauma;
rc=hid.find();
if rc=0;
run;
/************************************Link Fracture Claims (ICD9 Diagnosis) with Repair Claims (CPT/HCPCS, some ICD9 procedure code)***************/

data fx_dgns_4(drop=rc: px_date tx_site xray_date trauma_dt);
if _n_=1 then do;
  declare hash hid(dataset:"fx_prcd", multidata:"N", hashexp:20);
  rc=hid.defineKey("patid", "px_date", "tx_site");
/*  rc=hid.defineData("px_date", "tx_site");*/
  rc=hid.defineDone();
  declare hash hxray(dataset:"fx_spine_xray(rename=px_date=xray_date)", multidata:"Y", hashexp:20);
  rc=hxray.defineKey("patid", "tx_site");
  rc=hxray.defineData("xray_date");
  rc=hxray.defineDone();
  declare hash htrauma(dataset:"fx_trauma", multidata:"Y", hashexp:20);
  rc=htrauma.defineKey("patid");
  rc=htrauma.defineData("trauma_dt");
  rc=htrauma.defineDone();
end;
if 0 then set fx_prcd(keep=patid px_date tx_site) 
              fx_spine_xray(keep=patid px_date tx_site rename=px_date=xray_date)
              fx_trauma;
set fx_dgns_3;
length cq $4 spine_image trauma_date 4 trauma $1;
format spine_image trauma_date mmddyy10.;
cq="0000";
rc=hid.find(key:patid, key:begin_date,key:fx_site);
if rc^=0 then do;
    px_date=.;
    tx_site=" ";
end;
if enc_type="IP" then do;
/*CQ = 1 Inpatient claim with primary diagnosis code */
    if pdx="P" then substr(cq,1,1)="1";
/*CQ = 2 Inpatient claim with secondary diagnosis code*/
    else substr(cq,2,1)="2";
end; else do;
/*CQ = 3 outpatient diagnosis code AND carrier line with repair/replace HCPCS*/
    if rc=0 then substr(cq,3,1)="3";
    rc1=hxray.find(key:patid, key:fx_site);
    do while (rc1 = 0);
        if begin_date-10 <=xray_date<= begin_date then do;
            if enc_type in ("AV" "IF" "NH" "HH" "ER" "ED") then do;
/*CQ = 4 outpatient [Physician E&M codes] diagnosis code with spine image/x-ray within 10 day early*/
                substr(cq,4,1)="4";
                spine_image=min(spine_image,xray_date);
            end;
        end;
        rc1=hxray.find_next(key:patid, key:fx_site);
    end;
end;
/*is there trauma dx within 14 days*/
rc2=htrauma.find(key:patid);
do while (rc2 = 0) ;
    if 0<=abs(trauma_dt-begin_date)<=14 then do;
            trauma="1";
            trauma_date=min(trauma_date,trauma_dt);
   end ;    
   rc2=htrauma.find_next(key:patid) ;
end;

run;
proc freq data=fx_dgns_4; tables enc_type*cq fx_site*cq trauma/missing;run;

*goto 002_fx_epi.sas;




/* 
START OF 002_fx_data.sas
 */

/*all the claims to define episode sequence */
data _dat0(keep=
PATID ENCOUNTERID ADMIT_DATE DISCHARGE_DATE BEGIN_DATE END_DATE DX DX_TYPE PDX  /* SOURCE */ ENC_TYPE fx_site px px_date
site cq spine_image trauma_date trauma );
set fx_dgns_4 fx_excare Fx_prcd(rename=tx_site=fx_site);
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

proc sort data = Work.seq_COMBO;
  by patid seq_start_date;
run;

data combo_seq;
set seq_COMBO;
by patid seq_start_date;
length combo_fx_site $30. combo_seq 4;
retain combo_seq 0 combo_fx_site;
if first.patid or seq_start_date-lag(seq_start_date) then combo_seq=1+combo_seq;
where seq_cq^='0000' and seq_cq^=' ';
if combo_fx_site=" " or ""<site_order<lag(site_order) then combo_fx_site=fx_site;
run;

proc sort data = Work.seq_COMBO;
  by patid seq;
run;

data FX_CLM_DB;
merge _dat2 seq_start seq_end seq_cq(drop=fx_site) seq_COMBO(keep=patid seq alone_combo);
by patid seq;
run;

proc sql;
select count(distinct seq) from FX_CLM_DB;
quit;




/* 
Collapse to fracture episodes

Q: Why are some seq_start_date values missing?
 */
proc sort 
  data = Work.fx_clm_db 
  out = Work.fractureEpisodes (drop = seq
                               rename = (seq_start_date = fractureEpisodeStart
                                         seq_end_date = fractureEpisodeEnd
                                         fx_site = fractureSite))
  nodupkey;
  by patid seq seq_start_date seq_end_date fx_site;
run;

proc sql;
  create table DT.fractureEpisodesPrevControl as
    select A.database,
           A.cohort,
           A.indexDate,
           A.controlID,
           A.age,
           A.sex,
           B.*,
           case
             when prxmatch("/spine/", B.fractureSite) then "Clinical vertebral fracture"
             when prxmatch("/(hip)|(pelvis)|(femur)|(humerus)|(radius)|(ulna)/", B.fractureSite) then "Non-vertebral osteoporotic fracture"
             else ""
             end as fractureType
    from DT.controlLookup A inner join
         Work.fractureEpisodes B on (A.patid = B.patid);
  create table Work.summaryFractureEpisodesPrev as
    select "DT.fractureEpisodesPrevControl" as table,
           fractureType, fractureSite,
           count(distinct patid) as countDistinctPatid,
           count(*) as countFractureEpisodes
    from DT.fractureEpisodesPrevControl
    group by fractureType, fractureSite;
  select * from Work.summaryFractureEpisodesPrev;
  select "DT.fractureEpisodesPrevControl" as table,
         sum(countDistinctPatid) as sumDistinctPatid,
         sum(countFractureEpisodes) as sumFractureEpisodes
    from Work.summaryFractureEpisodesPrev;
quit;




proc export
  data = Work.summaryFractureEpisodesPrev
  outfile = "data\processed\&cmt..csv"
  dbms = csv
  replace;
  delimiter = '09'x;
run;


ods html close;
