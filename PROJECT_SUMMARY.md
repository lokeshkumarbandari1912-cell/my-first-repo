# Universal Subsidy & Benefit Finder - Project Summary

## Project Overview
A full-stack web application that helps users find government schemes and benefits they're eligible for based on their profile information.

## Project Structure
```
subsidy-finder/
├── README.md                    # Complete setup and usage instructions
├── PROJECT_SUMMARY.md          # This file - project overview
├── backend/                    # FastAPI Python backend
│   ├── main.py                 # Main FastAPI application (3025 bytes)
│   ├── schemes.json           # Sample government schemes database (1751 bytes)
│   ├── requirements.txt       # Python dependencies (25 bytes)
│   └── __pycache__/           # Python cache files
├── frontend/                   # React/Vite frontend
│   ├── src/
│   │   ├── App.jsx            # Main React component (3683 bytes)
│   │   └── index.js           # React entry point (209 bytes)
│   ├── package.json           # Node.js dependencies for Vite (426 bytes)
│   ├── vite.config.js         # Vite configuration (210 bytes)
│   ├── index.html             # HTML template for Vite (500 bytes)
│   └── standalone.html        # No-build-tools version (8370 bytes)
```

## Key Features
- User profile input (income, age, state, family size, caste, disability, occupation)
- Backend eligibility matching engine with JSON rules
- Frontend form with validation and error handling
- Sample database with 5 government schemes
- CORS enabled for local development
- Multiple deployment options

## Technology Stack
- **Backend**: FastAPI, Python, Pydantic, Uvicorn
- **Frontend**: React, Vite (or standalone HTML/CSS/JS)
- **Database**: JSON file (for MVP)
- **Development**: Hot reload, modern tooling

## Running the Application

### Backend (Required)
```bash
cd backend
py -m pip install fastapi uvicorn pydantic
py -m uvicorn main:app --reload --port 8000
```
Backend available at: http://localhost:8000

### Frontend Options

#### Option 1: Standalone HTML (No build tools)
- Open `frontend/standalone.html` directly in browser
- Works immediately, no installation required

#### Option 2: Vite Development Server
```bash
cd frontend
npm install
npm run dev
```
Frontend available at: http://localhost:3000

#### Option 3: Python HTTP Server
```bash
cd frontend
py -m http.server 3000
```
Then open: http://localhost:3000/standalone.html

## Sample Test Data
- Income: 250000
- Age: 20
- State: State X
- Family Size: 1
- Caste: general
- Expected Result: 2 eligible schemes

## API Endpoints
- `POST /eligible` - Submit profile, get eligible schemes
- `GET /schemes` - List all available schemes

## Created: September 10, 2025
## Status: Fully functional MVP ready for testing and deployment
