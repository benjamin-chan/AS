proc sql;
  
  create table UCB.tempLookupMPCDControl as &selectfrom3 where database = "MPCD";
  create table UCB.temp0710 as &select2 from MPSTD.DX_07_10 A &join2 &where2;
  create table UCB.temp&type.DxMPCDControl as
    &select1 from UCB.tempLookupMPCDControl A inner join UCB.temp0710 B &on1;
  drop table UCB.temp0710;

  create table UCB.tempLookupMedicareControl as &selectfrom3 where database = "Medicare";
  create table UCB.temp06 as &select2 from StdC5p.STD_DX_2006 A &join2 &where2;
  create table UCB.temp07 as &select2 from StdC5p.STD_DX_2007 A &join2 &where2;
  create table UCB.temp08 as &select2 from StdC5p.STD_DX_2008 A &join2 &where2;
  create table UCB.temp09 as &select2 from StdC5p.STD_DX_2009 A &join2 &where2;
  create table UCB.temp10 as &select2 from StdC5p.STD_DX_2010 A &join2 &where2;
  create table UCB.temp11 as &select2 from StdC5p.STD_DX_2011 A &join2 &where2;
  create table UCB.temp12 as &select2 from StdC5p.STD_DX_2012 A &join2 &where2;
  create table UCB.temp13 as &select2 from StdC5p.STD_DX_2013 A &join2 &where2;
  create table UCB.temp14 as &select2 from StdC5p.STD_DX_2014 A &join2 &where2;
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
  
quit;
