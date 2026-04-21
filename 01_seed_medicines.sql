-- ============================================================
-- MedScout — Seed Medicines
-- Description: Sample medicines (brand + generic) for dev
-- ============================================================
USE medscout;

INSERT INTO medicines (brand_name, generic_name, manufacturer, form, strength, pack_size, prescription_required) VALUES
('Crocin Advance','Paracetamol','GlaxoSmithKline','tablet','500mg','Strip of 15',0),
('Dolo 650','Paracetamol','Micro Labs','tablet','650mg','Strip of 15',0),
('Calpol','Paracetamol','GlaxoSmithKline','syrup','250mg/5ml','Bottle of 60ml',0),
('Combiflam','Ibuprofen + Paracetamol','Sanofi India','tablet','400mg+325mg','Strip of 20',0),
('Brufen','Ibuprofen','Abbott India','tablet','400mg','Strip of 15',0),
('Nise','Nimesulide','Dr. Reddys','tablet','100mg','Strip of 10',1),
('Voveran SR','Diclofenac Sodium','Novartis India','tablet','100mg','Strip of 15',1),
('Augmentin 625','Amoxicillin + Clavulanic Acid','GlaxoSmithKline','tablet','500mg+125mg','Strip of 10',1),
('Azithral 500','Azithromycin','Alembic Pharma','tablet','500mg','Strip of 3',1),
('Monocef','Ceftriaxone','Aristo Pharma','injection','1g','Vial',1),
('Ciprofloxacin','Ciprofloxacin','Cipla','tablet','500mg','Strip of 10',1),
('Metrogyl 400','Metronidazole','J.B. Chemicals','tablet','400mg','Strip of 15',1),
('Glycomet 500','Metformin','USV','tablet','500mg','Strip of 20',1),
('Amaryl M','Glimepiride + Metformin','Sanofi India','tablet','1mg+500mg','Strip of 15',1),
('Janumet','Sitagliptin + Metformin','MSD Pharma','tablet','50mg+500mg','Strip of 7',1),
('Ecosprin 75','Aspirin','USV','tablet','75mg','Strip of 14',0),
('Atorva 10','Atorvastatin','Zydus Cadila','tablet','10mg','Strip of 15',1),
('Telmisartan 40','Telmisartan','Glenmark','tablet','40mg','Strip of 15',1),
('Amlodipine 5','Amlodipine','Cipla','tablet','5mg','Strip of 15',1),
('Metoprolol','Metoprolol Succinate','AstraZeneca','tablet','50mg','Strip of 10',1),
('Pan 40','Pantoprazole','Alkem Laboratories','tablet','40mg','Strip of 15',0),
('Omez','Omeprazole','Dr. Reddys','capsule','20mg','Strip of 15',0),
('Montair LC','Montelukast + Levocetirizine','Cipla','tablet','10mg+5mg','Strip of 15',1),
('Allegra 120','Fexofenadine','Sanofi India','tablet','120mg','Strip of 10',0),
('Cetirizine','Cetirizine','Cipla','tablet','10mg','Strip of 10',0),
('Asthalin','Salbutamol','Cipla','inhaler','100mcg','200 doses',1),
('Foracort','Budesonide + Formoterol','Cipla','inhaler','200mcg+6mcg','120 doses',1),
('Betadine','Povidone Iodine','Win-Medicare','ointment','5%','Tube of 15g',0),
('Candid B','Clotrimazole + Beclomethasone','Glenmark','cream','1%+0.025%','Tube of 15g',1),
('Becosules','B-Complex + Vitamin C','Pfizer','capsule','Multi','Strip of 20',0),
('Shelcal 500','Calcium + Vitamin D3','Torrent Pharma','tablet','500mg+250IU','Strip of 15',0),
('Supradyn','Multivitamin + Multimineral','Bayer','tablet','Multi','Strip of 15',0),
('Limcee','Ascorbic Acid','Abbott India','tablet','500mg','Strip of 15',0),
('Neurobion Forte','Vitamin B1+B6+B12','Procter & Gamble','tablet','10mg+3mg+15mcg','Strip of 30',0),
('Thyronorm 50','Levothyroxine','Abbott India','tablet','50mcg','Strip of 100',1),
('Thyronorm 100','Levothyroxine','Abbott India','tablet','100mcg','Strip of 100',1),
('Escitalopram','Escitalopram','Sun Pharma','tablet','10mg','Strip of 10',1),
('Fluconazole','Fluconazole','Cipla','capsule','150mg','Strip of 1',1),
('Volini Spray','Diclofenac Diethylamine','Sun Pharma','spray','4%','Bottle of 40g',0),
('Emeset','Ondansetron','Cipla','tablet','4mg','Strip of 10',1),
('Pregabalin','Pregabalin','Torrent Pharma','capsule','75mg','Strip of 10',1),
('Gabapentin','Gabapentin','Sun Pharma','capsule','300mg','Strip of 10',1),
('Losartan 50','Losartan','Cipla','tablet','50mg','Strip of 10',1),
('Ramipril','Ramipril','Sanofi India','capsule','5mg','Strip of 10',1),
('Tamsulosin','Tamsulosin','Cipla','capsule','0.4mg','Strip of 10',1);

-- NOTE: Production dataset contains 5000+ rows.
-- Import via: LOAD DATA INFILE 'medicines_full.csv' INTO TABLE medicines ...
