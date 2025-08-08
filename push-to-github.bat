@echo off
cd C:\Users\AbdulRehman\PrimeTrade-App\backend

echo Committing files...
git commit -m "Initial_commit"

echo Setting up main branch...
git branch -M main

echo Adding remote origin...
git remote add origin https://github.com/haadidevx-eng/primetrade-api.git

echo Pushing to GitHub...
git push -u origin main

echo.
echo Done! Repository pushed to GitHub.
pause
