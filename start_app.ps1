# Universal Subsidy & Benefit Finder - PowerShell Launcher
# Starts both backend and frontend servers together

Write-Host "🚀 Starting Universal Subsidy & Benefit Finder..." -ForegroundColor Green
Write-Host "=" * 50

# Get script directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BackendDir = Join-Path $ScriptDir "backend"
$FrontendDir = Join-Path $ScriptDir "frontend"

# Check if required files exist
if (-not (Test-Path (Join-Path $BackendDir "main.py"))) {
    Write-Host "❌ Error: backend/main.py not found!" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path (Join-Path $FrontendDir "standalone.html"))) {
    Write-Host "❌ Error: frontend/standalone.html not found!" -ForegroundColor Red
    exit 1
}

$Jobs = @()

try {
    # Start backend server
    Write-Host "🔧 Starting Backend Server (FastAPI)..." -ForegroundColor Yellow
    $BackendJob = Start-Job -ScriptBlock {
        param($BackendPath)
        Set-Location $BackendPath
        py -m uvicorn main:app --reload --port 8000 --host 127.0.0.1
    } -ArgumentList $BackendDir
    $Jobs += $BackendJob
    
    # Wait for backend to start
    Write-Host "⏳ Waiting for backend to initialize..." -ForegroundColor Yellow
    Start-Sleep -Seconds 3
    
    # Start frontend server
    Write-Host "🌐 Starting Frontend Server (Python HTTP)..." -ForegroundColor Yellow
    $FrontendJob = Start-Job -ScriptBlock {
        param($FrontendPath)
        Set-Location $FrontendPath
        py -m http.server 3000
    } -ArgumentList $FrontendDir
    $Jobs += $FrontendJob
    
    # Wait for frontend to start
    Write-Host "⏳ Waiting for frontend to initialize..." -ForegroundColor Yellow
    Start-Sleep -Seconds 2
    
    # Open browser
    Write-Host "🌍 Opening application in browser..." -ForegroundColor Yellow
    Start-Process "http://localhost:3000/standalone.html"
    
    Write-Host ""
    Write-Host "=" * 50 -ForegroundColor Green
    Write-Host "✅ Application Started Successfully!" -ForegroundColor Green
    Write-Host "=" * 50 -ForegroundColor Green
    Write-Host "🔗 Backend API:  http://localhost:8000" -ForegroundColor Cyan
    Write-Host "🔗 Frontend App: http://localhost:3000/standalone.html" -ForegroundColor Cyan
    Write-Host "📚 API Docs:     http://localhost:8000/docs" -ForegroundColor Cyan
    Write-Host "=" * 50 -ForegroundColor Green
    Write-Host ""
    Write-Host "💡 Press Ctrl+C to stop all servers" -ForegroundColor Yellow
    
    # Keep script running and monitor jobs
    try {
        while ($true) {
            Start-Sleep -Seconds 1
            
            # Check if jobs are still running
            foreach ($Job in $Jobs) {
                if ($Job.State -eq "Failed" -or $Job.State -eq "Completed") {
                    Write-Host "⚠️  Server job stopped unexpectedly" -ForegroundColor Red
                }
            }
        }
    }
    catch {
        Write-Host "`n🛑 Shutting down servers..." -ForegroundColor Yellow
    }
}
catch {
    Write-Host "❌ Error starting servers: $_" -ForegroundColor Red
}
finally {
    # Clean up jobs
    foreach ($Job in $Jobs) {
        try {
            Stop-Job $Job -ErrorAction SilentlyContinue
            Remove-Job $Job -ErrorAction SilentlyContinue
            Write-Host "✅ Server job stopped" -ForegroundColor Green
        }
        catch {
            Write-Host "⚠️  Error stopping server job: $_" -ForegroundColor Red
        }
    }
    
    Write-Host "👋 All servers stopped. Goodbye!" -ForegroundColor Green
}
