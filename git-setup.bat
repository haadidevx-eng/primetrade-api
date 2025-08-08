@echo off
cd /d C:\Users\AbdulRehman\PrimeTrade-App\backend

echo Setting up git configuration...
git config user.email "primetrade@example.com"
git config user.name "PrimeTrade"

echo Committing files...
git commit -m "Initial commit"

echo Setting up main branch...
git branch -M main

echo Creating GitHub repository...
echo Please create a new repository on GitHub: https://github.com/new
echo Repository name: primetrade-api
echo Make it public
echo Do not initialize with README, .gitignore, or license

echo.
echo After creating the repository, copy the URL and press any key...
pause

echo.
set /p REPO_URL="Enter your GitHub repository URL (https://github.com/yourusername/primetrade-api.git): "

echo Adding remote origin...
git remote add origin %REPO_URL%

echo Pushing to GitHub...
git push -u origin main

echo.
echo ================================================================
echo GitHub repository created and pushed successfully!
echo.
echo Next step: Deploy to Vercel
echo 1. Go to https://vercel.com/new
echo 2. Import your GitHub repository: %REPO_URL%
echo 3. Add environment variables (see VERCEL_DEPLOYMENT.md)
echo 4. Deploy!
echo ================================================================
pause
