proc sql;
  
  create table UCB64.tempLookupMPCD as &selectfrom3 where database = "MPCD";
  create table UCB64.temp0710 as &select2 from MPSTD.RX_07_10 A;
  create table UCB64.temp&type.RxMPCD as
    &select1 from UCB64.tempLookupMPCD A inner join UCB64.temp0710 B &on1;
  drop table UCB64.temp0710;

  create table UCB64.tempLookupMarketscan as &selectfrom3 where database = "Marketscan";
  create table UCB64.temp10 as &select2 from UCBSTD.RX_2010 A;
  create table UCB64.temp11 as &select2 from UCBSTD.RX_2011 A;
  create table UCB64.temp12 as &select2 from UCBSTD.RX_2012 A;
  create table UCB64.temp13 as &select2 from UCBSTD.RX_2013 A;
  create table UCB64.temp14 as &select2 from UCBSTD.RX_2014 A;
  create table UCB64.temp&type.RxUCB as
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
  create table UCB64.temp06 as &select2 from STD_SABR.STD_RX_2006 A;
  create table UCB64.temp07 as &select2 from STD_SABR.STD_RX_2007 A;
  create table UCB64.temp08 as &select2 from STD_SABR.STD_RX_2008 A;
  create table UCB64.temp09 as &select2 from STD_SABR.STD_RX_2009 A;
  create table UCB64.temp10 as &select2 from STD_SABR.STD_RX_2010 A;
  create table UCB64.temp11 as &select2 from STD_SABR.STD_RX_2011 A;
  create table UCB64.temp12 as &select2 from STD_SABR.STD_RX_2012 A;
  create table UCB64.temp13 as &select2 from STD_SABR.STD_RX_2013 A;
  create table UCB64.temp14 as &select2 from STD_SABR.STD_RX_2014 A;
  create table UCB64.temp&type.RxSABR as
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

  create table UCB64.temp&type.RxAll as
    select * from UCB64.temp&type.RxMPCD union corr
    select * from UCB64.temp&type.RxUCB  union corr
    select * from UCB64.temp&type.RxSABR ;
  select "UCB64.temp&type.RxAll" as table, database, count(*) format = comma20.0 as n from UCB64.temp&type.RxAll group by database;
  drop table UCB64.temp&type.RxMPCD;
  drop table UCB64.temp&type.RxUCB ;
  drop table UCB64.temp&type.RxSABR;

quit;
