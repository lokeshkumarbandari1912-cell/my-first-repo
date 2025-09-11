# Universal Subsidy & Benefit Finder - Fullstack MVP

This repository contains a minimal full-stack MVP for a Universal Subsidy & Benefit Finder that helps users discover government schemes and benefits they're eligible for based on their profile.

## Features

- **User Profile Input**: Users can enter their income, age, state, family size, caste, disability status, and occupation
- **Eligibility Matching**: Backend matches user profiles against scheme eligibility criteria
- **Results Display**: Frontend shows eligible schemes with descriptions and application links
- **Sample Database**: Includes 5 sample government schemes for testing

## Project Structure

```
subsidy-finder/
├── backend/
│   ├── main.py              # FastAPI backend server
│   ├── schemes.json         # Sample schemes database
│   └── requirements.txt     # Python dependencies
├── frontend/
│   ├── public/
│   │   └── index.html       # HTML template
│   ├── src/
│   │   ├── App.jsx          # Main React component
│   │   └── index.js         # React entry point
│   └── package.json         # Node.js dependencies
└── README.md
```

## How to Run

### Backend Setup

1. Navigate to the backend directory:
   ```bash
   cd backend
   ```

2. Create and activate a virtual environment:
   ```bash
   python -m venv venv
   # On Windows:
   venv\Scripts\activate
   # On macOS/Linux:
   source venv/bin/activate
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Start the FastAPI server:
   ```bash
   uvicorn main:app --reload --port 8000
   ```

The backend will be available at `http://localhost:8000`

### Frontend Setup

1. Navigate to the frontend directory:
   ```bash
   cd frontend
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Start the Vite development server:
   ```bash
   npm run dev
   ```

The frontend will be available at `http://localhost:3000`

## Usage

1. Open `http://localhost:3000` in your browser
2. Fill in your profile details:
   - Annual Income (required)
   - Age (required)
   - State (required)
   - Family Size (optional, defaults to 1)
   - Caste (optional)
   - Occupation (optional)
   - Disability status (checkbox)
3. Click "Find Schemes" to see eligible government schemes
4. Click on "Apply / More info" links to learn more about each scheme

## Sample Schemes

The application includes 5 sample schemes:

1. **Central Scholarship for Higher Education** - For students aged 17-30 with income ≤ ₹3,00,000
2. **Old Age Pension** - For seniors aged 60+ with income ≤ ₹2,00,000
3. **Small Farmer Input Subsidy** - For farmers with income ≤ ₹4,00,000
4. **Disability Assistance** - For people with certified disabilities
5. **State Girls Scholarship** - For girls aged 14-25 in State X with income ≤ ₹2,50,000

## API Endpoints

- `POST /eligible` - Submit user profile and get eligible schemes
- `GET /schemes` - List all available schemes

## Next Steps & Improvements

- Add authentication for user profiles and notifications
- Implement real government scheme data scraping
- Add multi-language support
- Enhance eligibility rules engine with complex boolean logic
- Add document upload verification
- Implement analytics and logging
- Add Dockerfiles for easy deployment
- Create mobile-responsive design

## Technology Stack

- **Backend**: FastAPI, Python, Pydantic
- **Frontend**: React, JavaScript
- **Database**: JSON file (for MVP)
- **CORS**: Enabled for local development

## Contributing

This is an MVP demonstration. For production use, always verify eligibility criteria on official government portals.
