-- ============================================================
-- MedScout — Migration V2: Add lat/lng to shops
-- Description: Adds latitude and longitude columns for geo-search
-- ============================================================
USE medscout;

-- Idempotent: only add if columns don't exist
-- Note: In production, Flyway tracks applied migrations automatically.

ALTER TABLE shops
    ADD COLUMN IF NOT EXISTS lat DECIMAL(10, 8) NULL COMMENT 'Latitude for geo-search' AFTER state,
    ADD COLUMN IF NOT EXISTS lng DECIMAL(11, 8) NULL COMMENT 'Longitude for geo-search' AFTER lat;

-- Add spatial index for proximity queries
CREATE INDEX IF NOT EXISTS idx_shops_lat_lng ON shops(lat, lng);
