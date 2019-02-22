del ..\output\* /q
del ..\data\processed\* /q

REM call :execute contentsSourceDatasets
REM call :execute importOutcomeCodebook
REM call :execute calculateASPrevalence
REM call :execute buildASCohort
REM call :execute pullTargetDrug
REM call :execute buildExposureCohorts
REM call :execute buildIndexLookup
REM call :execute buildControlLookup
REM call :execute LC_UCBSTD
REM call :execute LC_MPSTD
REM call :execute LC_SABRSTD
REM call :execute unionExpoCohort7
REM call :execute reproduceTables2
REM call :execute buildServiceCodeDatasets
REM call :execute buildServiceCodeDatasetsControl
REM call :execute queryFractures
REM call :execute queryFracturesControl
REM call :execute CANCER_setoguchi
REM call :execute CANCER_NMSC
REM call :execute queryOutcomeHospitalizedInfection
REM call :execute queryOutcomeOpportunisticInfection
REM call :execute queryPrevalentComorbidities
REM call :execute queryPrevalentComorbiditiesControl
call :execute queryIncidenceOutcomes
REM call :execute generateNDCLookup
REM call :execute queryOtherComorbidities
call :execute modelPropensityScore
rem Run summarizePropensityScore.Rmd to check propensity score model
call :execute modelIncidenceOutcomes
REM call :execute contentsWorkingDatasets

"C:\Program Files\7-Zip\7z.exe" d ..\output.zip ..\output\*
"C:\Program Files\7-Zip\7z.exe" a ..\output.zip ..\output\*
"C:\Program Files\7-Zip\7z.exe" l ..\output.zip > ..\output.zip.log
"C:\Program Files\7-Zip\7z.exe" d ..\data.zip ..\data\processed\*
"C:\Program Files\7-Zip\7z.exe" a ..\data.zip ..\data\processed\*
"C:\Program Files\7-Zip\7z.exe" l ..\data.zip > ..\data.zip.log

exit /b


:execute
set exe="D:\Program Files\SASHome\SASFoundation\9.4\sas.exe"
set cfg="Y:\SAS\9.4\S2\sasv9.cfg"
set ini="U:\studies\AS\pgms\bchan"
set scr=U:\studies\AS\pgms\bchan\scripts
set out=U:\studies\AS\pgms\bchan\output
set f=%1
%exe% -CONFIG %cfg% -sasinitialfolder %ini% ^
  -sysin %scr%\%f%.sas ^
  -log   %out%\%f%.log ^
  -print %out%\%f%.log 
