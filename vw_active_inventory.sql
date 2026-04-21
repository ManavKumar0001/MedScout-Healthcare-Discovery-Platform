-- ============================================================
-- MedScout — View: Active Inventory
-- Description: Filters out expired medicines and zero-quantity rows
--              Use this view for all customer-facing queries
-- ============================================================
USE medscout;

CREATE OR REPLACE VIEW vw_active_inventory AS
SELECT
    i.id              AS inventory_id,
    i.shop_id,
    s.name            AS shop_name,
    s.pincode,
    s.city,
    i.medicine_id,
    m.brand_name,
    m.generic_name,
    m.manufacturer,
    m.form,
    m.strength,
    i.quantity,
    i.price,
    i.discount_pct,
    ROUND(i.price * (1 - i.discount_pct / 100), 2) AS effective_price,
    i.batch_number,
    i.expiry_date,
    DATEDIFF(i.expiry_date, CURDATE()) AS days_until_expiry,
    i.last_updated
FROM
    inventory i
    INNER JOIN shops s     ON i.shop_id = s.id
    INNER JOIN medicines m ON i.medicine_id = m.id
WHERE
    i.quantity > 0
    AND i.expiry_date > CURDATE()
    AND s.is_approved = 1
    AND s.is_active = 1
    AND m.is_active = 1;
