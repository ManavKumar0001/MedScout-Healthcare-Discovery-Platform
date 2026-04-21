-- ============================================================
-- MedScout — Stored Procedure: Nearby Shops (Haversine)
-- Description: Finds shops within a given radius (km) from
--              a lat/lng point, sorted by distance
-- ============================================================
USE medscout;

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_nearby_shops_haversine$$

CREATE PROCEDURE sp_nearby_shops_haversine(
    IN p_lat        DECIMAL(10, 8),
    IN p_lng        DECIMAL(11, 8),
    IN p_radius_km  DECIMAL(5, 2),
    IN p_limit      INT
)
BEGIN
    -- Default radius: 5 km
    IF p_radius_km IS NULL OR p_radius_km <= 0 THEN
        SET p_radius_km = 5.00;
    END IF;

    IF p_limit IS NULL OR p_limit <= 0 THEN
        SET p_limit = 50;
    END IF;

    SELECT
        s.id,
        s.name,
        s.address,
        s.pincode,
        s.city,
        s.phone,
        s.timings,
        s.lat,
        s.lng,
        -- Haversine formula (Earth radius = 6371 km)
        ROUND(
            6371 * ACOS(
                LEAST(1, -- clamp to avoid NaN from floating point
                    COS(RADIANS(p_lat)) * COS(RADIANS(s.lat))
                    * COS(RADIANS(s.lng) - RADIANS(p_lng))
                    + SIN(RADIANS(p_lat)) * SIN(RADIANS(s.lat))
                )
            ), 2
        ) AS distance_km
    FROM
        shops s
    WHERE
        s.is_approved = 1
        AND s.is_active = 1
        AND s.lat IS NOT NULL
        AND s.lng IS NOT NULL
        -- Bounding box pre-filter for performance
        AND s.lat BETWEEN (p_lat - (p_radius_km / 111.0))
                       AND (p_lat + (p_radius_km / 111.0))
        AND s.lng BETWEEN (p_lng - (p_radius_km / (111.0 * COS(RADIANS(p_lat)))))
                       AND (p_lng + (p_radius_km / (111.0 * COS(RADIANS(p_lat)))))
    HAVING
        distance_km <= p_radius_km
    ORDER BY
        distance_km ASC
    LIMIT p_limit;
END$$

DELIMITER ;

-- Usage:
-- Find shops within 3 km of Connaught Place, Delhi
-- CALL sp_nearby_shops_haversine(28.6328, 77.2197, 3.00, 20);
--
-- Find shops within 5 km of Noida Sector 18
-- CALL sp_nearby_shops_haversine(28.5687, 77.3210, 5.00, 50);
