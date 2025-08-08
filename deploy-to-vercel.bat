@echo off
echo ====================================================
echo Prime Trade API - Vercel Deployment Guide
echo ====================================================
echo.
echo Your backend is now ready for Vercel deployment!
echo.
echo FILES CREATED:
echo - vercel.json (Vercel configuration)
echo - index.js (Entry point for Vercel)
echo - Updated package.json with build scripts
echo.
echo DEPLOYMENT STEPS:
echo.
echo 1. Go to https://vercel.com/new
echo 2. Connect your GitHub account
echo 3. Import your repository
echo 4. Configure these Environment Variables:
echo    - NODE_ENV = production
echo    - DB_HOST = [Your PlanetScale host]
echo    - DB_USER = [Your PlanetScale username] 
echo    - DB_PASSWORD = [Your PlanetScale password]
echo    - DB_NAME = [Your database name]
echo    - JWT_SECRET = primetrade-secret-key-2025
echo.
echo 5. Deploy the project
echo.
echo CURRENT DIRECTORY: %CD%
echo.
echo All files are ready for deployment!
echo.
echo ====================================================
pause
