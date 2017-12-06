del ..\output\* /q
del ..\data\processed\* /q

rem call :execute contentsSourceDatasets
rem call :execute importOutcomeCodebook
rem call :execute buildIndexLookup
rem call :execute buildControlLookup
rem call :execute buildExposureFollowUp
rem call :execute reproduceTables2
rem call :execute buildServiceCodeDatasets
rem call :execute buildServiceCodeDatasetsControl
rem call :execute queryFractures
rem call :execute queryFracturesControl
rem call :execute CANCER_setoguchi
rem call :execute CANCER_NMSC
rem call :execute queryOutcomeHospitalizedInfection
rem call :execute queryOutcomeOpportunisticInfection
rem call :execute queryPrevalentComorbidities
rem call :execute queryPrevalentComorbiditiesControl
rem call :execute queryIncidenceOutcomes
call :execute generateNDCLookup
call :execute queryOtherComorbidities
call :execute modelPropensityScore
rem call :execute modelIncidenceOutcomes
call :execute contentsWorkingDatasets

"C:\Program Files\7-Zip\7z.exe" d ..\output.zip ..\output\*
"C:\Program Files\7-Zip\7z.exe" a ..\output.zip ..\output\*
"C:\Program Files\7-Zip\7z.exe" l ..\output.zip > ..\output.zip.log
"C:\Program Files\7-Zip\7z.exe" d ..\data.zip ..\data\processed\*
"C:\Program Files\7-Zip\7z.exe" a ..\data.zip ..\data\processed\*
"C:\Program Files\7-Zip\7z.exe" l ..\data.zip > ..\data.zip.log

exit /b


:execute
set exe="D:\Program Files\SASHome\x86\SASFoundation\9.4\sas.exe"
set cfg="Y:\SAS94_32\S1\sasv9.cfg"
set ini="U:\studies\AS\pgms\bchan"
set scr=U:\studies\AS\pgms\bchan\scripts
set out=U:\studies\AS\pgms\bchan\output
set f=%1
%exe% -CONFIG %cfg% -sasinitialfolder %ini% ^
  -sysin %scr%\%f%.sas ^
  -log   %out%\%f%.log ^
  -print %out%\%f%.log 
