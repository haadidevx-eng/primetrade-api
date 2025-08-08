@echo off
echo ========================================
echo Prime Trade - Deployment Preparation
echo ========================================
echo.

echo Your backend is ready for deployment to Railway.app!
echo.
echo Files prepared for deployment:
echo ✅ server.js - Main API server
echo ✅ package.json - Dependencies
echo ✅ railway.json - Railway configuration
echo ✅ .env.example - Environment template
echo ✅ schema.sql - Database structure
echo.

echo Next Steps:
echo.
echo 1. Go to GitHub.com and create account (if needed)
echo 2. Create new repository: primetrade-api
echo 3. Upload all files from this backend folder
echo 4. Go to railway.app and deploy from GitHub
echo 5. Add MySQL database service
echo 6. Configure environment variables
echo 7. Import database schema
echo.

echo ========================================
echo IMPORTANT LINKS:
echo ========================================
echo GitHub: https://github.com
echo Railway: https://railway.app
echo Documentation: See RAILWAY_DEPLOYMENT.md
echo.

echo Current backend folder contains:
dir /b

echo.
echo Ready to deploy! Follow the steps in RAILWAY_DEPLOYMENT.md
echo.
pause
