for /f %%I in ('wmic os get localdatetime ^|find "20"') do set dt=%%I
REM dt format is now YYYYMMDDhhmmss...
SET YYYY=%dt:~0,4%
SET MM=%dt:~4,2%
SET DD=%dt:~6,2%
ECHO %YYYY% - %MM% - %DD%

SET PATHTOZGVIEW=C:\soft\co2-zgview-2
SET PATHTOCO2WEB=C:\soft\xampp\htdocs\co2dbdata
buildgraph.exe fromFile="%PATHTOZGVIEW%\2017\07\19.CSV" intoFile="%PATHTOCO2WEB%\2017\07\20170719.CSV"