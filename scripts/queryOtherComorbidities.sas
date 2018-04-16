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




/* 
From: Yang, Shuo [mailto:shuoyang@uabmc.edu] 
Sent: Tuesday, April 10, 2018 8:28 AM
To: Chen, Lang <langchen@uabmc.edu>; Benjamin Chan <chanb@ohsu.edu>
Subject: RE: Marketscan provider codes

Hi Ben,

Please see below formats that I created from marketscan data dictionary.

Best,

Shawn
 */
proc format;      /*<-- $PROVIDERTYPE. (from STDPROV) */
      value $providerType
            '1'='Acute Care Hospital'
            '10'='Birthing Center'
            '100'='Pediatric Otolaryngology'
            '105'='Pediatric Critical Care Med'
            '120'='Chiropractor/DCM'
            '130'='Podiatry'
            '140'='Pain Mgmt/Pain Medicine'
            '145'='Pediatric Anesthesiology'
            '15'='Treatment Center'
            '150'='Anesthesiology'
            '160'='Nuclear Medicine'
            '170'='Mental Health/Chemical Dep NEC'
            '175'='Mental Health Facilities'
            '180'='Chemical Depend Treatment Ctr'
            '185'='Pediatric Radiology'
            '20'='Mental Health/Chemical Dep NEC'
            '200'='Medical Doctor - MD (NEC)'
            '202'='Osteopathic Medicine'
            '204'='Internal Medicine (NEC)'
            '206'='MultiSpecialty Physician Group'
            '208'='Convalescent Care Facility'
            '21'='Pulmonary Disease'
            '210'='Intermediate Care Facility'
            '215'='Residential Treatment Center'
            '22'='Rheumatology'
            '220'='Emergency Medicine'
            '225'='Hospitalist'
            '227'='Palliative Medicine'
            '23'='Mental Hlth/Chem Dep Day Care'
            '230'='Allergy & Immunology'
            '240'='Family Practice'
            '245'='Special Care Facility (NEC)'
            '25'='Rehabilitation Facilities'
            '250'='Dentist - MD & DDS (NEC)'
            '260'='Dental Specialist'
            '265'='Critical Care Medicine'
            '270'='Endocrinology & Metabolism'
            '275'='Gastroenterology'
            '280'='Hematology'
            '285'='Infectious Disease'
            '290'='Nephrology'
            '295'='Pathology'
            '30'='Longterm Care (NEC)'
            '300'='Pediatric Pathology'
            '31'='Extended Care Facility'
            '32'='Geriatric Hospital'
            '320'='Radiology'
            '325'='Genetics'
            '33'='Convalescent Care Facility'
            '330'='Ophthalmology'
            '34'='Preventative Medicine'
            '340'='Otolaryngology'
            '35'='Psychiatry'
            '350'='Physical Medicine & Rehab'
            '355'='Plastic/Maxillofacial Surgery'
            '36'='Continuing Care Retirement Com'
            '360'='Proctology'
            '365'='Urology'
            '37'='Day/Night Care Center'
            '38'='Hospice Facility'
            '380'='Dermatology'
            '40'='Other Facility (NEC)'
            '400'='Pediatrician (NEC)'
            '41'='Infirmary'
            '410'='Pediatric Specialist (NEC)'
            '413'='Pediatric Nephrology'
            '415'='Pediatric Ophthalmology'
            '418'='Pediatric Orthopaedics'
            '42'='Special Care Facility (NEC)'
            '420'='Geriatric Medicine'
            '423'='Cardiovascular Dis/Cardiology'
            '425'='Neurology'
            '428'='Pediatric Emergency Medicine'
            '430'='Pediatric Allergy & Immunology'
            '433'='Pediatric Endocrinology'
            '435'='Neonatal-Perinatal Medicine'
            '438'='Pediatric Gastroenterology'
            '440'='Pediatric Cardiology'
            '443'='Pediatric Hematology-Oncology'
            '448'='Pediatric Infectious Diseases'
            '450'='Pediatric Rheumatology'
            '453'='Sports Medicine (Pediatrics)'
            '455'='Pediatric Urology'
            '458'='Child Psychiatry'
            '460'='Pediatric Medical Toxicology'
            '5'='Ambulatory Surgery Centers'
            '500'='Surgeon (NEC)'
            '505'='Surgical Specialist (NEC)'
            '510'='Colon & Rectal Surgery'
            '520'='Neurological Surgery'
            '530'='Orthopaedic Surgery'
            '535'='Abdominal Surgery'
            '540'='Cardiovascular Surgery'
            '545'='Dermatologic Surgery'
            '550'='General Vascular Surgery'
            '555'='Head and Neck Surgery'
            '560'='Pediatric Surgery'
            '565'='Surgical Critical Care'
            '570'='Transplant Surgery'
            '575'='Traumatic Surgery'
            '580'='Cardiothoracic Surgery'
            '585'='Thoracic Surgery'
            '6'='Urgent Care Facility'
            '805'='Dental Technician'
            '810'='Dietitian'
            '815'='Medical Technician'
            '820'='Midwife'
            '822'='Nursing Services'
            '824'='Psychiatric Nurse'
            '825'='Nurse Practitioner'
            '827'='Nurse Anesthetist'
            '830'='Optometrist'
            '835'='Optician'
            '840'='Pharmacist'
            '845'='Physician Assistant'
            '850'='Therapy (Physical)'
            '853'='Therapists (Supportive)'
            '855'='Therapists (Alternative)'
            '857'='Renal Dialysis Therapy'
            '860'='Psychologist'
            '865'='Acupuncturist'
            '870'='Spiritual Healers'
            '900'='Health Educator/Agency'
            '905'='Transportation'
            '910'='Health Resort'
            '915'='Hearing Labs'
            '920'='Home Health Organiz/Agency'
            '925'='Imaging Center'
            '930'='Laboratory'
            '935'='Pharmacy'
            '940'='Supply Center'
            '945'='Vision Center'
            '950'='Public Health Agency'
            '955'='Unknown Clinic'
            '960'='Case Manager'
