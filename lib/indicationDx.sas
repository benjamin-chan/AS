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
