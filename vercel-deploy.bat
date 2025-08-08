@echo off
echo ================================================================
echo Prime Trade API - Vercel Deployment
echo ================================================================
echo.
echo ✅ GitHub Repository: https://github.com/haadidevx-eng/primetrade-api
echo ✅ All files have been pushed successfully!
echo.
echo NEXT STEPS - Deploy to Vercel:
echo.
echo 1. Open https://vercel.com/new in your browser
echo 2. Sign in with GitHub (if not already signed in)
echo 3. Click "Import" next to your repository: haadidevx-eng/primetrade-api
echo 4. In the deployment settings:
echo    - Project Name: primetrade-api
echo    - Framework Preset: Other
echo    - Root Directory: ./
echo    - Build Command: npm run build
echo    - Output Directory: (leave empty)
echo    - Install Command: npm install
echo.
echo 5. Add Environment Variables (IMPORTANT!):
echo    Click "Environment Variables" section and add:
echo    - NODE_ENV = production
echo    - DB_HOST = (your PlanetScale host URL)
echo    - DB_USER = (your PlanetScale username)
echo    - DB_PASSWORD = (your PlanetScale password)
echo    - DB_NAME = primetrade_app
echo    - JWT_SECRET = primetrade-secret-key-2025
echo.
echo 6. Click "Deploy"
echo.
echo 🔗 Opening Vercel deployment page...
start https://vercel.com/new
echo.
echo ================================================================
echo After deployment, your API will be available at:
echo https://primetrade-api.vercel.app/api/health
echo ================================================================
pause
