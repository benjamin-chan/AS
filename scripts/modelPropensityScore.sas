*  University of Alabama at Birmingham                               *
*  AS project                                                        *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=modelPropensityScore; * type the name of your program here (without the filename extension);
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


proc sql;
  create table Work.allCovariates as
    select A.database,
           case
             when A.exposure in ("No exposure", "NSAID") then "NSAID or no exposure"
             else A.exposure
             end as exposure3,
           A.PATID,
           A.age,
           case
             when age = 0 then "0"
             when  1 <= age <= 18 then "1-18"
             when 19 <= age <= 29 then "19-29"
             when 30 <= age <= 39 then "30-39"
             when 40 <= age <= 49 then "40-49"
             when 50 <= age <= 59 then "50-59"
             when 60 <= age <= 69 then "60-69"
             when 70 <= age       then "70+"
             else ""
             end as catAge,
           A.SEX,
           A.indexID,
           max(0, B.indAmyloidosis     ) as indAmyloidosis,
           max(0, C.indAortInsuffRegurg) as indAortInsuffRegurg,
           max(0, D.indApicalPulmFib   ) as indApicalPulmFib,
           max(0, E.indCaudaEquina     ) as indCaudaEquina,
           max(0, F.indVertFrac        ) as indVertFrac,
           max(0, G.indConductBlock    ) as indConductBlock,
           max(0, H.indCrohnsDis       ) as indCrohnsDis,
           max(0, I.indHematCa         ) as indHematCa,
           max(0, J.indHospInf         ) as indHospInf,
           max(0, K.indIgANeph         ) as indIgANeph,
           max(0, L.indInterstLungDis  ) as indInterstLungDis,
           max(0, M.indMI              ) as indMI,
           max(0, N.indNephSyn         ) as indNephSyn,
           max(0, O.indNMSC            ) as indNMSC,
           max(0, P.indNonVertOsFrac   ) as indNonVertOsFrac,
           max(0, Q.indOppInf          ) as indOppInf,
           max(0, R.indPsoriasis       ) as indPsoriasis,
           max(0, S.indPSA             ) as indPSA,
           max(0, T.indRestrictLungDis ) as indRestrictLungDis,
           max(0, U.indSolidCa         ) as indSolidCa,
           max(0, V.indSpinalCordComp  ) as indSpinalCordComp,
           max(0, W.indUlcerColitis    ) as indUlcerColitis,
           max(0, X.indUveitis         ) as indUveitis,
           max(0, AA.indDiabetes       ) as indDiabetes,
           max(0, BB.indHT             ) as indHT,
           max(0, CC.indMetabSyn       ) as indMetabSyn,
           max(0, DD.indNAFattyLiverDis) as indNAFattyLiverDis,
           max(0, EE.indCOPDEmphysema  ) as indCOPDEmphysema,
           case
             when FF.meanPredEqDoseCat = "" then "None"
             else FF.meanPredEqDoseCat
             end as meanPredEqDoseCat
    from 
      DT.indexLookup A left join
      (select indexID, 1 as indAmyloidosis      from DT.comorbidities      where indPrevPriorToIndex = 1 & prxmatch("/Amyloidosis/"                               , disease    )) B  on (A.indexID = B.indexID ) left join
      (select indexID, 1 as indAortInsuffRegurg from DT.comorbidities      where indPrevPriorToIndex = 1 & prxmatch("/Aortic Insufficiency\/Aortic Regurgitation/", disease    )) C  on (A.indexID = C.indexID ) left join
      (select indexID, 1 as indApicalPulmFib    from DT.comorbidities      where indPrevPriorToIndex = 1 & prxmatch("/Apical Pulmonary fibrosis/"                 , disease    )) D  on (A.indexID = D.indexID ) left join
      (select indexID, 1 as indCaudaEquina      from DT.comorbidities      where indPrevPriorToIndex = 1 & prxmatch("/Cauda Equina syndrome/"                     , disease    )) E  on (A.indexID = E.indexID ) left join
      (select indexID, 1 as indVertFrac         from DT.comorbidities      where indPrevPriorToIndex = 1 & prxmatch("/Clinical vertebral fracture/"               , disease    )) F  on (A.indexID = F.indexID ) left join
      (select indexID, 1 as indConductBlock     from DT.comorbidities      where indPrevPriorToIndex = 1 & prxmatch("/Conduction Block/"                          , disease    )) G  on (A.indexID = G.indexID ) left join
      (select indexID, 1 as indCrohnsDis        from DT.comorbidities      where indPrevPriorToIndex = 1 & prxmatch("/Crohn/"                                     , disease    )) H  on (A.indexID = H.indexID ) left join
      (select indexID, 1 as indHematCa          from DT.comorbidities      where indPrevPriorToIndex = 1 & prxmatch("/Hematologic Cancer/"                        , disease    )) I  on (A.indexID = I.indexID ) left join
      (select indexID, 1 as indHospInf          from DT.comorbidities      where indPrevPriorToIndex = 1 & prxmatch("/Hospitalized infection/"                    , disease    )) J  on (A.indexID = J.indexID ) left join
      (select indexID, 1 as indIgANeph          from DT.comorbidities      where indPrevPriorToIndex = 1 & prxmatch("/IgA nephropathy/"                           , disease    )) K  on (A.indexID = K.indexID ) left join
      (select indexID, 1 as indInterstLungDis   from DT.comorbidities      where indPrevPriorToIndex = 1 & prxmatch("/Interstitial lung disease/"                 , disease    )) L  on (A.indexID = L.indexID ) left join
      (select indexID, 1 as indMI               from DT.comorbidities      where indPrevPriorToIndex = 1 & prxmatch("/Myocardial infarction/"                     , disease    )) M  on (A.indexID = M.indexID ) left join
      (select indexID, 1 as indNephSyn          from DT.comorbidities      where indPrevPriorToIndex = 1 & prxmatch("/Nephrotic syndrome/"                        , disease    )) N  on (A.indexID = N.indexID ) left join
      (select indexID, 1 as indNMSC             from DT.comorbidities      where indPrevPriorToIndex = 1 & prxmatch("/Non Melanoma Skin Cancer/"                  , disease    )) O  on (A.indexID = O.indexID ) left join
      (select indexID, 1 as indNonVertOsFrac    from DT.comorbidities      where indPrevPriorToIndex = 1 & prxmatch("/Non-vertebral osteoporotic fracture/"       , disease    )) P  on (A.indexID = P.indexID ) left join
      (select indexID, 1 as indOppInf           from DT.comorbidities      where indPrevPriorToIndex = 1 & prxmatch("/Opportunistic infection/"                   , disease    )) Q  on (A.indexID = Q.indexID ) left join
      (select indexID, 1 as indPsoriasis        from DT.comorbidities      where indPrevPriorToIndex = 1 & prxmatch("/Psoriasis/"                                 , disease    )) R  on (A.indexID = R.indexID ) left join
      (select indexID, 1 as indPSA              from DT.comorbidities      where indPrevPriorToIndex = 1 & prxmatch("/Psoriatic arthritis/"                       , disease    )) S  on (A.indexID = S.indexID ) left join
      (select indexID, 1 as indRestrictLungDis  from DT.comorbidities      where indPrevPriorToIndex = 1 & prxmatch("/Restrictive lung disease/"                  , disease    )) T  on (A.indexID = T.indexID ) left join
      (select indexID, 1 as indSolidCa          from DT.comorbidities      where indPrevPriorToIndex = 1 & prxmatch("/Solid Cancer/"                              , disease    )) U  on (A.indexID = U.indexID ) left join
      (select indexID, 1 as indSpinalCordComp   from DT.comorbidities      where indPrevPriorToIndex = 1 & prxmatch("/Spinal Cord compression/"                   , disease    )) V  on (A.indexID = V.indexID ) left join
      (select indexID, 1 as indUlcerColitis     from DT.comorbidities      where indPrevPriorToIndex = 1 & prxmatch("/Ulcerative Colitis/"                        , disease    )) W  on (A.indexID = W.indexID ) left join
      (select indexID, 1 as indUveitis          from DT.comorbidities      where indPrevPriorToIndex = 1 & prxmatch("/Uveitis/"                                   , disease    )) X  on (A.indexID = X.indexID ) left join
      (select indexID, 1 as indDiabetes         from DT.comorbiditiesOther where                           prxmatch("/Diabetes/"                                  , comorbidity)) AA on (A.indexID = AA.indexID) left join
      (select indexID, 1 as indHT               from DT.comorbiditiesOther where                           prxmatch("/Hypertention/"                              , comorbidity)) BB on (A.indexID = BB.indexID) left join
      (select indexID, 1 as indMetabSyn         from DT.comorbiditiesOther where                           prxmatch("/Metabolic syndrome/"                        , comorbidity)) CC on (A.indexID = CC.indexID) left join
      (select indexID, 1 as indNAFattyLiverDis  from DT.comorbiditiesOther where                           prxmatch("/Non-alcoholic fatty liver disease/"         , comorbidity)) DD on (A.indexID = DD.indexID) left join
      (select indexID, 1 as indCOPDEmphysema    from DT.comorbiditiesOther where                           prxmatch("/COPD or emphysema/"                         , comorbidity)) EE on (A.indexID = EE.indexID) left join
      (select indexID, meanPredEqDoseCat        from DT.rxOralCorticosteroid                                                                                                    ) FF on (A.indexID = FF.indexID) ;
