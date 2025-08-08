@echo off
echo ========================================
echo Prime Trade Backend - Local Test
echo ========================================
echo.

echo Step 1: Installing backend dependencies...
npm install

if %errorlevel% neq 0 (
    echo Error: Failed to install dependencies
    echo.
    echo Try running this in Command Prompt instead of PowerShell:
    echo   1. Press Win + R
    echo   2. Type: cmd
    echo   3. Navigate to: cd C:\Users\AbdulRehman\PrimeTrade-App\backend
    echo   4. Run: npm install
    echo.
    pause
    exit /b 1
)

echo.
echo ========================================
echo Dependencies installed successfully!
echo ========================================
echo.

echo Step 2: Make sure XAMPP MySQL is running...
echo   - Open XAMPP Control Panel
echo   - Start MySQL service
echo   - Make sure port 3306 is available
echo.

echo Step 3: Testing database connection...
echo Starting Prime Trade API server...
echo.

npm start
