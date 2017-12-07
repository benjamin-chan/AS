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
	"410"-"410.99",
	"412"-"421.99" = "MI"      
/* Coronary heart disease *//*changed according to Dr. Curtis"*/
    "410"-"410.99",/*changed according to Dr. Curtis"*/
	"411"-"414.99",        /*changed according to Dr. Curtis"*/
	"429.2"-"429.29"= "CHD"
/* Peripheral vascular disorder */
	"440.20"-"440.24",
	"440.31"-"440.32",
	"440.8"-"440.89",
	"440.9"-"440.99",
	"443.9"-"443.99",
	"441"-"441.99",
	"785.4"-"785.49",
    "V43.4"-"V43.49",
	"v43.4"-"v43.49"= "PVD"
/* Cerebrovascular disease */
    "430"-"438.99" = "CVD"
/* Dementia */
	"290"-"290.99" = "DEM"
/* Chronic pulmonary disease */
	"490"-"496.99",
	"500"-"505.99",
	"506.4"-"506.49" =  "CPD"
/* Rheumatologic disease */
	"710.0"-"710.09",
    "710.1"-"710.19",
 	"710.4"-"710.49",
   /* "714.0 "-"714.2 ",
    "714.81", exclude RA*/
    "725"-"725.99" = "RHD"
/* Peptic ulcer disease */
	"531"-"534.99" = "PUD"
/* Mild liver disease */
	"571.2"-"571.29",
	"571.5"-"571.59",
	"571.6"-"571.69",
	"571.4"-"571.49" = "MLIVD"
/* Diabetes */
	"250"-"250.39",
	"250.7"-"250.79" = "DIAB"
/* Diabetes with chronic complications */
	"250.4"-"250.69" = "DIABC"
/* Hemiplegia or paraplegia */
	"344.1"-"344.19",
	"342"-"342.99" = "PLEGIA"
/* Renal Disease */
	"582"-"582.99",
	"583"-"583.79",
	"585"-"585.99",
	"586"-"586.99",
	"588"-"588.99" = "REN"
/*Malignancy, including leukemia and lymphoma */
	"140"-"172.99",
	"174"-"195.89",
	"200"-"208.99" = "MALIGN"
/* Moderate or severe liver disease */
	"572.2"-"572.89",
	"456.0"-"456.21" = "SLIVD"
/* Metastatic solid tumor */
	"196"-"199.19" = "MST"
/* AIDS */
	"042"-"044.99" = "AIDS"
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
  from dx
  where  enctype in &inpatout.
  ;

   create table _PxSubset as
  select*
  from px 
  where enctype in &inpatout.
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
   if    PX= "38.48" or
         PX ="93668" or
         PX in ("34201","34203","35454","35456","35459","35470") or
                "35355" <= PX <= "35381" or
         PX in ("35473","35474","35482","35483","35485","35492","35493",
                "35495","75962","75992") or
         PX in ("35521","35533","35541","35546","35548","35549","35551",
                "35556","35558","35563","35565","35566","35571","35582","35583",
                "35584","35585","35586","35587","35621","35623","35641","35646",
                "35647","35651","35654","35656","35661","35663","35665","35666","35671")
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
      , (w.MRN is null)              as  NoVisitFlag   label = "No visits for this person"
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



%macro indicationDx(idVar,IndexDateVarName);
data indDx(drop=i dx enctype adate ddate pdx age);  *one record per MRN,index_generic,index_dt;  
  length &CovariateListDx 3;
 set dx(keep=&idVar &IndexDateVarName dx enctype adate ddate pdx birth_date where=(enctype in ('IP','IF','AV')));
