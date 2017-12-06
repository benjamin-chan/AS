*  University of Alabama at Birmingham                               *
*  BRONCHIECTASIS project                                            *
**********************************************************************;
options pagesize=74 linesize=150 pageno=1 missing=' ' date FORMCHAR="|----|+|---+=|-/\<>*";
* Programmer    : Benjamin Chan <chanb@ohsu.edu>
* Creation date : 
* Modify date   :
;
%let cmt=generateNDCLookup; * type the name of your program here (without the filename extension);
%let pgm=&cmt..sas;
%include "lib\libname.sas" ;
footnote "&pgm.";
* footnote2 "%sysfunc(datetime(),datetime14.)";
title1 '--- BRONCHIECTASIS project ---';
**********************************************************************;
options macrogen mlogic mprint symbolgen;
options nomacrogen nomlogic nomprint nosymbolgen;



ods html
  body = "output\&cmt..html"
  style = Statistical;


/* 
From: Yang, Shuo [mailto:shuoyang@uabmc.edu] 
Sent: Wednesday, August 24, 2016 12:06 PM
To: Benjamin Chan <chanb@ohsu.edu>; Chen, Lang <langchen@uabmc.edu>
Cc: Emily Henkle <henkle@ohsu.edu>; Matthews, Robert S <rsm@uab.edu>; Curtis, Jeffrey R <jrcurtis@uabmc.edu>
Subject: RE: oral steroids for bronchiectasis

Hi Ben,

I copied 1 SAS datasets to "Q:\pgms\bchan\FDB" folder:

* FDB_ETC_NDC_15:

  * It's the First Data Bank data with 'Enhanced Therapeutic Class'
    identifiers. And this is the most often used data for searching target
    generic names and NDCs.

  * If you have the accurate generic name list, then you can search generic
    names in 'GNN', 'GNN60' variables, which are generic name and generic name
    in 60 characters; or search generic/brand names in 'BN', 'LN', 'LN60'
    variables, which are brand name, label name and label name in 60
    characters. Then you can get the NDC lists. Or

  * If you don't have a complete/accurate generic names, you can search one or
    several generic names which you are sure they should be correct, then get
    the 'ETC_NAME' and 'ETC_ID' of them, which they stands for 'Enhanced
    Therapeutic Class Names' and 'Enhanced Therapeutic Class IDs', and then go
    back to search those 'ETC_ID' in the FDB_ETC_NDC_15 data. This step will
    give you medicines assigned in the same therapeutic class. Then you can
    review the generic name list to drop anything you don't need.

  * Notes:

    * Key variables you would be interested are: ETC_NAME, ETC_ID, GNN, GNN60,
      BN, LN, LN60, RT, STR, STR60. And in which,

      * RT stands for Route

      * STR stands for Strength; and STR60 stands for Strength info in 60
        characters (longer format)

    * In the results of any search, the RT variable should not be 'MISCELL',
      which stands for 'MISCELLANEOUS' and the medicine in this type are 'Bulk
      Chemicals' and we don't think they are real medicines prescribed to
      patients.

  * An example of SAS codes to search for biologic drugs that I used are
    pasted below.

Feel free to let me know if you have any question.

Best,

Shawn
 */
libname FDB "Q:\pgms\bchan\FDB" access = readonly;
proc contents data = FDB.FDB_ETC_NDC_15 order = varnum;
run;


/* 
For oral steroids, integrate UAB's Ndc_oralsteroids data set


From: Yang, Shuo [mailto:shuoyang@uabmc.edu]   
Sent: Monday, September 19, 2016 11:28 AM  
To: Biostatistics & Design Program <bdp@ohsu.edu>; Benjamin Chan <chanb@ohsu.edu>  
Cc: Chen, Lang <langchen@uabmc.edu>; Kevin Winthrop <winthrop@ohsu.edu>; Curtis, Jeffrey R <jrcurtis@uabmc.edu>  
Subject: Oral Steroids NDC List with Converted Prednisone Equivalent Dose  

Hi Ben and All,

The cleaned oral steroids NDC list (with Prednisone equivalent dose) are at
our shared server SAS library :

libname ndc "W:\onenote\references\Drug NDCs\SAS Data"; 

And named: Ndc_oralsteroids

There are 8 unique GNNs found, 

BETAMETHASONE
BUDESONIDE
CORTISONE
DEXAMETHASONE
HYDROCORTISONE
PREDNISOLONE
PREDNISONE
TRIAMCINOLONE

with 3360 unique NDCs;

And the variable "Prednisone_EQ_Dose" in the SAS data gives the converted
doses; The 'coeff' variable gives the converting coefficient based on below
algorithm.

Target Steroids    | xx mg = | xx mg Prednisone
-------------------|---------|-----------------
BETAMETHASONE      | 1 =     | 25/3
CORTISONE          | 1 =     | 1/5
DEXAMETHASONE      | 1 =     | 20/3
FLUDROCORTISONE    | 1 =     | 1/5
HYDROCORTISONE     | 1 =     | 1/4
METHYLPREDNISOLONE | 1 =     | 5/4
PREDNISOLONE       | 1 =     | 1
TRIAMCINOLONE      | 1 =     | 5/4
BUDESONIDE         | 1 =     | N/A (confirmed there is no coefficient by Lang on 9/13/2016)

Let me know if you have any difficulty to find or view the SAS data.
 */
