/* 
Medicare 5% Sample  
2006-2014
(data can track back to 1999, but only use from 2006 in this project)
 */
libname ccw5std spde "h:\studies\osteo\data\CDM\5pct"
                 datapath=("h:\studies\osteo\data\CDM\5pct"
                           "j:\studies\osteo\data\CDM\5pct"
                           "k:\studies\osteo\data\CDM\5pct"
                           "l:\studies\osteo\data\CDM\5pct")
                 indexpath=("i:\studies\osteo\data\CDM\5pct"
                            "m:\studies\osteo\data\CDM\5pct");
/* 
Medicare SABER2 
2006-2014 
Standardization data are in server 1 in SAS lib
Std_sabr
 */ 
libname std_SABR spde "q:\data\std_SABER"
                 datapath=("q:\data\std_SABER"
                           "r:\data\std_SABER"
                           "s:\data\std_SABER"
                           "t:\data\std_SABER"
                           "u:\studies\SABER2\data\std_SABER")
                 indexpath=("q:\data\aetna"
                            "t:\data\aetna")
                  COMPRESS=BINARY;;
/* 
MPCD  
2007-2010 
(only RA(SP) & Healthy(CP2) population from 'Commercial' (eg. not Medicaid) coverage included)  
 */
libname MPSTD spde "h:\studies\mpcd\data\stddata"
                 datapath=("p:\studies\mpcd\data\stddata"
                           "i:\studies\mpcd\data\stddata"
                           "j:\studies\mpcd\data\stddata"
                           "k:\studies\mpcd\data\stddata"
                           "l:\studies\mpcd\data\stddata"
                           "m:\studies\mpcd\data\stddata")
                 indexpath=("l:\studies\mpcd\data\stddata"
                            "m:\studies\mpcd\data\stddata")
                 partsize=500m
                 bysort=yes;
/* 
MarketScan  
2010-2014 
 */
libname UCBSTD spde "q:\studies\AS\data\stddata"
                 datapath=("q:\studies\AS\data\stddata"
                           "r:\studies\AS\data\stddata"
                           "s:\studies\AS\data\stddata"
                           "t:\studies\AS\data\stddata"
                           "u:\studies\AS\data\stddata"
                           "v:\studies\AS\data\stddata")
                 indexpath=("t:\studies\AS\data\stddata"
                            "u:\studies\AS\data\stddata"
                            "v:\studies\AS\data\stddata")
                 bysort=no;
/* 
Working SAS Library:
SPDE library:
 */
libname UCB spde "q:\studies\AS\data\UCB"
                 datapath=("q:\studies\AS\data\UCB"
                           "r:\studies\AS\data\UCB"
                           "s:\studies\AS\data\UCB"
                           "t:\studies\AS\data\UCB"
                           "u:\studies\AS\data\UCB"
                           "v:\studies\AS\data\UCB")
                 indexpath=("t:\studies\AS\data\UCB"
                            "u:\studies\AS\data\UCB"
                            "v:\studies\AS\data\UCB")
                 bysort=no;
/* 
Small data library:
 */ 
libname dt 'V:\studies\AS\data\';