by &idVar &IndexDateVarName;
  retain &CovariateListDx; 
  array vars (*) &CovariateListDx;
     if first.&IndexDateVarName then do;
     do i=1 to dim(vars);
	      vars(i)=0;
     end;
  end;
  age=int((adate-birth_date)/365.25);
  if        dx      in :('070.41','070.44','070.51','070.54','V02.62') then hepatitisC  =1;
  if        dx      in :('V04.81','V06.6','V03.82')                    then fluVaccineDx=1;
  if substr(dx,1,5) in ('718.4','718.5','724.9','738.5')              then JointSurgDx =1;
  if        dx      in :('707.0')                                      then ulcer       =1;
  if substr(dx,1,5) in ('364.0')                                      then uveitis     =1;
  if        dx      in :('783.43')                                     then growthFail  =1;
  if        dx      in :('V76.1','V76.10','V76.11','V76.12') and age>=40 then mammoDx     =1;
  if        dx      in :('V76.44') and age>=50                         then PSAdx       =1;
  if        dx      in :('V72.3','V72.30','V72.31','V72.32','V76.2','V76.20') & age>=50 then PapDx=1;
  if        dx      in :('V76.41','V76.51')                            then EndoDx      =1; 
  if        dx      in :('V85.2')                                      then obese   =1; *Body Mass Index between 25-29, adult;
  if        dx      in :('278.02')                                     then obese   =2; *overweight;
  if        dx      in :('278.00','278.01')                            then obese   =3; *obesity;
  if        dx      in :('793.91','V85.3','V85.4')                     then obese   =4; *BMI>=30;
  if        dx      in :('305.13','V15.82')                            then smoke   =1; *ex;      else
  if        dx      =:'305.1'                                          then smoke   =2; *current;     
  if        dx      in :('V81.0' )                                     then lipidDx =1; /*, 'V81.1', 'V82.2' dr. Curtis ask to remove*/
  if        dx      in :('710.2')                                      then Sjogrens=1;
  if dx in :('410.01','410.11','410.21','410.31','410.41','410.51','410.61',
            '410.71','410.81','410.91') & 3<=(ddate-adate)<=180       then mi=1;   
  if dx=:'428' /*and pdx='P' */                                           then heartFailure=1;
  if dx in :('710.2', '714.1'/*,'782.2',*/ ,'714.81','714.2' /*,'793.1', '518.89'*/) then EAM=1; /* Extra-articular manifestations */ 
  if dx=:'435.9' then TIA=1; 
  if substr(dx,1,3) in ('436', '435') or 
     substr(dx,1,5) in ('437.1', '437.9') or
    (substr(dx,1,3) in ('433', '434') and substr(dx,6,1)='1')        then Stroke =1;
  if substr(dx,1,3) in ('401', '402', '403', '404', '405') then Hypertension=1;
  if substr(dx,1,3)='411' then Angina=1;

  if '200'<=dx<='208.92'                                             then hemaCA =1;
  if '140'<=dx<='199.19'                                              then solidCA=1;

  if dx in :('537.4','565.1','566','567.2','567.2','567.21','567.22','567.23','567.29',
          '569.5','569.6','569.69','569.81','596.1','619.1','566.') then fistula_abscessDx=1;

  if '800'<=dx<='829.99' or dx=:'733.1' then fracture=1;
  if dx=:'733.0' then osteo=1;

  if last.&IndexDateVarName ; 
label hepatitisC='hepatitisC DX'
      fluVaccineDx='fluVaccine DX'
      JointSurgDx='Joint Surgery DX'
      ulcer='Ulcer DX'
      uveitis='Uveitis DX'
      growthFail='Growth Fail DX'
      mammoDx='Breast Cancer Screening DX'
      PSAdx='Prostate cancer Screen DX'
      PapDx='Gynecological examination';

run;

%mend indicationDx;


%macro indicationPx(idVar,IndexDateVarName);
data indPx(drop=adate pdate px birth_date age i);
  length &CovariateListPx 3;
