@echo off
cd /d "%~dp0"
title Triceratops Debug Tool
color 0E

:: Admin check
fltmc >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrative privileges . . .
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    goto :exit
)

:: = = = = = = = = = = = = = = = = = = = =
:: Main Menu
:mainMenu
cls
echo - - - - - - - - - - - - - - - - - - - -
echo Main Menu
echo - - - - - - - - - - - - - - - - - - - -
echo.
echo 1. System File Checker
echo 2. Deployment Image Servicing and Management
echo 3. Restart Windows Explorer
echo 4. Defragment and Optimize Drives
echo 5. Open Disk Cleanup
echo 6. Open Sound Control Panel
echo 7. Open Advanced System Settings
echo 8. List System Information
echo.
echo 9. Exit
echo.

set /p choice=Select an option: 

if "%choice%"=="1" goto :systemFileChecker
if "%choice%"=="2" goto :deploymentImageServicingManagement
if "%choice%"=="3" goto :restartWindowsExplorer
if "%choice%"=="4" goto :defragmentDrives
if "%choice%"=="5" goto :diskCleanup
if "%choice%"=="6" goto :soundControlPanel
if "%choice%"=="7" goto :advancedSystemSettings
if "%choice%"=="8" goto :systemInformation
if "%choice%"=="9" goto :exit

cls
echo Invalid option selected
pause
goto :mainMenu

:: = = = = = = = = = = = = = = = = = = = =
:: System File Checker
:systemFileChecker
cls
echo - - - - - - - - - - - - - - - - - - - -
echo System File Checker
echo - - - - - - - - - - - - - - - - - - - -
echo.
echo Please Select an Option . . .
echo.
echo 1. Scan Now                // Scans all protected system files and attempts to repair any issues found
echo 2. Verify Only             // Scans all protected system files, but does not attempt to repair them
echo.
echo 3. Return to Main Menu
echo.

set /p choice=Select an option: 

if "%choice%"=="1" call :scanNow
if "%choice%"=="2" call :verifyOnly
if "%choice%"=="3" goto :mainMenu

cls
echo Invalid option selected
pause
goto :mainMenu

:scanNow
cls
echo Running System File Checker - Scan Now . . .
sfc /scannow
echo.
pause
goto :mainMenu

:verifyOnly
cls
echo Running System File Checker - Verify Only . . .
sfc /verifyonly
echo.
pause
goto :mainMenu

:: = = = = = = = = = = = = = = = = = = = =
:: Deployment Image Servicing and Management
:deploymentImageServicingManagement
cls
echo - - - - - - - - - - - - - - - - - - - -
echo Deployment Image Servicing and Management
echo - - - - - - - - - - - - - - - - - - - -
echo.
echo Please Select an Option . . .
echo.
echo 1. Check Health            // Performs a quick check to determine if the Windows image has been corrupted
echo 2. Scan Health             // Executes a more comprehensive scan for image corruption
echo 3. Restore Health          // Scans for and repairs corrupted files in the Windows image
echo.
echo 4. Return to Main Menu
echo.

set /p choice=Select an option: 

if "%choice%"=="1" call :checkHealth
if "%choice%"=="2" call :scanHealth
if "%choice%"=="3" call :restoreHealth
if "%choice%"=="4" goto :mainMenu

cls
echo Invalid option selected
pause
goto :mainMenu

:checkHealth
cls
echo Running Deployment Image Servicing and Management - Check Health . . .
dism /Online /Cleanup-Image /CheckHealth
echo.
pause
goto :mainMenu

:scanHealth
cls
echo Running Deployment Image Servicing and Management - Scan Health . . .
dism /Online /Cleanup-Image /ScanHealth
echo.
pause
goto :mainMenu

:restoreHealth
cls
echo Running Deployment Image Servicing and Management - Restore Health . . .
dism /Online /Cleanup-Image /RestoreHealth
echo.
pause
goto :mainMenu

:: = = = = = = = = = = = = = = = = = = = =
:: Restarting Windows Explorer
:restartWindowsExplorer
cls
echo - - - - - - - - - - - - - - - - - - - -
echo Restart Windows Explorer
echo - - - - - - - - - - - - - - - - - - - -
echo.
echo This might take awhile . . .
echo.
taskkill /f /im explorer.exe >nul 2>&1
call :wait 1
tasklist /fi "imagename eq explorer.exe" | find /i "explorer.exe" >nul
if errorlevel 1 (start "" explorer.exe)
pause
goto :mainMenu  

:: = = = = = = = = = = = = = = = = = = = =
:: Defragment and Optimize Drives
:defragmentDrives
cls
echo - - - - - - - - - - - - - - - - - - - -
echo Defragment and Optimize Drives
echo - - - - - - - - - - - - - - - - - - - -
echo.
echo Drive Optimizer . . .
call :wait 1
start dfrgui.exe
echo.
pause
goto :mainMenu

:: = = = = = = = = = = = = = = = = = = = =
:: Open Disk Cleanup
:diskCleanup
cls
echo - - - - - - - - - - - - - - - - - - - -
echo Disk Cleanup
echo - - - - - - - - - - - - - - - - - - - -
echo.
echo Opening Disk Cleanup . . .
call :wait 1
start cleanmgr.exe
echo.
pause
goto :mainMenu