libname NDC "W:\onenote\references\Drug NDCs\SAS Data" access = readonly;
proc contents data = NDC.Ndc_oralsteroids order = varnum;
run;
proc contents data = NDC.NDC_DMARD_Bio_All order = varnum;
run; 


proc sql;
/* 
Create table of search strings used in LIKE operators
 */
  create table Work.LikeStr (class char(32), rt char(10), drug char(32), likeStr1 char(32), likeStr2 char(28));
  insert into Work.LikeStr
    values ("macrolide", "oral", "azithromycin", '%azithromycin%', 'macrolides')
    values ("macrolide", "oral", "clarithromycin", '%clarithromycin%', 'macrolides')
    values ("macrolide", "oral", "erythromycin", '%erythromycin%', 'macrolides');
  insert into Work.LikeStr
    values ("antitubercular", "oral", "ethambutol", '%ethambutol%', '%antitubercular%')
    values ("antitubercular", "oral", "rifamycin", '%rifa%', '%antitubercular%')
    values ("antitubercular", "oral", "rifabutin", '%rifabutin%', '%antitubercular%')
    values ("antitubercular", "oral", "pyrazinamide", '%pyrazinamide%', '%antitubercular%');
  insert into Work.LikeStr
    values ("inhaled steroid", "inhalation", "beclomethasone", '%beclomethasone%', '%asthma%')
    values ("inhaled steroid", "inhalation", "budesonide", '%budesonide%', '%asthma%')
    values ("inhaled steroid", "inhalation", "flunisolide", '%flunisolide%', '%asthma%')
    values ("inhaled steroid", "inhalation", "fluticasone", '%fluticasone%', '%asthma%')
    values ("inhaled steroid", "inhalation", "mometasone", '%mometasone%', '%asthma%')
    values ("inhaled steroid", "inhalation", "triamcinolone", '%triamcinolone%', '%asthma%'); 
  insert into Work.LikeStr
    values ("combined steroid/bronchodilator", "inhalation", "ipratropium/albuterol", '%ipratropium%albuterol%', '%asthma%')
    values ("combined steroid/bronchodilator", "inhalation", "budesonide/formoterol", '%budesonide%formoterol%', '%asthma%')
    values ("combined steroid/bronchodilator", "inhalation", "fluticasone/salmeterol", '%fluticasone%salmeterol%', '%asthma%');
  insert into Work.LikeStr
    values ("antibiotic", "oral", "levofloxacin", '%levofloxacin%', '%fluoroquinolone%antibiotic%')
    values ("antibiotic", "oral", "moxifloxacin", '%moxifloxacin%', '%fluoroquinolone%antibiotic%')
    values ("antibiotic", "oral", "ciprofloxacin", '%ciprofloxacin%', '%fluoroquinolone%antibiotic%')
    values ("antibiotic", "oral", "amoxicillin", '%amoxicillin%', '%aminopenicillin%antibiotic%')
    values ("antibiotic", "oral", "amoxicillin", '%amoxicillin%clavulanate', '%aminopenicillin%antibiotic%')
    values ("antibiotic", "oral", "doxycycline", '%doxycycline', '%tetracycline%antibiotic%')
    values ("antibiotic", "oral", "minocycline", '%minocycline%', '%tetracycline%antibiotic%')
    values ("antibiotic", "oral", "sulfamethoxazole/trimethoprim", '%sulfa%trim', '%antibac%')
    values ("antibiotic", "oral", "linezolid", '%linezolid%', '%oxazolidinone%antibiotic%');
  insert into Work.LikeStr
    values ("antibiotic", "inhalation", "aztreonam", '%aztreonam%', '%antibiotic%')
    values ("antibiotic", "inhalation", "tobramycin", '%tobram%', '%antibiotic%')
    values ("antibiotic", "inhalation", "amikacin", '%amikac%', '%antibiotic%')
    values ("antibiotic", "inhalation", "colistin", '%colistin%', '%polymyxin%')
    values ("antibiotic", "inhalation", "gentamicin", '%gentam%', '%antibiotic%')
    values ("antibiotic", "intraven", "aztreonam", '%aztreonam%', '%antibiotic%')
    values ("antibiotic", "intraven", "tobramycin", '%tobram%', '%antibiotic%')
    values ("antibiotic", "intraven", "amikacin", '%amikac%', '%antibiotic%')
    values ("antibiotic", "intraven", "colistin", '%colistin%', '%polymyxin%')
    values ("antibiotic", "intraven", "gentamicin", '%gentam%', '%antibiotic%')
    values ("antibiotic", "injection", "aztreonam", '%aztreonam%', '%antibiotic%')
    values ("antibiotic", "injection", "tobramycin", '%tobram%', '%antibiotic%')
    values ("antibiotic", "injection", "amikacin", '%amikac%', '%antibiotic%')
    values ("antibiotic", "injection", "colistin", '%colistin%', '%polymyxin%')
    values ("antibiotic", "injection", "gentamicin", '%gentam%', '%antibiotic%');
  select "Work.LikeStr" as table, * from Work.LikeStr;
