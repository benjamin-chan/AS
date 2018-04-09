*  University of Alabama at Birmingham                               *
*  AS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=queryOtherComorbidities; * type the name of your program here (without the filename extension);
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




proc import out = Work.comorbidityLookup
            datafile = "U:\studies\AS\pgms\bchan\data\raw\AS Project Codebooks - 20170410\AS Project Covariates Codebook-20170410.xlsx" 
            dbms = xlsx 
            replace;
  sheet = "Comorbidity"; 
  getnames = yes;
  datarow = 2;
run;
proc sql;
  alter table Work.comorbidityLookup
    add code varchar;
  update Work.comorbidityLookup
    set code = dequote(icd9_list);
  alter table Work.comorbidityLookup
    drop compact_definion, icd9_list, billable, description, F;
  delete from Work.comorbidityLookup
    where missing(code);
  insert into Work.comorbidityLookup
    values ("COPD or emphysema", "4910" )
    values ("COPD or emphysema", "4911" )
    values ("COPD or emphysema", "49120")
    values ("COPD or emphysema", "49121")
    values ("COPD or emphysema", "49122")
    values ("COPD or emphysema", "4918" )
    values ("COPD or emphysema", "4919" )
    values ("COPD or emphysema", "4920" )
    values ("COPD or emphysema", "4928" )
    values ("COPD or emphysema", "496"  )
    values ("COPD or emphysema", "49320")
    values ("COPD or emphysema", "49321")
    values ("COPD or emphysema", "49322");
quit;


proc sql;

  %let select1 = select A.*, B.comorbidity;
  %let join1 = inner join Work.comorbidityLookup B on (A.code = B.code);
  create table DT.comorbiditiesOther as
    select distinct
           C.database, C.exposure, C.patid, C.ASCohortDate, C.indexGNN, C.indexDate, C.indexID, 
           C.age, C.sex,
           C.comorbidity,
           1 as indPreExposure
    from (&select1 from UCB.tempPrevDxAll A &join1) C;

  select comorbidity, database, exposure, sum(indPreExposure) as sumIndPreExposure
    from DT.comorbiditiesOther
    group by comorbidity, database, exposure;

quit;



/* 
BEGIN Fenglong's comorbidities code

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
/* 
Only use ICD-9 codes from previous 12 months for Charlson
 */
/* 
Last execution: 1/2/2018 (commit 56f369)
DO NOT EXECUTE AGAIN
Due to server upgrade (32-bit to 64-bit SAS), subsequent execution results in error:
"ERROR: Foreign datasets cannot be modified."
 */
/*  
proc sql;
  create table UCB.tempPrevDx12mPrior as
    select * 
    from UCB.tempPrevDxAll 
    where intnx("year", indexDate, -1, "same") < begin_date <= indexDate
    order by indexID, indexDate;
  create table UCB.tempPrevPx12mPrior as
    select * 
    from UCB.tempPrevPxAll 
    where intnx("year", indexDate, -1, "same") < px_date <= indexDate
    order by indexID, indexDate;
  create table UCB.tempPrevRx12mPrior as
    select A.*, B.etc_name, B.source
    from UCB.tempPrevRxAll A left join
         DT.lookupNDC B on (A.ndc = B.ndc)
    where intnx("year", indexDate, -1, "same") < dispense_date <= indexDate
    order by indexID, indexDate;
quit;

%include "lib\charlson.sas" / source2;
%include "lib\indicationDx.sas" / source2;
%include "lib\indicationPx.sas" / source2;
%include "lib\indicationRx.sas" / source2;
%include "lib\NumCnt.sas" / source2;
%include "lib\ciras.sas" / source2;

%let CovariateListDx= hepatitisC fluVaccineDx JointSurgDx ulcer obese smoke 
                      lipidDx uveitis growthFail mammoDx PSAdx PapDx endoDx Sjogrens MI heartFailure stroke TIA EAM
                      fistula_abscessDx hemaCa solidCa
                      Hypertension angina fracture osteo icd7100; *covariate in 3rd line are from malignancy WG;
%indicationDx(indexID, indexDate);

%let CovariateListPx = InflamMarker RehabVisit RF platelet LFT FluVaccine jointSurg lipidPx Coronary_Revas
                       intraArticularInj MammoPx PSApx PAPpx endoPx FOBT J3490
                       fistula_abscessPx ercpPx barium_ugiPx barium_colonPx; 
%indicationPx(indexID, indexDate);

%let CovariateListRx= chemo lipid dm folate fungus HTN naproxen narcotics nsaid sedative steroid tb thyroid viral
                     dementia statin NSAIDcox BBlocker op_PPI op_bisphosp op_other 
                     thiazide thiazolidinedione anticoagulant
           antithrom antibiotics antipsych antidepres anticonvul calcium Adrenergic; 
%indicationRx(indexID, indexDate);
proc means data = Work.indRx;
  var &CovariateListRx;
run;

%charlson(inputds = ,
          idVar = indexID,
          IndexDateVarName = indexDate,
          outputds = CCI,
          IndexVarName = Charlson,
          inpatonly = B,
          malig = N);

%ciras(DT.indexLookup, indexID, indexDate);


proc sql;
  create table DT.charlsonIndex as select * from Work._WithCharlson;
  create table DT.CIRAS as select * from Work.CIRAS;
  create table DT.indRx as select * from Work.indRx;
quit;
proc contents data = DT.charlsonIndex order = varnum;
run;
proc contents data = DT.CIRAS order = varnum;
run;
proc contents data = DT.indRx order = varnum;
run;
 */
