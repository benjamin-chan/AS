proc sql;
  
  create table UCB64.tempLookupMPCD as &selectfrom3 where database = "MPCD";
  create table UCB64.temp0710 as &select2 from MPSTD.DX_07_10 A &where2;
  alter table UCB64.temp0710 modify prov_type format = $3.;
  create table UCB64.temp&type.DxMPCD as
    &select1, B.prov_type as prov_type2 from UCB64.tempLookupMPCD A inner join UCB64.temp0710 B &on1;
  drop table UCB64.temp0710;

  create table UCB64.tempLookupMarketscan as &selectfrom3 where database = "Marketscan";
  create table UCB64.temp10 as &select2 from UCBSTD.DX_2010 A &where2;
  create table UCB64.temp11 as &select2 from UCBSTD.DX_2011 A &where2;
  create table UCB64.temp12 as &select2 from UCBSTD.DX_2012 A &where2;
  create table UCB64.temp13 as &select2 from UCBSTD.DX_2013 A &where2;
  create table UCB64.temp14 as &select2 from UCBSTD.DX_2014 A &where2;
  create table UCB64.temp&type.DxUCB as
    &select1 from UCB64.tempLookupMarketscan A inner join UCB64.temp10 B &on1 union corr
    &select1 from UCB64.tempLookupMarketscan A inner join UCB64.temp11 B &on1 union corr
    &select1 from UCB64.tempLookupMarketscan A inner join UCB64.temp12 B &on1 union corr
    &select1 from UCB64.tempLookupMarketscan A inner join UCB64.temp13 B &on1 union corr
    &select1 from UCB64.tempLookupMarketscan A inner join UCB64.temp14 B &on1 ;
  drop table UCB64.temp10;
  drop table UCB64.temp11;
  drop table UCB64.temp12;
  drop table UCB64.temp13;
  drop table UCB64.temp14;

  create table UCB64.tempLookupMedicare as &selectfrom3 where database = "Medicare";
  create table UCB64.temp06 as &select2 from STD_SABR.STD_DX_2006    A &where2;
  create table UCB64.temp07 as &select2 from STD_SABR.STD_DX_2007    A &where2;
  create table UCB64.temp08 as &select2 from STD_SABR.STD_DX_2008_V2 A &where2;
  create table UCB64.temp09 as &select2 from STD_SABR.STD_DX_2009    A &where2;
  create table UCB64.temp10 as &select2 from STD_SABR.STD_DX_2010    A &where2;
  create table UCB64.temp11 as &select2 from STD_SABR.STD_DX_2011    A &where2;
  create table UCB64.temp12 as &select2 from STD_SABR.STD_DX_2012    A &where2;
  create table UCB64.temp13 as &select2 from STD_SABR.STD_DX_2013    A &where2;
  create table UCB64.temp14 as &select2 from STD_SABR.STD_DX_2014    A &where2;
  create table UCB64.temp&type.DxSABR as
    &select1 from UCB64.tempLookupMedicare A inner join UCB64.temp06 B &on1 union corr
    &select1 from UCB64.tempLookupMedicare A inner join UCB64.temp07 B &on1 union corr
    &select1 from UCB64.tempLookupMedicare A inner join UCB64.temp08 B &on1 union corr
    &select1 from UCB64.tempLookupMedicare A inner join UCB64.temp09 B &on1 union corr
    &select1 from UCB64.tempLookupMedicare A inner join UCB64.temp10 B &on1 union corr
    &select1 from UCB64.tempLookupMedicare A inner join UCB64.temp11 B &on1 union corr
    &select1 from UCB64.tempLookupMedicare A inner join UCB64.temp12 B &on1 union corr
    &select1 from UCB64.tempLookupMedicare A inner join UCB64.temp13 B &on1 union corr
    &select1 from UCB64.tempLookupMedicare A inner join UCB64.temp14 B &on1 ;
  drop table UCB64.temp06;
  drop table UCB64.temp07;
  drop table UCB64.temp08;
  drop table UCB64.temp09;
  drop table UCB64.temp10;
  drop table UCB64.temp11;
  drop table UCB64.temp12;
  drop table UCB64.temp13;
  drop table UCB64.temp14;
  
  create table UCB64.temp&type.DxAll as
    select * from UCB64.temp&type.DxMPCD union corr
    select * from UCB64.temp&type.DxUCB  union corr
    select * from UCB64.temp&type.DxSABR ;
  select "UCB64.temp&type.DxAll" as table, database, count(*) format = comma20.0 as n from UCB64.temp&type.DxAll group by database;
  drop table UCB64.temp&type.DxMPCD;
  drop table UCB64.temp&type.DxUCB ;
  drop table UCB64.temp&type.DxSABR;

quit;
