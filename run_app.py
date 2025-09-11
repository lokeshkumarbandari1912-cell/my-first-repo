#!/usr/bin/env python3
"""
Universal Subsidy & Benefit Finder - Single Launch Script
Starts both backend and frontend servers together
"""

import subprocess
import time
import webbrowser
import os
import sys
from pathlib import Path

def main():
    print("Starting Universal Subsidy & Benefit Finder...")
    print("=" * 50)
    
    # Get the directory where this script is located
    script_dir = Path(__file__).parent
    backend_dir = script_dir / "backend"
    frontend_dir = script_dir / "frontend"
    
    # Check if required files exist
    if not (backend_dir / "main.py").exists():
        print("Error: backend/main.py not found!")
        return
    
    if not (frontend_dir / "standalone.html").exists():
        print("Error: frontend/standalone.html not found!")
        return
    
    processes = []
    
    try:
        # Start backend server
        print("Starting Backend Server (FastAPI)...")
        backend_cmd = [
            sys.executable, "-m", "uvicorn", "main:app", 
            "--reload", "--port", "8000", "--host", "127.0.0.1"
        ]
        backend_process = subprocess.Popen(
            backend_cmd,
            cwd=backend_dir,
            creationflags=subprocess.CREATE_NEW_CONSOLE if os.name == 'nt' else 0
        )
        processes.append(("Backend", backend_process))
        
        # Wait for backend to start
        print("Waiting for backend to initialize...")
        time.sleep(3)
        
        # Start frontend server
        print("Starting Frontend Server (Python HTTP)...")
        frontend_cmd = [sys.executable, "-m", "http.server", "3000"]
        frontend_process = subprocess.Popen(
            frontend_cmd,
            cwd=frontend_dir,
            creationflags=subprocess.CREATE_NEW_CONSOLE if os.name == 'nt' else 0
        )
        processes.append(("Frontend", frontend_process))
        
        # Wait for frontend to start
        print("Waiting for frontend to initialize...")
        time.sleep(2)
        
        # Open browser
        print("Opening application in browser...")
        webbrowser.open("http://localhost:3000/standalone.html")
        
        print("\n" + "=" * 50)
        print("Application Started Successfully!")
        print("=" * 50)
        print("Backend API:  http://localhost:8000")
        print("Frontend App: http://localhost:3000/standalone.html")
        print("API Docs:     http://localhost:8000/docs")
        print("=" * 50)
        print("\nPress Ctrl+C to stop all servers")
        
        # Keep the script running
        try:
            while True:
                time.sleep(1)
                # Check if processes are still running
                for name, process in processes:
                    if process.poll() is not None:
                        print(f"Warning: {name} server stopped unexpectedly")
        
        except KeyboardInterrupt:
            print("\nShutting down servers...")
            
    except Exception as e:
        print(f"Error starting servers: {e}")
    
    finally:
        # Clean up processes
        for name, process in processes:
            try:
                process.terminate()
                process.wait(timeout=5)
                print(f"{name} server stopped")
            except subprocess.TimeoutExpired:
                process.kill()
                print(f"{name} server force killed")
            except Exception as e:
                print(f"Error stopping {name} server: {e}")
        
        print("All servers stopped. Goodbye!")

if __name__ == "__main__":
    main()