/* 
END Fenglong's comorbidities code
 */




proc sql;
/* 
Oral corticosteroid use
Mean outpatient prescribed daily dose of prednisone equivalents in the 6
months prior to index date: less than 5 mg/d (low dose), 5 to less than 10
mg/d (medium dose), and 10 mg/d or more (high dose)
 */
  create table DT.rxOralCorticosteroid as
    select C.database, C.patid, C.indexID,
           1 as indOralCorticosteroid,
           sum(C.daysAtRisk * C.prednisodeEquivalentDose) as sumPredEq,
           sum(C.daysAtRisk) as sumDaysSupply,
           sum(C.daysAtRisk * C.prednisodeEquivalentDose) / 183 as meanPredEqDose,
           case 
             when 0 <= sum(C.daysAtRisk * C.prednisodeEquivalentDose) / 183 < 2.5 then "Low (<2.5 mg/d)"
             when 2.5 <= sum(C.daysAtRisk * C.prednisodeEquivalentDose) / 183 < 5 then "Medium-Low (2.5-5 mg/d)"
             when 5 <= sum(C.daysAtRisk * C.prednisodeEquivalentDose) / 183 < 10 then "Medium-High (5-10 mg/d)"
             when 10 <= sum(C.daysAtRisk * C.prednisodeEquivalentDose) / 183 then "High (10+ mg/d)"
             else ""
             end as meanPredEqDoseCat
    from (select A.database, A.patid, A.indexID, 
                 A.indexDate - 183 format = mmddyy10. as riskStart, 
                 A.indexDate, 
                 A.dispense_date, 
                 A.dispense_date + A.dispense_sup - 1 format = mmddyy10. as dispense_end, 
                 A.dispense_sup, 
                 case
                   /* Rx completely in at-risk period */
                   when (A.indexDate - 183 <= A.dispense_date) & ((A.dispense_date + A.dispense_sup - 1) <= A.indexDate) 
                     then A.dispense_sup 
                   /* Rx begins before at-risk period */
                   when (A.dispense_date < A.indexDate - 183) 
                     then A.dispense_sup - (A.indexDate - 183 - A.dispense_date) 
                   /* Rx ends after at-risk period */
                   when (A.indexDate < (A.dispense_date + A.dispense_sup - 1)) 
                     then A.dispense_sup - (A.dispense_date + A.dispense_sup - 1 - A.indexDate) 
                   else .
                   end as daysAtRisk,
                 B.prednisodeEquivalentDose
          from UCB.tempPrevRxAll A inner join
               DT.lookupNDC B on (A.ndc = B.ndc)
          where ^missing(B.prednisodeEquivalentDose) & 
                ((A.indexDate - 183 <= A.dispense_date <= A.indexDate) | 
                  (A.indexDate - 183 <= (A.dispense_date + A.dispense_sup - 1) <= A.indexDate))) C
    group by C.database, C.patid, C.indexID;
/* 
Create diagnosis code indicators from inpatient admissions
 */
  create table DT.diagIndicatorsInpatient as
    select A.database, A.patid, A.indexID,
           count(distinct A.admit_date) as countIPAdmits,
           case
             when count(distinct A.admit_date) > 0 then 1
             else 0
             end as indIPAdmit12mPrior
    from UCB.tempPrevDx12mPrior A
    where A.enc_type = "IP"
    group by A.database, A.patid, A.indexID;
