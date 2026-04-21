-- ============================================================
-- MedScout — Migration V3: Add generic_name index
-- Description: Fulltext + B-tree index on generic_name for search
-- ============================================================
USE medscout;

-- B-tree index for exact/prefix lookups
CREATE INDEX IF NOT EXISTS idx_medicines_generic_name ON medicines(generic_name);

-- Fulltext index for natural-language search
CREATE FULLTEXT INDEX IF NOT EXISTS ft_medicines_search ON medicines(brand_name, generic_name);
