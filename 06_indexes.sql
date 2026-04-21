-- ============================================================
-- MedScout — Indexes
-- Version: 1.0
-- Description: Performance indexes for search & lookup queries
-- ============================================================

USE medscout;

-- -------------------------
-- Users
-- -------------------------
-- email uniqueness is enforced via UNIQUE constraint in 02_users.sql
CREATE INDEX idx_users_role        ON users(role);
CREATE INDEX idx_users_created_at  ON users(created_at);

-- -------------------------
-- Shops
-- -------------------------
CREATE INDEX idx_shops_pincode     ON shops(pincode);
CREATE INDEX idx_shops_owner_id    ON shops(owner_id);
CREATE INDEX idx_shops_is_approved ON shops(is_approved);
CREATE INDEX idx_shops_lat_lng     ON shops(lat, lng);
CREATE INDEX idx_shops_city        ON shops(city);

-- -------------------------
-- Medicines
-- -------------------------
CREATE INDEX idx_medicines_brand_name   ON medicines(brand_name);
CREATE INDEX idx_medicines_generic_name ON medicines(generic_name);
CREATE INDEX idx_medicines_manufacturer ON medicines(manufacturer);
CREATE FULLTEXT INDEX ft_medicines_search
    ON medicines(brand_name, generic_name);

-- -------------------------
-- Inventory
-- -------------------------
CREATE INDEX idx_inventory_shop_id       ON inventory(shop_id);
CREATE INDEX idx_inventory_medicine_id   ON inventory(medicine_id);
CREATE INDEX idx_inventory_expiry_date   ON inventory(expiry_date);
CREATE INDEX idx_inventory_last_updated  ON inventory(last_updated);

-- Composite index: primary search path — find medicine stock by pincode
-- This supports the JOIN: inventory → shops (on shop_id) filtered by pincode + medicine_id
CREATE INDEX idx_inventory_medicine_shop ON inventory(medicine_id, shop_id);
