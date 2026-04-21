-- ============================================================
-- MedScout — Shops Table
-- Version: 1.0
-- Description: Medical shops registered by shop owners
-- ============================================================

USE medscout;

CREATE TABLE IF NOT EXISTS shops (
    id              BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    owner_id        BIGINT UNSIGNED NOT NULL,
    name            VARCHAR(200)    NOT NULL,
    address         TEXT            NOT NULL,
    pincode         VARCHAR(10)     NOT NULL,
    city            VARCHAR(100)    NULL,
    state           VARCHAR(100)    NULL,
    lat             DECIMAL(10, 8)  NULL       COMMENT 'Latitude for geo-search',
    lng             DECIMAL(11, 8)  NULL       COMMENT 'Longitude for geo-search',
    phone           VARCHAR(15)     NOT NULL,
    timings         VARCHAR(100)    NULL       COMMENT 'e.g. Mon-Sat 9AM-9PM',
    license_number  VARCHAR(50)     NULL       COMMENT 'Drug license number',
    is_approved     TINYINT(1)      NOT NULL DEFAULT 0  COMMENT 'Admin approval flag',
    is_active       TINYINT(1)      NOT NULL DEFAULT 1,
    created_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_shops_owner FOREIGN KEY (owner_id) REFERENCES users(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
