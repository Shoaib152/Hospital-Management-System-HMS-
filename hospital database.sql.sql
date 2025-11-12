CREATE DATABASE hospital_mgmt;
USE hospital_mgmt;

CREATE TABLE Hospital (
  H_registered_num INT PRIMARY KEY,
  H_name VARCHAR(50),
  H_address VARCHAR(100),
  H_phone_num INT,
  H_email VARCHAR(50),
  H_specialization VARCHAR(30)
);

INSERT INTO Hospital VALUES
(1001, 'CityCare Hospital', 'Main Road Karachi', 213456789, 'info@citycare.com', 'Cardiology'),
(1002, 'LifeLine Hospital', 'Model Town Lahore', 423567891, 'contact@lifeline.com', 'Neurology');

CREATE TABLE Employee (
  E_id INT AUTO_INCREMENT PRIMARY KEY,
  E_name VARCHAR(50),
  E_address VARCHAR(50),
  E_phone_no INT,
  E_gender VARCHAR(50),
  E_department VARCHAR(50),
  E_salary INT,
  E_DOJ DATE,
  E_qualification VARCHAR(50),
  H_registered_num INT,
  FOREIGN KEY (H_registered_num) REFERENCES Hospital(H_registered_num)
);

INSERT INTO Employee (E_name, E_address, E_phone_no, E_gender, E_department, E_salary, E_DOJ, E_qualification, H_registered_num) VALUES
('Dr. Ahmed', 'Gulshan Karachi', 321456789, 'Male', 'Cardiology', 120000, '2020-03-15', 'MBBS', 1001),
('Nurse Aisha', 'PECHS Karachi', 332456987, 'Female', 'Nursing', 60000, '2021-05-12', 'BS Nursing', 1001),
('Ali Khan', 'Saddar Karachi', 345678912, 'Male', 'Reception', 45000, '2022-02-20', 'BBA', 1001);

CREATE TABLE Doctor (
  D_id INT PRIMARY KEY,
  D_name VARCHAR(50),
  D_department VARCHAR(50),
  FOREIGN KEY (D_id) REFERENCES Employee(E_id)
);

INSERT INTO Doctor VALUES
(1, 'Dr. Ahmed', 'Cardiology');

CREATE TABLE Nurse (
  N_id INT PRIMARY KEY,
  N_name VARCHAR(50),
  FOREIGN KEY (N_id) REFERENCES Employee(E_id)
);

INSERT INTO Nurse VALUES
(2, 'Nurse Aisha');

CREATE TABLE Receptionist (
  Rec_id INT PRIMARY KEY,
  Rec_name VARCHAR(50),
  FOREIGN KEY (Rec_id) REFERENCES Employee(E_id)
);

INSERT INTO Receptionist VALUES
(3, 'Ali Khan');

CREATE TABLE Records (
  record_no INT AUTO_INCREMENT PRIMARY KEY,
  application_no INT UNIQUE,
  Rec_id INT,
  FOREIGN KEY (Rec_id) REFERENCES Receptionist(Rec_id)
);

INSERT INTO Records (application_no, Rec_id) VALUES
(5001, 3),
(5002, 3);

CREATE TABLE Patient (
  P_id INT AUTO_INCREMENT PRIMARY KEY,
  P_name VARCHAR(50) NOT NULL,
  P_age INT,
  P_gender VARCHAR(50),
  P_bloodgroup VARCHAR(20),
  P_address VARCHAR(50),
  P_phone_no INT
);

INSERT INTO Patient (P_name, P_age, P_gender, P_bloodgroup, P_address, P_phone_no) VALUES
('Zeeshan Ali', 32, 'Male', 'B+', 'North Karachi', 300112233),
('Sara Khan', 28, 'Female', 'O+', 'Gulshan Block 7', 301223344);

CREATE TABLE Appointment (
  A_id INT AUTO_INCREMENT PRIMARY KEY,
  P_id INT,
  Rec_id INT,
  appointment_date DATE,
  appointment_time TIME,
  status VARCHAR(30),
  FOREIGN KEY (P_id) REFERENCES Patient(P_id),
  FOREIGN KEY (Rec_id) REFERENCES Receptionist(Rec_id)
);

INSERT INTO Appointment (P_id, Rec_id, appointment_date, appointment_time, status) VALUES
(1, 3, '2025-10-25', '10:00:00', 'Confirmed'),
(2, 3, '2025-10-26', '11:30:00', 'Pending');

CREATE TABLE Rooms (
  R_id INT AUTO_INCREMENT PRIMARY KEY,
  R_type VARCHAR(30),
  Capacity INT,
  Availability INT
);

INSERT INTO Rooms (R_type, Capacity, Availability) VALUES
('General', 4, 2),
('Private', 1, 1);

CREATE TABLE Treatment (
  T_id INT AUTO_INCREMENT PRIMARY KEY,
  P_id INT,
  R_id INT,
  D_id INT,
  Treatment_type VARCHAR(45),
  Date_of_admission DATETIME,
  Date_of_discharge DATETIME,
  Prescription VARCHAR(255),
  FOREIGN KEY (P_id) REFERENCES Patient(P_id),
  FOREIGN KEY (R_id) REFERENCES Rooms(R_id),
  FOREIGN KEY (D_id) REFERENCES Doctor(D_id)
);

