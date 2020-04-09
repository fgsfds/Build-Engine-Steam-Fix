@echo off

if exist "unins000.exe" (	rmdir zmbv /s /q
							del "Graphic mode setup.exe"
							del "unins000.*"
							del "goggame.dll"
							del "One Unit Whole Blood.zip"
							del "dosboxBlood*"
							del "*.ico"
							del "dosbox_*.txt"
							del "dosbox-0.73.tar.gz"
							del "innosetup_license.txt"
							cls )


:menu
cls

if exist "cdmusic" ( SET CDM=-c "imgmount D game.inst -t iso")
if not exist "cdmusic" ( SET CDM=)



if not exist "BuildGDX.jar" (echo [91m1. Download BuildGDX[0m)
if exist "BuildGDX.jar" (echo 1. BuildGDX)

echo.
echo 2. Blood DOSBox
echo 3. Cryptic Passage DOSBox
echo.
if not exist "cdmusic" (echo [91m4. CD music DISABLED[0m)
if exist "cdmusic" (echo [92m4. CD music ENABLED[0m)
echo.
echo 5. DOSBox Setup
echo 6. Build Mouse Fix
echo.
echo 7. MapEdit
echo.
echo.
echo Q. Quit
echo.
echo.

choice /c 1234567Q /n /m "Choose an option: "

if errorlevel 8 exit
if errorlevel 7 goto mapedit
if errorlevel 6 goto MFX
if errorlevel 5 goto Setup
if errorlevel 4 goto music
if errorlevel 3 goto CP
if errorlevel 2 goto B
if errorlevel 1 goto GDX
exit

:GDX

if not exist "BuildGDX.jar" (	start https://m210.duke4.net/index.php/downloads/download/8-java/53-buildgdx
										exit)
if exist "BuildGDX.jar" (	goto GDX2 )

:B
dosboxx.exe -fullscreen -conf config.conf %CDM%		-c "BLOOD.EXE" -noconsole -c "exit"
exit

:CP
dosboxx.exe -fullscreen -conf config.conf %CDM%		-c "CRYPTIC.exe" -noconsole -c "exit"
exit

:Setup
dosboxx.exe -conf config.conf					-c "SETUP.exe" -noconsole -c "exit"
exit

:mapedit
dosboxx.exe -conf config.conf 					-c "mapedit.exe" -noconsole -c "exit"
exit

:GDX2

if not exist ACTIVE.MRK (	start /wait BuildGDX.jar
							cls
							exit )

if exist ACTIVE.MRK (	del ACTIVE.MRK
						ren TILES007.ART CPART07.AR_
						ren TILES015.ART CPART15.AR_
						ren BART07.AR_ TILES007.ART
						ren BART15.AR_ TILES015.ART
						start /wait BuildGDX.jar
						cls
						exit )
exit

:music
if not exist "cdmusic" (	type NUL > cdmusic
							cls
							goto menu )



if exist "cdmusic" (	del cdmusic
						cls
						goto menu )
exit

:MFX
cls

if not exist "blood.exe" (	echo .EXE NOT FOUND
							echo.
							PAUSE
							goto menu )

CertUtil -hashfile BLOOD.EXE MD5 | find /i /v "md5" | find /i /v "certutil" > md5.txt
set /p MD=<md5.txt
set "MD=%MD: =%"
del md5.txt

if %MD% == 8c6ee2d4fa0cc38e4ae70f1c3bf249ca (goto MFX1)
if %MD% == b207854aea21cb21e0d4a303095a1ca5 (goto MFX2)
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
if errorlevel 1 ( dosboxx.exe -conf config.conf -c "buildmfx.exe blood.exe" -noconsole -c "exit" )
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
if errorlevel 1 ( dosboxx.exe -conf config.conf -c "buildmfx.exe blood.exe /u" -noconsole -c "exit" )
goto menu