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


%macro NumCnt(dsn,DateVar);
  proc sort data=&dsn nodupkey out=num&dsn; by &idVar &indexDateVarName &dateVar; *note nodupkey, several dx on one day counted one visit/hosp;
  data num&dsn(keep=&idVar &indexDateVarName Num&dsn);
    set num&dsn;
	by &idVar &indexDateVarName;
	if first.&indexDateVarName then Num&dsn=0; Num&dsn+1;
	if last.&indexDateVarName;
  run;
%mend NumCnt;
