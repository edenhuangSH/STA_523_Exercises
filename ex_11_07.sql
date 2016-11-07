/* Create a table that has a new column - abv_avg 
which contains how much more (or less) than the average, 
for their department, each person is paid. */

-- On saxon: sqlite3 /data/Sta523/employees.sqlite

SELECT * FROM employees;
-- name        email              salary      dept
-- ----------  -----------------  ----------  ----------
-- Alice       alice@company.com  52000.0     Accounting
-- Bob         bob@company.com    40000.0     Accounting
-- Carol       carol@company.com  30000.0     Sales
-- Dave        dave@company.com   33000.0     Accounting
-- Eve         eve@company.com    44000.0     Sales
-- Frank       frank@comany.com   37000.0     Sales

SELECT AVG(salary) as avg_salary FROM employees GROUP BY dept;

-- avg_salary
-- ----------------
-- 41666.6666666667
-- 37000.0

SELECT dept, AVG(salary) as avg_salary FROM employees GROUP BY dept;
-- dept        avg_salary
-- ----------  ----------------
-- Accounting  41666.6666666667
-- Sales       37000.0

SELECT dept, ROUND(AVG(salary),2) as avg_salary FROM employees GROUP BY dept;

-- dept        avg_salary
-- ----------  ----------
-- Accounting  41666.67
-- Sales       37000.0

SELECT * FROM employees NATURAL JOIN (SELECT dept, ROUND(AVG(salary),2) as avg_salary FROM employees GROUP BY dept);

--name        email              salary      dept        avg_salary
------------  -----------------  ----------  ----------  ----------
--Alice       alice@company.com  52000.0     Accounting  41666.67
--Bob         bob@company.com    40000.0     Accounting  41666.67
--Dave        dave@company.com   33000.0     Accounting  41666.67
--Carol       carol@company.com  30000.0     Sales       37000.0
--Eve         eve@company.com    44000.0     Sales       37000.0
--Frank       frank@comany.com   37000.0     Sales       37000.0

SELECT name, email, salary, dept, salary-avg_salary AS abv_avg FROM employees NATURAL JOIN (SELECT dept, ROUND(AVG(salary),2) as avg_salary FROM employees GROUP BY dept);

-- name        email              salary      dept        abv_avg
-- ----------  -----------------  ----------  ----------  ----------
-- Alice       alice@company.com  52000.0     Accounting  10333.33
-- Bob         bob@company.com    40000.0     Accounting  -1666.67
-- Dave        dave@company.com   33000.0     Accounting  -8666.67
-- Carol       carol@company.com  30000.0     Sales       -7000.0
-- Eve         eve@company.com    44000.0     Sales       7000.0
-- Frank       frank@comany.com   37000.0     Sales       0.0