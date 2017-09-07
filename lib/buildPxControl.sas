proc sql;

  create table UCB.temp0710 as &select2 from MPSTD.PX_07_10;
  create table UCB.temp&type.PxMPCDControl as
    &select1 from UCB.tempLookupMPCDControl A inner join UCB.temp0710 B &on1;
  drop table UCB.temp0710;

  create table UCB.temp06 as &select2 from StdC5p.STD_PX_2006;
  create table UCB.temp07 as &select2 from StdC5p.STD_PX_2007;
  create table UCB.temp08 as &select2 from StdC5p.STD_PX_2008;
  create table UCB.temp09 as &select2 from StdC5p.STD_PX_2009;
  create table UCB.temp10 as &select2 from StdC5p.STD_PX_2010;
  create table UCB.temp11 as &select2 from StdC5p.STD_PX_2011;
  create table UCB.temp12 as &select2 from StdC5p.STD_PX_2012;
  create table UCB.temp13 as &select2 from StdC5p.STD_PX_2013;
  create table UCB.temp14 as &select2 from StdC5p.STD_PX_2014;
  create table UCB.temp&type.PxSABRControl as
    &select1 from UCB.tempLookupMedicareControl A inner join UCB.temp06 B &on1 union corr
    &select1 from UCB.tempLookupMedicareControl A inner join UCB.temp07 B &on1 union corr
    &select1 from UCB.tempLookupMedicareControl A inner join UCB.temp08 B &on1 union corr
    &select1 from UCB.tempLookupMedicareControl A inner join UCB.temp09 B &on1 union corr
    &select1 from UCB.tempLookupMedicareControl A inner join UCB.temp10 B &on1 union corr
    &select1 from UCB.tempLookupMedicareControl A inner join UCB.temp11 B &on1 union corr
    &select1 from UCB.tempLookupMedicareControl A inner join UCB.temp12 B &on1 union corr
    &select1 from UCB.tempLookupMedicareControl A inner join UCB.temp13 B &on1 union corr
    &select1 from UCB.tempLookupMedicareControl A inner join UCB.temp14 B &on1 ;
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