quit;


proc means data = Work.allCovariates;
  class database exposure3;
  var indAmyloidosis
      indAortInsuffRegurg
      indApicalPulmFib
      indCaudaEquina
      indVertFrac
      indConductBlock
      indCrohnsDis
      indHematCa
      indHospInf
      indIgANeph
      indInterstLungDis
      indMI
      indNephSyn
      indNMSC
      indNonVertOsFrac
      indOppInf
      indPsoriasis
      indPSA
      indRestrictLungDis
      indSolidCa
      indSpinalCordComp
      indUlcerColitis
      indUveitis
      indDiabetes
      indHT
      indMetabSyn
      indNAFattyLiverDis
      indCOPDEmphysema;
run;
proc freq data = Work.allCovariates;
  table database * exposure3 * meanPredEqDoseCat / list;
run;
proc sql;
  select database,
         catAge,
         min(age) as minAge,
         max(age) as maxAge,
         count(*) as n,
         sum(exposure3 = "TNF") as nTNF,
         sum(exposure3 = "DMARD") as nDMARD,
         sum(exposure3 = "NSAID or no exposure") as nNSAID
  from Work.AllCovariates
  group by database, catAge;
quit;


/* 
Fit 3-level model
3 levels of treatment exposure: TNF, DMARD, NSAID or no exposure

Fit separate models for each data source: MPCD, Marketscan, Medicare

Some parameters blow up; exlude these from the model estimation
 */
