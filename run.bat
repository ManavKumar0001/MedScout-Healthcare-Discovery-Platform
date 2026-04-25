@echo off
setlocal enabledelayedexpansion

cd /d "%~dp0"

:: Configuration
set DRIVER_VERSION=8.0.33
set DRIVER_JAR=mysql-connector-j-%DRIVER_VERSION%.jar
set DRIVER_URL=https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/%DRIVER_VERSION%/%DRIVER_JAR%

echo ========================================
echo   MedScout Backend Runner (Windows)
echo ========================================

:: 1. Check for JDBC Driver
if not exist "%DRIVER_JAR%" (
    echo [INFO] MySQL JDBC Driver not found. Downloading...
    curl -L -O %DRIVER_URL%
    if !errorlevel! neq 0 (
        echo [ERROR] Failed to download JDBC driver. Please check your internet connection.
        pause
        exit /b 1
    )
)

:: 2. Compile
echo [INFO] Compiling MedScoutBackend.java...
javac MedScoutBackend.java
if !errorlevel! neq 0 (
    echo [ERROR] Compilation failed.
    pause
    exit /b 1
)

:: 3. Run
echo [INFO] Starting Backend Server...
echo [INFO] Press Ctrl+C to stop.
java -cp ".;%DRIVER_JAR%" MedScoutBackend

endlocal
pause
