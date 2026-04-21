-- ============================================================
-- MedScout — Medicines Master Table
-- Version: 1.0
-- Description: Centralised medicine catalogue (brand + generic)
-- ============================================================

USE medscout;

CREATE TABLE IF NOT EXISTS medicines (
    id              BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    brand_name      VARCHAR(255)    NOT NULL,
    generic_name    VARCHAR(255)    NOT NULL,
    manufacturer    VARCHAR(255)    NULL,
    form            ENUM('tablet', 'capsule', 'syrup', 'injection', 'cream',
                         'ointment', 'drops', 'inhaler', 'powder', 'gel',
                         'suspension', 'spray', 'patch', 'suppository', 'other')
                    NOT NULL DEFAULT 'tablet',
    strength        VARCHAR(50)     NULL       COMMENT 'e.g. 500mg, 10mg/5ml',
    pack_size       VARCHAR(50)     NULL       COMMENT 'e.g. strip of 10, bottle of 100ml',
    prescription_required TINYINT(1) NOT NULL DEFAULT 0,
    is_active       TINYINT(1)      NOT NULL DEFAULT 1,
    created_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