%let class = exposure3 (ref = "TNF") catAge (ref = "70+") sex (ref = "M") meanPredEqDoseCat (ref = "None") / param = ref;


%let db = MPCD;
proc logistic data = Work.allCovariates outest = Work.psBetas3Level;
  where database = "&db";
  class &class;
  model exposure3 = catAge
                    sex
                    /* indAmyloidosis */
                    indAortInsuffRegurg
                    /* indApicalPulmFib */
                    /* indCaudaEquina */
                    indVertFrac
                    /* indConductBlock */
                    indCrohnsDis
                    indHematCa
                    indHospInf
                    indIgANeph
                    /* indInterstLungDis */
                    /* indMI */
                    /* indNephSyn */
                    /* indNMSC */
                    indNonVertOsFrac
                    indOppInf
                    indPsoriasis
                    indPSA
                    indRestrictLungDis
                    indSolidCa
                    /* indSpinalCordComp */
                    indUlcerColitis
                    indUveitis
                    indDiabetes
                    indHT
                    indMetabSyn
                    indNAFattyLiverDis
                    indCOPDEmphysema
                    meanPredEqDoseCat
                    / link = glogit rsquare;
  output out = Work.ps3Level predicted = ps xbeta = xbeta;
run;
proc datasets library = work nolist;
  change psBetas3Level = psBetas3Level&db
         ps3Level = ps3Level&db;
run;

