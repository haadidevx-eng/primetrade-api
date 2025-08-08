@echo off
echo ========================================
echo Prime Trade API Server
echo ========================================
echo.

echo Checking if XAMPP MySQL is running...
echo - Make sure XAMPP Control Panel shows MySQL as RUNNING
echo - If not, start MySQL service in XAMPP
echo.
pause

echo Starting Prime Trade API server...
echo.
echo Server will run at: http://localhost:3000
echo.
echo To test the API:
echo 1. Keep this window open (server is running)
echo 2. Open your browser
echo 3. Go to: http://localhost:3000/api/health
echo 4. Or use the test-api.html file
echo.
echo Press Ctrl+C to stop the server
echo.

node server.js
