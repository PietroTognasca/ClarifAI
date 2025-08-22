#!/bin/bash

# ClarifAI Application Startup Script
# This script starts both backend and frontend servers

echo "🚀 Starting ClarifAI Application..."
echo "=================================="

# Check if we're in the right directory
if [ ! -d "backend" ] || [ ! -d "frontend" ]; then
    echo "❌ Error: Please run this script from the RAG_repository directory"
    echo "   Expected structure: RAG_repository/backend and RAG_repository/frontend"
    exit 1
fi

# Check environment file
if [ ! -f ".env" ]; then
    echo "⚠️  Warning: .env file not found"
    echo "   Please create .env with your GEMINI_API_KEY and PDF_PATH"
    echo "   See SETUP_GUIDE.md for instructions"
    exit 1
fi

# Check if Gemini API key is set (not just placeholder)
if grep -q "your_gemini_api_key_here" .env || grep -q "your_actual_gemini_api_key_here" .env; then
    echo "⚠️  Warning: Please set your actual Gemini API key in .env file"
    echo "   Get your API key from: https://makersuite.google.com/app/apikey"
    exit 1
fi

# Source environment variables
set -a
source .env
set +a

# Check PDF file exists
if [ ! -f "$PDF_PATH" ]; then
    echo "⚠️  Warning: PDF file not found at: $PDF_PATH"
    echo "   Please update PDF_PATH in .env to point to your study document"
    exit 1
fi

echo "✅ Configuration verified"
echo "✅ PDF file found: $PDF_PATH"

# Start backend
echo -e "\n🔧 Starting Backend Server..."
cd backend
python3 app.py &
BACKEND_PID=$!
cd ..

# Wait for backend to start
echo "⏳ Waiting for backend to initialize..."
sleep 3

# Check if backend is running
if curl -s "http://127.0.0.1:5001/api/books" > /dev/null; then
    echo "✅ Backend started successfully on http://127.0.0.1:5001"
else
    echo "❌ Backend failed to start"
    kill $BACKEND_PID 2>/dev/null
    exit 1
fi

# Start frontend
echo -e "\n🎨 Starting Frontend Server..."
cd frontend
npm start &
FRONTEND_PID=$!
cd ..

echo -e "\n🌐 Application Starting..."
echo "   Backend:  http://127.0.0.1:5001"
echo "   Frontend: http://localhost:3000"
echo -e "\n📖 Open your browser and go to: http://localhost:3000"

# Function to cleanup on exit
cleanup() {
    echo -e "\n🔥 Shutting down servers..."
    kill $BACKEND_PID $FRONTEND_PID 2>/dev/null
    wait $BACKEND_PID $FRONTEND_PID 2>/dev/null
    echo "✅ Cleanup complete"
}

# Set trap for cleanup
trap cleanup EXIT INT TERM

# Wait for user to press Ctrl+C
echo -e "\n💡 Press Ctrl+C to stop all servers"
wait