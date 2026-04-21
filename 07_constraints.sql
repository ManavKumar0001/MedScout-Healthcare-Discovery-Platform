-- ============================================================
-- MedScout — Additional Constraints
-- Version: 1.0
-- Description: Extra FKs, unique constraints, and check constraints
--              (beyond what's defined inline in table DDLs)
-- ============================================================

USE medscout;

-- -------------------------
-- Unique: one inventory row per shop + medicine + batch
-- Prevents duplicate entries for the same medicine in the same shop
-- -------------------------
ALTER TABLE inventory
    ADD CONSTRAINT uq_inventory_shop_medicine_batch
    UNIQUE (shop_id, medicine_id, batch_number);

-- -------------------------
-- Check: expiry_date must be a valid future or present date at insertion
-- Note: MySQL 8.0.16+ supports CHECK constraints
-- -------------------------
ALTER TABLE inventory
    ADD CONSTRAINT chk_expiry_not_past
    CHECK (expiry_date >= '2020-01-01');

-- -------------------------
-- Check: shop pincode format (Indian 6-digit pincode)
-- -------------------------
ALTER TABLE shops
    ADD CONSTRAINT chk_pincode_format
    CHECK (pincode REGEXP '^[1-9][0-9]{5}$');

-- -------------------------
-- Check: valid latitude range
-- -------------------------
ALTER TABLE shops
    ADD CONSTRAINT chk_lat_range
    CHECK (lat IS NULL OR (lat >= -90 AND lat <= 90));

-- -------------------------
-- Check: valid longitude range
-- -------------------------
ALTER TABLE shops
    ADD CONSTRAINT chk_lng_range
    CHECK (lng IS NULL OR (lng >= -180 AND lng <= 180));

-- -------------------------
-- Check: phone number basic validation
-- -------------------------
ALTER TABLE shops
    ADD CONSTRAINT chk_shop_phone_format
    CHECK (phone REGEXP '^[+]?[0-9]{10,15}$');

ALTER TABLE users
    ADD CONSTRAINT chk_user_phone_format
    CHECK (phone IS NULL OR phone REGEXP '^[+]?[0-9]{10,15}$');

-- -------------------------
-- Check: email format basic validation
-- -------------------------
ALTER TABLE users
    ADD CONSTRAINT chk_email_format
    CHECK (email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$');
