@echo off
set fileName=%~nx0
call :waitforpid %1
Setlocal EnableDelayedExpansion
shift
set args=0
for %%I in (%*) do set /a "args+=1"
set /a "args-=1"
set operation=del
set returnValue=0

for /l %%I in (1,1,%args%) do (
	
	call :setValue %%1
	
	if  "!returnValue!"=="" (
		goto lastStep
	) else (
	if  "!returnValue!"=="del" (
		set operation=del
	) else (
		if "!returnValue!"=="move" (
			set operation=move
		) else (
			if !operation!==del (
				call :myDel %%1
			) else (
				if !operation!==move (
				call :myMove %%1 %%2
				shift
				)
			)
		)
	)
	)
	shift
)

:lastStep
set "fileName=SIM\%filename%"
set dest=%fileName%
set dest=%dest:SIM\=%

start ar000loader.exe
start /b "" cmd /c move "%filename%" "%dest%"&exit /b

::is only for good conscience , we never should reach this point
exit /b

:setValue
set returnValue=%1
goto :eof

:waitforpid
 tasklist /fi "pid eq %1" 2>nul | find "%1" >nul
 if %ERRORLEVEL%==0 (
   timeout /t 2 /nobreak >nul
   goto :waitforpid
 )
goto :eof

:myDel
del /F  %1
goto :eof

:myMove
move /Y  %1 %2
goto :eof
  