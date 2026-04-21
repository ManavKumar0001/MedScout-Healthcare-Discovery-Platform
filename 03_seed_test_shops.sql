-- ============================================================
-- MedScout — Seed Test Shops
-- Description: Sample shops across 4 pincodes in Delhi NCR
-- ============================================================
USE medscout;

INSERT INTO shops (owner_id, name, address, pincode, city, state, lat, lng, phone, timings, license_number, is_approved, is_active) VALUES
-- Owner 2: Rajesh Kumar
(2, 'Rajesh Medical Store', '12, Main Market, Lajpat Nagar', '110024', 'New Delhi', 'Delhi', 28.56891000, 77.24370000, '+919876543210', 'Mon-Sat 8AM-10PM, Sun 9AM-2PM', 'DL-20B-123456', 1, 1),
(2, 'Rajesh Pharma Hub', '45, Defence Colony Market', '110024', 'New Delhi', 'Delhi', 28.57230000, 77.23180000, '+919876543210', 'Mon-Sun 9AM-9PM', 'DL-20B-123457', 1, 1),

-- Owner 3: Priya Sharma
(3, 'Priya Health Pharmacy', 'Shop 7, Sector 18 Market', '201301', 'Noida', 'Uttar Pradesh', 28.56870000, 77.32100000, '+919876543211', 'Mon-Sat 8AM-11PM', 'UP-20A-654321', 1, 1),

-- Owner 4: Amit Patel
(4, 'Apollo Pharmacy - MG Road', '23, MG Road, Near Metro Station', '122001', 'Gurugram', 'Haryana', 28.45910000, 77.02690000, '+919876543212', 'Mon-Sun 8AM-11PM', 'HR-11A-111222', 1, 1),
(4, 'LifeCare Medicals', 'B-12, DLF Phase 3', '122010', 'Gurugram', 'Haryana', 28.49420000, 77.09360000, '+919876543212', 'Mon-Sat 9AM-10PM', 'HR-11A-111223', 1, 1),

-- Owner 5: Sunita Verma (not email verified)
(5, 'Sunita Medical Agency', '89, Civil Lines', '201301', 'Noida', 'Uttar Pradesh', 28.57520000, 77.35400000, '+919876543213', 'Mon-Sat 9AM-9PM', 'UP-20A-789012', 0, 1),

-- Owner 6: Deepak Singh
(6, 'MedPlus - Connaught Place', 'A-Block, Connaught Place', '110001', 'New Delhi', 'Delhi', 28.63280000, 77.21970000, '+919876543214', 'Mon-Sun 7AM-11PM', 'DL-20B-333444', 1, 1),
(6, 'Jan Aushadhi Kendra - Karol Bagh', '15, Ajmal Khan Road', '110005', 'New Delhi', 'Delhi', 28.65180000, 77.19230000, '+919876543214', 'Mon-Sat 9AM-8PM', 'DL-20B-333445', 1, 1);
