*********************************************************************
*  University of Alabama at Birmingham                               *
*  AMGEN CMS project                                                 *
**********************************************************************;
options pagesize=60 linesize=150 pageno=1 missing=' ' nodate FORMCHAR="|----|+|---+=|-/\<>*" msglevel=i fullstimer;
* Programmer    : Shanette Daigle

                  01/05/2017  v1  This program creates the fracture aggregate file for Year 6 (through 2014)
                                  Note that beginning in Year 6, Standardized Diagnosis Files and Standardized Procedures Files have been split into multiple files per year because of increasing file size 
* Modify date   :
;



%let cmt=FX_MarketScan_DB_06_14 - create dataset v1;
%let pgm=&cmt..sas;
/*%let pgms=&outputfolder.\Fracture Aggregate File\; */
%let opt=/missing norow nocol nopercent;
%include "h:\studies\PV\formats\libname.txt";
footnote "&pgm.";
footnote2 "%sysfunc(datetime(),datetime14.)";
title1 '--- Pharmacovigilence project ---';

**********************************************************************;
options macrogen mlogic mprint symbolgen;
options nomacrogen nomlogic nomprint nosymbolgen;

%let htmlname=%sysfunc(translate(%quote(&cmt), '_',' '));  * Translate spaces into underscores;
%put &htmlname;


%let firstyear=2010;
%let firstyr=%substr(&firstyear,3,2);

%let lastyear=2015;  
%let lastyr=%substr(&lastyear,3,2);

%let ob=obs=100000;
%let ob=;

%let in_lib=stdmks;  /* lib name of standardized file*/

/*Save files to my temp library because they are large*/
/*options user=lang4;*/
/*proc datasets lib=SGD2 kill; quit;*/

/*******************************************************************SAVE LOG*/
PROC PRINTTO log="&outputfolder.\fx_agre.log.";
%put START TIME: %sysfunc(datetime(),datetime14.);


/*Creates Year-Specific Fracture ICD Diagnosis Files and Trauma ICD Diagnosis Files*/

%macro fxdgnstrauma;
    %do year=&firstyear %to &lastyear;

        data fx_dgns_file_&year(label="DX fx claim")
             fx_excare_file_&year(label="DX extend care claim") 
             trauma_&year; /*Only keeping patid and claim_date for the Trauma M2M Macro Later*/

            set &in_lib..dx_&year;
            if '800' <=: strip(DX) <=: '829' or strip(DX) =: '7331' then
                output fx_dgns_file_&year; /*Relevant fracture diagnosis substrings*/
            if strip(DX) in: ('V541' 'V542') then
                output fx_excare_file_&year; /*Relevant fracture diagnosis substrings*/
            if 'E800' <=: strip(DX) <=: 'E848' or 'E881' <=: strip(DX) <=: 'E884' or 'E908' <=: strip(DX) <=: 'E909' or 'E916' <=: strip(DX) <=: 'E928' then
                output trauma_&year; /*Relevant trauma diagnosis substrings*/
        run;
    %end;
%mend;
%fxdgnstrauma;



/*Assign "Broad" fracture site (fx_site) for all ICD9 diagnoses, outputting separately, so some records are cloned, then combining into one file */
/*No longer using matched trauma files here*/

%macro comballfxdgns;
    data fx_dgns_&firstyr._&lastyr;
        set %do year=&firstyear %to &lastyear; fx_dgns_file_&year %end;;
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
    data fx_excare_&firstyr._&lastyr;
        set %do year=&firstyear %to &lastyear; fx_excare_file_&year %end;;
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

    proc sort data=fx_dgns_&firstyr._&lastyr; by patid BEGIN_DATE fx_site; run; /*183,292,694*/
    proc sort data=fx_excare_&firstyr._&lastyr; by patid BEGIN_DATE fx_site; run; /*183,292,694*/
%mend;
%comballfxdgns;

proc print data=fx_dgns_&firstyr._&lastyr (obs=30);
    run;
proc freq data=fx_dgns_&firstyr._&lastyr;
    tables fx_site;
run;


/*Now, assign a more specific fracture site (e.g., closed, other) (site) that is used in the CQ algorithms*/
/*Since Expanded Diagnosis Codes (V Codes) apply to sub-categories of each broad fracture site, clone records for these so they appear in both places*/

