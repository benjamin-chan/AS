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


%macro ciras(cohort,idVar,indexDateVarName);

data inflamMarker RehabVisit RF platelet lft; 
  set UCB.tempPrevPxAll; 
  if (codeType = "CPT" &
      px in ('85652','86141')) then output inflamMarker; 
  if (codeType in ("CPT", "HCPCS") &
      px in ('11040','29405','92598','97020','97504','11041','29445','95831','97022','97520','11042','29505', 
            '95832','97024','97530','11043','29515','95833','97026','97535','11044','29520','95834','97028', 
            '97537','29065','29530','95851','97032','97542','29075','29540','95852','97033','97545','29085', 
            '29550','96105','97034','97546','29105','29580','96110','97035','97703','29125','29590','96111', 
            '97036','97750','29126','64550','96115','97039','97770','29130','90901','97001','97110','97799', 
            '29131','90911','97002','97112','V5362','29200','92506','97003','97113','V5363','29220','92507', 
            '97004','97116','V5364','29240','92508','97010','97124','29260','92510','97012','97139','29280', 
            '92525','97014','97140','29345','92526','97016','97150','29365','92597','97018','97250')) 
                        then output RehabVisit; 
   if (codeType = "CPT" &
       px in ('86430','86431','86200','80072')) then output RF; 
   if (codeType = "CPT" &
       px in ('85025','85032','85049','85590','85595')) then output platelet; 
   if (codeType = "CPT" &
       px in ('80047','80049','80050','80053','80058','80051','80054')) then output lft; 
   
run; 

data felty; 
set  UCB.tempPrevDxAll(where=(dx=:'7141' and enc_type in ('IP','IF','AV')));    
run; 

data rh;
set UCB.tempPrevDxAll(where=(enc_type in ('IP','IF','AV')));
if prov_type = 66;
run;
	
  %NumCnt(rh, admit_date);
  %NumCnt(inflamMarker, admit_date);
  %NumCnt(RehabVisit, admit_date);
  %NumCnt(lft, admit_date);
  %NumCnt(RF, admit_date);
  %NumCnt(platelet, admit_date);
  %NumCnt(felty, admit_date); 

data ciras(drop=j sex01 /* birth_date */ sex age);
merge &cohort(keep=&idVar &indexDateVarName  /* birth_date */ sex age in=a)
      numInflamMarker
	  numRehabVisit
	  numRF
	  numFelty
	  numPlatelet
	  numLft
	  numRh;
by &idVar &indexDateVarName;
if a;
/* age=(&indexDateVarName-birth_date)/365.25; */
if lowcase(sex)='m' then sex01=0; else sex01=1;

array zero(*)   NumRh numinflamMarker NumRehabVisit NumRF Numplatelet Numlft Numfelty ;
    do j=1 to dim(zero);
	if zero(j)=. then zero(j)=0;
	end;

CIRAS=age*(-0.066) + sex01*(-0.092) + numinflamMarker*0.60 + NumRehabVisit*0.69+NumRF*2.1+
        NumFelty*2.3 + Numplatelet*0.42  + NumLft*(-0.14)       + NumRh*0.52   + 6.5;
run;

proc datasets nolist;
	delete NumRh numInflamMarker NumRehabVisit NumRF Numplatelet Numlft NumFelty 
              Rh    InflamMarker    RehabVisit    RF    Platelet    Lft    Felty ;
quit;run;
%mend ciras;
