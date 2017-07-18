for /f %%I in ('wmic os get localdatetime ^|find "20"') do set dt=%%I
REM dt format is now YYYYMMDDhhmmss...
SET YYYY=%dt:~0,4%
SET MM=%dt:~4,2%
SET DD=%dt:~6,2%
ECHO %YYYY% - %MM% - %DD%

SET PATHTOZGVIEW=C:\soft\co2-zgview-2
SET PATHTOCO2WEB=C:\soft\xampp\htdocs\co2dbdata

SET PATHTOZG2DAY=%PATHTOZGVIEW%\%YYYY%\%MM%\%DD%.CSV
SET PATHTOCO2DAY=%PATHTOCO2WEB%\%YYYY%\%MM%\%YYYY%%MM%%DD%.CSV

MD %PATHTOCO2DAY:~0,-12%

buildgraph.exe fromFile="%PATHTOZG2DAY%" intoFile="%PATHTOCO2DAY%"