data fx_dgns_&firstyr._&lastyr._2;  /*183,292,694*/
    set fx_dgns_&firstyr._&lastyr;

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
data fx_dgns_&firstyr._&lastyr._3;
    set fx_dgns_&firstyr._&lastyr._2
/*    fx_excare_&firstyr._&lastyr.*/
        ;
run;

title2 "Combined Diagnosis file (original and cloned):  fx_dgns_&firstyr._&lastyr._3";
proc freq data=fx_dgns_&firstyr._&lastyr._3;
    tables fx_site site;
run;

proc sort data=fx_dgns_&firstyr._&lastyr._3;
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
    %do year=&firstyear %to &lastyear;
        data fx_prcd_&year spine_xray_&year;
            set &in_lib..px_&year;
            length tx_site $30;
            length HLAT $1;

            if strip(px) in ('21300' '21310' '21315' '21320' '21325' '21330' '21335' '21336' '21337' '21338' '21339' '21340' '21343' '21344' '21345' '21346' '21347' '21348' 
                                 '21355' '21356' '21360' '21365' '21366' '21385' '21386' '21387' '21390' '21395' '21400' '21401' '21406' '21407' '21408' '21421' '21422' '21423' 
                                 '21431' '21432' '21433' '21435' '21436' '21440' '21445' '21450' '21451' '21452' '21453' '21454' '21461' '21462' '21465' '21470'
                                 '62000' '62005' '62010')  and lengthn(strip(px)) = 5 then do; 
                tx_site='(800-804) skull/face'; output fx_prcd_&year; end; 

            if strip(px) in ('22305' '22310' '22315' '22318' '22319' '22325' '22326' '22327' '22328' '22520' '22521' '22522' '22523' '22524' '22525' '76012' '76013' 
                                 'S2360' 'S2361' 'S2362' 'S2363' '72291' '72292')  and lengthn(strip(px)) = 5 then do;
                tx_site = '(805, 806, 73313) spine'; output fx_prcd_&year; end;
     
            if  strip(px) in ('21493' '21494' '21495' '21800' '21805' '21810' '21820' '21825' ) then do;
                tx_site='(807) rib/sternum/trachea'; output fx_prcd_&year; end;

            if strip(px) in ('27193' '27194' '27215' '27216' '27217' '27218' '27220' '27222' '27226' '27227' '27228')  and lengthn(strip(px)) = 5 then do;
                tx_site = '(808) pelvis'; output fx_prcd_&year; end;

            if strip(px) in ('23500' '23505' '23515')  and lengthn(strip(px)) = 5 then do;
                tx_site = '(810) clavicle'; output fx_prcd_&year; end;

            if strip(px) in ('23570' '23575' '23585') then do;
                tx_site= '(811) scapula'; output fx_prcd_&year; end;  

            if strip(px) in ('23600' '23605' '23615' '23616' '23620' '23625' '23630' '23665' '24500' '24505' '24515' '24516' '24530' '24535' '24538' '24545' '24546' '24560'
                         '24565' '24566' '24575' '24576' '24577' '24579' '24582')  and lengthn(strip(px)) = 5 then do;
                tx_site = '(812, 73311) humerus'; output fx_prcd_&year; end;
                    
            if strip(px) in ('25600' '25605' '25606' '25607' '25608' '25609' '25620' '25650' '25651' '25652')  and lengthn(strip(px)) = 5 then do;
                tx_site = '(813, 73312) radius_ulna'; output fx_prcd_&year; end; /*Procedure codes are the same for both categories*/
        
            if strip(px) in ('24650' '24655' '24665' '24666' '24670' '24675' '24685' '25500' '25505' '25515' '25520' '25525' '25526' '25530' '25535' '25545' '25560' '25565'
                         '25574' '25575')  and lengthn(strip(px)) = 5 then do;
                tx_site = '(813, 73312) radius_ulna'; output fx_prcd_&year; end; /*Procedure codes are the same for both categories*/
           
            if strip(px) in ('25622' '25624' '25628' '25630' '25635' '25645' '25680' '25685')  and lengthn(strip(px)) = 5 then do;
                tx_site = '(814) carpal'; output fx_prcd_&year; end;   
        
            if strip(px) in ('26600' '26605' '26607' '26608' '26615' '26645' '26650' '26665' '26720' '26725' '26727' '26735' '26740' '26742' '26746' '26750' '26755' '26756' '26765' )
                       and lengthn(strip(px)) = 5 then do;
                tx_site='(815-817) hand/fingers'; output fx_prcd_&year; end;  

            if '27230' <= strip(px) <= '27248' and lengthn(strip(px)) = 5 then do;
                tx_site = '(820, 73314) hip'; output fx_prcd_&year; end;

            if '27500' <= strip(px) <= '27514'  and lengthn(strip(px)) = 5 then do;
                tx_site = '(821, 73315) femur'; output fx_prcd_&year; end;

            if strip(px) in ('27520' '27524')  and lengthn(strip(px)) = 5 then do;
                tx_site = '(822) patella'; output fx_prcd_&year; end;  

            if ('27530' <= strip(px) <= '27536' or '27750' <= strip(px) <= '27759' or '27780' <= strip(px) <= '27784' or '27824' <= strip(px) <= '27828') and lengthn(strip(px)) = 5  then do;
                tx_site = '(823, 73316) tib_fib'; output fx_prcd_&year; end;

            if strip(px) in ('27760' '27762' '27766' '27786' '27788' '27792' '27808' '27810' '27814' '27816' '27818' '27822' '27823' '28430' '28435' '28436' '28445')  and lengthn(strip(px)) = 5 then do;
                tx_site = '(824) ankle'; output fx_prcd_&year; end;
 
            if strip(px) in ('28320' '28322' '28400' '28405' '28406' '28415' '28420' ) and lengthn(strip(px)) = 5 then do; 
                tx_site='(825) tarsal_metatarsal'; output fx_prcd_&year; end;

         /********************************Hip/Femur Additions - must be matched with DGNS to be included*/
         /*Hip replacement codes*/
            /*Hip*/
            if strip(px) in ('27130' '27125') and lengthn(strip(px)) = 5  then do;
                HLAT='1'; tx_site = '(820, 73314) hip'; output fx_prcd_&year; end;
    
            /*Codes below are the only ICD9 Procedure Codes that we are using for "repair"*/
            if strip(px) in ('8151' '8152') and lengthn(strip(px)) = 4 then do;
                HLAT = '1'; tx_site = '(820, 73314) hip'; output fx_prcd_&year; end;
     
            /*Femur repair codes, assigned to both Hip and Femur treatment sites... CHECK - MAYBE WE NEED TO DO THIS THE OTHER WAY AS WELL*/
            /*Hip*/
            if strip(px) in ('7855' '7905' '7915' '7925' '7935' '7965') and lengthn(strip(px)) = 4 then do;
                HLAT = '1'; tx_site = '(820, 73314) hip'; output fx_prcd_&year; end;
        
            /*Femur*/
            if strip(px) in ('7855' '7905' '7915' '7925' '7935' '7965') and lengthn(strip(px)) = 4 then do;
                HLAT = '1'; tx_site = '(821, 73315) femur'; output fx_prcd_&year; end;
             /*spine image*/
                if '72010' <= strip(px) <= '72159' or '72240' <= strip(px) <= '72285' or strip(px) = '72295' then do;   /*Spine Imaging Codes*/
                tx_site='(805, 806, 73313) spine';
                output spine_xray_&year; end;  
 
    %end;
    run;

    data fx_prcd;  /*7,111,777*/
        set %do year=&firstyear %to &lastyear; fx_prcd_&year %end;;
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
    proc sort data=fx_prcd nodupkey; by patid ENCOUNTERID px_date tx_site; run;      /*6,232,497*/ 
 
    data spine_xray;  /*45,816,552*/
        set %do year=&firstyear %to &lastyear; spine_xray_&year %end;;
        keep patid px_date tx_site  ENCOUNTERID begin_date;
    run;
    proc sort data=spine_xray nodupkey; by patid px_date; run;   /*26,146,253*/ 
