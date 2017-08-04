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
                        B.diagCodeType,
                        B.provTypeCategory;
  %let on1 = on (A.patid = B.patid);
  %let select2 = select A.patid, A.encounterID, A.enc_type, A.admit_date, A.begin_date, A.discharge_date, A.end_date, A.dx_type, A.dx, A.pdx,
                        case
                          when '800' <= substr(A.dx, 1, 3) <= '829' or substr(A.dx, 1, 4) = '7331' then "DX fx claim"
                          when substr(A.dx, 1, 4) in ('V541' 'V542') then "DX extend care claim"
                          when 'E800' <= substr(A.dx, 1, 4) <= 'E848' or 
                               'E881' <= substr(A.dx, 1, 4) <= 'E884' or 
                               'E908' <= substr(A.dx, 1, 4) <= 'E909' or 
                               'E916' <= substr(A.dx, 1, 4) <= 'E928' 
                            then "Only keeping patid and claim_date for the Trauma M2M Macro Later"
                          else ""
                          end as diagCodeType;
  %let join2 = inner join Work.lookupProvTypePhysician B on (A.prov_type = B.prov_type_code); 

  %let where2 = where A.dx_type = "09" & B.indPhysician = 1 & ^missing(calculated diagCodeType);
  %let selectfrom3 = select * from DT.indexLookup;
  create table UCB.tempFracDxMPCD as
    &select1 from (&selectfrom3 where database = "MPCD") A inner join (&select2 from MPSTD.DX_07_10 A &join2 &where2) B &on1;
  create table UCB.tempFracDxUCB as
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.DX_2010 A &join2 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.DX_2011 A &join2 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.DX_2012 A &join2 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.DX_2013 A &join2 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.DX_2014 A &join2 &where2) B &on1 ;
  create table UCB.tempFracDxSABR as
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2006    A &join2 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2007    A &join2 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2008_V2 A &join2 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2009    A &join2 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2010    A &join2 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2011    A &join2 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2012    A &join2 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2013    A &join2 &where2) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_DX_2014    A &join2 &where2) B &on1 ;

  %let select1 = select A.*, 
                        B.encounterID, B.admit_date, B.begin_date, B.discharge_date, B.end_date, B.px_date, B.px_type, B.px, 
                        case 
                          when B.px_type = "09" then "ICD9-PX" 
                          when B.px_type = "C1" | ^anyalpha(strip(B.px)) then "CPT" 
                          when B.px_type = "H1" & anyalpha(substr(strip(B.px), 1, 1)) & ^anyalpha(strip(B.px), 2) then "HCPCS" 
                          else "" 
                          end as codeType, 
                        B.px as code;
  %let on1 = on (A.patid = B.patid);
  %let select2 = select patid, encounterID, admit_date, begin_date, discharge_date, end_date, px_date, px_type, px;
  %let selectfrom3 = select * from DT.indexLookup;
  create table UCB.tempPxMPCD as
    &select1 from (&selectfrom3 where database = "MPCD") A inner join (&select2 from MPSTD.PX_07_10) B &on1;
  create table UCB.tempPxUCB as
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.PX_2010) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.PX_2011) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.PX_2012) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.PX_2013) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Marketscan") A inner join (&select2 from UCBSTD.PX_2014) B &on1 ;
  create table UCB.tempPxSABR as
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2006) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2007) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2008) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2009) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2010) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2011) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2012) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2013) B &on1 union corr
    &select1 from (&selectfrom3 where database = "Medicare") A inner join (&select2 from STD_SABR.STD_PX_2014) B &on1 ;

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


/*###########################################################################################################*/
/*************************************************************************************************************/
/*Look for repair procedures and assign treatment site*******************/
/*This code has been updated to include hip/femur replacement with matching diagnosis code, also looked in claim strip(DX) not just primary strip(DX) 
/*Not accepting contiguous sites until later*/
/*Excluding procedures from DME files*/
/*******************************Select All Spine Imaging Codes from STD Procedure Files for CQ=4/5 algorithms*/

%macro fx_prcd;
    data fx_prcd spine_xray;
        set UCB.tempPxMPCD
            UCB.tempPxUCB
            UCB.tempPxSABR;

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
 
    %end;
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