%let db = Marketscan;
proc logistic data = Work.allCovariates outest = Work.psBetas3Level;
  where database = "&db";
  class &class;
  model exposure3 = catAge
                    sex
                    /* indAmyloidosis */
                    indAortInsuffRegurg
                    /* indApicalPulmFib */
                    /* indCaudaEquina */
                    indVertFrac
                    indConductBlock
                    indCrohnsDis
                    indHematCa
                    indHospInf
                    indIgANeph
                    indInterstLungDis
                    indMI
                    /* indNephSyn */
                    indNMSC
                    indNonVertOsFrac
                    indOppInf
                    indPsoriasis
                    indPSA
                    indRestrictLungDis
                    indSolidCa
                    indSpinalCordComp
                    indUlcerColitis
                    indUveitis
                    indDiabetes
                    indHT
                    indMetabSyn
                    indNAFattyLiverDis
                    indCOPDEmphysema
                    meanPredEqDoseCat
                    / link = glogit rsquare;
  output out = Work.ps3Level predicted = ps xbeta = xbeta;
run;
proc datasets library = work nolist;
  change psBetas3Level = psBetas3Level&db
         ps3Level = ps3Level&db;
run;

%let db = Medicare;
proc logistic data = Work.allCovariates outest = Work.psBetas3Level;
  where database = "&db";
  class &class;
  model exposure3 = catAge
                    sex
                    indAmyloidosis
                    indAortInsuffRegurg
                    /* indApicalPulmFib */
                    indCaudaEquina
                    indVertFrac
                    indConductBlock
                    indCrohnsDis
                    indHematCa
                    indHospInf
                    indIgANeph
                    indInterstLungDis
                    indMI
                    indNephSyn
                    indNMSC
                    indNonVertOsFrac
                    indOppInf
                    indPsoriasis
                    indPSA
                    indRestrictLungDis
                    indSolidCa
                    indSpinalCordComp
                    indUlcerColitis
                    indUveitis
                    indDiabetes
                    indHT
                    indMetabSyn
                    indNAFattyLiverDis
                    indCOPDEmphysema
                    meanPredEqDoseCat
                    / link = glogit rsquare;
  output out = Work.ps3Level predicted = ps xbeta = xbeta;
run;
proc datasets library = work nolist;
  change psBetas3Level = psBetas3Level&db
         ps3Level = ps3Level&db;
run;

proc sql;
  create table Work.ps3Level as
    select * from ps3LevelMPCD union corr
    select * from ps3LevelMarketscan union corr
    select * from ps3LevelMedicare ;
  create table Work.psBetas3Level as
    select "MPCD" as database, * from psBetas3LevelMPCD union corr
    select "Marketscan" as database, * from psBetas3LevelMarketscan union corr
    select "Medicare" as database, * from psBetas3LevelMedicare ;
quit;


/* 
Check
 */
proc sql;
  select database, indexID,
         sum(ps) as sumPS 
    from Work.ps3Level
    group by database, indexID
    having calculated sumPS < 1 - 1e-12;
quit;


/* 
Union model coefficients from the 4-level model and the 3-level model
 */
proc sql;
  create table Work.psBetas as
    select * from Work.psBetas3Level ;
quit;


/* 
Union propensity scores from the 4-level model and the 3-level model
Calculate IPTW
 */
%let varlist = indexID, database, _level_, ps,
               age,
               catAge,
               sex,
               indAmyloidosis,
               indAortInsuffRegurg,
               indApicalPulmFib,
               indCaudaEquina,
               indVertFrac,
               indConductBlock,
               indCrohnsDis,
               indHematCa,
               indHospInf,
               indIgANeph,
               indInterstLungDis,
               indMI,
               indNephSyn,
               indNMSC,
               indNonVertOsFrac,
               indOppInf,
               indPsoriasis,
               indPSA,
               indRestrictLungDis,
               indSolidCa,
               indSpinalCordComp,
               indUlcerColitis,
               indUveitis,
               indDiabetes,
               indHT,
               indMetabSyn,
               indNAFattyLiverDis,
               indCOPDEmphysema,
               meanPredEqDoseCat;
proc sql;
  create table Work.ps as
    select "3-level exposure" as model, exposure3 as exposure, &varlist from Work.ps3Level 
    order by indexID, exposure;
  alter table Work.ps add iptw numeric;
  update Work.ps set iptw = (exposure  = _level_) / ps + (exposure ^= _level_) / (1 - ps);
quit;


/* 
Determine common support region
For propensity of TNF
 */