%mend;
%fx_prcd; 

proc print data=fx_prcd (obs=25);
    run;

data trauma (rename=(begin_date=trauma_dt));   /*4,121,118*/
    set trauma_20:;
run;
proc sort data= trauma(keep=patid trauma_dt) nodupkey; by patid trauma_dt;run;

/*subset the spine xray procedure claim for patients with fx diagnosis code only*/
/*so SAS will not run out of memory*/
data fx_spine_xray(keep=patid tx_site px_date ENCOUNTERID begin_date);
if _n_=1 then do;
  declare hash hid(dataset:"fx_dgns_&firstyr._&lastyr._3(where=(fx_site='(805, 806, 73313) spine')))", multidata:"N", hashexp:20);
  rc=hid.defineKey("patid");
  rc=hid.defineDone();
end;
set spine_xray;
rc=hid.find();
if rc=0;
run;
/*subset the trauma claim for patients with fx diagnosis code only*/
/*so SAS will not run out of memory*/
data fx_trauma(drop=rc);
if _n_=1 then do;
  declare hash hid(dataset:"fx_dgns_&firstyr._&lastyr._3", multidata:"N", hashexp:20);
  rc=hid.defineKey("patid");
  rc=hid.defineDone();
end;
set trauma;
rc=hid.find();
if rc=0;
run;
/************************************Link Fracture Claims (ICD9 Diagnosis) with Repair Claims (CPT/HCPCS, some ICD9 procedure code)***************/

