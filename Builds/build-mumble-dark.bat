@echo off
set SCRIPT_DIR=mumble-theme
set PATH=%PATH%
pushd %SCRIPT_DIR%\source
popd
rd /q /s mumble-icons
mkdir mumble-icons
python fill-icons.py nowshed #4B9CD3 mumble-icons
for /r icons/nowshed/ %%i in (*.svg) do powershell -Command "(gc %%~dpnxi) -replace '#4285f4', '#6a1b9a' | Out-File -encoding ASCII mumble-icons/%%~nxi"
python make-resource.py -base-dir %SCRIPT_DIR%\ -find-files -config dark-config.json -icons-dir mumble-icons -output mumble-dark-nowshed-recolored -style dark.qss 
rd /q /s mumble-icons
python make-resource.py -base-dir %SCRIPT_DIR%\ -find-files -config dark-config.json -icons-dir icons/nowshed -output mumble-dark-nowshed -style dark.qss

copy /y mumble-dark-nowshed.qbtheme %LOCALAPPDATA%\qBittorrent
move /y mumble-dark-nowshed.qbtheme ..\mumble-dark-nowshed.qbtheme
move /y mumble-dark-nowshed-recolored.qbtheme ..\mumble-dark-nowshed-recolored.qbtheme
