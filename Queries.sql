-- queries

SELECT * FROM staff;

SELECT * FROM staff_address;


-- Update the salary of a staff member:
UPDATE staff SET Salary = 30000 WHERE Staff_ID = 5;

-- Delete a staff member:
DELETE FROM staff WHERE Staff_ID = 4;


-- INNER JOIN:
-- Retrieve transaction details along with the corresponding product and customer information:

SELECT td.*, p.ProductName, c.Cname
FROM transaction_details td
INNER JOIN Product p ON td.ProductID = p.ProductID
INNER JOIN transaction t ON td.TransactionID = t.TransactionID
INNER JOIN customer c ON t.CustomerID = c.CustomerID;

-- LEFT JOIN:
-- Retrieve all products along with their supplier information:

SELECT p.*, s.CompanyName AS SupplierName
FROM Product p
LEFT JOIN Supplier s ON p.SupplierID = s.SupplierID;


-- Check the quantity of each product in inventory:
SELECT ProductName, Quantity
FROM Product;

-- Get the total sales amount for each medication:

SELECT p.ProductName, SUM(td.UnitPrice * td.Quantity) AS TotalSales
FROM transaction_details td
INNER JOIN Product p ON td.ProductID = p.ProductID
GROUP BY p.ProductName;

-- Retrieve transaction details for a specific customer:
SELECT t.TransactionDate, p.ProductName, td.UnitPrice, td.Quantity, td.Discount, (td.UnitPrice * td.Quantity) AS TotalAmount
FROM transaction t
INNER JOIN transaction_details td ON t.TransactionID = td.TransactionID
INNER JOIN Product p ON td.ProductID = p.ProductID
WHERE t.CustomerID = 2;-- Change customer ID as needed