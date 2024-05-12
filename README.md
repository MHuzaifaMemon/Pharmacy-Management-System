# Pharmacy Management System
The Pharmacy Management System is a database system designed to efficiently manage medication inventory, track prescriptions, and streamline customer interactions. It provides a comprehensive solution for pharmacies to organize their staff, products, customers, suppliers, and transactions.

# Install MySQL Database
If MySQL is not already installed on your system, download and install it from the official MySQL website: MySQL Downloads. MySQL Downloads
Follow the installation instructions provided for your operating system.
Windows: Go to the MySQL Community Downloads page. MySQL Downloads Under "MySQL Community Server", select the appropriate version for your Windows architecture (usually 64-bit). Click on the "Download" button. Follow the on-screen instructions to complete the download.
macOS: Visit the MySQL Community Downloads page. MySQL Downloads Under "MySQL Community Server", select the macOS version. Click on the "Download" button. Follow the instructions to complete the download.
Linux: For Linux distributions, MySQL is often available through package managers like apt (for Debian/Ubuntu) or yum (for CentOS/RHEL). Alternatively, you can download the MySQL Community Server for Linux from the MySQL website and install it manually. Visit the MySQL Community Downloads page. MySQL Downloads Select the appropriate Linux distribution and architecture. Click on the "Download" button. Follow the instructions provided for your specific Linux distribution.

# Setup Instructions
Create Database Schema: Execute the following SQL command to create the necessary schema for the database:

# CREATE SCHEMA pharmacy_management_system;
Create Tables: Run the provided SQL script to create the required tables in the database. Ensure that your database server is running and accessible.

-- Execute the SQL script provided
Insert Sample Data (Optional): If desired, insert sample data into the tables to populate them for testing purposes.

Run the Application: Integrate the database with your application code. Implement functionalities for staff management, product management, customer management, supplier management, and transaction processing as per your requirements.
# Database Schema

Staff
Staff_ID: Unique identifier for the staff member (Primary Key)
Staff_Name: Name of the staff member
Job: Job title or role of the staff member
Salary: Salary of the staff member
Commission: Commission percentage (nullable)
Hire_Date: Date of hire
Phone: Contact phone number

Staff_Address
Staff_ID: Foreign key referencing Staff table
Address: Address of the staff member
Birthday: Birthday of the staff member (Primary Key)

Category
CategoryID: Unique identifier for the category (Primary Key)
CategoryName: Name of the category
Description: Description of the category
NO_OF_ITEMS: Number of items in the category

Customer
CustomerID: Unique identifier for the customer (Primary Key)
Cname: Customer name
Cphone: Customer phone number

Supplier
SupplierID: Unique identifier for the supplier (Primary Key)
CompanyName: Name of the company
SupplierName: Name of the supplier (nullable)
Company_Address: Address of the company
Phone: Contact phone number

Product
ProductID: Unique identifier for the product (Primary Key)
ProductName: Name of the product
SupplierID: Foreign key referencing Supplier table
CategoryID: Foreign key referencing Category table
Quantity: Quantity of the product
UnitPrice: Price per unit

Transaction
TransactionID: Unique identifier for the transaction (Primary Key)
CustomerID: Foreign key referencing Customer table
StaffID: Foreign key referencing Staff table
TransactionDate: Date of the transaction
Total_Amount: Total amount of the transaction

Transaction_Details
TransactionID: Foreign key referencing Transaction table
ProductID: Foreign key referencing Product table
UnitPrice: Price per unit
Quantity: Quantity of the product
Discount: Discount applied to the transaction
