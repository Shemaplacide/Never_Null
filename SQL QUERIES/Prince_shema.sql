-- 1. DROP TABLE IF EXISTS
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE employees PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN -- ignore error if table doesn't exist
         RAISE;
      END IF;
END;
/

-- 1. CREATE TABLE
CREATE TABLE employees (
  emp_id NUMBER PRIMARY KEY,
  emp_name VARCHAR2(100),
  department VARCHAR2(50),
  salary NUMBER,
  hire_date DATE
);

-- 2. INSERT DATA (unique emp_id, matching your data)
INSERT INTO employees VALUES (10, 'Alice', 'IT', 5000, TO_DATE('2022-01-15','YYYY-MM-DD'));
INSERT INTO employees VALUES (11, 'Bob', 'HR', 4500, TO_DATE('2022-01-20','YYYY-MM-DD'));
INSERT INTO employees VALUES (12, 'Carol', 'IT', 5200, TO_DATE('2022-02-15','YYYY-MM-DD'));
INSERT INTO employees VALUES (13, 'David', 'Finance', 4300, TO_DATE('2022-03-01','YYYY-MM-DD'));
INSERT INTO employees VALUES (14, 'Eve', 'HR', 4600, TO_DATE('2022-03-05','YYYY-MM-DD'));

COMMIT;



-- 1. Compare Values with Previous or Next Records

-- LAG() and LEAD() are used to access the previous and next row's salary.
-- This helps in comparing how a particular employee's salary trends over time or position.
-- Real-Life Example: Tracking salary progression or regressions in payroll reports.

SELECT emp_id, emp_name, salary,
       LAG(salary) OVER (ORDER BY emp_id) AS prev_salary,
       LEAD(salary) OVER (ORDER BY emp_id) AS next_salary,
       CASE
         WHEN salary > LAG(salary) OVER (ORDER BY emp_id) THEN 'HIGHER'
         WHEN salary < LAG(salary) OVER (ORDER BY emp_id) THEN 'LOWER'
         ELSE 'EQUAL'
       END AS compare_prev
FROM employees;


--  2. RANK() and DENSE_RANK() within Department

-- RANK() assigns the same rank to duplicates, but leaves gaps.
-- DENSE_RANK() assigns same rank to duplicates, but no gaps.
-- Useful for HR to understand who shares top salary positions in departments.

SELECT emp_id, emp_name, department, salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_salary,
       DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dense_rank_salary
FROM employees;


-- 3. Top 3 Salaries per Department
-- RANK() + filter WHERE rnk <= 3 is used to get top earners per department.
-- Real-Life Example: Identifying top performers for bonuses or promotions.

SELECT * FROM (
  SELECT emp_id, emp_name, department, salary,
         RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk
  FROM employees
) WHERE rnk <= 3;


-- 4. First 2 Employees per Department by Hire Date

-- ROW_NUMBER() ranks based on hire_date.
-- Real-Life Application: HR might use this to find most senior employees.

SELECT * FROM (
  SELECT emp_id, emp_name, department, hire_date,
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY hire_date) AS row_num
  FROM employees
) WHERE row_num <= 2;


-- 5. Window Aggregation – Max in Category vs Overall

-- MAX() OVER (PARTITION BY ...) gives departmental max.
-- MAX() OVER () gives global max.
-- Helps in benchmarking salaries and identifying outliers.

SELECT emp_id, emp_name, department, salary,
       MAX(salary) OVER (PARTITION BY department) AS max_in_dept,
       MAX(salary) OVER () AS overall_max
FROM employees;
