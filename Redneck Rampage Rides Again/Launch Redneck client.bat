@echo off

:menu
cls
if not exist "AGAIN\BuildGDX.jar" (echo [91m1. Download BuildGDX[0m)
if exist "AGAIN\BuildGDX.jar" (echo 1. BuildGDX)

echo.
echo 2. Redneck Rampage Rides Again DOSBox
echo.
echo 3. DOSBox Setup
echo 4. Build Mouse Fix
echo.
echo.
echo Q. Quit
echo.
echo.

choice /c 1234Q /n /m "Choose an option: "

if errorlevel 5 exit
if errorlevel 4 goto MFX
if errorlevel 3 goto Setup
if errorlevel 2 goto RR
if errorlevel 1 goto GDX
exit

:GDX

if not exist "AGAIN\BuildGDX.jar" (	start https://m210.duke4.net/index.php/downloads/download/8-java/53-buildgdx
										exit)

if exist "AGAIN\BuildGDX.jar" (	cd AGAIN 
									start /WAIT BuildGDX.jar
									cls
									exit )

:RR
dosbox\dosbox.exe -fullscreen -conf config.conf		-c "RA.exe" -noconsole -c "exit"
exit

:Setup
dosbox\dosbox.exe -conf config.conf					-c "setup.exe" -noconsole -c "exit"
exit



:MFX
cls

if not exist "AGAIN\RA.exe" (	echo .EXE NOT FOUND
								echo.
								PAUSE
								goto menu )

CertUtil -hashfile AGAIN\RA.EXE MD5 | find /i /v "md5" | find /i /v "certutil" > md5.txt
set /p MD=<md5.txt
set "MD=%MD: =%"
del md5.txt

if %MD% == 73639a07a00afefdfd0c7f547c78ac9f (goto MFX1)
if %MD% == ec904e39ba768ee06b2e8cc7731bab79 (goto MFX2)
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
if errorlevel 1 ( dosbox\dosbox.exe -conf config.conf -c "buildmfx.exe RA.exe" -noconsole -c "exit" )
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
if errorlevel 1 ( dosbox\dosbox.exe -conf config.conf -c "buildmfx.exe RA.exe /u" -noconsole -c "exit" )
goto menu