data fx_dgns_&firstyr._&lastyr._4(drop=rc: px_date tx_site xray_date trauma_dt);
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
set fx_dgns_&firstyr._&lastyr._3;
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
proc freq data=fx_dgns_&firstyr._&lastyr._4; tables enc_type*cq fx_site*cq trauma/missing;run;

*goto 002_fx_epi.sas;















































/*all the claims used to aggregrate to fracure episode file*/
data fx_aggr_new_2(keep=
PATID ENCOUNTERID ADMIT_DATE DISCHARGE_DATE BEGIN_DATE END_DATE DX DX_TYPE PDX  SOURCE ENC_TYPE fx_site px tx_site 
site cq spine_image trauma_date trauma );
set fx_dgns_&firstyr._&lastyr._4 fx_excare_&firstyr._&lastyr
fx_prcd;
run;


***********************************************************************************************EPISODE ALGORITHM
MACRO VARIABLES:
REQUIRED:
data = Name of the dataset to be created
fx_aggr_data = Name of the fracture aggregate file
where = where statement to select records with icd9 codes pertaining to fractures of interest
mrg = 1 if the merge statement to create &data.1 required for fracture aggr files not restricted to eligible subjects, any other value to skip the step

id = name of the variable that uniquely identifies each subject, subject ID
file = variable which has the information about the file, a record comes from
start = name of the variable indicating start of lookback period
clm_dt = variable indicating the claim date of the current record
icd = variable containing the icd9 dx code
cq = single CQ variable indicating the case qualifying type for each record
eos = end of study date

OPTIONAL:
mrg_data = single record per subject file identifying the eligible cohort
ds = any additional arguments for the data steps
d1 = any additional arguments for the data steps
d2 = any additional arguments for the data steps
d3 = any additional arguments for the data steps
**********************************************************************************************;

