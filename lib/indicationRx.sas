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
  set UCB.tempPrevRx12mPrior;
  by &idVar &IndexDateVarName;
  retain  &CovariateListRx ;
  length  &CovariateListRx  3 ;
  array vars (*) ImminentDeathRx &CovariateListRx ;
  do i=1 to dim(vars);
    if first.&IndexDateVarName then vars(i)=0;
  end;
    
  * if lowcase(etc_name)=:'chemo'     then chemo=1; *Note to cancer WG: chemo includes chemo and chemo2;
  * if lowcase(etc_name)=:'lipid'     then lipid=1; *changed from clop to lipid on Nov. 29, 09;
  if source = "NDC_INSULIN" then dm=1;
  * if lowcase(etc_name)=:'folate'    then folate=1;
  if source = "NDC_ANTI_FUNGAL" then fungus=1;
  if source = "NDC_ANTI_HYPERTENSIVE" then htn=1;
  * if lowcase(etc_name)=:'naproxen'  then naproxen=1;
  if source = "NDC_NARCOTICS" then narcotics=1;
  if source in ("NDC_NSAIDCOX", "NDC_NSAIDNONCOX") then nsaid=1;
  
  if source = "NDC_PPIS" then op_PPI=1;
  if source = "NDC_BISPHOSPHONATES" then op_bisphosp=1;
  
  * if lowcase(etc_name)=:'op_other'  then op_other=1;
  * if lowcase(etc_name)=:'sedative'  then sedative=1;
  if source in ("NDC_STEROIDS", "NDC_TOPICALSTEROIDS") then steroid=1;
  if source = "NDC_TB" then tb=1;
  * if lowcase(etc_name)=:'thyroid'   then thyroid=1;
  if source = "NDC_ANTIVIRAL" then viral=1;
  * if lowcase(etc_name)=:'dementia'  then dementia=1; 
  if source = "NDC_STATIN" then statin=1;
  if source = "NDC_NSAIDCOX" then nsaidcox=1;
  if source = "NDC_BETABLOCKERS" then BBlocker=1; 
  * if lowcase(etc_name)=:'antithrom' then antithrom=1;  
  if source = "NDC_ANTIBIOTICS" then antibiotics=1; 
  * if lowcase(etc_name)=:'antipsych' then antipsych=1;
  * if lowcase(etc_name)=:'antidepre' then antidepres=1;
  * if lowcase(etc_name)=:'anticonvu' then anticonvul=1;
  * if lowcase(etc_name)=:'calcium'   then calcium=1;
  * if lowcase(etc_name)=:'Adrenergi' then Adrenergic=1;

  if index(lowcase(gnn),'thiazide')     >0    then thiazide=1;
  if index(lowcase(gnn),'rosiglitazone')>0 or
	 index(lowcase(gnn),'troglitazone') >0 or
     index(lowcase(gnn),'pioglitazone') >0    then thiazolidinedione=1;
  if index(lowcase(gnn),'warfarin')     >0 or 
	 index(lowcase(gnn),'heparin')      >0 or
     index(lowcase(gnn),'enoxaparin sodium')   then anticoagulant=1; /*Dr.curtis ask to add*/
  if last.&IndexDateVarName;
run;
%mend indicationRx;
