-- 1. Compare salary with previous and next values
SELECT emp_id, emp_name, salary,
       LAG(salary) OVER (ORDER BY emp_id) AS prev_salary,
       LEAD(salary) OVER (ORDER BY emp_id) AS next_salary,
       CASE
         WHEN salary > LAG(salary) OVER (ORDER BY emp_id) THEN 'HIGHER'
         WHEN salary < LAG(salary) OVER (ORDER BY emp_id) THEN 'LOWER'
         ELSE 'EQUAL'
       END AS compare_prev
FROM employees;

-- 2. RANK() and DENSE_RANK() within department
SELECT emp_id, emp_name, department, salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_salary,
       DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dense_rank_salary
FROM employees;

-- 3. Top 3 salaries per department
SELECT * FROM (
  SELECT emp_id, emp_name, department, salary,
         RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk
  FROM employees
) WHERE rnk <= 3;

-- 4. First 2 employees per department by hire date
SELECT * FROM (
  SELECT emp_id, emp_name, department, hire_date,
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY hire_date) AS row_num
  FROM employees
) WHERE row_num <= 2;

-- 5. Aggregation: MAX salary in department vs overall
SELECT emp_id, emp_name, department, salary,
       MAX(salary) OVER (PARTITION BY department) AS max_in_dept,
       MAX(salary) OVER () AS overall_max
FROM employees;