%macro episode(id=,
file=,
start=,
clm_dt=,
icd=,
eos=,
data=,
fx_aggr_data=,
if=,
lag=,
ds=,
ds1=,
mrg=,
mrg_data=,
ds2=,
ds3=
);

    *select non dme fracture claim records from the fracture aggregate file for the fx_sites to be analyzed;
    data &data.;   /*fx_cohort*/
        set &fx_aggr_data;   /*fx_aggr_new_2(keep=patid claim_date fx_site file trauma strip(DX) strip(DX) cq repair: rename=(fx_site=site))*/
        by &id;   /*patid*/
        &if;   /* */
        &ds;   /* */
        &ds1;  /* */ 
    run;


    %if &mrg = 1 %then %do;    /*0*/
        *link the selected claim records to the eligible data.;
        data &data.1;
            merge &mrg_data &data.(in=b drop=&start &eos);
            by &id;
            &ds2;
            &ds3;
        run;
    %end;
    %else %do;
        data &data.1;  /*fx_cohort1*/
            set &data;  /*fx_cohort*/
        run;
    %end;

    proc sort data=&data.1;by &id;run;    /*fx_cohort, sorted by patid*/

    data &data.2 no_site;   /*fx_cohort2*/
        length icd3 $3 fx_site $30;
        set &data.1;   /*fx_cohort1*/
        by &id;  /*patid*/
        rename &id=id &clm_dt=d_event;   /*patid, claim_date*/
        icd3=substr(&icd, 1, 3);

        if cq in ('1' '2' '3' '4' '5' '1000' '0200' '0030' '0004' '0034') then use='yes';           
        else use='no';
        if fx_site ^= '' then output &data.2;   /*fx_cohort2*/
        else output no_site;
    run;
    
    *check the number of subjects;
    proc sort data=&data.2(keep=id) nodupkey out=n_subj;by id;run;  /*fx_cohort2*/

    *sort the dataset by subject id, fx_site defined earlier and claim date;
    proc sort data=&data.2 out=ss;by id fx_site d_event use;run;


    *restrict the records to a single record for each fracture fx_site per day. preference being given to a record which has cq > 0;
    /*This looks to consolidate a record, keeping indicators across date and outputting a single record */
    data &data.3;  /*fx_cohort3*/
        set ss;
        by id fx_site d_event use;  /*Use is based on CQ>0*/
        length ip /*repair_right_day repair_left_day*/ cq1 cq2 cq3 cq4 cq5 $1;       
        retain ip /*repair_right_day repair_left_day*/  cq1 cq2 cq3 cq4 cq5 ;
        if first.d_event then do; ip='0'; /*repair_right_day='0'; repair_left_day='0';*/
             cq1='0'; cq2='0'; cq3='0'; cq4='0'; cq5='0'; end;
        if UPCASE (enc_type) = 'IP' then ip='1';
        if substr(cq,1,1)='1' then cq1='1'; if substr(cq,2,1)='2' then cq2='1'; if substr(cq,3,1)='3' then cq3='1'; if substr(cq,4,1)='4' then cq4='1'; if cq='5' then cq5='1';
        /*if repair_right='1' then repair_right_day='1';
        if repair_left='1' then repair_left_day='1';*/
        if last.d_event;  /*Keeping only last claim_date*/
    run;

    proc sort data=&data.3; by id fx_site d_event;run; /*fx_cohort3*/

    *assign a unique sequence number to each episode based on the lag variable - lag is 90 days;
    data &data.4; /*fx_cohort4*/
        set &data.3;
        by id fx_site d_event;
        retain seq 1;
        prev_date=lag(d_event); /*Claim date before current record*/
        if first.fx_site then prev_date=d_event;  /*Set first record in fracture fx_site as the claim date*/
        lag=d_event-prev_date;   /*Claim date - Previous Claim date*/
        format prev_date mmddyy10.;
        if _n_ > 1 and lag=0 or lag ge &lag then do;  /*is 0 for claims with only one record?*/
            seq+1;
        end;
    run;

    proc sort data=&data.4;by id fx_site /*d_event*/ seq;run;

    /*REMOVE V54 CLAIMS at the start of an EPISODE................NEW CODE*/
    data &data.4 V54RECORDS;  
        set &data.4;
        by id fx_site /*d_event*/ seq;
        retain V54Start;

    if first.seq then do;
        V54Start='0';
        if strip(DX)="V54" then V54Start='1';
    end;

    if strip(DX)="V54" then HASV54='1';
        else HASV54='0';

        REMOVETHIS='0';
    
        V54LAG=lag(HasV54);

        if first.seq then V54Lag=HasV54;
        if V54Start='1' and V54Lag='1' and HasV54='1' then REMOVETHIS='1'; 

        if REMOVETHIS='1' then output V54RECORDS;  /*Hard code other variable later on to set all episode variables to missing if not achieved by this*/
        else output &data.4;   

    run;

    proc sort data=&data.4;by id fx_site d_event seq;run;
    
    *assign begin date for each episode;
    data begin;
        set &data.4;
        by id seq;
        length begindate 4;
        if first.seq;
        begindate=d_event;
        format begindate mmddyy10.;
        keep id seq begindate;
    run;

    *assign end date for each episode;
    data end;
        set &data.4;
        by id seq;
        if last.seq;
        length enddate 4;
        enddate=d_event;
        format enddate  mmddyy10.;
        keep id seq enddate;
    run;

    *assign enrollment status to each record;
    * WKS - enrollment always 'y';
    data &data.5;
        merge &data.4(in=a) begin(in=b keep=id seq begindate) end(in=c keep=id seq enddate);   /*data 4 has all the claims*/
        by id seq;
        retain enrollment;
        if a*b*c;
        if first.seq then enrollment='n';
        enrollment='y';
    run;
    
    *assign sequence use indicator to each record and retain it - Modified for 2nd Fracture Version;
    * also set seq_ip;
    /*Modify trauma indicator so it is only episode begin date, not any trauma throughout the episdoe*/
    data &data.6;
        set &data.5;
        by seq;
        length seq_use seq_ip 4 seq_trauma $1 /*repair_dt_1st 4  */;
        retain seq_use seq_ip seq_trauma /*repair_dt_1st*/;          
      retain /*repair_right_seq repair_left_seq*/  seq_cq1 seq_cq2 seq_cq3 seq_cq4 seq_cq5 ;
        if first.seq then do; seq_use=.; seq_ip=.; seq_trauma=.; /*repair_dt_1st=.;*/
            /*repair_right_seq='0'; repair_left_seq='0';*/  seq_cq1='0'; seq_cq2='0'; seq_cq3='0'; seq_cq4='0'; seq_cq5='0'; 
            end;
        if seq_use=.  and use='yes' and enrollment='y' then seq_use=1;
        if first.seq then do;    /*modified this*/
            if trauma='1' then seq_trauma='1';
        end; 
        if ip='1' then seq_ip=1;
        /*if repair_dt_1st=. and cq='3' then
            repair_dt_1st=d_event;
        if repair_right_day='1' then repair_right_seq='1';
        if repair_left_day='1' then repair_left_seq='1';  */
        if cq1='1' then seq_cq1='1';
        if cq2='1' then seq_cq2='1';
        if cq3='1' then seq_cq3='1';
        if cq4='1' then seq_cq4='1';
        if cq5='1' then seq_cq5='1'; ;
        /*format repair_dt_1st mmddyy10.;*/
    run;
    
    *select last record of each sequence if sequence use = 1;
    data &data.7(keep=id seq seq_use);
        set &data.6;
        by id seq;
        if last.seq and seq_use=1;
    run;

    *select last record of each sequence if seq_ip = 1;
    data seq_ip(keep=id seq seq_ip);
        set &data.6;
        by id seq;
        if last.seq and seq_ip=1;
    run;

    *select last record of each sequence if seq_trauma = 1;
    data seq_trauma(keep=id seq seq_trauma);
        set &data.6;
        by id seq;
        if last.seq and seq_trauma='1';
    run;

    *assign sequence use=1 to all records of a seq if any sequence use=1 else sequence use=0;
    data &data.8;
        merge &data.7(in=a) &data.6(in=b drop=seq_use seq_ip seq_trauma) seq_ip seq_trauma;
        by id seq;
        if b;
        if missing(seq_use) then seq_use=0;
        if missing(seq_ip) then seq_ip=0;
        if missing(seq_trauma) then seq_trauma='0';
        label seq_ip = 'Inpatient claim for this fx_site in this sequence';
    run;

    proc sort data=&data.8 out=ss1;by id seq d_event cq;run;

    *get earliest CQ date and earliest CQ type for each used sequence;
    data &data.9(keep=id seq seq_earliest_cq_fx_dt seq_earliest_cq_type) epsd_wo_cq;
        length seq_earliest_cq_fx_dt 4 seq_earliest_cq_type $1;
        set ss1;
        by id seq d_event cq;
        retain seq_earliest_cq_fx_dt seq_earliest_cq_type;
        if first.seq then do;seq_earliest_cq_fx_dt=.;seq_earliest_cq_type='';end;
        if seq_earliest_cq_fx_dt=. and seq_earliest_cq_type = '' and use='yes' then do;
            seq_earliest_cq_fx_dt = d_event;
            seq_earliest_cq_type = cq;
        end;
        if last.seq then 
            if ^missing(seq_earliest_cq_fx_dt) then output &data.9;
            else output epsd_wo_cq;
        format seq_earliest_cq_fx_dt mmddyy10.;
    run;

    *assign earliest CQ date and earliest CQ type for each used sequence;
    data &data.10;
        merge &data.9(in=a) &data.8(in=b);
        by id seq;
        if b;
    run;
    
    data &data.11;
        retain id &icd  fx_site cq use d_event lag seq begindate enddate seq_use seq_earlie:;
        set &data.10;
        by id seq;
        drop icd3 prev: enrollment ;
    run;