%let exposure = "TNF";
proc means data = Work.ps n nmiss min max mean median stddev;
  where _level_ in (&exposure);
  class model _level_ exposure;
  var ps;
run;
proc sql;
  create table Work.commonSupportRegion as
    select model,
           max(minPS) as commonSupportLowerBound,
           min(maxPS) as commonSupportUpperBound
    from (select model, exposure,
                 min(ps) as minPS,
                 max(ps) as maxPS
          from Work.ps
          where _level_ in (&exposure)
          group by model, exposure)
    group by model;
  select * from Work.commonSupportRegion;
  create table Work.temp as
    select * from Work.ps where _level_ in (&exposure);
  create table Work.ps as
    select A.*, 
           B.commonSupportLowerBound, 
           B.commonSupportUpperBound,
           case
             when A.ps = . then .
             when B.commonSupportLowerBound <= A.ps <= B.commonSupportUpperBound then 1
             else 0
             end as indCommonSupport
    from Work.temp A inner join
         Work.commonSupportRegion B on (A.model = B.model);
  select model,
         exposure, 
         _level_, 
         sum(indCommonSupport = 1) as n1, 
         sum(indCommonSupport = 1) / sum(^missing(indCommonSupport)) format = percent9.3 as prop1,
         sum(indCommonSupport = 0) as n0, 
         sum(indCommonSupport = 0) / sum(^missing(indCommonSupport)) format = percent9.3 as prop0
    from Work.ps
    group by model, exposure, _level_;
quit;


/* 
Stabilize weights

See

Austin, P. C., and Stuart, E. A. (2015) Moving towards best practice when
using inverse probability of treatment weighting (IPTW) using the propensity
score to estimate causal treatment effects in observational studies. Statist.
Med., 34: 3661–3679. doi: 10.1002/sim.6607.
 */
proc sql;
  create table Work.temp as select * from Work.ps;
  create table Work.ps as
    select A.*,
           B.marginalPS,
           B.marginalPS * ((A.exposure  = A._level_) / A.ps +
                           (A.exposure ^= A._level_) / (1 - A.ps))
             as iptwStabilized
    from Work.temp A inner join
         (select model,
                 exposure, 
                 _level_, 
                 mean(ps) as marginalPS 
          from Work.temp 
          group by model, exposure, _level_) B on (A.model = B.model & A.exposure = B.exposure);
  drop table Work.temp;
quit;
proc means data = Work.ps n nmiss min max mean median stddev maxdec = 3;
  class indCommonSupport model exposure _level_;
  var ps marginalPS iptw iptwStabilized;
run;
proc corr data = Work.ps;
  var iptw iptwStabilized;
run;


/* 
Save output data files
 */
proc sql;
  create table DT.ps as
    select * 
    from Work.ps;
  create table Work.psDeidentified as
    select model,
           database,
           exposure,
           _level_,
           ps,
           indCommonSupport,
           iptw,
           marginalPS,
           iptwStabilized,
           age,
           catAge,
           sex,
           indAmyloidosis,
           indAortInsuffRegurg,
           indApicalPulmFib,
           indCaudaEquina,
           indVertFrac,
           indConductBlock,
           indCrohnsDis,
           indHematCa,
           indHospInf,
           indIgANeph,
           indInterstLungDis,
           indMI,
           indNephSyn,
           indNMSC,
           indNonVertOsFrac,
           indOppInf,
           indPsoriasis,
           indPSA,
           indRestrictLungDis,
           indSolidCa,
           indSpinalCordComp,
           indUlcerColitis,
           indUveitis,
           indDiabetes,
           indHT,
           indMetabSyn,
           indNAFattyLiverDis,
           indCOPDEmphysema,
           meanPredEqDoseCat
    from DT.ps;
quit;
proc export
  data = Work.psBetas
  outfile = "data\processed\psBetas.csv"
  dbms = csv
  replace;
  delimiter = ",";
run;
proc export
  data = Work.psDeidentified
  outfile = "data\processed\psDeidentified.csv"
  dbms = csv
  replace;
  delimiter = ",";
run;
proc export
  data = Work.commonSupportRegion
  outfile = "data\processed\commonSupportRegion.csv"
  dbms = csv
  replace;
  delimiter = ",";
run;


ods html close;
