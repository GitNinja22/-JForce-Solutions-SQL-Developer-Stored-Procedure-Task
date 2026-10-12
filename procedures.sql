-- Stored Procedures Tasks

DELIMITER $$

-- Task 1: Active employees in a department whose basic salary meets the minimum.
CREATE PROCEDURE GetEmployeeSalaryReport(
    IN p_department_name VARCHAR(50),
    IN p_minimum_salary DECIMAL(10,2)
)
BEGIN
    IF p_department_name IS NULL OR TRIM(p_department_name) = '' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Department name cannot be empty.';
    ELSEIF p_minimum_salary IS NULL OR p_minimum_salary < 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Minimum salary must be zero or greater.';
    ELSE
        SELECT employee_id, employee_name, department, designation,
               basic_salary, joining_date
        FROM employees
        WHERE department = p_department_name
          AND basic_salary >= p_minimum_salary
          AND status = 'Active'
        ORDER BY basic_salary DESC;
    END IF;
END$$

CALL GetEmployeeSalaryReport('IT', 50000);

-- Task 2: Calculate HRA, DA, PF, and net salary for one employee.
CREATE PROCEDURE CalculateEmployeeSalary(
    IN p_employee_id INT
)
BEGIN
    IF p_employee_id IS NULL OR p_employee_id <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Employee ID must be a positive number.';
    ELSEIF NOT EXISTS (
        SELECT 1 FROM employees WHERE employee_id = p_employee_id
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Employee ID was not found.';
    ELSE
        SELECT employee_name,
               basic_salary AS basic_salary,
               ROUND(basic_salary * 0.20, 2) AS HRA,
               ROUND(basic_salary * 0.10, 2) AS DA,
               ROUND(basic_salary * 0.12, 2) AS PF,
               ROUND(basic_salary + (basic_salary * 0.20)
                     + (basic_salary * 0.10) - (basic_salary * 0.12), 2)
                   AS net_salary
        FROM employees
        WHERE employee_id = p_employee_id;
    END IF;
END$$

CALL CalculateEmployeeSalary(101);



-- Task 3: Assign salary grade using CASE.
CREATE PROCEDURE EmployeeSalaryGrade(
    IN p_employee_id INT
)
BEGIN
    IF p_employee_id IS NULL OR p_employee_id <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Employee ID must be a positive number.';
    ELSEIF NOT EXISTS (
        SELECT 1 FROM employees WHERE employee_id = p_employee_id
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Employee ID was not found.';
    ELSE
        SELECT employee_name,
               basic_salary,
               CASE
                   WHEN basic_salary < 30000 THEN 'C'
                   WHEN basic_salary <= 60000 THEN 'B'
                   ELSE 'A'
               END AS salary_grade
        FROM employees
        WHERE employee_id = p_employee_id;
    END IF;
END$$

-- Bonus: Department-level salary statistics.
CREATE PROCEDURE GetDepartmentSummary(
    IN p_department_name VARCHAR(50)
)
BEGIN
    IF p_department_name IS NULL OR TRIM(p_department_name) = '' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Department name cannot be empty.';
    ELSEIF NOT EXISTS (
        SELECT 1 FROM employees WHERE department = p_department_name
    ) THEN
        SELECT CONCAT('Department not found: ', p_department_name) AS message;
    ELSE
        SELECT department,
               COUNT(*) AS total_employees,
               ROUND(AVG(basic_salary), 2) AS average_salary,
               MAX(basic_salary) AS highest_salary,
               MIN(basic_salary) AS lowest_salary,
               SUM(basic_salary) AS total_salary_expenditure
        FROM employees
        WHERE department = p_department_name
        GROUP BY department;
    END IF;
END$$

DELIMITER ;

CALL GetDepartmentSummary('Legal');