set px(keep=&idVar &IndexDateVarName adate pdate px birth_date);
by &idVar &IndexDateVarName ;
  age=int((adate-birth_date)/365.25);  
  retain &CovariateListPx; 
  array vars (*) &CovariateListPx ;
  do i=1 to dim(vars);
     if first.&IndexDateVarName then vars(i)=0;
  end;
  
  *lab data for claim-based RA severity score (CIRAS); 
  if px in ('J3490','J3590', 'J7799', 'C9399','Q4082') then J3490=1;
  if px in ('85652','86141')                                                        then inflamMarker=1;
  if px in ('11040','29405','92598','97020','97504','11041','29445','95831','97022','97520','11042','29505',
            '95832','97024','97530','11043','29515','95833','97026','97535','11044','29520','95834','97028',
            '97537','29065','29530','95851','97032','97542','29075','29540','95852','97033','97545','29085',
            '29550','96105','97034','97546','29105','29580','96110','97035','97703','29125','29590','96111',
            '97036','97750','29126','64550','96115','97039','97770','29130','90901','97001','97110','97799',
            '29131','90911','97002','97112','V5362','29200','92506','97003','97113','V5363','29220','92507',
            '97004','97116','V5364','29240','92508','97010','97124','29260','92510','97012','97139','29280',
            '92525','97014','97140','29345','92526','97016','97150','29365','92597','97018','97250') 
			                                                                        then RehabVisit=1;
   if px in ('86430','86431','86200','80072')                                       then RF=1;
   if px in ('85025','85032','85049','85590','85595')                               then platelet+1;
   if px in ('80047','80049','80058','80051','80054')                               then lft+1;
   if px in ('99.52','90659','90660','90656','90658','G0008','4037F','90732','G0009','4040F', 
             'V04.81','G8108') or '90655'<=px<='90663'                              then FluVaccine=1; *2nd line by JimL; 
   if '80.0'<=px<='80.49' or 
      '80.6'<=px<='80.99' or
      '81.1'<=px<='81.29' or
	  '81.4'<=px<='81.59' or
	  '81.7'<=px<='81.99' or
   px in :("22532","22808","23802","25443","26357","26842","27440","28086","28730","29838",
"22533","22810","23929","25444","26358","26843","27441","28088","28735","29840",
"22534","22812","24102","25445","26370","26844","27442","28260","28737","29844",
"22548","22818","24360","25446","26372","26850","27443","28261","28740","29845",
"22554","22819","24361","25447","26373","26852","27445","28262","28750","29848",
"22556","22840","24362","25800","26418","26860","27446","28264","28755","29860",
"22558","22841","24363","25805","26420","26861","27447","28270","28760","29861",
"22585","22842","24365","25810","26426","26862","27580","28272","28899","29863",
"22590","22843","24366","25820","26428","26863","27599","28290","29805","29870",
"22595","22844","24800","25825","26432","26989","27625","28292","29806","29873",
"22600","22845","24802","25830","26433","27054","27626","28293","29820","29875",
"22610","22846","24999","25999","26434","27130","27700","28294","29821","29876",
"22612","22847","25105","26130","26437","27284","27702","28296","29822","29884",
"22614","22851","25118","26135","26530","27286","27703","28297","29823","29895",
"22630","22899","25119","26140","26531","27299","27870","28298","29827","29897",
"22632","23105","25332","26145","26535","27334","27871","28299","29830","29898",
"22800","23470","25337","26350","26536","27335","27899","28705","29835","29899",
"22802","23472","25441","26352","26820","27437","28070","28715","29836","29900",
"22804","23800","25442","26356","26841","27438","28072","28725","29837","29901" ) 
                                                                                    then JointSurg=1;

   if px in ('80061', '82465', '83700', '83701', '83704', '83718', '83719', '83721', '84478') then lipidPx=1;
   if px in ('81.92')                                                               then intraArticularInj=1;
   if px in ('87.36','87.37','76083','76092','77052','77057','G8111','G0202') and age>=40 then mammoPx=1;
   if px in ('84152','84153','84154','G0103') and age>=50                          then PSApx=1;
   if px in ('91.46','88156','P3000','P3001','Q0091', 'G0101','G0123','G0124','G0141',
             'G0143','G0144','G0145','G0147', 'G0148') or '88141'<=px<='88154'      then PAPpx=1;
   if px in ('45.24','45.23','45.25','45330','45331','45333','45338','45378','45380',
             '45384','45385','G0104','G0105','G0121')                               then endopx=1;
   if px in ('82270','82271','82272','82273','82274','G0107','G0328') & age>=50     then FOBT=1;

   if platelet>=4 then platelet=4; *CIRAS definition;
   if lft>=5 then lft=5;           *CIRAS definition;
   
   *2009-09-21 malignancy WG-specific covariates;
if px in ('42.84','46.72','46.74','46.76','48.73','48.81','48.93','49.01','49.02','49.11',
 '49.12','54.21','57.83','57.84','69.42','45000','45005','45020','45990',
 '46020','46040','46045','46050','46060','46270','46275','46280','46285','46288',
 '46706','46710','46712') then fistula_abscessPx=1; 
if px in ('43260','43261','43262','43263','43264','43265','43267','43268','43269','43271','43272') then ercpPx=1;
if px in ('87.62','87.63','74240','74241','74245','74246','74247','74249','74250','74251') then barium_ugiPx=1;
if px in ('87.64','74270','74280') then barium_colonPx=1; 

