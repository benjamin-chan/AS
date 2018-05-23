proc sql;

  create table UCB64.temp0710 as &select2 from MPSTD.PX_07_10;
  create table UCB64.temp&type.PxMPCD as
    &select1 from UCB64.tempLookupMPCD A inner join UCB64.temp0710 B &on1;
  drop table UCB64.temp0710;

  create table UCB64.temp10 as &select2 from UCBSTD.PX_2010;
  create table UCB64.temp11 as &select2 from UCBSTD.PX_2011;
  create table UCB64.temp12 as &select2 from UCBSTD.PX_2012;
  create table UCB64.temp13 as &select2 from UCBSTD.PX_2013;
  create table UCB64.temp14 as &select2 from UCBSTD.PX_2014;
  create table UCB64.temp&type.PxUCB as
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

  create table UCB64.temp06 as &select2 from STD_SABR.STD_PX_2006;
  create table UCB64.temp07 as &select2 from STD_SABR.STD_PX_2007;
  create table UCB64.temp08 as &select2 from STD_SABR.STD_PX_2008;
  create table UCB64.temp09 as &select2 from STD_SABR.STD_PX_2009;
  create table UCB64.temp10 as &select2 from STD_SABR.STD_PX_2010;
  create table UCB64.temp11 as &select2 from STD_SABR.STD_PX_2011;
  create table UCB64.temp12 as &select2 from STD_SABR.STD_PX_2012;
  create table UCB64.temp13 as &select2 from STD_SABR.STD_PX_2013;
  create table UCB64.temp14 as &select2 from STD_SABR.STD_PX_2014;
  create table UCB64.temp&type.PxSABR as
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

  create table UCB64.temp&type.PxAll as
    select * from UCB64.temp&type.PxMPCD union corr
    select * from UCB64.temp&type.PxUCB  union corr
    select * from UCB64.temp&type.PxSABR ;
  select "UCB64.temp&type.PxAll" as table, database, count(*) format = comma20.0 as n from UCB64.temp&type.PxAll group by database;
  drop table UCB64.temp&type.PxMPCD;
  drop table UCB64.temp&type.PxUCB ;
  drop table UCB64.temp&type.PxSABR;

quit;
