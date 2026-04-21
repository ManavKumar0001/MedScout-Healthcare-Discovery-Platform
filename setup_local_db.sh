#!/bin/bash
# ============================================================
# MedScout — Local DB Setup Script
# Description: One-shot script to create DB, run schema, and seed data
# Usage: chmod +x setup_local_db.sh && ./setup_local_db.sh
# ============================================================

set -euo pipefail

# ── Configuration ───────────────────────────────────────────
DB_USER="${MYSQL_USER:-root}"
DB_PASS="${MYSQL_PASSWORD:-}"
DB_HOST="${MYSQL_HOST:-localhost}"
DB_PORT="${MYSQL_PORT:-3306}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(dirname "$SCRIPT_DIR")"

# ── MySQL command helper ────────────────────────────────────
mysql_cmd() {
    if [ -n "$DB_PASS" ]; then
        mysql -u "$DB_USER" -p"$DB_PASS" -h "$DB_HOST" -P "$DB_PORT" "$@"
    else
        mysql -u "$DB_USER" -h "$DB_HOST" -P "$DB_PORT" "$@"
    fi
}

echo "============================================"
echo "  MedScout — Database Setup"
echo "============================================"
echo ""
echo "Host: $DB_HOST:$DB_PORT"
echo "User: $DB_USER"
echo ""

# ── Step 1: Create Database ─────────────────────────────────
echo "[1/5] Creating database..."
mysql_cmd < "$BASE_DIR/schema/01_create_database.sql"
echo "  ✓ Database 'medscout' created"

# ── Step 2: Create Tables ───────────────────────────────────
echo "[2/5] Creating tables..."
for f in 02_users.sql 03_shops.sql 04_medicines.sql 05_inventory.sql; do
    echo "  → Running $f"
    mysql_cmd medscout < "$BASE_DIR/schema/$f"
done
echo "  ✓ All tables created"

# ── Step 3: Create Indexes & Constraints ────────────────────
echo "[3/5] Creating indexes and constraints..."
mysql_cmd medscout < "$BASE_DIR/schema/06_indexes.sql"
mysql_cmd medscout < "$BASE_DIR/schema/07_constraints.sql"
echo "  ✓ Indexes and constraints applied"

# ── Step 4: Create Procedures, Triggers, Views ──────────────
echo "[4/5] Creating procedures, triggers, and views..."

for f in "$BASE_DIR"/procedures/*.sql; do
    [ -f "$f" ] && echo "  → $(basename "$f")" && mysql_cmd medscout < "$f"
done

for f in "$BASE_DIR"/triggers/*.sql; do
    [ -f "$f" ] && echo "  → $(basename "$f")" && mysql_cmd medscout < "$f"
done

for f in "$BASE_DIR"/views/*.sql; do
    [ -f "$f" ] && echo "  → $(basename "$f")" && mysql_cmd medscout < "$f"
done

echo "  ✓ Procedures, triggers, views created"

# ── Step 5: Seed Data ───────────────────────────────────────
echo "[5/5] Seeding data..."
for f in $(ls "$BASE_DIR"/seed/*.sql | sort); do
    echo "  → $(basename "$f")"
    mysql_cmd medscout < "$f"
done
echo "  ✓ Seed data loaded"

echo ""
echo "============================================"
echo "  ✅ MedScout database setup complete!"
echo "============================================"
echo ""
echo "Test it: mysql -u $DB_USER -p medscout -e 'SELECT COUNT(*) FROM medicines;'"