*2009-11-05 CVD WG;
if PX in ('92974', '92980', '92981', '92982', '92984', '92995', '92996', '33521', '33522', '33523', '33530',
          '33510', '33511', '33512', '33513', '33514', '33516', '33517', '33518', '33519', '33521', '33522', 
          '33523', '33530', '33533', '33534', '33535', '33536') then Coronary_Revas=1;

   if last.&IndexDateVarName;
run;
%mend indicationPx;


%macro indicationRx(idVar,IndexDateVarName);
data indRx(keep=&idVar &IndexDateVarName &CovariateListRx);
  set rx2;
  by &idVar &IndexDateVarName;
  retain  &CovariateListRx ;
  length  &CovariateListRx  3 ;
  array vars (*) ImminentDeathRx &CovariateListRx ;
  do i=1 to dim(vars);
    if first.&IndexDateVarName then vars(i)=0;
  end;
    
  if lowcase(drugclass)=:'chemo'     then chemo=1; *Note to cancer WG: chemo includes chemo and chemo2;
  if lowcase(drugclass)=:'lipid'     then lipid=1; *changed from clop to lipid on Nov. 29, 09;
  if lowcase(drugclass)=:'dm'        then dm=1;
  if lowcase(drugclass)=:'folate'    then folate=1;
  if lowcase(drugclass)=:'fungus'    then fungus=1;
  if lowcase(drugclass)=:'htn'       then htn=1;
  if lowcase(drugclass)=:'naproxen'  then naproxen=1;
  if lowcase(drugclass)=:'narcotics' then narcotics=1;
  if lowcase(drugclass)=:'nsaid'     then nsaid=1;
  
  if lowcase(drugclass)=:'op_ppi'    then op_PPI=1;
  if lowcase(drugclass)=:'op_bis'    then op_bisphosp=1;
  
  if lowcase(drugclass)=:'op_other'  then op_other=1;
  if lowcase(drugclass)=:'sedative'  then sedative=1;
  if lowcase(drugclass)=:'steroid'   then steroid=1;
  if lowcase(drugclass)=:'tb'        then tb=1;
  if lowcase(drugclass)=:'thyroid'   then thyroid=1;
  if lowcase(drugclass)=:'viral'     then viral=1;
  if lowcase(drugclass)=:'dementia'  then dementia=1; 
  if lowcase(drugclass)=:'statin'    then statin=1;
  if lowcase(drugclass)=:'nsaidcox'  then nsaidcox=1;
  if lowcase(drugclass)=:'bblocker'  then BBlocker=1; 
  if lowcase(drugclass)=:'antithrom' then antithrom=1;  
  if lowcase(drugclass)=:'antibioti' then antibiotics=1; 
  if lowcase(drugclass)=:'antipsych' then antipsych=1;
  if lowcase(drugclass)=:'antidepre' then antidepres=1;
  if lowcase(drugclass)=:'anticonvu' then anticonvul=1;
  if lowcase(drugclass)=:'calcium'   then calcium=1;
  if lowcase(drugclass)=:'Adrenergi' then Adrenergic=1;
  if lowcase(drugclass)=:'Adrenergi' then Adrenergic=1;

  if index(lowcase(generic),'thiazide')     >0    then thiazide=1;
  if index(lowcase(generic),'rosiglitazone')>0 or
	 index(lowcase(generic),'troglitazone') >0 or
     index(lowcase(generic),'pioglitazone') >0    then thiazolidinedione=1;
  if index(lowcase(generic),'warfarin')     >0 or 
	 index(lowcase(generic),'heparin')      >0 or
     index(lowcase(generic),'enoxaparin sodium')   then anticoagulant=1; /*Dr.curtis ask to add*/
  if last.&IndexDateVarName;
run;
%mend indicationRx;


%macro NumCnt(dsn,DateVar);
  proc sort data=&dsn nodupkey out=num&dsn; by &idVar &indexDateVarName &dateVar; *note nodupkey, several dx on one day counted one visit/hosp;
  data num&dsn(keep=&idVar &indexDateVarName Num&dsn);
    set num&dsn;
	by &idVar &indexDateVarName;
	if first.&indexDateVarName then Num&dsn=0; Num&dsn+1;
	if last.&indexDateVarName;
  run;
%mend NumCnt;


