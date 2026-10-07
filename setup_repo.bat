@echo off
setlocal
cd /d "%~dp0"

echo =========================================================
echo    Surface Duo 2 Custom Kernel - GitHub Repo Setup
echo =========================================================
echo.

where git >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Git is not found in PATH!
    pause
    exit /b 1
)

if not exist ".git" (
    echo [*] Initializing Git repository...
    git init
    git branch -M main
)

echo [*] Staging all files...
git add .
git commit -m "Initialize Duo 2 Kernel Builder with GitHub Actions"

echo.
set /p REPO_URL="Enter your GitHub Repository URL (e.g. https://github.com/Username/duo2-kernel-builder.git): "

if "%REPO_URL%"=="" (
    echo [!] No URL provided. You can run 'git remote add origin <URL>' later.
    pause
    exit /b 0
)

git remote remove origin >nul 2>nul
git remote add origin %REPO_URL%

echo.
echo [*] Pushing to GitHub main branch...
git push -u origin main

if %errorlevel% equ 0 (
    echo.
    echo =========================================================
    echo [SUCCESS] Code pushed to GitHub!
    echo Now open your repo in browser, go to Actions tab,
    echo and click "Run workflow" to compile your kernel!
    echo =========================================================
) else (
    echo.
    echo [!] Push failed or authentication needed. Please check your GitHub credentials or SSH key.
)

pause
