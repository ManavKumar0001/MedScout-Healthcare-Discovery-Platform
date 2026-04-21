-- ============================================================
-- MedScout — Inventory Table
-- Version: 1.0
-- Description: Per-shop stock of medicines with price & expiry
-- ============================================================

USE medscout;

CREATE TABLE IF NOT EXISTS inventory (
    id              BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    shop_id         BIGINT UNSIGNED NOT NULL,
    medicine_id     BIGINT UNSIGNED NOT NULL,
    quantity        INT UNSIGNED    NOT NULL DEFAULT 0,
    price           DECIMAL(10, 2)  NOT NULL           COMMENT 'MRP in INR',
    discount_pct    DECIMAL(5, 2)   NULL DEFAULT 0.00  COMMENT 'Discount percentage offered',
    batch_number    VARCHAR(50)     NULL,
    expiry_date     DATE            NOT NULL,
    last_updated    TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_inventory_shop     FOREIGN KEY (shop_id)     REFERENCES shops(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_inventory_medicine FOREIGN KEY (medicine_id)  REFERENCES medicines(id)
        ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT chk_quantity_non_negative CHECK (quantity >= 0),
    CONSTRAINT chk_price_positive        CHECK (price > 0),
    CONSTRAINT chk_discount_range        CHECK (discount_pct >= 0 AND discount_pct <= 100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