/* 
Count encounters
 */
  create table Work.countAVPhysEncounters as
    select B.database, B.patid, B.indexID,
           sum(indAVPhysEncounter) as countAVPhysEncounters
    from (select distinct A.database, A.patid, A.indexID, A.begin_date,
                 prxmatch("/(0[1-9])|(1[0-46-8])|(2[02-9])|(3[0346-9])|(4[046])|(66)|(7[26-9])|(8[1-6])|(9[0-489])|(C[03])/",
                         A.prov_type) > 0 as indAVPhysEncounter
          from UCB.tempPrevDx12mPrior A
          where A.enc_type = "AV" & not(missing(A.dx)) & calculated indAVPhysEncounter = 1) B
    group by B.database, B.patid, B.indexID;
  create table Work.countAVRheumEncounters as
    select B.database, B.patid, B.indexID,
           sum(indAVRheumEncounter) as countAVRheumEncounters
    from (select distinct A.database, A.patid, A.indexID, A.begin_date,
                 A.prov_type = "66" as indAVRheumEncounter
          from UCB.tempPrevDx12mPrior A
          where A.enc_type = "AV" & not(missing(A.dx)) & calculated indAVRheumEncounter = 1) B
    group by B.database, B.patid, B.indexID;
  create table Work.countEREncounters as
    select A.database, A.patid, A.indexID,
           count(distinct A.begin_date) as countERVisits,
           case
             when count(distinct A.begin_date) > 0 then 1
             else 0
             end as indERVisit12mPrior
    from UCB.tempPrevDx12mPrior A
    where A.enc_type = "ED"
    group by A.database, A.patid, A.indexID;
  create table DT.countEncounters as
    select coalesce(A.database, B.database, C.database) as database,
           coalesce(A.patid, B.patid, C.patid) as patid,
           coalesce(A.indexID, B.indexID, C.indexID) as indexID,
           A.countAVPhysEncounters,
           B.countAVRheumEncounters,
           C.indERVisit12mPrior,
           C.countERVisits
    from Work.countAVPhysEncounters A full join
         Work.countAVRheumEncounters B on (A.indexID = B.indexID) full join
         Work.countEREncounters C on (A.indexID = C.indexID | B.indexID = C.indexID);
  select ^missing(countAVPhysEncounters) as a,
         ^missing(countAVRheumEncounters) as b,
         ^missing(indERVisit12mPrior) as c,
         count(*) as n
    from DT.countEncounters
    group by calculated a, calculated b, calculated c;
/* 
Inhaled antibiotics

IS A DAYS-SUPPLY CRITERION REQUIRED??
  create table Work.indInhaledAntibiotics0 as
    select A.patid, A.episodeID, 
           A.begin_date format = mmddyy10. as rxDate, 
           "HCPCS" as codeType, 
           A.px as drugCode, 
           "INJECTION" as drugRoute, 
           B.descript as drugName, 
           A.px_amt,
           . as dispense_sup, 
           . as dispense_amt
      from WRK.proccodesHCPCS12mPrior A inner join 
           DT.lookupJcodes B on (A.px = B.code)
      where lower(category) = "inhaled antibiotic"
    union corr
    select D.patid, D.episodeID, 
           D.dispense_date format = mmddyy10. as rxDate, 
           "NDC" as codeType, 
           E.ndc as drugCode, 
           D.rt as drugRoute, 
           D.gnn as drugName, 
           . as px_amt,
           D.dispense_sup, 
           D.dispense_amt
      from WRK.rx12mPrior D inner join 
           DT.lookupNDC E on (D.ndc = E.ndc)
      where (lower(E.etc_name) like '%antibiotic%' | lower(E.etc_name) like '%polymyxin%') & 
            lowcase(E.rt) in ("inhalation", "intraven", "injection");
  select codeType, drugRoute, drugName, count(distinct patid) as countDistinctPatid
    from Work.indInhaledAntibiotics0
    group by codeType, drugRoute, drugName;
  create table Work.indInhaledAntibiotics1 as
    select distinct
           A.patid, A.episodeID,
           1 as indInhaledAntibiotics
    from Work.indInhaledAntibiotics0 A;
 */
quit;




ods html close;
