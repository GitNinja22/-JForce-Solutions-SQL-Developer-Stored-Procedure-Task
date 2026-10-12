-- JForce Solutions: Employee Management and Payroll

CREATE DATABASE IF NOT EXISTS jforce_payroll;
USE jforce_payroll;

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    designation VARCHAR(80) NOT NULL,
    basic_salary DECIMAL(10,2) NOT NULL,
    joining_date DATE NOT NULL,
    status ENUM('Active', 'Inactive') NOT NULL DEFAULT 'Active',
    CONSTRAINT chk_basic_salary CHECK (basic_salary >= 0)
);

INSERT INTO employees
(employee_id, employee_name, department, designation, basic_salary, joining_date, status)
VALUES
(101, 'Aarav Sharma',  'IT','Software Developer', 65000.00, '2022-01-15', 'Active'),
(102, 'Priya Patel',   'IT', 'Data Analyst', 52000.00, '2023-03-10', 'Active'),
(103, 'Rohan Mehta',   'IT', 'Support Engineer',28000.00, '2024-06-01', 'Active'),
(104, 'Neha Singh',    'HR', 'HR Executive',35000.00, '2021-11-20', 'Active'),
(105, 'Vikram Rao',    'HR', 'HR Manager', 72000.00, '2020-07-05', 'Active'),
(106, 'Ananya Iyer',   'Finance', 'Accountant',48000.00, '2022-09-12', 'Active'),
(107, 'Kabir Joshi',   'Finance', 'Finance Manager',     85000.00, '2019-04-18', 'Active'),
(108, 'Meera Nair',    'Operations','Operations Associate',29000.00, '2024-02-26', 'Active'),
(109, 'Ishaan Gupta',  'Operations','Team Lead',61000.00, '2021-05-30', 'Inactive'),
(110, 'Sara Khan',     'Sales', 'Sales Executive',42000.00, '2023-08-14', 'Active'),
(111, 'Dev Malhotra',  'Sales', 'Sales Manager', 78000.00, '2020-12-01', 'Active'),
(112, 'Tara Desai',    'IT',  'QA Engineer',60000.00, '2022-12-19', 'Inactive');

select * from employees;
