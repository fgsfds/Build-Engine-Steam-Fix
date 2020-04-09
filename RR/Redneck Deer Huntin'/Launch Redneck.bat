@echo off

:menu
cd %CD%
cls
echo 1. Redneck Deer Huntin' DOSBox
echo.
echo 2. DOSBox Setup
echo 3. Build Mouse Fix
echo.
echo.
echo Q. Quit
echo.
echo.

choice /c 123Q /n /m "Choose an option: "

if errorlevel 4 exit
if errorlevel 3 goto MFX
if errorlevel 2 goto Setup
if errorlevel 1 goto RR
exit

:RR
dosbox\dosbox.exe -fullscreen -conf config.conf		-c "RDH.EXE" -noconsole -c "exit"
exit

:Setup
dosbox\dosbox.exe -conf config.conf					-c "CONFIG.EXE" -noconsole -c "exit"
exit

:MFX
cls

if not exist "huntin\rdh.exe" (	echo .EXE NOT FOUND
								echo.
								PAUSE
								goto menu )

CertUtil -hashfile HUNTIN\RDH.EXE MD5 | find /i /v "md5" | find /i /v "certutil" > md5.txt
set /p MD=<md5.txt
set "MD=%MD: =%"
del md5.txt

if %MD% == 6a6e5f3d3cbc65d0dc26c4573769d123 (goto MFX1)
if %MD% == 1f139f27bf3113e8f8d74c017b418f79 (goto MFX2)
echo UNKNOWN .EXE VERSION
echo.
PAUSE
goto menu

:MFX1
echo Mouse Fix [91mDISABLED[0m
echo.
echo 1. Enable?
echo.
echo Q. Back
echo.

choice /c 1Q /n /m "Choose an option: "

if errorlevel 2 goto menu
if errorlevel 1 ( dosbox\dosbox.exe -conf config.conf -c "buildmfx.exe RDH.exe" -noconsole -c "exit" )
goto menu

:MFX2
echo Mouse Fix [92mENABLED[0m
echo.
echo 1. Disable?
echo.
echo Q. Back
echo.

choice /c 1Q /n /m "Choose an option: "

if errorlevel 2 goto menu
if errorlevel 1 ( dosbox\dosbox.exe -conf config.conf -c "buildmfx.exe RDH.exe /u" -noconsole -c "exit" )
goto menu