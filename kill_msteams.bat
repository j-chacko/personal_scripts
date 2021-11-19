ECHO OFF

:: FIX SLOW TEAMS PERFORMANCE

:::: Kill the Teams process
tasklist /fi "imagename eq Teams.exe" |find ":" > nul
if errorlevel 1 taskkill /im "Teams.exe" /t /f

:::: Kill the Outlook process
tasklist /fi "imagename eq OUTLOOK.exe" |find ":" > nul
if errorlevel 1 taskkill /im "OUTLOOK.exe" /t /f

:::: Clear all subfolders and files within %APPDATA%\Microsoft\Teams
cd %APPDATA%\Microsoft\Teams
rd /s /q . 2 > nul

:::: Restarts the computer, with a delay of 30 seconds.
:::: Change 30 to another number if you want to increase of reduce the delay
:::: 0 will restart immediately
shutdown /r /f /t 30

exit