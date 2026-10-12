# -JForce-Solutions-SQL-Developer-Stored-Procedure-Task


## Files
- `database.sql`: Creates `jforce_payroll`, creates the `employees` table, and inserts 12 sample employees.
- `procedures.sql`: Creates the four requested stored procedures, including validation and missing-department handling.

## Run in MySQL Workbench
1. Open MySQL Workbench and connect to your MySQL server.
2. Open `database.sql`, click the lightning-bolt **Execute** button, and confirm it completes.
3. Open `procedures.sql` and execute it.
4. Run the test calls below in a query tab (remove the leading `--` from each call).

```sql
USE jforce_payroll;

CALL GetEmployeeSalaryReport('IT', 50000);
CALL CalculateEmployeeSalary(101);
CALL EmployeeSalaryGrade(103);
CALL GetDepartmentSummary('Finance');
CALL GetDepartmentSummary('Legal');
```

## Procedure logic
- `GetEmployeeSalaryReport`: Filters by department, minimum basic salary, and `Active` status.
- `CalculateEmployeeSalary`: HRA = 20%, DA = 10%, PF = 12%; net salary = basic + HRA + DA - PF.
- `EmployeeSalaryGrade`: C below ₹30,000; B from ₹30,000 through ₹60,000; A above ₹60,000.
- `GetDepartmentSummary`: Uses `COUNT`, `AVG`, `MAX`, `MIN`, and `SUM`. If the department has no employee rows, it returns a message.

## Notes
- The script uses `DELIMITER $$`, supported by MySQL Workbench, so procedure bodies can contain semicolons.
- The scripts use `DROP PROCEDURE IF EXISTS` and `DROP TABLE IF EXISTS` to make reruns straightforward. **Warning:** rerunning `database.sql` drops and recreates the sample `employees` table, so it deletes any changes you made to that table.
- `CHECK` constraints are enforced by MySQL 8.0.16 and later.


