-- ============================================================
-- MedScout — Migration V4: Add last_updated trigger
-- Description: Auto-updates inventory.last_updated on any change
-- ============================================================
USE medscout;

DELIMITER $$

DROP TRIGGER IF EXISTS trg_inventory_last_updated$$

CREATE TRIGGER trg_inventory_last_updated
    BEFORE UPDATE ON inventory
    FOR EACH ROW
BEGIN
    SET NEW.last_updated = CURRENT_TIMESTAMP;
END$$

DELIMITER ;
