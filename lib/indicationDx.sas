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
data indDx(drop=i dx enc_type admit_date discharge_date pdx age);  *one record per MRN,index_generic,index_dt;  
  length &CovariateListDx 3;
 set UCB.tempPrevDx12mPrior(keep=&idVar &IndexDateVarName dx enc_type admit_date discharge_date pdx age where=(enc_type in ('IP','IF','AV')));
by &idVar &IndexDateVarName;
  retain &CovariateListDx; 
  array vars (*) &CovariateListDx;
     if first.&IndexDateVarName then do;
     do i=1 to dim(vars);
	      vars(i)=0;
     end;
  end;
  * age=int((adate-birth_date)/365.25);
  if        dx      in :('07041','07044','07051','07054','V0262') then hepatitisC  =1;
  if        dx      in :('V0481','V066','V0382')                    then fluVaccineDx=1;
  if substr(dx,1,5) in ('7184','7185','7249','7385')              then JointSurgDx =1;
  if        dx      in :('7070')                                      then ulcer       =1;
  if substr(dx,1,5) in ('3640')                                      then uveitis     =1;
  if        dx      in :('78343')                                     then growthFail  =1;
  if        dx      in :('V761','V7610','V7611','V7612') and age>=40 then mammoDx     =1;
  if        dx      in :('V7644') and age>=50                         then PSAdx       =1;
  if        dx      in :('V723','V7230','V7231','V7232','V762','V7620') & age>=50 then PapDx=1;
  if        dx      in :('V7641','V7651')                            then EndoDx      =1; 
  if        dx      in :('V852')                                      then obese   =1; *Body Mass Index between 25-29, adult;
  if        dx      in :('27802')                                     then obese   =2; *overweight;
  if        dx      in :('27800','27801')                            then obese   =3; *obesity;
  if        dx      in :('79391','V853','V854')                     then obese   =4; *BMI>=30;
  if        dx      in :('30513','V1582')                            then smoke   =1; *ex;      else
  if        dx      =:'3051'                                          then smoke   =2; *current;     
  if        dx      in :('V810' )                                     then lipidDx =1; /*, 'V81.1', 'V82.2' dr. Curtis ask to remove*/
  if        dx      in :('7102')                                      then Sjogrens=1;
  if dx in :('41001','41011','41021','41031','41041','41051','41061',
            '41071','41081','41091') & 3<=(discharge_date - admit_date)<=180       then mi=1;   
  if dx=:'428' /*and pdx='P' */                                           then heartFailure=1;
  if dx in :('7102', '7141'/*,'782.2',*/ ,'71481','7142' /*,'793.1', '518.89'*/) then EAM=1; /* Extra-articular manifestations */ 
  if dx=:'4359' then TIA=1; 
  if substr(dx,1,3) in ('436', '435') or 
     substr(dx,1,5) in ('4371', '4379') or
    (substr(dx,1,3) in ('433', '434') and substr(dx,6,1)='1')        then Stroke =1;
  if substr(dx,1,3) in ('401', '402', '403', '404', '405') then Hypertension=1;
  if substr(dx,1,3)='411' then Angina=1;

  if '200'<=dx<='20892'                                             then hemaCA =1;
  if '140'<=dx<='19919'                                              then solidCA=1;

  if dx in :('5374','5651','566','5672','5672','56721','56722','56723','56729',
          '5695','5696','56969','56981','5961','6191','566') then fistula_abscessDx=1;

  if '800'<=dx<='82999' or dx=:'7331' then fracture=1;
  if dx=:'7330' then osteo=1;

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