;
run;




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




proc import out = Work.biologicsLookup
            datafile = "U:\studies\AS\pgms\bchan\data\raw\AS Project Codebooks - 20170410\AS Project Medicine - DMARDs & BIOs  - 20170409.xlsx" 
            dbms = xlsx 
            replace;
  sheet = "Sheet1"; 
  getnames = yes;
  datarow = 2;
run;
proc sql;
  delete from Work.biologicsLookup
    where category ^= "Biologic";
  select category, subcate as subcategory, gnn, count(*) as n
    from Work.biologicsLookup
    group by category, subcate, gnn;
quit;
proc sql;
  create table Work.indBiologics0 as
    select A.database, A.patid, A.indexID,
           A.begin_date format = mmddyy10. as rxDate, 
           "HCPCS" as codeType, 
           A.px as drugCode, 
           B.gnn as drugName, 
           B.descript as drugDesc, 
           . as dispense_sup
      from UCB.tempPrevPxAll A inner join 
           Work.biologicsLookup B on (A.px = B.code)
      where A.px_date < A.indexDate - 183
    union corr
    select A.database, A.patid, A.indexID,
           A.dispense_date format = mmddyy10. as rxDate, 
           "NDC" as codeType, 
           A.ndc as drugCode, 
           B.gnn as drugName, 
           B.descript as drugDesc, 
           A.dispense_sup
      from UCB.tempPrevRxAll A inner join 
           Work.biologicsLookup B on (A.ndc = B.code)
      where A.dispense_date < A.indexDate - 183;
  select codeType, drugName, count(distinct patid) as countDistinctPatid
    from Work.indBiologics0
    group by codeType, drugName;
  create table DT.indBiologics as
    select distinct
           A.database, A.patid, A.indexID,
           1 as indRxBiologics
    from Work.indBiologics0 A;
quit;




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
           count(distinct A.admit_date) as countIPAdmits12mPrior,
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
           sum(indAVPhys12mPrior) as countAVPhys12mPrior
    from (select distinct A.database, A.patid, A.indexID, A.begin_date,
                 1 as indAVPhys12mPrior
          from UCB.tempPrevPx12mPrior A
          where A.codeType = "CPT" & 
                prxmatch("/^(992[0147][1-5])|(990((24)|(58)))/", A.code) & 
                calculated indAVPhys12mPrior = 1) B
    group by B.database, B.patid, B.indexID;
  create table Work.countAVRheumEncounters as
    select B.database, B.patid, B.indexID,
           sum(indAVRheum12mPrior) as countAVRheum12mPrior
    from (select distinct A.database, A.patid, A.indexID, A.begin_date,
                 case
                   when A.database = "MPCD" & B.prov_type = "66" then 1
                   when A.database = "Marketscan" & B.prov_type = "300" then 1
                   when A.database = "Medicare" & B.prov_type = "66" then 1
                   else .
                   end as indAVRheum12mPrior
          from UCB.tempPrevPx12mPrior A inner join
               UCB.tempPrevDx12mPrior B on (A.database = B.database & A.patid = B.patid & A.encounterID = B.encounterID)
          where A.codeType = "CPT" & 
                prxmatch("/^(992[0147][1-5])|(990((24)|(58)))/", A.code) & 
                calculated indAVRheum12mPrior = 1) B
    group by B.database, B.patid, B.indexID;
  create table Work.countEREncounters as
    select A.database, A.patid, A.indexID,
           count(distinct A.begin_date) as countERVisits,
           case
             when count(distinct A.begin_date) > 0 then 1
             else 0
             end as indERVisit12mPrior
    from UCB.tempPrevPx12mPrior A
    where A.codeType = "CPT" & prxmatch("/^9928[1-5]/", code)
    group by A.database, A.patid, A.indexID;
  create table DT.countEncounters as
    select coalesce(A.database, B.database, C.database) as database,
           coalesce(A.patid, B.patid, C.patid) as patid,
           coalesce(A.indexID, B.indexID, C.indexID) as indexID,
           A.countAVPhys12mPrior,
           B.countAVRheum12mPrior,
           C.indERVisit12mPrior,
           C.countERVisits
    from Work.countAVPhysEncounters A full join
         Work.countAVRheumEncounters B on (A.indexID = B.indexID) full join
         Work.countEREncounters C on (A.indexID = C.indexID | B.indexID = C.indexID);
  select ^missing(countAVPhys12mPrior) as a,
         ^missing(countAVRheum12mPrior) as b,
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


/* 
Code for outpatient infections
Use code for hospitalized infections
See queryPrevalentComorbidities.sas
 */
proc sql;
  create table Work.defOutcomes as
    select * 
    from DT.defOutcomes 
    where disease ^in ("Interstitial lung disease");
quit;
proc sql;
  create table DT.outpatientInfection as
    select distinct 
           A.database, A.patid, A.indexID,
           1 as indOutpatientInfection
    from UCB.tempPrevDxAll A inner join 
         Work.defOutcomes B on (A.codeType = B.codeType & A.code = B.code)
    where A.enc_type = "AV" &
          B.disease in ("Hospitalized infection");
quit;




ods html close;