%macro ciras(cohort,idVar,indexDateVarName);
data inflamMarker RehabVisit RF platelet lft; 
  set px; 
  if px in ('85652','86141') then output inflamMarker; 
  if px in ('11040','29405','92598','97020','97504','11041','29445','95831','97022','97520','11042','29505', 
            '95832','97024','97530','11043','29515','95833','97026','97535','11044','29520','95834','97028', 
            '97537','29065','29530','95851','97032','97542','29075','29540','95852','97033','97545','29085', 
            '29550','96105','97034','97546','29105','29580','96110','97035','97703','29125','29590','96111', 
            '97036','97750','29126','64550','96115','97039','97770','29130','90901','97001','97110','97799', 
            '29131','90911','97002','97112','V5362','29200','92506','97003','97113','V5363','29220','92507', 
            '97004','97116','V5364','29240','92508','97010','97124','29260','92510','97012','97139','29280', 
            '92525','97014','97140','29345','92526','97016','97150','29365','92597','97018','97250') 
                        then output RehabVisit; 
   if px in ('86430','86431','86200','80072') then output RF; 
   if px in ('85025','85032','85049','85590','85595') then output platelet; 
   if px in ('80047','80049','80050','80053','80058','80051','80054') then output lft; 
   
run; 

data felty; 
set  dx(where=(dx=:'714.1' and enctype in ('IP','IF','AV')));    
run; 

data rh;
set dx(where=(enctype in ('IP','IF','AV')));
if SRV_SPCLTY_CTG_CD='RH';
run;
	
  %NumCnt(rh,adate);
  %NumCnt(inflamMarker,adate);
  %NumCnt(RehabVisit,adate);
  %NumCnt(lft,adate);
  %NumCnt(RF,adate);
  %NumCnt(platelet,adate);
  %NumCnt(felty,adate); 

data ciras(drop=j sex birth_date gender age);
merge &cohort(keep=&idVar &indexDateVarName  birth_date gender in=a)
      numInflamMarker
	  numRehabVisit
	  numRF
	  numFelty
	  numPlatelet
	  numLft
	  numRh;
by &idVar &indexDateVarName;
if a;
age=(&indexDateVarName-birth_date)/365.25;
if lowcase(gender)='m' then sex=0; else sex=1;

array zero(*)   NumRh numinflamMarker NumRehabVisit NumRF Numplatelet Numlft Numfelty ;
    do j=1 to dim(zero);
	if zero(j)=. then zero(j)=0;
	end;

CIRAS=age*(-0.066) + sex*(-0.092) + numinflamMarker*0.60 + NumRehabVisit*0.69+NumRF*2.1+
        NumFelty*2.3 + Numplatelet*0.42  + NumLft*(-0.14)       + NumRh*0.52   + 6.5;
run;

proc datasets nolist;
	delete NumRh numInflamMarker NumRehabVisit NumRF Numplatelet Numlft NumFelty 
              Rh    InflamMarker    RehabVisit    RF    Platelet    Lft    Felty ;
quit;run;
%mend ciras;




%let CovariateListDx= hepatitisC fluVaccineDx JointSurgDx ulcer obese smoke 
                      lipidDx uveitis growthFail mammoDx PSAdx PapDx endoDx Sjogrens MI heartFailure stroke TIA EAM
                      fistula_abscessDx hemaCa solidCa
                      Hypertension angina fracture osteo icd7100; *covariate in 3rd line are from malignancy WG;
%indicationDx(mrn,index_dt)

%let CovariateListPx = InflamMarker RehabVisit RF platelet LFT FluVaccine jointSurg lipidPx Coronary_Revas
                       intraArticularInj MammoPx PSApx PAPpx endoPx FOBT J3490
                       fistula_abscessPx ercpPx barium_ugiPx barium_colonPx; 
%indicationPx(mrn,index_dt)

%let CovariateListRx= chemo lipid dm folate fungus HTN naproxen narcotics nsaid sedative steroid tb thyroid viral
                     dementia statin NSAIDcox BBlocker op_PPI op_bisphosp op_other 
                     thiazide thiazolidinedione anticoagulant
					 antithrom antibiotics antipsych antidepres anticonvul calcium Adrenergic; 
%indicationRx(mrn,Index_dt)


%charlson(inputds=saber_cohort,idVar=mrn,IndexDateVarName=index_dt,outputds=CCI,IndexVarName=Charlson,inpatonly=B,malig=N);

%ciras(Saber_cohort,mrn,index_dt)





