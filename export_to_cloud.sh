#!/bin/bash
# ============================================================
# MedScout — Export to Cloud Script
# Description: Dumps local DB and prepares for import to Railway/Aiven
# Usage: chmod +x export_to_cloud.sh && ./export_to_cloud.sh
# ============================================================

set -euo pipefail

DB_USER="${MYSQL_USER:-root}"
DB_PASS="${MYSQL_PASSWORD:-}"
DB_HOST="${MYSQL_HOST:-localhost}"
DB_PORT="${MYSQL_PORT:-3306}"
DB_NAME="medscout"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(dirname "$SCRIPT_DIR")"
BACKUP_DIR="$BASE_DIR/backup"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
DUMP_FILE="$BACKUP_DIR/dev_backup_${TIMESTAMP}.sql"

mkdir -p "$BACKUP_DIR"

echo "============================================"
echo "  MedScout — Database Export"
echo "============================================"
echo ""

# ── Dump local database ─────────────────────────────────────
echo "[1/3] Dumping local database..."
if [ -n "$DB_PASS" ]; then
    mysqldump -u "$DB_USER" -p"$DB_PASS" -h "$DB_HOST" -P "$DB_PORT" \
        --routines --triggers --single-transaction \
        "$DB_NAME" > "$DUMP_FILE"
else
    mysqldump -u "$DB_USER" -h "$DB_HOST" -P "$DB_PORT" \
        --routines --triggers --single-transaction \
        "$DB_NAME" > "$DUMP_FILE"
fi
echo "  ✓ Dump saved to: $DUMP_FILE"

# ── Compress ─────────────────────────────────────────────────
echo "[2/3] Compressing dump..."
gzip -k "$DUMP_FILE"
echo "  ✓ Compressed: ${DUMP_FILE}.gz"

# ── Cloud import instructions ────────────────────────────────
echo "[3/3] Cloud import instructions:"
echo ""
echo "  Railway:"
echo "    railway run mysql < $DUMP_FILE"
echo ""
echo "  Aiven:"
echo "    mysql -h <host> -P <port> -u <user> -p<pass> <dbname> < $DUMP_FILE"
echo ""
echo "  PlanetScale (schema only):"
echo "    pscale shell <db> <branch> < $DUMP_FILE"
echo ""
echo "============================================"
echo "  ✅ Export complete!"
echo "============================================"
