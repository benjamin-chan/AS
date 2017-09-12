proc sql;
  
  create table UCB.tempLookupMPCD as &selectfrom3 where database = "MPCD";
  create table UCB.temp0710 as &select2 from MPSTD.RX_07_10 A &where2;
  create table UCB.temp&type.RxMPCD as
    &select1 from UCB.tempLookupMPCD A inner join UCB.temp0710 B &on1;
  drop table UCB.temp0710;

  create table UCB.tempLookupMarketscan as &selectfrom3 where database = "Marketscan";
  create table UCB.temp10 as &select2 from UCBSTD.RX_2010 A &where2;
  create table UCB.temp11 as &select2 from UCBSTD.RX_2011 A &where2;
  create table UCB.temp12 as &select2 from UCBSTD.RX_2012 A &where2;
  create table UCB.temp13 as &select2 from UCBSTD.RX_2013 A &where2;
  create table UCB.temp14 as &select2 from UCBSTD.RX_2014 A &where2;
  create table UCB.temp&type.RxUCB as
    &select1 from UCB.tempLookupMarketscan A inner join UCB.temp10 B &on1 union corr
    &select1 from UCB.tempLookupMarketscan A inner join UCB.temp11 B &on1 union corr
    &select1 from UCB.tempLookupMarketscan A inner join UCB.temp12 B &on1 union corr
    &select1 from UCB.tempLookupMarketscan A inner join UCB.temp13 B &on1 union corr
    &select1 from UCB.tempLookupMarketscan A inner join UCB.temp14 B &on1 ;
  drop table UCB.temp10;
  drop table UCB.temp11;
  drop table UCB.temp12;
  drop table UCB.temp13;
  drop table UCB.temp14;

  create table UCB.tempLookupMedicare as &selectfrom3 where database = "Medicare";
  create table UCB.temp06 as &select2 from STD_SABR.STD_RX_2006 A &where2;
  create table UCB.temp07 as &select2 from STD_SABR.STD_RX_2007 A &where2;
  create table UCB.temp08 as &select2 from STD_SABR.STD_RX_2008 A &where2;
  create table UCB.temp09 as &select2 from STD_SABR.STD_RX_2009 A &where2;
  create table UCB.temp10 as &select2 from STD_SABR.STD_RX_2010 A &where2;
  create table UCB.temp11 as &select2 from STD_SABR.STD_RX_2011 A &where2;
  create table UCB.temp12 as &select2 from STD_SABR.STD_RX_2012 A &where2;
  create table UCB.temp13 as &select2 from STD_SABR.STD_RX_2013 A &where2;
  create table UCB.temp14 as &select2 from STD_SABR.STD_RX_2014 A &where2;
  create table UCB.temp&type.RxSABR as
    &select1 from UCB.tempLookupMedicare A inner join UCB.temp06 B &on1 union corr
    &select1 from UCB.tempLookupMedicare A inner join UCB.temp07 B &on1 union corr
    &select1 from UCB.tempLookupMedicare A inner join UCB.temp08 B &on1 union corr
    &select1 from UCB.tempLookupMedicare A inner join UCB.temp09 B &on1 union corr
    &select1 from UCB.tempLookupMedicare A inner join UCB.temp10 B &on1 union corr
    &select1 from UCB.tempLookupMedicare A inner join UCB.temp11 B &on1 union corr
    &select1 from UCB.tempLookupMedicare A inner join UCB.temp12 B &on1 union corr
    &select1 from UCB.tempLookupMedicare A inner join UCB.temp13 B &on1 union corr
    &select1 from UCB.tempLookupMedicare A inner join UCB.temp14 B &on1 ;
  drop table UCB.temp06;
  drop table UCB.temp07;
  drop table UCB.temp08;
  drop table UCB.temp09;
  drop table UCB.temp10;
  drop table UCB.temp11;
  drop table UCB.temp12;
  drop table UCB.temp13;
  drop table UCB.temp14;
  
quit;
