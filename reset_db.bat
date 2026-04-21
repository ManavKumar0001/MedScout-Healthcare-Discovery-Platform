@echo off
echo [WARNING] This will DROP the entire 'medscout' database and recreate it.
set /p confirm="Are you sure you want to proceed? (y/n): "

if /i "%confirm%" neq "y" (
    echo [INFO] Operation cancelled.
    pause
    exit /b
)

echo [INFO] Dropping database...
mysql -u root -p -e "DROP DATABASE IF EXISTS medscout;"

echo [INFO] Recreating database...
call setup_local_db.bat
