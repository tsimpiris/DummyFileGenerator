:: Dummy File Generator
:: Output a dummy file of your preferred size for testing purposes
:: Ioannis Tsimpiris

@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
::SET me=%~n0
SET parent=%~dp0


TITLE = Dummy File Generator


:main
SET /p unit=Enter Unit [kb, mb, gb]: 
SET /p filesize=Enter Size: 
SET /p outputfile=Type Output Filename: 

IF %unit%==kb GOTO createfile
IF %unit%==mb GOTO createfile
IF %unit%==gb GOTO createfile
ECHO Available options are: kb, mb or gb
GOTO main


:createfile
IF EXIST %parent%%outputfile% ECHO File already exists... Deleting it & DEL %parent%%outputfile%
ECHO Creating a %filesize%%unit% file named %outputfile%

:: Create file with 2 bytes
echo.>Temp_%outputfile%
:: Expand to 1 KB
for /L %%i in (1, 1, 9) do type Temp_%outputfile%>>Temp_%outputfile%

IF %unit%==kb GOTO kilo
IF %unit%==mb GOTO mega
IF %unit%==gb GOTO giga


:kilo
:: Expand to the given size
for /L %%i in (1, 1, %filesize%) do type Temp_%outputfile%>>%outputfile%
GOTO removeTemp


:mega
:: Expand to 1 MB
for /L %%i in (1, 1, 10) do type Temp_%outputfile%>>Temp_%outputfile%
:: Expand to the given size
for /L %%i in (1, 1, %filesize%) do type Temp_%outputfile%>>%outputfile%
GOTO removeTemp


:giga
:: Expand to 1 MB
for /L %%i in (1, 1, 10) do type Temp_%outputfile%>>Temp_%outputfile%
:: Expand to 1 GB
for /L %%i in (1, 1, 10) do type Temp_%outputfile%>>Temp_%outputfile%
:: Expand to the given size
for /L %%i in (1, 1, %filesize%) do type Temp_%outputfile%>>%outputfile%
GOTO removeTemp


:removeTemp
DEL Temp_%outputfile%
ECHO done
GOTO exitBatchFile


:exitBatchFile
PAUSE