#!/bin/bash
# ============================================================
# MedScout — Reset Database Script
# Description: Drops and recreates the database for a clean dev state
# Usage: chmod +x reset_db.sh && ./reset_db.sh
# WARNING: This will DELETE all data!
# ============================================================

set -euo pipefail

DB_USER="${MYSQL_USER:-root}"
DB_PASS="${MYSQL_PASSWORD:-}"
DB_HOST="${MYSQL_HOST:-localhost}"
DB_PORT="${MYSQL_PORT:-3306}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mysql_cmd() {
    if [ -n "$DB_PASS" ]; then
        mysql -u "$DB_USER" -p"$DB_PASS" -h "$DB_HOST" -P "$DB_PORT" "$@"
    else
        mysql -u "$DB_USER" -h "$DB_HOST" -P "$DB_PORT" "$@"
    fi
}

echo ""
echo "⚠️  WARNING: This will DROP the entire 'medscout' database!"
echo ""
read -p "Are you sure? (y/N): " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Aborted."
    exit 0
fi

echo ""
echo "[1/2] Dropping database 'medscout'..."
mysql_cmd -e "DROP DATABASE IF EXISTS medscout;"
echo "  ✓ Database dropped"

echo "[2/2] Recreating from scratch..."
"$SCRIPT_DIR/setup_local_db.sh"

echo ""
echo "✅ Database reset complete!"
