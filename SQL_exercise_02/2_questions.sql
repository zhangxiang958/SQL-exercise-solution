-- LINK : https://en.wikibooks.org/wiki/SQL_Exercises/Employee_management
-- 2.1 Select the last name of all employees.
SELECT lastname FROM employees;
-- 2.2 Select the last name of all employees, without duplicates.
SELECT lastname FROM employees WHERE lastname != 'duplicates';
-- 2.3 Select all the data of employees whose last name is "Smith".
SELECT * FROM employees WHERE lastname = 'smith';
-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".
SELECT * FROM employees WHERE lastname IN ('smith', 'doe');
-- 2.5 Select all the data of employees that work in department 14.
SELECT * FROM employees WHERE department = 14;
-- 2.6 Select all the data of employees that work in department 37 or department 77.
SELECT * FROM employees WHERE department IN (37, 77);
-- 2.7 Select all the data of employees whose last name begins with an "S".
SELECT * FROM employees WHERE lastname LiKE 'S%';
-- 2.8 Select the sum of all the departments' budgets.
SELECT SUM(budget) FROM department;
-- 2.9 Select the number of employees in each department (you only need to show the department code and the number of employees).
SELECT COUNT(SSN), code FROM employees, department WHERE employees.department = department.code GROUP BY employees;
-- 2.10 Select all the data of employees, including each employee's department's data.
SELECT * FROM employees, department WHERE employees.department = department.code;
-- 2.11 Select the name and last name of each employee, along with the name and budget of the employee's department.
SELECT name, lastname, department.name AS departmentname, budget FROM employees, department WHERE employees.department = department.code;
-- 2.12 Select the name and last name of employees working for departments with a budget greater than $60,000.
SELECT name, lastname FROM employees, department WHERE department.budget > 60000;
-- 2.13 Select the departments with a budget larger than the average budget of all the departments.
SELECT * FROM department WHERE budget > (SELECT AVG(budget) FROM department);
-- 2.14 Select the names of departments with more than two employees.
SELECT name FROM (SELECT COUNT(*) AS employeesCount, department FROM employees GROUP BY department) count WHERE employeesCount > 2;
-- 2.15 Very Important - Select the name and last name of employees working for departments with second lowest budget.
SELECT name, lastname FROM employees, department 
WHERE employees.department IN 
(SELECT code FROM department ORDER BY budget ASC HAVING budget = 
 (SELECT budget FROM department ORDER BY budget ASC LIMIT 1, 1)
);
-- 2.16  Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. 
INSERT INTO department VALUES(11, 'Quality ASssurance', 40000);
-- And Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
INSERT INTO employees VALUES('847-21-9811', 'Mary', 'Moore', 11);
-- 2.17 Reduce the budget of all departments by 10%.
UPDATE department SET budget = budget * 0.9;
-- 2.18 Reassign all employees from the Research department (code 77) to the IT department (code 14).
UPDATE employees SET department = 14 WHERE department = 77;
-- 2.19 Delete from the table all employees in the IT department (code 14).
DELETE FROM employees WHERE department = 14;
-- 2.20 Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
DELETE FROM employees WHERE department IN (SELECT code FROM department WHERE budget >= 60000);
-- 2.21 Delete from the table all employees.
DELETE FROM employees;
