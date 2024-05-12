CREATE SCHEMA pharmacy_management_system ;
drop database pharmacy_management_system;
-- Final Normalized Tables:
-- 1.	Staff: StaffID (PK), SName, job, Salary, Commission, Hiredate, Phone
-- 2.	StaffAddress: StaffID (FK - references Staff.StaffID), Address, Birthday (PK)
-- 3.	Category: CategoryID (PK), CategoryName, Description, NO_OF_ITEMS
-- 4.	Customer: customerID (PK), Cname, Cphone
-- 5.	Supplier: supplierID (PK), CompanyName, supplierName, company_address, phone
-- 6.	Product: ProductID (PK), ProductName, SupplierID (FK), CategoryID (FK), Quantity , UnitPrice (>0)
-- 7.	Transaction: TransactionID (PK), CustomerID (FK), StaffID (FK), TransactionDate , total_amount
-- 8.	TransactionDetails: (TransactionID (FK), ProductID (FK)) (PK), UnitPrice (>=0), Quantity (>0), Discount (>=0 AND<=1)

CREATE TABLE staff(
  Staff_ID INT NOT NULL,  
  Staff_Name VARCHAR(20) NOT NULL,
  Job VARCHAR(25) NOT NULL,
  Salary INT NOT NULL,
  Commission INT NULL,
  Hire_Date DATE NOT NULL,
  Phone VARCHAR(15) NOT NULL,
  CONSTRAINT PK_Staff
  PRIMARY KEY (Staff_ID)
);

CREATE TABLE staff_address(
  Staff_ID INT NOT NULL,
  Address VARCHAR(255) NOT NULL,
  Birthday DATE NOT NULL,
  PRIMARY KEY (Staff_ID, Birthday),  
  FOREIGN KEY (Staff_ID) REFERENCES staff(Staff_ID)  
);

CREATE TABLE category(
  CategoryID INT NOT NULL,
  CategoryName VARCHAR(50) NOT NULL,
  Description VARCHAR(255) NULL,
  NO_OF_ITEMS INT NOT NULL DEFAULT 0,
  PRIMARY KEY (CategoryID)
);

CREATE TABLE customer(
  CustomerID INT NOT NULL,
  Cname VARCHAR(50) NOT NULL,
  Cphone VARCHAR(15) NOT NULL,
  PRIMARY KEY (CustomerID)
);



CREATE TABLE Supplier(
  SupplierID INT NOT NULL,
  CompanyName VARCHAR(100) NOT NULL,
  SupplierName VARCHAR(50) NULL,
  Company_Address VARCHAR(255) NOT NULL,
  Phone VARCHAR(15) NOT NULL,
  PRIMARY KEY (SupplierID)
);

CREATE TABLE Product(
  ProductID INT NOT NULL,
  ProductName VARCHAR(70) NOT NULL,
  SupplierID INT NOT NULL,
  CategoryID INT NOT NULL,
  Quantity INT NOT NULL DEFAULT 0,
  UnitPrice DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (ProductID),
  CONSTRAINT CHK_Product_Price CHECK ((UnitPrice >= 0)), 
  FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
  FOREIGN KEY (CategoryID) REFERENCES category(CategoryID)
);

CREATE TABLE transaction(
  TransactionID INT NOT NULL,
  CustomerID INT NOT NULL,
  StaffID INT NOT NULL,
  TransactionDate DATE NOT NULL,
  Total_Amount DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (TransactionID),
  FOREIGN KEY (CustomerID) REFERENCES customer(CustomerID),
  FOREIGN KEY (StaffID) REFERENCES staff(Staff_ID)
);

