filename f "data\raw\PublicUseData\TaxonomyCrosswalk.txt";
data Work.TaxonomyCrosswalk;
  infile f dsd delimiter = '09'x firstobs = 2;
  length prov_type_code $6 prov_type_desc $80 taxonomy_code $12 taxonomy_desc $255;
  input prov_type_code $ prov_type_desc $ taxonomy_code $ taxonomy_desc $;
  indPhysician = prxmatch("/physician[^\ssssistant]/", lowcase(prov_type_desc));
run;
proc sort 
  data = Work.TaxonomyCrosswalk (keep = indPhysician prov_type_code prov_type_desc) 
  out = Work.lookupProvTypePhysician nodupkey;
  by indPhysician prov_type_code;
run;


%let provTypeCategory = case
                           when B.indPhysician = 1 then "Physician provider"
                           when B.indPhysician = 0 then "Non-physician provider"
                           else "Missing provider type"
                           end as provTypeCategory;

/* 
HOW TO USE THE &provTypeCategory MACRO VARIABLE

proc sql;
  create table Work.test as
    select &provTypeCategory, B.indPhysician, A.prov_type, B.prov_type_desc, count(*) as n
    from MPSTD.DX_07_10 A inner join
         Work.lookupProvTypePhysician B on (A.prov_type = B.prov_type_code)
    group by B.indPhysician, A.prov_type, B.prov_type_desc;
  alter table Work.test
    modify prov_type format = $6.;
quit;
 */
 