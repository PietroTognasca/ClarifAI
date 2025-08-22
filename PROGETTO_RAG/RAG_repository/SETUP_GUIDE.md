# 🚀 ClarifAI Setup Instructions

## Quick Start Guide

### 1. Environment Setup

Create a `.env` file in the project root with your configuration:

```bash
# Required: Your Google Gemini API key
# Get it from: https://makersuite.google.com/app/apikey
GEMINI_API_KEY=your_actual_gemini_api_key_here

# Required: Path to your study PDF file
PDF_PATH=/path/to/your/study/document.pdf
```

### 2. Install Dependencies

**Backend:**
```bash
cd backend
pip install -r requirements.txt
```

**Frontend:**
```bash
cd frontend
npm install
```

### 3. Run the Application

**Terminal 1 - Backend:**
```bash
cd backend
python3 app.py
```
*Backend will run on http://127.0.0.1:5001*

**Terminal 2 - Frontend:**
```bash
cd frontend
npm start
```
*Frontend will run on http://localhost:3000*

### 4. Access the Application

Open your browser and navigate to: **http://localhost:3000**

## Application Features

✅ **PDF Processing**: Automatically processes and indexes your study materials  
✅ **Intelligent Q&A**: Ask questions about your documents and get contextual answers  
✅ **Image Analysis**: Analyze specific pages of your PDF documents  
✅ **Modern UI**: Clean, responsive interface with dark/light theme support  
✅ **Mathematical Formulas**: Supports rendering of mathematical equations  
✅ **RAG Technology**: Uses Retrieval-Augmented Generation for accurate responses  

## Health Check Status

✅ All dependencies installed and working  
✅ Backend Flask API running correctly  
✅ Frontend React application building successfully  
✅ Database (ChromaDB) integration functional  
✅ PDF processing pipeline operational  
✅ Environment configuration ready  

## Minor Issues to Address

⚠️ **ESLint Warnings**: Some unused variables in App.js (non-critical)  
⚠️ **Accessibility**: A few href attributes need valid values (minor)  

These warnings don't affect functionality but can be cleaned up for production.

## Architecture Overview

- **Backend**: Python Flask + Google Gemini API + ChromaDB
- **Frontend**: React + TypeScript + React Markdown + KaTeX
- **AI Integration**: Google Generative AI for embeddings and responses
- **Document Processing**: PyPDF2 + PyMuPDF for text extraction
- **Vector Database**: ChromaDB for semantic search

The application is working perfectly and ready for use!