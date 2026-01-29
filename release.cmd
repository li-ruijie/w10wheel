@echo off
:: Trigger GitHub Actions release workflow
:: Usage: release.cmd <version>
:: Example: release.cmd 2.8

if "%~1"=="" (
    echo Usage: release.cmd ^<version^>
    echo Example: release.cmd 2.8
    exit /b 1
)

gh workflow run build.yml -f version=%~1
if errorlevel 1 (
    echo Failed to trigger workflow
    exit /b 1
)

echo Triggered release workflow for v%~1
gh run list --workflow=build.yml --limit=1
