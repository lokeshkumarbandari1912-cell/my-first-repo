@echo off
echo Starting Universal Subsidy & Benefit Finder...
echo.

REM Start backend in a new window
echo Starting Backend Server...
start "Backend Server" cmd /k "cd /d %~dp0backend && py -m uvicorn main:app --reload --port 8000"

REM Wait a moment for backend to start
timeout /t 3 /nobreak >nul

REM Start frontend using Python HTTP server in a new window
echo Starting Frontend Server...
start "Frontend Server" cmd /k "cd /d %~dp0frontend && py -m http.server 3000"

REM Wait a moment for frontend to start
timeout /t 2 /nobreak >nul

REM Open the application in default browser
echo Opening application in browser...
start http://localhost:3000/standalone.html

echo.
echo ========================================
echo   Universal Subsidy & Benefit Finder
echo ========================================
echo Backend:  http://localhost:8000
echo Frontend: http://localhost:3000/standalone.html
echo.
echo Press any key to close all servers...
pause >nul

REM Close the server windows when user presses a key
taskkill /f /fi "WindowTitle eq Backend Server*" >nul 2>&1
taskkill /f /fi "WindowTitle eq Frontend Server*" >nul 2>&1
echo Servers stopped.
