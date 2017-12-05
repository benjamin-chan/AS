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