CREATE TABLE transaction_details(
  TransactionID INT NOT NULL,
  ProductID INT NOT NULL,
  UnitPrice DECIMAL(10,2) NOT NULL,
  Quantity INT NOT NULL,
  Discount DECIMAL(5,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (TransactionID,ProductID),
  CONSTRAINT CHK_Discount   CHECK ((Discount >= 0 and Discount <= 1)), 
  CONSTRAINT CHK_Quantity   CHECK ((Quantity > 0)), 
  CONSTRAINT CHK_UnitPrice   CHECK ((UnitPrice >= 0)),
  FOREIGN KEY (TransactionID) REFERENCES transaction(TransactionID),
  FOREIGN KEY (ProductID) REFERENCES product(ProductID)
);

-- inserting data to each table upto 50 rows

-- Inserting data into the staff table
INSERT INTO pharmacy_management_system.staff (Staff_ID, Staff_Name, Job, Salary, Commission, Hire_Date, Phone) 
VALUES 
(1, 'John Doe', 'Manager', 50000, 2000, '2023-01-15', '123-456-7890'),
(2, 'Jane Smith', 'Cashier', 30000, 1000, '2023-02-20', '234-567-8901'),
(3, 'Michael Johnson', 'Pharmacist', 60000, 2500, '2022-11-10', '345-678-9012'),
(4, 'Emily Brown', 'Technician', 35000, NULL, '2023-05-05', '456-789-0123'),
(5, 'Chris Wilson', 'Pharmacist', 65000, 3000, '2023-08-12', '567-890-1234'),
(6, 'Sarah Adams', 'Technician', 35000, NULL, '2023-03-08', '123-456-7890'),
(7, 'William Brown', 'Pharmacist', 65000, 3000, '2023-07-15', '234-567-8901'),
(8, 'Jennifer Garcia', 'Cashier', 32000, 1500, '2023-09-18', '345-678-9012'),
(9, 'Matthew Clark', 'Technician', 36000, NULL, '2024-01-30', '456-789-0123'),
(10, 'Emma Martinez', 'Pharmacist', 70000, 3500, '2024-03-25', '567-890-1234'),
(11, 'David Wilson', 'Manager', 55000, 2200, '2023-04-08', '678-901-2345'),
(12, 'Sophia Taylor', 'Cashier', 31000, 1200, '2023-06-20', '789-012-3456'),
(13, 'James Anderson', 'Technician', 34000, NULL, '2023-08-15', '890-123-4567'),
(14, 'Olivia Thompson', 'Pharmacist', 68000, 3200, '2024-02-28', '901-234-5678'),
(15, 'Ethan Garcia', 'Cashier', 33000, 1300, '2024-04-10', '012-345-6789'),
(16, 'Mia Robinson', 'Technician', 37000, NULL, '2023-05-12', '123-456-7890'),
(17, 'Aiden White', 'Pharmacist', 72000, 3800, '2023-11-20', '234-567-8901'),
(18, 'Grace Davis', 'Manager', 56000, 2300, '2023-12-18', '345-678-9012'),
(19, 'Chloe Wilson', 'Cashier', 34000, 1400, '2024-02-05', '456-789-0123'),
(20, 'Jack Martinez', 'Technician', 38000, NULL, '2023-10-10', '567-890-1234'),
(21, 'Sophia Lee', 'Pharmacist', 74000, 4000, '2024-01-05', '678-901-2345'),
(22, 'Noah Clark', 'Manager', 58000, 2400, '2023-07-30', '789-012-3456'),
(23, 'Ava Adams', 'Cashier', 35000, 1500, '2023-09-28', '890-123-4567'),
(24, 'Liam Brown', 'Technician', 39000, NULL, '2024-03-15', '901-234-5678'),
(25, 'Isabella Garcia', 'Pharmacist', 76000, 4200, '2024-05-20', '012-345-6789'),
(26, 'Mason Taylor', 'Manager', 60000, 2500, '2023-08-05', '123-456-7890'),
(27, 'Olivia Thompson', 'Cashier', 36000, 1600, '2023-11-28', '234-567-8901'),
(28, 'Alexander Wilson', 'Technician', 40000, NULL, '2024-01-20', '345-678-9012'),
(29, 'Sophia Robinson', 'Pharmacist', 78000, 4400, '2024-04-18', '456-789-0123'),
(30, 'William White', 'Manager', 62000, 2600, '2023-09-10', '567-890-1234'),
(31, 'Charlotte Davis', 'Cashier', 37000, 1700, '2023-12-08', '678-901-2345'),
(32, 'Ethan Thompson', 'Technician', 41000, NULL, '2024-02-25', '789-012-3456'),
(33, 'Emily Garcia', 'Pharmacist', 80000, 4600, '2024-05-15', '890-123-4567'),
(34, 'Emma Clark', 'Manager', 64000, 2700, '2023-10-28', '901-234-5678'),
(35, 'Noah Adams', 'Cashier', 38000, 1800, '2024-01-20', '012-345-6789'),
(36, 'Ava Martinez', 'Technician', 42000, NULL, '2024-04-08', '123-456-7890'),
(37, 'Mason Wilson', 'Pharmacist', 82000, 4800, '2023-12-05', '234-567-8901'),
(38, 'Olivia Thompson', 'Manager', 66000, 2800, '2024-02-18', '345-678-9012'),
(39, 'Isabella Robinson', 'Cashier', 39000, 1900, '2024-05-08', '456-789-0123'),
(40, 'Liam White', 'Technician', 43000, NULL, '2023-11-15', '567-890-1234'),
(41, 'Emma Davis', 'Pharmacist', 84000, 5000, '2023-01-30', '678-901-2345'),
(42, 'William Adams', 'Manager', 68000, 2900, '2023-04-28', '789-012-3456'),
(43, 'Charlotte Brown', 'Cashier', 40000, 2000, '2023-07-25', '890-123-4567'),
(44, 'Ethan Garcia', 'Technician', 44000, NULL, '2023-10-10', '901-234-5678'),
(45, 'Emily Wilson', 'Pharmacist', 86000, 5200, '2024-01-05', '012-345-6789'),
(46, 'Samantha Lee', 'Cashier', 32000, 1500, '2023-09-18', '678-901-2345'),
(47, 'Daniel Clark', 'Technician', 36000, NULL, '2024-01-30', '789-012-3456'),
(48, 'Olivia Martinez', 'Pharmacist', 70000, 3500, '2024-03-25', '890-123-4567'),
(49, 'Matthew White', 'Manager', 55000, 2200, '2023-04-08', '901-234-5678'),
(50, 'Emma Taylor', 'Cashier', 31000, 1200, '2023-06-20', '012-345-6789');

-- Inserting data into the staff_address table
INSERT INTO pharmacy_management_system.staff_address (Staff_ID, Address, Birthday) 
VALUES 
(1, '123 Main St', '1990-05-10'),
(2, '456 Elm St', '1995-08-25'),
(3, '789 Oak St', '1988-12-01'),
(4, '321 Pine St', '1992-03-15'),
(5, '654 Maple St', '1991-07-20'),
(6, '321 Pine St', '1992-03-15'),
(7, '654 Maple St', '1991-07-20'),
(8, '987 Cedar St', '1994-09-28'),
(9, '456 Birch St', '1993-11-05'),
(10, '789 Walnut St', '1989-02-14'),
(11, '234 Oak St', '1996-04-30'),
(12, '567 Elm St', '1990-08-10'),
(13, '123 Pine St', '1993-02-20'),
(14, '456 Cedar St', '1990-06-25'),
(15, '789 Birch St', '1995-05-12'),
(16, '987 Maple St', '1994-08-18'),
(17, '654 Cedar St', '1992-12-08'),
(18, '321 Elm St', '1991-04-05'),
(19, '123 Walnut St', '1996-09-30'),
(20, '456 Oak St', '1995-11-15'),
(21, '789 Pine St', '1993-10-28'),
(22, '987 Birch St', '1990-03-25'),
(23, '654 Walnut St', '1991-07-30'),
(24, '321 Cedar St', '1994-05-08'),
(25, '123 Elm St', '1995-09-20'),
(26, '456 Pine St', '1996-01-12'),
(27, '789 Oak St', '1992-08-05'),
(28, '987 Maple St', '1993-12-18'),
(29, '654 Elm St', '1994-04-28'),
(30, '321 Birch St', '1990-06-15'),
(31, '123 Walnut St', '1991-10-10'),
(32, '456 Oak St', '1995-03-08'),
(33, '789 Pine St', '1996-07-25'),
(34, '987 Cedar St', '1992-11-30'),
(35, '654 Birch St', '1993-05-20'),
(36, '321 Elm St', '1994-08-28'),
(37, '123 Maple St', '1995-01-15'),
(38, '456 Cedar St', '1996-04-05'),
(39, '789 Birch St', '1990-09-18'),
(40, '987 Walnut St', '1991-02-10'),
(41, '654 Oak St', '1994-12-28'),
(42, '321 Pine St', '1995-07-15'),
(43, '123 Cedar St', '1996-10-05'),
(44, '456 Birch St', '1992-05-28'),
(45, '789 Walnut St', '1993-08-20'),
(46, '987 Cedar St', '1994-09-28'),
(47, '456 Birch St', '1993-11-05'),
(48, '789 Walnut St', '1989-02-14'),
(49, '234 Oak St', '1996-04-30'),
(50, '567 Elm St', '1990-08-10');

-- Inserting data into the category table
INSERT INTO pharmacy_management_system.category (CategoryID, CategoryName, Description, NO_OF_ITEMS) 
VALUES 
(1, 'Pain Relief', 'Medications for pain management', 20),
(2, 'Cold & Flu', 'Medications for cold and flu symptoms', 15),
(3, 'Allergy', 'Medications for allergy relief', 10),
(4, 'First Aid', 'First aid supplies', 25),
(5, 'Skin Care', 'Skin care products', 30),
(6, 'Digestive Health', 'Products for digestive health', 18),
(7, 'Vitamins & Supplements', 'Nutritional supplements', 22),
(8, 'Eye Care', 'Products for eye health', 12),
(9, 'Oral Care', 'Dental hygiene products', 28),
(10, 'Baby & Child Care', 'Products for infants and children', 35),
(11, 'Diabetes Care', 'Products for diabetes management', 25),
(12, 'Weight Management', 'Products for weight control', 20),
(13, 'Hair Care', 'Hair care products', 30),
(14, 'Home Health Care', 'Medical equipment for home use', 40),
(15, 'Personal Care', 'Personal hygiene products', 45),
(16, 'Senior Care', 'Products for elderly care', 18),
(17, 'Feminine Care', 'Products for feminine hygiene', 22),
(18, 'Mens Care', 'Products for mens grooming', 12),
(19, 'Pet Care', 'Products for pet health', 28),
(20, 'Allergy & Sinus', 'Products for allergy relief', 35),
(21, 'Diet & Fitness', 'Products for diet and fitness', 25),
(22, 'Medical Supplies', 'Medical supplies and equipment', 20),
(23, 'Homeopathic Remedies', 'Homeopathic medicines', 30),
(24, 'Sexual Wellness', 'Products for sexual health', 40),
(25, 'Vision Care', 'Products for vision correction', 45),
(26, 'Smoking Cessation', 'Products to quit smoking', 18),
(27, 'Foot Care', 'Products for foot health', 22),
(28, 'Incontinence', 'Products for incontinence', 12),
(29, 'Medicated Skin Care', 'Medicated skin care products', 28),
(30, 'Orthopedic Care', 'Orthopedic products', 35),
(31, 'Respiratory Care', 'Products for respiratory health', 25),
(32, 'Sleep Aids', 'Products for sleep support', 20),
(33, 'Ear Care', 'Products for ear health', 30),
(34, 'Travel Health', 'Products for travel health', 40),
(35, 'Wound Care', 'Products for wound care', 45),
(36, 'Emergency Preparedness', 'Emergency medical supplies', 18),
(37, 'Testing Supplies', 'Medical testing supplies', 22),
(38, 'Healthy Lifestyles', 'Products for healthy living', 12),
(39, 'Health Monitors', 'Health monitoring devices', 28),
(40, 'Rehabilitation', 'Rehabilitation equipment', 35),
(41, 'Medical ID Jewelry', 'Medical identification jewelry', 25),
(42, 'Alternative Medicine', 'Alternative health remedies', 20),
(43, 'Medical Books', 'Books on medical topics', 30),
(44, 'Patient Care', 'Products for patient care', 40),
(45, 'Health Information', 'Educational materials on health', 45),
(46, 'Digestive Health', 'Products for digestive health', 18),
(47, 'Vitamins & Supplements', 'Nutritional supplements', 22),
(48, 'Eye Care', 'Products for eye health', 12),
(49, 'Oral Care', 'Dental hygiene products', 28),
(50, 'Baby & Child Care', 'Products for infants and children', 35);

-- Inserting data into the customer table
INSERT INTO pharmacy_management_system.customer (CustomerID, Cname, Cphone) 
VALUES 
(1, 'Alice Johnson', '555-123-4567'),
(2, 'Bob Smith', '555-234-5678'),
(3, 'Emily Davis', '555-345-6789'),
(4, 'David Miller', '555-456-7890'),
(5, 'Sophia Wilson', '555-567-8901'),
(6, 'Sophia Brown', '555-234-5678'),
(7, 'Mason Garcia', '555-345-6789'),
(8, 'Charlotte Clark', '555-456-7890'),
(9, 'Ethan Wilson', '555-567-8901'),
(10, 'Amelia Martinez', '555-678-9012'),
(11, 'Jacob Taylor', '555-789-0123'),
(12, 'Abigail Adams', '555-890-1234'),
(13, 'Logan Brown', '555-901-2345'),
(14, 'Harper Garcia', '555-012-3456'),
(15, 'Evelyn Clark', '555-123-4567'),
(16, 'Sebastian Wilson', '555-234-5678'),
(17, 'Avery Martinez', '555-345-6789'),
(18, 'Jackson Taylor', '555-456-7890'),
(19, 'Sofia Adams', '555-567-8901'),
(20, 'Henry Brown', '555-678-9012'),
(21, 'Scarlett Garcia', '555-789-0123'),
(22, 'Madison Clark', '555-890-1234'),
(23, 'Elijah Wilson', '555-901-2345'),
(24, 'Lily Martinez', '555-012-3456'),
(25, 'Liam Taylor', '555-123-4567'),
(26, 'Aria Adams', '555-234-5678'),
(27, 'Grayson Brown', '555-345-6789'),
(28, 'Chloe Garcia', '555-456-7890'),
(29, 'Zoey Clark', '555-567-8901'),
(30, 'Carter Wilson', '555-678-9012'),
(31, 'Riley Martinez', '555-789-0123'),
(32, 'Hudson Taylor', '555-890-1234'),
(33, 'Nora Adams', '555-901-2345'),
(34, 'Levi Brown', '555-012-3456'),
(35, 'Hannah Garcia', '555-123-4567'),
(36, 'Eli Clark', '555-234-5678'),
(37, 'Grace Wilson', '555-345-6789'),
(38, 'Addison Martinez', '555-456-7890'),
(39, 'Mateo Taylor', '555-567-8901'),
(40, 'Luna Adams', '555-678-9012'),
(41, 'Zoe Brown', '555-789-0123'),
(42, 'Brooks Garcia', '555-890-1234'),
(43, 'Audrey Clark', '555-901-2345'),
(44, 'Nathan Wilson', '555-012-3456'),
(45, 'Violet Martinez', '555-123-4567'),
(46, 'Mia Anderson', '555-678-9012'),
(47, 'Ethan Thompson', '555-789-0123'),
(48, 'Chloe Garcia', '555-890-1234'),
(49, 'Aiden Martinez', '555-901-2345'),
(50, 'Grace Robinson', '555-012-3456');

-- Inserting data into the Supplier table
INSERT INTO pharmacy_management_system.Supplier (SupplierID, CompanyName, SupplierName, Company_Address, Phone) 
VALUES 
(1, 'ABC Pharmaceuticals', 'ABC Supplier', '789 Oak St', '123-456-7890'),
(2, 'XYZ Medical Supplies', 'XYZ Supplier', '456 Pine St', '234-567-8901'),
(3, 'Pharma Inc', 'Pharma Supplier', '789 Elm St', '345-678-9012'),
(4, 'MediCorp', 'MediCorp Supplier', '321 Maple St', '456-789-0123'),
(5, 'Health Solutions', 'Health Solutions Supplier', '654 Cedar St', '567-890-1234'),
(6, 'Sunrise Pharmaceuticals', 'Sunrise Supplier', '234 Elm St', '901-234-5678'),
(7, 'MediWorld', 'MediWorld Supplier', '567 Pine St', '012-345-6789'),
(8, 'ABC Pharmaceuticals', 'ABC Supplier', '789 Oak St', '123-456-7890'),
(9, 'XYZ Medical Supplies', 'XYZ Supplier', '456 Pine St', '234-567-8901'),
(10, 'Pharma Inc', 'Pharma Supplier', '789 Elm St', '345-678-9012'),
(11, 'MediCorp', 'MediCorp Supplier', '321 Maple St', '456-789-0123'),
(12, 'Health Solutions', 'Health Solutions Supplier', '654 Cedar St', '567-890-1234'),
(13, 'Global Pharma', 'Global Pharma Supplier', '987 Birch St', '678-901-2345'),
(14, 'BioMed Solutions', 'BioMed Supplier', '654 Walnut St', '789-012-3456'),
(15, 'Nature''s Best', 'Nature''s Best Supplier', '789 Oak St', '890-123-4567'),
(16, 'Sunrise Pharmaceuticals', 'Sunrise Supplier', '234 Elm St', '901-234-5678'),
(17, 'MediWorld', 'MediWorld Supplier', '567 Pine St', '012-345-6789'),
(18, 'ABC Pharmaceuticals', 'ABC Supplier', '789 Oak St', '123-456-7890'),
(19, 'XYZ Medical Supplies', 'XYZ Supplier', '456 Pine St', '234-567-8901'),
(20, 'Pharma Inc', 'Pharma Supplier', '789 Elm St', '345-678-9012'),
(21, 'MediCorp', 'MediCorp Supplier', '321 Maple St', '456-789-0123'),
(22, 'Health Solutions', 'Health Solutions Supplier', '654 Cedar St', '567-890-1234'),
(23, 'Global Pharma', 'Global Pharma Supplier', '987 Birch St', '678-901-2345'),
(24, 'BioMed Solutions', 'BioMed Supplier', '654 Walnut St', '789-012-3456'),
(25, 'Nature''s Best', 'Nature''s Best Supplier', '789 Oak St', '890-123-4567'),
(26, 'Sunrise Pharmaceuticals', 'Sunrise Supplier', '234 Elm St', '901-234-5678'),
(27, 'MediWorld', 'MediWorld Supplier', '567 Pine St', '012-345-6789'),
(28, 'ABC Pharmaceuticals', 'ABC Supplier', '789 Oak St', '123-456-7890'),
(29, 'XYZ Medical Supplies', 'XYZ Supplier', '456 Pine St', '234-567-8901'),
(30, 'Pharma Inc', 'Pharma Supplier', '789 Elm St', '345-678-9012'),
(31, 'MediCorp', 'MediCorp Supplier', '321 Maple St', '456-789-0123'),
(32, 'Health Solutions', 'Health Solutions Supplier', '654 Cedar St', '567-890-1234'),
(33, 'Global Pharma', 'Global Pharma Supplier', '987 Birch St', '678-901-2345'),
(34, 'BioMed Solutions', 'BioMed Supplier', '654 Walnut St', '789-012-3456'),
(35, 'Nature''s Best', 'Nature''s Best Supplier', '789 Oak St', '890-123-4567'),
(36, 'Sunrise Pharmaceuticals', 'Sunrise Supplier', '234 Elm St', '901-234-5678'),
(37, 'MediWorld', 'MediWorld Supplier', '567 Pine St', '012-345-6789'),
(38, 'ABC Pharmaceuticals', 'ABC Supplier', '789 Oak St', '123-456-7890'),
(39, 'XYZ Medical Supplies', 'XYZ Supplier', '456 Pine St', '234-567-8901'),
(40, 'Pharma Inc', 'Pharma Supplier', '789 Elm St', '345-678-9012'),
(41, 'MediCorp', 'MediCorp Supplier', '321 Maple St', '456-789-0123'),
(42, 'Health Solutions', 'Health Solutions Supplier', '654 Cedar St', '567-890-1234'),
(43, 'Global Pharma', 'Global Pharma Supplier', '987 Birch St', '678-901-2345'),
(44, 'BioMed Solutions', 'BioMed Supplier', '654 Walnut St', '789-012-3456'),
(45, 'Nature''s Best', 'Nature''s Best Supplier', '789 Oak St', '890-123-4567'),
(46, 'Global Pharma', 'Global Pharma Supplier', '987 Birch St', '678-901-2345'),
(47, 'BioMed Solutions', 'BioMed Supplier', '654 Walnut St', '789-012-3456'),
(48, 'Natures Best', 'Natures Best Supplier', '789 Oak St', '890-123-4567'),
(49, 'Sunrise Pharmaceuticals', 'Sunrise Supplier', '234 Elm St', '901-234-5678'),
(50, 'MediWorld', 'MediWorld Supplier', '567 Pine St', '012-345-6789');

-- Inserting data into the Product table
INSERT INTO pharmacy_management_system.Product (ProductID, ProductName, SupplierID, CategoryID, Quantity, UnitPrice) 
VALUES 
(1, 'Acetaminophen', 1, 1, 100, 5.99),
(2, 'Ibuprofen', 1, 1, 150, 7.99),
(3, 'Cough Syrup', 2, 2, 50, 9.99),
(4, 'Band-Aids', 4, 4, 200, 4.50),
(5, 'Sunscreen', 5, 5, 80, 12.99),
(6, 'Probiotic Capsules', 6, 6, 50, 19.99),
(7, 'Vitamin C Supplements', 7, 7, 65, 12.50),
(8, 'Eye Drops', 8, 8, 30, 8.75),
(9, 'Toothpaste', 9, 9, 120, 3.99),
(10, 'Baby Shampoo', 10, 10, 70, 5.50),
(11, 'Digestive Enzymes', 11, 11, 40, 14.75),
(12, 'Multivitamin Gummies', 12, 12, 55, 10.25),
(13, 'Contact Lens Solution', 13, 13, 25, 15.99),
(14, 'Hair Growth Shampoo', 14, 14, 60, 8.99),
(15, 'Blood Pressure Monitor', 15, 15, 35, 45.00),
(16, 'Hand Sanitizer', 16, 16, 45, 6.25),
(17, 'Feminine Hygiene Products', 17, 17, 75, 4.50),
(18, 'Men''s Beard Oil', 18, 18, 20, 11.99),
(19, 'Pet Multivitamins', 19, 19, 80, 7.50),
(20, 'Antihistamine Tablets', 20, 20, 90, 9.25),
(21, 'Protein Bars', 21, 21, 50, 12.99),
(22, 'Blood Glucose Monitor', 22, 22, 30, 55.00),
(23, 'Sleep Aid Supplements', 23, 23, 65, 8.75),
(24, 'Ear Wax Removal Kit', 24, 24, 40, 14.50),
(25, 'Travel First Aid Kit', 25, 25, 55, 20.99),
(26, 'Wound Dressing Supplies', 26, 26, 25, 16.50),
(27, 'Emergency Blanket', 27, 27, 35, 6.99),
(28, 'Nicotine Patches', 28, 28, 60, 24.50),
(29, 'Foot Cream', 29, 29, 70, 9.75),
(30, 'Incontinence Pads', 30, 30, 40, 18.50),
(31, 'Acne Treatment Gel', 31, 31, 75, 5.25),
(32, 'Nebulizer Machine', 32, 32, 30, 65.00),
(33, 'Sleeping Mask', 33, 33, 65, 7.75),
(34, 'Ear Plugs', 34, 34, 40, 11.50),
(35, 'Motion Sickness Pills', 35, 35, 50, 9.99),
(36, 'Wound Cleansing Spray', 36, 36, 25, 14.25),
(37, 'Medical Gloves', 37, 37, 55, 18.99),
(38, 'Healthy Recipe Book', 38, 38, 80, 12.75),
(39, 'Blood Pressure Cuff', 39, 39, 35, 29.50),
(40, 'Rehabilitation Bands', 40, 40, 40, 8.99),
(41, 'Medical ID Bracelet', 41, 41, 65, 15.50),
(42, 'Herbal Supplements', 42, 42, 70, 6.75),
(43, 'Medical Reference Guide', 43, 43, 30, 19.99),
(44, 'Patient Gown', 44, 44, 45, 7.25),
(45, 'Health Magazine Subscription', 45, 45, 50, 5.99),
(46, 'Antacid Tablets', 3, 3, 60, 6.75),
(47, 'Multivitamin Tablets', 3, 6, 100, 14.99),
(48, 'Eye Drops', 4, 7, 40, 8.25),
(49, 'Toothpaste', 5, 8, 120, 3.99),
(50, 'Baby Shampoo', 2, 9, 70, 5.50);

-- Inserting data into the transaction table
INSERT INTO pharmacy_management_system.transaction (TransactionID, CustomerID, StaffID, TransactionDate, Total_Amount) 
VALUES 
(1, 1, 1, '2024-05-10', 25.50),
(2, 2, 2, '2024-05-11', 30.25),
(3, 3, 3, '2024-05-12', 15.75),
(4, 4, 4, '2024-05-13', 18.50),
(5, 5, 5, '2024-05-14', 42.00),
(6, 6, 6, '2024-05-20', 28.75),
(7, 7, 7, '2024-05-21', 22.90),
(8, 8, 8, '2024-05-22', 38.25),
(9, 9, 9, '2024-05-23', 20.80),
(10, 10, 10, '2024-05-24', 16.99),
(11, 11, 11, '2024-05-25', 30.50),
(12, 12, 12, '2024-05-26', 25.75),
(13, 13, 13, '2024-05-27', 35.25),
(14, 14, 14, '2024-05-28', 29.99),
(15, 15, 15, '2024-05-29', 65.00),
(16, 16, 16, '2024-05-30', 20.50),
(17, 17, 17, '2024-05-31', 42.75),
(18, 18, 18, '2024-06-01', 14.99),
(19, 19, 19, '2024-06-02', 18.50),
(20, 20, 20, '2024-06-03', 27.75),
(21, 21, 21, '2024-06-04', 50.25),
(22, 22, 22, '2024-06-05', 23.99),
(23, 23, 23, '2024-06-06', 28.50),
(24, 24, 24, '2024-06-07', 19.75),
(25, 25, 25, '2024-06-08', 40.00),
(26, 26, 26, '2024-06-09', 28.50),
(27, 27, 27, '2024-06-10', 12.99),
(28, 28, 28, '2024-06-11', 36.50),
(29, 29, 29, '2024-06-12', 19.75),
(30, 30, 30, '2024-06-13', 25.99),
(31, 31, 31, '2024-06-14', 47.25),
(32, 32, 32, '2024-06-15', 33.99),
(33, 33, 33, '2024-06-16', 38.50),
(34, 34, 34, '2024-06-17', 16.75),
(35, 35, 35, '2024-06-18', 22.50),
(36, 36, 36, '2024-06-19', 29.99),
(37, 37, 37, '2024-06-20', 45.50),
(38, 38, 38, '2024-06-21', 35.99),
(39, 39, 39, '2024-06-22', 55.25),
(40, 40, 40, '2024-06-23', 27.99),
(41, 41, 41, '2024-06-24', 32.50),
(42, 42, 42, '2024-06-25', 24.99),
(43, 43, 43, '2024-06-26', 40.25),
(44, 44, 44, '2024-06-27', 18.75),
(45, 45, 45, '2024-06-28', 35.50),
(46, 46, 46, '2024-05-15', 36.75),
(47, 47, 47, '2024-05-16', 23.80),
(48, 48, 48, '2024-05-17', 55.25),
(49, 49, 49, '2024-05-18', 28.90),
(50, 50, 50, '2024-05-19', 19.99);

-- Inserting data into the transaction_details table
INSERT INTO pharmacy_management_system.transaction_details (TransactionID, ProductID, UnitPrice, Quantity, Discount) 
VALUES 
(1, 1, 5.99, 2, 0.1),
(2, 2, 7.99, 3, 0.05),
(3, 3, 9.99, 1, 0.0),
(4, 4, 4.50, 4, 0.1),
(5, 5, 12.99, 3, 0.05),
(6, 6, 19.99, 1, 0.05),
(6, 7, 12.50, 2, 0),
(7, 8, 8.75, 3, 0.1),
(7, 9, 3.99, 1, 0),
(8, 10, 5.50, 1, 0),
(8, 11, 14.75, 1, 0.05),
(9, 12, 10.25, 2, 0),
(9, 13, 15.99, 1, 0),
(10, 14, 8.99, 1, 0),
(10, 15, 45.00, 1, 0),
(11, 16, 6.25, 2, 0),
(11, 17, 4.50, 3, 0),
(12, 18, 11.99, 1, 0),
(12, 19, 7.50, 2, 0.05),
(13, 20, 9.25, 1, 0),
(13, 21, 12.99, 1, 0),
(14, 22, 55.00, 1, 0),
(14, 23, 8.75, 2, 0),
(15, 24, 14.50, 1, 0),
(15, 25, 20.99, 1, 0),
(16, 26, 16.50, 1, 0),
(16, 27, 6.99, 1, 0),
(17, 28, 24.50, 1, 0),
(17, 29, 9.75, 2, 0),
(18, 30, 18.50, 1, 0),
(18, 31, 5.25, 2, 0),
(19, 32, 65.00, 1, 0),
(19, 33, 7.75, 1, 0),
(20, 34, 11.50, 2, 0),
(20, 35, 9.99, 1, 0),
(21, 36, 14.25, 1, 0),
(21, 37, 18.99, 1, 0),
(22, 38, 12.75, 1, 0),
(22, 39, 29.50, 1, 0),
(23, 40, 8.99, 1, 0),
(23, 41, 15.50, 1, 0),
(24, 42, 6.75, 2, 0),
(24, 43, 19.99, 1, 0),
(25, 44, 7.25, 1, 0),
(25, 45, 5.99, 1, 0),
(46, 46, 6.75, 5, 0.1),
(47, 47, 14.99, 2, 0.05),
(48, 48, 8.25, 3, 0.0),
(49, 49, 3.99, 6, 0.1),
(50, 50, 5.50, 1, 0.05);