%mend;

%episode(
id=patid,
file=file,
start=start_lb,
clm_dt=begin_date,
icd=DX,
eos=eos_2006,  /*Not used currently*/
data=fx_cohort, 
fx_aggr_data=fx_aggr_new_2,
if=,
lag=90,
ds=,
ds1=,
mrg=0,
mrg_data=dti.baseline_cohort_99_06(in=a keep=patid start_lb eos_2006 death_dt_00_06),   /*Not use currently*/
ds2= if a*b,
ds3=
);

title2 'fx_cohort11';
proc print data=fx_cohort11(obs=200); run;

data temp_fx_aggr;  /*194,711,983*/
    set fx_aggr_new_2;   /*full, non-episode file*/
    rename fx_site = eps_site;  /*rename fx_site for merge in in next step*/
run;
proc sql;  /*This is the same number as keeping in the V54 codes.... 68,361,646*/
    create table checkuni2 as select distinct patid, eps_site, claim_date from temp_fx_aggr;
quit;


proc freq data=temp_fx_aggr;
    tables eps_site file /missing;
    title2 'temp fx aggr';
run;

proc sort data=temp_fx_aggr; by patid eps_site claim_date; run;

data new_fx_aggr(compress=binary);
    merge episodes(in=a)
            temp_fx_aggr(in=b);
    by patid eps_site claim_date;   

    rename seq = eps_seq
            seq_use = eps_seq_use
            seq_ip = eps_seq_ip
            begindate = eps_begin
            enddate = eps_end
            /*repair_right_seq = eps_repair_right
            repair_left_seq = eps_repair_left*/;
    label eps_site = 'Episode Site'
            seq = 'Episode sequence'
            seq_use = 'Episode includes at least 1 CQ claim'
            seq_ip = 'Episode includes at least 1 Inpatient claim'
            begindate = 'Episode begin date'
            enddate = 'Episode end date (based on claim_date variable)'
            eps_trauma = 'Episode has trauma claims within 14 days of episode begin date'
            /*eps_repair_dt_1st = 'Date of first fracture repair code (CQ=3) in this Episode'*/;