:: = = = = = = = = = = = = = = = = = = = =
:: Open Sound Control Panel
:soundControlPanel
cls
echo - - - - - - - - - - - - - - - - - - - -
echo Sound Control Panel
echo - - - - - - - - - - - - - - - - - - - -
echo.
echo Opening Sound Control Panel . . .
call :wait 1
control mmsys.cpl sounds
echo.
pause
goto :mainMenu

:: = = = = = = = = = = = = = = = = = = = =
:: Open Advanced System Settings
:advancedSystemSettings
cls
echo - - - - - - - - - - - - - - - - - - - -
echo Advanced System Settings
echo - - - - - - - - - - - - - - - - - - - -
echo.
echo Opening Advanced System Settings . . .
call :wait 1
sysdm.cpl
echo.
pause
goto :mainMenu

:: = = = = = = = = = = = = = = = = = = = =
:: List System Information
:systemInformation
cls
echo - - - - - - - - - - - - - - - - - - - -
echo System Information
echo - - - - - - - - - - - - - - - - - - - -
echo.
echo This might take awhile . . .
echo.
echo OS Information:
for /f "tokens=2,*" %%A in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName ^| find "ProductName"') do set OSName=%%B
for /f "tokens=2,*" %%A in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v DisplayVersion ^| find "DisplayVersion"') do set OSVer=%%B
for /f "tokens=2,*" %%A in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild ^| find "CurrentBuild"') do set OSBuild=%%B
echo %OSName% %OSVer% (Build %OSBuild%)
echo.
echo - - - - - - - - - - - - - - - - - - - -
echo.
echo BIOS Information:
powershell -Command "Get-CimInstance Win32_BIOS | Select-Object Manufacturer, Name, Version"
echo.
echo - - - - - - - - - - - - - - - - - - - -
echo.
echo Motherboard Information:
powershell -Command "Get-WmiObject -Class Win32_BaseBoard | Select-Object Manufacturer, Product, SerialNumber"
echo.
echo - - - - - - - - - - - - - - - - - - - -
echo.
echo System Architecture: %PROCESSOR_ARCHITECTURE%
echo.
echo - - - - - - - - - - - - - - - - - - - -
echo.
echo CPU Information:
powershell -Command "Get-WmiObject -Class Win32_Processor | Select-Object -ExpandProperty Name"
echo.
echo - - - - - - - - - - - - - - - - - - - -
echo.
echo RAM Information:
for /f "tokens=2 delims==" %%A in ('powershell -NoLogo -Command "(Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory"') do set RAM=%%A
for /f %%A in ('powershell -NoLogo -Command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB,2)"') do set RAMGB=%%A
echo Total Physical Memory: %RAMGB% GB
echo.
echo - - - - - - - - - - - - - - - - - - - -
echo.
echo GPU Information:
powershell -Command "Get-WmiObject -Class Win32_VideoController | Select-Object Name, AdapterRAM, DriverVersion"
echo.
echo - - - - - - - - - - - - - - - - - - - -
echo.
echo Storage Information:
powershell -Command "Get-WmiObject -Class Win32_LogicalDisk | Select-Object DeviceID, @{Name='FreeSpace(GB)';Expression={[math]::round($_.FreeSpace/1GB,2)}}, @{Name='Size(GB)';Expression={[math]::round($_.Size/1GB,2)}}"
echo.
echo - - - - - - - - - - - - - - - - - - - -
echo.
ipconfig
echo.
echo - - - - - - - - - - - - - - - - - - - -
echo.
getmac
echo.
echo - - - - - - - - - - - - - - - - - - - -
echo.
for /f %%A in ('powershell -NoLogo -Command "(Get-CimInstance Win32_OperatingSystem).LastBootUpTime.ToLocalTime().ToString(\"yyyy-MM-dd HH:mm:ss\")"') do set BootTime=%%A
echo System Boot Time: %BootTime%
echo.
echo - - - - - - - - - - - - - - - - - - - -
echo.
echo USB Devices:
powershell -Command "Get-WmiObject -Class Win32_USBHub | Select-Object DeviceID, PNPDeviceID, Description"
echo.
echo - - - - - - - - - - - - - - - - - - - -
echo.
echo Sound Devices:
powershell -Command "Get-WmiObject -Class Win32_SoundDevice | Select-Object Name, Manufacturer, Status"
echo.
echo - - - - - - - - - - - - - - - - - - - -
echo.
echo Installed Programs:
powershell -Command "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*, HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion"
echo.
echo - - - - - - - - - - - - - - - - - - - -
echo.
pause
goto :mainMenu

:: = = = = = = = = = = = = = = = = = = = =
:: Shared
:wait
set "_w=%~1"
if "%_w%"=="" set "_w=1"
set /a _w=_w+1
ping 127.0.0.1 -n %_w% >nul
exit /b

:: = = = = = = = = = = = = = = = = = = = =
:exit
exit /b