/* 
Create NDC lookup table
Use LIKE string 1 on brand name, generic name permutations, label name permutations, and tradename
Use LIKE string 2 on etc_name
 */
  create table DT.lookupNDC as
    select distinct
      A.*,
      . as prednisoneMultiplier,
      . as prednisodeEquivalentDose,
    "" as category,
    "" as subcategory,
    "" as source
    from
      FDB.FDB_ETC_NDC_15 A inner join
      Work.LikeStr B on (lowcase(A.rt) = B.rt &
                         (lowcase(A.bn) like compress(B.likeStr1) |
                          lowcase(A.gnn) like compress(B.likeStr1) |
                          lowcase(A.gnn60) like compress(B.likeStr1) |
                          lowcase(A.ln) like compress(B.likeStr1) |
                          lowcase(A.ln25) like compress(B.likeStr1) |
                          lowcase(A.ln60) like compress(B.likeStr1) |
                          lowcase(A.tradename) like compress(B.likeStr1)) &
                         lowcase(etc_name) like compress(B.likeStr2))
    union all
    select
      A.*,
      C.coeff as prednisoneMultiplier,
      C.Prednisone_EQ_Dose as prednisodeEquivalentDose,
      "" as category,
      "" as subcategory,
      "NDC_ORALSTEROIDS" as source
    from
      FDB.FDB_ETC_NDC_15 A inner join
      NDC.Ndc_oralsteroids C on (A.NDC = C.Code)
    union all
    select
      A.*,
      . as prednisoneMultiplier,
      . as prednisodeEquivalentDose,
      D.category,
      D.subcate as subcategory,
      D.source
    from
      FDB.FDB_ETC_NDC_15 A inner join
      (select codeType, code, category, subcate, "NDC_ALOPU" as source from NDC.NDC_ALOPU union corr
       select codeType, code, category, subcate, "NDC_DMARD_BIO_ALL" as source from NDC.NDC_DMARD_BIO_ALL) D on (A.NDC = D.Code)
    where D.codeType = "NDC"
    union all
    select
      A.*, . as prednisoneMultiplier, . as prednisodeEquivalentDose, "" as category, "" as subcategory, E.source
    from
      FDB.FDB_ETC_NDC_15 A inner join
      (/* select codeType, code, "NDC_ALOPU" as source from NDC.NDC_ALOPU union corr */
       select codeType, code, "NDC_ANTI_FUNGAL" as source from NDC.NDC_ANTI_FUNGAL union corr
       select codeType, code, "NDC_ANTI_HYPERTENSIVE" as source from NDC.NDC_ANTI_HYPERTENSIVE union corr
       select codeType, code, "NDC_ANTIBIOTICS" as source from NDC.NDC_ANTIBIOTICS union corr
       select codeType, code, "NDC_ANTICOAGULANTS" as source from NDC.NDC_ANTICOAGULANTS union corr
       select codeType, code, "NDC_ANTIHYPERLIPID" as source from NDC.NDC_ANTIHYPERLIPID union corr
       select codeType, code, "NDC_ANTIVIRAL" as source from NDC.NDC_ANTIVIRAL union corr
       select codeType, code, "NDC_BETABLOCKERS" as source from NDC.NDC_BETABLOCKERS union corr
       select codeType, code, "NDC_BISPHOSPHONATES" as source from NDC.NDC_BISPHOSPHONATES union corr
       /* select codeType, code, "NDC_DMARD_BIO_ALL" as source from NDC.NDC_DMARD_BIO_ALL union corr */
       select codeType, code, "NDC_FOLIC_ACID" as source from NDC.NDC_FOLIC_ACID union corr
       select codeType, code, "NDC_GANCICLOVIR" as source from NDC.NDC_GANCICLOVIR union corr
       select codeType, code, "NDC_INSULIN" as source from NDC.NDC_INSULIN union corr
       select codeType, code, "NDC_JIA_DMARDS" as source from NDC.NDC_JIA_DMARDS union corr
       select codeType, code, "NDC_NARCOTICS" as source from NDC.NDC_NARCOTICS union corr
       select codeType, code, "NDC_NSAIDCOX" as source from NDC.NDC_NSAIDCOX union corr
       select codeType, code, "NDC_NSAIDNONCOX" as source from NDC.NDC_NSAIDNONCOX union corr
       /* select codeType, code, "NDC_ORALSTEROIDS" as source from NDC.NDC_ORALSTEROIDS union corr */
       select codeType, code, "NDC_PPIS" as source from NDC.NDC_PPIS union corr
       select codeType, code, "NDC_PULMONARY_EMBOLISM" as source from NDC.NDC_PULMONARY_EMBOLISM union corr
       select codeType, code, "NDC_STATIN" as source from NDC.NDC_STATIN union corr
       /* select codeType, code, "NDC_STATIN_OLD15" as source from NDC.NDC_STATIN_OLD15 union corr
       select codeType, code, "NDC_STATINS" as source from NDC.NDC_STATINS union corr
       select codeType, code, "NDC_STATINS_OBSOLETE" as source from NDC.NDC_STATINS_OBSOLETE union corr */
       select codeType, code, "NDC_STEROIDS" as source from NDC.NDC_STEROIDS union corr
       select codeType, code, "NDC_TB" as source from NDC.NDC_TB union corr
       select codeType, code, "NDC_TOPICALSTEROIDS" as source from NDC.NDC_TOPICALSTEROIDS union corr
       select codeType, code, "NDC_VASCULITIS" as source from NDC.NDC_VASCULITIS union corr
       select codeType, code, "NDC_ZOSVAC" as source from NDC.NDC_ZOSVAC) E on (A.NDC = E.Code)
    where E.codeType = "NDC";

  create table DT.lookupJcodes as
    select A.* from NDC.NDC_DMARD_Bio_All A where A.codeType = "HCPCS" union corr
    select "" as gnn,
           "HCPCS" as codeType,
           description as descript,
           hcpcs_cd as code, 
           "" as str,
           "" as rt,
           "Inhaled antibiotic" as category,
           "" as subCate
      from NDC.Antibiotics_parenteral_hcpcs 
      where description like '%amikac%' | 
            description like '%aztreo%' | 
            description like '%colist%' | 
            description like '%gentam%' | 
            description like '%tobram%' 
    order by category, subCate, code;

  create table Work.summaryLookupNDC as
    select "Summary of DT.lookupNDC" as table,
           etc_name, 
           rt, 
           gnn60, 
           count(*) as n 
    from DT.lookupNDC 
    group by gnn60, rt, etc_name;
  select * from Work.summaryLookupNDC;
  create table Work.summaryOralSteroids as
    select "Summary of oral steroids" as table,
           etc_name, 
           rt, 
           gnn60, 
           count(*) as n,
           round(min(prednisodeEquivalentDose), 0.01) as minPrednisodeEqDose,
           round(max(prednisodeEquivalentDose), 0.01) as maxPrednisodeEqDose
    from DT.lookupNDC 
    where ^missing(prednisodeEquivalentDose)
    group by gnn60, rt, etc_name;
  select * from Work.summaryOralSteroids;
quit;


proc contents data = DT.lookupNDC order = varnum;
run;
proc contents data = DT.lookupJcodes order = varnum;
run;


proc export
  data = DT.lookupNDC
  outfile = "data\processed\lookupNDC.csv"
  dbms = csv
  replace;
  delimiter = ",";
run;
proc export
  data = DT.lookupJcodes
  outfile = "data\processed\lookupJcodes.csv"
  dbms = csv
  replace;
  delimiter = ",";
run;
proc export
  data = Work.summaryLookupNDC
  outfile = "data\processed\summaryLookupNDC.csv"
  dbms = csv
  replace;
  delimiter = ",";
run;
proc export
  data = Work.summaryOralSteroids
  outfile = "data\processed\summaryOralSteroids.csv"
  dbms = csv
  replace;
  delimiter = ",";
run;


ods html close;
