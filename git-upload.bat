@echo off
echo ========================================
echo Uploading Prime Trade API to GitHub
echo ========================================
echo.

echo Initializing git repository...
git init

echo Adding files...
git add server.js
git add package.json
git add railway.json
git add schema.sql
git add .env.example
git add RAILWAY_DEPLOYMENT.md
git add TESTING_GUIDE.md

echo Committing files...
git commit -m "Prime Trade E-commerce API Backend - Initial Release"

echo Adding remote repository...
git remote add origin https://github.com/haadidevx-eng/primetrade-api.git

echo Setting branch name...
git branch -M main

echo Pushing to GitHub...
git push -u origin main

echo.
echo ========================================
echo Upload Complete!
echo ========================================
echo.
echo Your repository: https://github.com/haadidevx-eng/primetrade-api
echo.
pause
