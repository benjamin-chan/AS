proc sql;
  
  create table UCB64.tempLookupMPCDControl as &selectfrom3 where database = "MPCD";
  create table UCB64.temp0710 as &select2 from MPSTD.DX_07_10 A &where2;
  create table UCB64.temp&type.DxMPCDControl as
    &select1 from UCB64.tempLookupMPCDControl A inner join UCB64.temp0710 B &on1;
  drop table UCB64.temp0710;

  create table UCB64.tempLookupMedicareControl as &selectfrom3 where database = "Medicare";
  create table UCB64.temp06 as &select2 from StdC5p.STD_DX_2006 A &where2;
  create table UCB64.temp07 as &select2 from StdC5p.STD_DX_2007 A &where2;
  create table UCB64.temp08 as &select2 from StdC5p.STD_DX_2008 A &where2;
  create table UCB64.temp09 as &select2 from StdC5p.STD_DX_2009 A &where2;
  create table UCB64.temp10 as &select2 from StdC5p.STD_DX_2010 A &where2;
  create table UCB64.temp11 as &select2 from StdC5p.STD_DX_2011 A &where2;
  create table UCB64.temp12 as &select2 from StdC5p.STD_DX_2012 A &where2;
  create table UCB64.temp13 as &select2 from StdC5p.STD_DX_2013 A &where2;
  create table UCB64.temp14 as &select2 from StdC5p.STD_DX_2014 A &where2;
  create table UCB64.temp&type.DxSABRControl as
    &select1 from UCB64.tempLookupMedicareControl A inner join UCB64.temp06 B &on1 union corr
    &select1 from UCB64.tempLookupMedicareControl A inner join UCB64.temp07 B &on1 union corr
    &select1 from UCB64.tempLookupMedicareControl A inner join UCB64.temp08 B &on1 union corr
    &select1 from UCB64.tempLookupMedicareControl A inner join UCB64.temp09 B &on1 union corr
    &select1 from UCB64.tempLookupMedicareControl A inner join UCB64.temp10 B &on1 union corr
    &select1 from UCB64.tempLookupMedicareControl A inner join UCB64.temp11 B &on1 union corr
    &select1 from UCB64.tempLookupMedicareControl A inner join UCB64.temp12 B &on1 union corr
    &select1 from UCB64.tempLookupMedicareControl A inner join UCB64.temp13 B &on1 union corr
    &select1 from UCB64.tempLookupMedicareControl A inner join UCB64.temp14 B &on1 ;
  drop table UCB64.temp06;
  drop table UCB64.temp07;
  drop table UCB64.temp08;
  drop table UCB64.temp09;
  drop table UCB64.temp10;
  drop table UCB64.temp11;
  drop table UCB64.temp12;
  drop table UCB64.temp13;
  drop table UCB64.temp14;
  
  create table UCB64.temp&type.DxAllControl as
    select * from UCB64.temp&type.DxMPCDControl union corr
    select * from UCB64.temp&type.DxSABRControl ;
  select "UCB64.temp&type.DxAllControl" as table, database, count(*) format = comma20.0 as n from UCB64.temp&type.DxAllControl group by database;
  drop table UCB64.temp&type.DxMPCDControl;
  drop table UCB64.temp&type.DxSABRControl;

quit;