run;
proc print data=new_fx_aggr(obs=50); 
    title2 'new fx aggr';
run;
proc print data=new_fx_aggr(obs=200); 
    var patid eps_site eps_begin eps_end claim_date eps_seq removethis DX; 
run;

proc contents data=new_fx_aggr;
    run;

proc freq data=new_fx_aggr; tables file; run;

proc freq data=new_fx_aggr; tables eps_site * (eps_seq_use cq); run;

/*Need to add orphan records now; however, only adding them if they were not CLONED - this was already restricted and trauma codes found*/
proc print data=orphans_notcontig_trauma (obs=50);
    run;
proc freq data=orphans_notcontig_trauma;
    tables fx_site file tx_file;
run;
proc print data=orphans_notcontig_trauma (obs=50);
    where tx_file="";
run;

data orphans_notcontig_trauma2;  /*303,952*/
    set orphans_notcontig_trauma;
    
    eps_site=fx_site;
    file=tx_file;
    claim_date=prcdr_date;
    orphan='1';

    if tx_file="" then delete;

        ufile=UPCASE(file);
        drop file;
        rename ufile=file;

    drop fx_site;

run;

proc print data=orphans_notcontig_trauma2 (obs=50);
    run;

/*Variable cleanup / add final labels*/ 
data new_fx_aggr_o; /*195,015,935*/
    set new_fx_aggr orphans_notcontig_trauma2;  

    label trauma14 = 'Claim has trauma claim within 14 days of claim date'
          CONTIG = 'Repair claim is for a contiguous site'
          ORPHAN = 'Orphan repair claim'
          dx = 'Diagnosis within 30 days of claim date'
          file = 'Medicare file type'
        ;
    drop REMOVETHIS year ;
run;

proc freq data=new_fx_aggr_o;
    tables eps_site;
run;

proc freq data=new_fx_aggr_o;
    tables file;
run;

%let outlib=spde_y6;
proc sort data=new_fx_aggr_o out=&outlib..FX_CLM_DB_06_14(compress=binary label='FX Aggr with lag=90' index=(patid)); by patid eps_site claim_date ; run;   /*195,015,935*/


proc contents data=&outlib..FX_CLM_DB_06_14 varnum; run;

proc print data=&outlib..FX_CLM_DB_06_14 (obs=10);
    run;

proc printto log=log;run;quit;
