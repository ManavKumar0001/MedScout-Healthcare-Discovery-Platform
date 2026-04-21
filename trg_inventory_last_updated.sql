-- ============================================================
-- MedScout — Trigger: Auto-update inventory.last_updated
-- Description: Sets last_updated = NOW() on every inventory row update
-- ============================================================
USE medscout;

DELIMITER $$

DROP TRIGGER IF EXISTS trg_inventory_last_updated$$

CREATE TRIGGER trg_inventory_last_updated
    BEFORE UPDATE ON inventory
    FOR EACH ROW
BEGIN
    -- Always refresh the last_updated timestamp on any change
    SET NEW.last_updated = CURRENT_TIMESTAMP;
END$$

DELIMITER ;
