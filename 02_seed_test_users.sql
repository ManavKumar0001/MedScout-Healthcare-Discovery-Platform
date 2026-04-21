-- ============================================================
-- MedScout — Seed Test Users
-- Description: Dummy customers + shop owners for development
-- ============================================================
USE medscout;

-- Passwords are bcrypt hashes of 'password123'
INSERT INTO users (email, password_hash, full_name, phone, role, is_active, email_verified) VALUES
-- Admins
('admin@medscout.in', '$2b$10$N9qo8uLOickgx2ZMRZoMye3Z6tY/6TpCBIaIZ9JDjDX8yR5mHRCe', 'MedScout Admin', '+919000000001', 'admin', 1, 1),

-- Shop Owners
('rajesh.pharmacy@gmail.com', '$2b$10$N9qo8uLOickgx2ZMRZoMye3Z6tY/6TpCBIaIZ9JDjDX8yR5mHRCe', 'Rajesh Kumar', '+919876543210', 'shop_owner', 1, 1),
('priya.medicals@gmail.com', '$2b$10$N9qo8uLOickgx2ZMRZoMye3Z6tY/6TpCBIaIZ9JDjDX8yR5mHRCe', 'Priya Sharma', '+919876543211', 'shop_owner', 1, 1),
('amit.pharma@gmail.com', '$2b$10$N9qo8uLOickgx2ZMRZoMye3Z6tY/6TpCBIaIZ9JDjDX8yR5mHRCe', 'Amit Patel', '+919876543212', 'shop_owner', 1, 1),
('sunita.medical@gmail.com', '$2b$10$N9qo8uLOickgx2ZMRZoMye3Z6tY/6TpCBIaIZ9JDjDX8yR5mHRCe', 'Sunita Verma', '+919876543213', 'shop_owner', 1, 0),
('deepak.chemist@gmail.com', '$2b$10$N9qo8uLOickgx2ZMRZoMye3Z6tY/6TpCBIaIZ9JDjDX8yR5mHRCe', 'Deepak Singh', '+919876543214', 'shop_owner', 1, 1),

-- Customers
('customer1@gmail.com', '$2b$10$N9qo8uLOickgx2ZMRZoMye3Z6tY/6TpCBIaIZ9JDjDX8yR5mHRCe', 'Ananya Gupta', '+919123456701', 'customer', 1, 1),
('customer2@gmail.com', '$2b$10$N9qo8uLOickgx2ZMRZoMye3Z6tY/6TpCBIaIZ9JDjDX8yR5mHRCe', 'Vikram Reddy', '+919123456702', 'customer', 1, 1),
('customer3@gmail.com', '$2b$10$N9qo8uLOickgx2ZMRZoMye3Z6tY/6TpCBIaIZ9JDjDX8yR5mHRCe', 'Meera Nair', '+919123456703', 'customer', 1, 0),
('customer4@gmail.com', '$2b$10$N9qo8uLOickgx2ZMRZoMye3Z6tY/6TpCBIaIZ9JDjDX8yR5mHRCe', 'Rohit Joshi', '+919123456704', 'customer', 1, 1),
('customer5@gmail.com', '$2b$10$N9qo8uLOickgx2ZMRZoMye3Z6tY/6TpCBIaIZ9JDjDX8yR5mHRCe', 'Kavita Desai', '+919123456705', 'customer', 0, 0);
