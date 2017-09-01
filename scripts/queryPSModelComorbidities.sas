*  University of Alabama at Birmingham                               *
*  AS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=queryPSModelComorbidities; * type the name of your program here (without the filename extension);
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




proc contents data = DT.comorbidities order = varnum;
run;
proc contents data = DT.comorbiditiesOther order = varnum;
run;


proc sql;
  %let select1 = indexID, database, exposure, patid, age, sex, AScohortDate;
  create table Work.comorbiditiesLong as
    select &select1, disease as comorbidity, 1 as indicator from DT.comorbidities      where indPrevPriorToIndex union corr
    select &select1,            comorbidity, 1 as indicator from DT.comorbiditiesOther where indPreExposure ;
quit;

proc transpose data = Work.comorbiditiesLong out = Work.comorbiditiesWide prefix = ind;
  by indexID database exposure patid age sex AScohortDate;
  id comorbidity;
  variable indicator;
run;

proc datasets library = Work nolist;
  modify comorbiditiesWide;
    rename indHematologic_Cancer = indHematCancer;
    rename indSolid_Cancer = indSolidCancer;
    rename indNon_Melanoma_Skin_Cancer = indNMSCancer;
    rename indAortic_Insufficiency_Aortic_R = indAorticInsuff;
    rename indConduction_Block = indCondBlock;
    rename indMyocardial_infarction = indMI;
    rename indHospitalized_infection = indHospInfect;
    rename indOpportunistic_infection = indOppInfect;
    rename indCrohn_s_Disease = indCrohns;
    rename indUlcerative_Colitis = indUlcColitis;
    * rename indAmyloidosis = indAmyloidosis;
    rename indIgA_nephropathy = indIgANephropathy;
    rename indNephrotic_syndrome = indNephroticSyn;
    rename indApical_Pulmonary_fibrosis = indApicalPulmFib;
    rename indInterstitial_lung_disease = indILD;
    rename indRestrictive_lung_disease_ = indRestrictLungDis;
    rename indCauda_Equina_syndrome = indCaudaEquina;
    rename indSpinal_Cord_compression = indSpinalCordComp;
    rename indClinical_vertebral_fracture = indVertFx;
    rename indNon_vertebral_osteoporotic_fr = indNonVertFx;
    rename indPsoriasis = indPSO;
    rename indPsoriatic_arthritis = indPSA;
    * rename indUveitis = indUveitis;
    * rename indHypertention = indHypertention;
    * rename indDiabetes = indDiabetes;
    rename indMetabolic_syndrome = indMetabSyn;
    rename indNon_alcoholic_fatty_liver_dis = indNonAlcFattyLiverDis;
run;

proc sql;
  create table Work.temp as
    select A.indexID, A.database, A.exposure, A.patid, A.age, A.sex, A.AScohortDate,
           year(A.AScohortDate) as AScohortYear,
           max(0, B.indHematCancer) as indHematCancer,
           max(0, B.indSolidCancer) as indSolidCancer,
           max(0, B.indNMSCancer) as indNMSCancer,
           max(0, B.indAorticInsuff) as indAorticInsuff,
           max(0, B.indCondBlock) as indCondBlock,
           max(0, B.indMI) as indMI,
           max(0, B.indHospInfect) as indHospInfect,
           max(0, B.indOppInfect) as indOppInfect,
           max(0, B.indCrohns) as indCrohns,
           max(0, B.indUlcColitis) as indUlcColitis,
           max(0, B.indAmyloidosis) as indAmyloidosis,
           max(0, B.indIgANephropathy) as indIgANephropathy,
           max(0, B.indNephroticSyn) as indNephroticSyn,
           max(0, B.indApicalPulmFib) as indApicalPulmFib,
           max(0, B.indILD) as indILD,
           max(0, B.indRestrictLungDis) as indRestrictLungDis,
           max(0, B.indCaudaEquina) as indCaudaEquina,
           max(0, B.indSpinalCordComp) as indSpinalCordComp,
           max(0, B.indVertFx) as indVertFx,
           max(0, B.indNonVertFx) as indNonVertFx,
           max(0, B.indPSO) as indPSO,
           max(0, B.indPSA) as indPSA,
           max(0, B.indUveitis) as indUveitis,
           max(0, B.indHypertention) as indHypertention,
           max(0, B.indDiabetes) as indDiabetes,
           max(0, B.indMetabSyn) as indMetabSyn,
           max(0, B.indNonAlcFattyLiverDis) as indNonAlcFattyLiverDis 
    from DT.indexLookup A left join
         Work.comorbiditiesWide B on (A.indexID = B.indexID);
quit;



Analysis Variable : age  
N N Miss Mean Median Minimum Maximum 
60009 1 55.7 56.0 5.0 103.0 




ods html close;
