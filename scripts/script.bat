del ..\output\* /q
del ..\data\processed\* /q

call :execute contentsWorkingDatasets

"C:\Program Files\7-Zip\7z.exe" d ..\output.zip ..\output\*
"C:\Program Files\7-Zip\7z.exe" a ..\output.zip ..\output\*
"C:\Program Files\7-Zip\7z.exe" l ..\output.zip > ..\output.zip.log
"C:\Program Files\7-Zip\7z.exe" d ..\data.zip ..\data\processed\*
"C:\Program Files\7-Zip\7z.exe" a ..\data.zip ..\data\processed\*
"C:\Program Files\7-Zip\7z.exe" l ..\data.zip > ..\data.zip.log

exit /b


:execute
set exe="C:\Program Files\SASHome\x86\SASFoundation\9.3\sas.exe"
set cfg="q:\pgms\bchan\sas93_1\S2\sasv9.cfg"
set ini="U:\studies\AS\pgms\bchan"
set scr=U:\studies\AS\pgms\bchan\scripts
set out=U:\studies\AS\pgms\bchan\output
set f=%1
%exe% -CONFIG %cfg% -sasinitialfolder %ini% ^
  -sysin %scr%\%f%.sas ^
  -log   %out%\%f%.log ^
  -print %out%\%f%.log 
