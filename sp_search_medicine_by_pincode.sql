-- ============================================================
-- MedScout — Stored Procedure: Search Medicine by Pincode
-- Description: Finds all shops in a given pincode that stock
--              a medicine matching the search term
-- ============================================================
USE medscout;

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_search_medicine_by_pincode$$

CREATE PROCEDURE sp_search_medicine_by_pincode(
    IN p_search_term  VARCHAR(255),
    IN p_pincode      VARCHAR(10),
    IN p_limit        INT,
    IN p_offset       INT
)
BEGIN
    -- Default limit
    IF p_limit IS NULL OR p_limit <= 0 THEN
        SET p_limit = 20;
    END IF;

    IF p_offset IS NULL OR p_offset < 0 THEN
        SET p_offset = 0;
    END IF;

    SELECT
        m.id            AS medicine_id,
        m.brand_name,
        m.generic_name,
        m.manufacturer,
        m.form,
        m.strength,
        s.id            AS shop_id,
        s.name          AS shop_name,
        s.address       AS shop_address,
        s.phone         AS shop_phone,
        s.timings       AS shop_timings,
        s.lat,
        s.lng,
        i.quantity       AS stock_quantity,
        i.price,
        i.discount_pct,
        ROUND(i.price * (1 - i.discount_pct / 100), 2) AS effective_price,
        i.expiry_date,
        i.last_updated   AS stock_last_updated
    FROM
        medicines m
        INNER JOIN inventory i ON m.id = i.medicine_id
        INNER JOIN shops s     ON i.shop_id = s.id
    WHERE
        s.pincode = p_pincode
        AND s.is_approved = 1
        AND s.is_active = 1
        AND i.quantity > 0
        AND i.expiry_date > CURDATE()
        AND (
            m.brand_name   LIKE CONCAT('%', p_search_term, '%')
            OR m.generic_name LIKE CONCAT('%', p_search_term, '%')
        )
    ORDER BY
        i.price ASC,
        i.quantity DESC
    LIMIT p_limit OFFSET p_offset;
END$$

DELIMITER ;

-- Usage:
-- CALL sp_search_medicine_by_pincode('Paracetamol', '110024', 20, 0);
-- CALL sp_search_medicine_by_pincode('Dolo', '201301', 10, 0);
