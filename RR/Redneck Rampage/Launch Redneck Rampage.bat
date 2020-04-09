@echo off

:menu
cls
if not exist "Redneck\BuildGDX.jar" (echo [91m1. Download BuildGDX[0m)
if exist "Redneck\BuildGDX.jar" (echo 1. BuildGDX)

echo.
echo 2. Redneck Rampage DOSBox
echo 3. Suckin' Grits On Route 66 DOSBox
echo.
echo 4. DOSBox Setup
echo 5. Build Mouse Fix
echo.
echo.
echo Q. Quit
echo.
echo.

choice /c 12345Q /n /m "Choose an option: "

if errorlevel 6 exit
if errorlevel 5 goto MFX
if errorlevel 4 goto Setup
if errorlevel 3 goto R66
if errorlevel 2 goto RR
if errorlevel 1 goto GDX
exit

:GDX

if not exist "Redneck\BuildGDX.jar" (	start https://m210.duke4.net/index.php/downloads/download/8-java/53-buildgdx
										exit)
if exist "Redneck\BuildGDX.jar" (	goto GDX2 )

:RR
dosbox\dosbox.exe -fullscreen -conf config.conf		-c "FIX.EXE" -c "RR.exe" -noconsole -c "exit"
exit

:R66
dosbox\dosbox.exe -fullscreen -conf config.conf		-c "ROUTE66.exe" -noconsole -c "exit"
exit

:Setup
dosbox\dosbox.exe -conf config.conf					-c "setup.exe" -noconsole -c "exit"
exit

:GDX2
cd Redneck

if not exist GAME.BAK (	start /wait BuildGDX.jar
						cls
						exit )

if exist GAME.BAK (	ren RR_OUTRO.ANM END66.ANM
					ren TURDMOV.ANM TURD66.ANM
					ren TILES009.ART TILESA66.ART
					ren TILES023.ART TILESB66.ART
					ren LN_FINAL.VOC END66.VOC
					ren SB_FINAL.VOC TURD66.VOC
					ren GAME.CON GAME66.CON
					ren GAME.BAK GAME.CON
					ren DEMO1.BAK DEMO1.DMO
					ren DEMO2.BAK DEMO2.DMO
					ren DEMO3.BAK DEMO3.DMO
					start /wait BuildGDX.jar
					cls
					exit )

exit

:MFX
cls

if not exist "Redneck\RR.exe" (	echo .EXE NOT FOUND
								echo.
								PAUSE
								goto menu )

CertUtil -hashfile Redneck\RR.EXE MD5 | find /i /v "md5" | find /i /v "certutil" > md5.txt
set /p MD=<md5.txt
set "MD=%MD: =%"
del md5.txt

if %MD% == 1e62852f4723d1a0ad329df7c4bf3b57 (goto MFX1)
if %MD% == c94bd233e4103a70df6955837b9f1180 (goto MFX2)
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
if errorlevel 1 ( dosbox\dosbox.exe -conf config.conf -c "buildmfx.exe RR.exe" -noconsole -c "exit" )
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
if errorlevel 1 ( dosbox\dosbox.exe -conf config.conf -c "buildmfx.exe RR.exe /u" -noconsole -c "exit" )
goto menu