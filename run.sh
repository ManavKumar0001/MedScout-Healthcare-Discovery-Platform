#!/bin/bash

# Configuration
DRIVER_VERSION="8.0.33"
DRIVER_JAR="mysql-connector-j-${DRIVER_VERSION}.jar"
DRIVER_URL="https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/${DRIVER_VERSION}/${DRIVER_JAR}"

echo "========================================"
echo "  MedScout Backend Runner (Linux/macOS)"
echo "========================================"

# 1. Check for JDBC Driver
if [ ! -f "$DRIVER_JAR" ]; then
    echo "[INFO] MySQL JDBC Driver not found. Downloading..."
    curl -L -O "$DRIVER_URL"
    if [ $? -ne 0 ]; then
        echo "[ERROR] Failed to download JDBC driver."
        exit 1
    fi
fi

# 2. Compile
echo "[INFO] Compiling MedScoutBackend.java..."
javac MedScoutBackend.java
if [ $? -ne 0 ]; then
    echo "[ERROR] Compilation failed."
    exit 1
fi

# 3. Run
echo "[INFO] Starting Backend Server..."
echo "[INFO] Press Ctrl+C to stop."
java -cp ".:${DRIVER_JAR}" MedScoutBackend
