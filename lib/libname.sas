/* 
Medicare 5% Sample  
2006-2014
(data can track back to 1999, but only use from 2006 in this project)
 */
libname stdc5p spde "H:\studies\osteo\data\STD_files\5pct"
                 datapath=("J:\studies\osteo\data\STD_files\5pct"
                           "K:\studies\osteo\data\STD_files\5pct"
                           "L:\studies\osteo\data\STD_files\5pct"
                           "M:\studies\osteo\data\STD_files\5pct"
                           "O:\studies\osteo\data\STD_files\5pct"
                           "P:\studies\osteo\data\STD_files\5pct")
                 indexpath=("I:\studies\osteo\data\STD_files\5pct"
                            "M:\studies\osteo\data\STD_files\5pct")
                   compress=binary;
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


/* 
NDC library

From: Chen, Lang [mailto:langchen@uabmc.edu] 
Sent: Monday, October 02, 2017 11:36 AM
To: Benjamin Chan <chanb@ohsu.edu>
Subject: RE: quick summary of AS call

Sorry for the delay. Here it is

W:\onenote\references\drug ndcs\sas data

Lang

From: Benjamin Chan [mailto:chanb@ohsu.edu] 
Sent: Monday, October 02, 2017 1:12 PM
To: Chen, Lang
Subject: RE: quick summary of AS call

Hi Lang, did you get a chance to take a look at this? Thanks.

From: Benjamin Chan 
Sent: Friday, September 29, 2017 3:31 PM
To: 'Chen, Lang' <langchen@uabmc.edu>
Subject: RE: quick summary of AS call

Lang,

I’m trying to adapt your W:\Users\lchen\pmg\outcome\outcome_infection.sas
program. It calls a data set in a library that is not defined. Can you tell me
were the NDC library it uses is? Thanks.
 */
libname NDC "W:\onenote\references\drug ndcs\sas data" access = readonly;