INSERT INTO Treatment (P_id, R_id, D_id, Treatment_type, Date_of_admission, Date_of_discharge, Prescription) VALUES
(1, 1, 1, 'Heart Checkup', '2025-10-20 10:00:00', '2025-10-21 14:00:00', 'BP Control + Routine Test'),
(2, 2, 1, 'ECG & Monitoring', '2025-10-22 09:00:00', '2025-10-23 16:00:00', 'Rest + Vitamin Supplements');

CREATE TABLE Test_Report (
  P_id INT,
  T_id INT,
  Result VARCHAR(50),
  Test_type VARCHAR(50),
  PRIMARY KEY (P_id, T_id),
  FOREIGN KEY (P_id) REFERENCES Patient(P_id),
  FOREIGN KEY (T_id) REFERENCES Treatment(T_id)
);

INSERT INTO Test_Report VALUES
(1, 1, 'Normal', 'Blood Test'),
(2, 2, 'Slight Abnormality', 'ECG');

CREATE TABLE Bills (
  B_id INT AUTO_INCREMENT PRIMARY KEY,
  P_id INT,
  Bill_amount DOUBLE,
  Mode_of_payment VARCHAR(30),
  Date_of_payment DATETIME,
  FOREIGN KEY (P_id) REFERENCES Patient(P_id)
);

INSERT INTO Bills (P_id, Bill_amount, Mode_of_payment, Date_of_payment) VALUES
(1, 15000.50, 'Cash', '2025-10-21 15:00:00'),
(2, 22000.00, 'Card', '2025-10-23 17:00:00');


SELECT p.P_name, b.Bill_amount, b.Date_of_payment
FROM Patient p JOIN Bills b ON p.P_id = b.P_id;

SELECT a.A_id, p.P_name, a.appointment_date, a.appointment_time, a.status
FROM Appointment a JOIN Patient p ON a.P_id = p.P_id
WHERE a.Rec_id = 3;

SELECT t.T_id, p.P_name, r.R_type, t.Treatment_type
FROM Treatment t
JOIN Patient p ON t.P_id = p.P_id
JOIN Rooms r ON t.R_id = r.R_id;

# 1. List All Patients
SELECT * FROM Patient;

# 2. List Female Patients Only
SELECT P_name, P_age, P_gender FROM Patient WHERE P_gender = 'Female';

# 3. Total Number of Patients
SELECT COUNT(*) AS Total_Patients FROM Patient;

# 4. Average Salary of Employees
SELECT AVG(E_salary) AS Average_Salary FROM Employee;

# 5. Highest Bill Paid
SELECT MAX(Bill_amount) AS Highest_Bill FROM Bills;

# 6. List All Appointments with Patient Names
SELECT p.P_name, a.appointment_date, a.appointment_time, a.status
FROM Appointment a
JOIN Patient p ON a.P_id = p.P_id;

# 7. Show Doctor Name and Patient Treated
SELECT d.D_name, p.P_name, t.Treatment_type
FROM Treatment t
JOIN Doctor d ON t.D_id = d.D_id
JOIN Patient p ON t.P_id = p.P_id;

# 8. List Patients Who Paid More Than 15000
SELECT P_name FROM Patient
WHERE P_id IN (
  SELECT P_id FROM Bills WHERE Bill_amount > 15000
);

# 9. Count Treatments per Doctor
SELECT D_id, COUNT(*) AS Total_Treatments
FROM Treatment
GROUP BY D_id;

# 10. Patients with Appointments Handled by 'Ali Khan'
SELECT P_name FROM Patient
WHERE P_id IN (
  SELECT P_id FROM Appointment
  WHERE Rec_id IN (
    SELECT Rec_id FROM Receptionist WHERE Rec_name = 'Ali Khan'
  )
);

# 11. Distinct Departments of Employees
SELECT DISTINCT E_department FROM Employee;

# 12. Bills Ordered by Amount (Descending)
SELECT * FROM Bills ORDER BY Bill_amount DESC;

# 13. Appointment Between Two Dates
SELECT * FROM Appointment
WHERE appointment_date BETWEEN '2025-10-20' AND '2025-10-30';

# 14. Show Patients and Their Room Type
SELECT p.P_name, r.R_type
FROM Treatment t
JOIN Patient p ON t.P_id = p.P_id
JOIN Rooms r ON t.R_id = r.R_id;

# 15. Total Bill per Payment Mode
SELECT Mode_of_payment, SUM(Bill_amount) AS Total_Amount
FROM Bills
GROUP BY Mode_of_payment;

# Security Implementation for hospital_mgmt Database:
# 1. Create Users / Roles
-- Admin role (full access)
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'admin123';

-- Doctor role (limited to patient and treatment)
CREATE USER 'doctor_user'@'localhost' IDENTIFIED BY 'doc123';

-- Receptionist role (limited to appointments and patient)
CREATE USER 'reception_user'@'localhost' IDENTIFIED BY 'rec123';

# 2. Grant Access Privileges (Permissions)
-- Admin gets full control
GRANT ALL PRIVILEGES ON hospital_mgmt.* TO 'admin_user'@'localhost';

-- Doctor can only view patient and treatment details
GRANT SELECT ON hospital_mgmt.Patient TO 'doctor_user'@'localhost';
GRANT SELECT, UPDATE ON hospital_mgmt.Treatment TO 'doctor_user'@'localhost';

-- Receptionist can manage appointments and patient info
GRANT SELECT, INSERT, UPDATE ON hospital_mgmt.Patient TO 'reception_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON hospital_mgmt.Appointment TO 'reception_user'@'localhost';

-- Remove any accidental full privileges
REVOKE DELETE ON hospital_mgmt.Patient FROM 'reception_user'@'localhost';
