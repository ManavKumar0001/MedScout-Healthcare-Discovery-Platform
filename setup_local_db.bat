@echo off
echo [INFO] Setting up local MedScout database...

:: Note: This assumes mysql is in your PATH. 
:: If it asks for a password and you don't have one, just press Enter.

mysql -u root -p < ..\schema\01_create_database.sql
mysql -u root -p medscout < ..\schema\02_users.sql
mysql -u root -p medscout < ..\schema\03_shops.sql
mysql -u root -p medscout < ..\schema\04_medicines.sql
mysql -u root -p medscout < ..\schema\05_inventory.sql
mysql -u root -p medscout < ..\schema\06_indexes.sql
mysql -u root -p medscout < ..\schema\07_constraints.sql

echo [SUCCESS] Database setup complete.
pause
