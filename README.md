# 🏥 Hospital Management System (Database Project)

## 📘 About the Project
This project is a **Hospital Management Database System** built using **MySQL**.  
It helps manage hospitals, employees, patients, appointments, treatments, and billing efficiently.  
The project also includes user roles for secure access (Admin, Doctor, Receptionist).

---

## 🧩 Database Details
**Database Name:** `hospital_mgmt`

### Tables Included:
1. Hospital  
2. Employee  
3. Doctor  
4. Nurse  
5. Receptionist  
6. Records  
7. Patient  
8. Appointment  
9. Rooms  
10. Treatment  
11. Test_Report  
12. Bills  

Each table is connected using **foreign keys** to ensure relational integrity.

---

## ⚙️ Features
✅ Manage hospital and employee data  
✅ Handle patient registration and appointments  
✅ Record treatments and generate bills  
✅ Secure role-based access for users  
✅ Perform data analysis using SQL queries  

---

## 💾 How to Run the Project

### Step 1: Open MySQL or phpMyAdmin
Ensure your MySQL server is running.

### Step 2: Create the Database
```sql
CREATE DATABASE hospital_mgmt;
USE hospital_mgmt;
```

### Step 3: Import the SQL File
Run the SQL script file `database.sql` in your MySQL environment.

### Step 4: Verify Tables
```sql
SHOW TABLES;
```

### Step 5: View Sample Data
```sql
SELECT * FROM Patient;
SELECT * FROM Employee;
SELECT * FROM Bills;
```

---

## 📊 Example SQL Queries

| Query | Description |
|-------|--------------|
| `SELECT * FROM Patient;` | View all patient records |
| `SELECT AVG(E_salary) FROM Employee;` | Find average employee salary |
| `SELECT MAX(Bill_amount) FROM Bills;` | Find highest bill amount |
| `SELECT p.P_name, b.Bill_amount FROM Patient p JOIN Bills b ON p.P_id = b.P_id;` | Show patients with their bill amount |
| `SELECT DISTINCT E_department FROM Employee;` | Show all unique departments |

---

## 🧠 User Roles and Access Control

### 👑 Admin Role (Full Access)
```sql
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'admin123';
GRANT ALL PRIVILEGES ON hospital_mgmt.* TO 'admin_user'@'localhost';
```

### 🩺 Doctor Role (Limited Access)
```sql
CREATE USER 'doctor_user'@'localhost' IDENTIFIED BY 'doc123';
GRANT SELECT ON hospital_mgmt.Patient TO 'doctor_user'@'localhost';
GRANT SELECT, UPDATE ON hospital_mgmt.Treatment TO 'doctor_user'@'localhost';
```

### 💼 Receptionist Role (Limited Access)
```sql
CREATE USER 'reception_user'@'localhost' IDENTIFIED BY 'rec123';
GRANT SELECT, INSERT, UPDATE ON hospital_mgmt.Patient TO 'reception_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON hospital_mgmt.Appointment TO 'reception_user'@'localhost';
```

---

## 📅 Sample Output

**Appointments**
| Patient | Date | Time | Status |
|----------|------|------|--------|
| Zeeshan Ali | 2025-10-25 | 10:00 AM | Confirmed |
| Sara Khan | 2025-10-26 | 11:30 AM | Pending |

**Bills**
| Patient | Amount | Payment Mode |
|----------|---------|---------------|
| Zeeshan Ali | 15000.50 | Cash |
| Sara Khan | 22000.00 | Card |

---

## 👨‍💻 Developer
**Name:** Shoaib Ahmed  
**Project:** Hospital Management Database System  
**Language:** MySQL  
**Year:** 2025  

---

## 🌟 Key Learning Outcomes
- Understand relational database design  
- Use of primary & foreign keys  
- Practice SQL joins, aggregate functions, and constraints  
- Implement database security using user privileges  
