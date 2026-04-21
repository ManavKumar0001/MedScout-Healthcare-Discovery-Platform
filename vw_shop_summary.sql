-- ============================================================
-- MedScout — View: Shop Summary
-- Description: Each shop with total medicine count & stock stats
-- ============================================================
USE medscout;

CREATE OR REPLACE VIEW vw_shop_summary AS
SELECT
    s.id              AS shop_id,
    s.name            AS shop_name,
    s.address,
    s.pincode,
    s.city,
    s.state,
    s.phone,
    s.timings,
    s.is_approved,
    s.is_active,
    u.full_name       AS owner_name,
    u.email           AS owner_email,
    COUNT(DISTINCT i.medicine_id)   AS total_medicines,
    SUM(i.quantity)                  AS total_stock_units,
    ROUND(AVG(i.price), 2)          AS avg_price,
    MIN(i.expiry_date)              AS earliest_expiry,
    MAX(i.last_updated)             AS last_stock_update
FROM
    shops s
    LEFT JOIN users u     ON s.owner_id = u.id
    LEFT JOIN inventory i ON s.id = i.shop_id
                          AND i.quantity > 0
                          AND i.expiry_date > CURDATE()
GROUP BY
    s.id, s.name, s.address, s.pincode, s.city, s.state,
    s.phone, s.timings, s.is_approved, s.is_active,
    u.full_name, u.email;
