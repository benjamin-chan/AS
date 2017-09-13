proc sql;
  
  create table UCB.tempLookupMPCDControl as &selectfrom3 where database = "MPCD";
  create table UCB.temp0710 as &select2 from MPSTD.DX_07_10 A &where2;
  create table UCB.temp&type.DxMPCDControl as
    &select1 from UCB.tempLookupMPCDControl A inner join UCB.temp0710 B &on1;
  drop table UCB.temp0710;

  create table UCB.tempLookupMedicareControl as &selectfrom3 where database = "Medicare";
  create table UCB.temp06 as &select2 from StdC5p.STD_DX_2006 A &where2;
  create table UCB.temp07 as &select2 from StdC5p.STD_DX_2007 A &where2;
  create table UCB.temp08 as &select2 from StdC5p.STD_DX_2008 A &where2;
  create table UCB.temp09 as &select2 from StdC5p.STD_DX_2009 A &where2;
  create table UCB.temp10 as &select2 from StdC5p.STD_DX_2010 A &where2;
  create table UCB.temp11 as &select2 from StdC5p.STD_DX_2011 A &where2;
  create table UCB.temp12 as &select2 from StdC5p.STD_DX_2012 A &where2;
  create table UCB.temp13 as &select2 from StdC5p.STD_DX_2013 A &where2;
  create table UCB.temp14 as &select2 from StdC5p.STD_DX_2014 A &where2;
  create table UCB.temp&type.DxSABRControl as
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
  
  create table UCB.temp&type.DxAllControl as
    select * from UCB.temp&type.DxMPCDControl union corr
    select * from UCB.temp&type.DxSABRControl ;
  select "UCB.temp&type.DxAllControl" as table, database, count(*) format = comma20.0 as n from UCB.temp&type.RxAllControl group by database;
  drop table UCB.temp&type.RxMPCDControl;
  drop table UCB.temp&type.RxSABRControl;

quit;
