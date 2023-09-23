@echo off
SETLOCAL EnableDelayedExpansion

set k3path=D:\GAMES\dota-eb\k3loader\

if NOT exist %k3path%mydir.txt (
  echo file doesn't exist
  pause
  exit
)

echo Processing~
taskkill /f /im "WFE v2.27.exe" >nul

echo Read Path
set COUNTER=0
for /f "tokens=1,2 delims==" %%a in (%k3path%mydir.txt) do (
  set /A COUNTER=COUNTER+1
  if !COUNTER! == 1 set codePath=%%b
  if !COUNTER! == 2 set wfePath=%%b
)

echo Read current WFEConfig.ini
if exist WFEConfig.ini (del WFEConfig.ini)
for /f "tokens=1 delims=" %%a in (%wfePath%WFEConfig.ini) do (
    set var=%%a
    @REM if "!var:~0,8!"=="Msg2 = G" (
    if "!var:~0,8!"=="[QUICKCH" (    
      goto :endLoop
    )
    echo(!var! >> WFEConfig.ini
)

:endLoop
type %k3path%host.txt >> WFEConfig.ini

findstr "Load Code" "%codePath%" > temp.txt

set COUNTER=3
for /f "tokens=1,2 delims=:" %%a in (temp.txt) do (
  set x=%%b
  set y=!x:" )=!

  echo Key!COUNTER! = RCtrl + L>> WFEConfig.ini
  echo Msg!COUNTER! = !y:~1!>> WFEConfig.ini
  set /A COUNTER=COUNTER+1
)

copy /Y WFEConfig.ini %wfePath%

del temp.txt
del WFEConfig.ini

echo WFE running~

start "" %wfePath%WFE.lnk