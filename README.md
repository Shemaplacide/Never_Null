# Never_Null – SQL Window Functions 🚀

Welcome to **Never_Null**, where smart queries meet teamwork and good humor!  
This is our official submission for the **SQL Window Functions** assignment using **Oracle 21c**.

> **Team Members:**  
> - Shema Placide (ID: 26497)  
> - Nziza Prince (ID: 26651)  
> 👨‍🏫 **Lecturer:** [Maniraguha Eric](https://github.com/ericmaniraguha)

---


## 🎯 Explanations

This folder contains all the SQL scripts related to our Window Functions assignment using **Oracle 21c**.  
The scripts are organized and written to demonstrate **analytical queries** applied on a simple `employees` dataset.  
Each file reflects a key step in completing the assignment.  
All scripts are intended to be run inside **Oracle SQL Developer** or any Oracle 21c-compatible environment.

---

## 📸 Screenshots

### ✅ Table Creation: `employees`
```sql
CREATE TABLE employees (
  emp_id     NUMBER PRIMARY KEY,
  emp_name   VARCHAR2(100),
  department VARCHAR2(50),
  salary     NUMBER,
  hire_date  DATE
);

```
![Create tables](https://github.com/user-attachments/assets/ee403013-68b9-4a3a-a4b0-9b9021d7a7ed)

![table created](https://github.com/user-attachments/assets/7095314c-0d4c-4480-bf09-1e581ae3aa91)

> 📌 This table simulates employees across various departments for analysis.

### 📥 Sample Data Inserted

![Inserted Employes](https://github.com/user-attachments/assets/b98897f8-c673-4ddd-86a4-22bfd1d37dd0)


### 🏆 Top 3 Salaries Per Department

![3  Top 3 Salaries per Department](https://github.com/user-attachments/assets/a54b0d96-cbf8-457f-b5ec-870575ba3486)

![3  Top 3 Salaries A](https://github.com/user-attachments/assets/80cf00f3-bcf3-494c-9f91-aedde96696df)


![3  Top 3 Salaries B](https://github.com/user-attachments/assets/f864309c-c941-4981-9fcc-f41325e9f1cf)



### ⏳ First 2 Employees per Department

![4  First 2 Employees](https://github.com/user-attachments/assets/af3c4834-65b2-4c94-8445-8f3712eca6cc)

![First 2 Employees B](https://github.com/user-attachments/assets/baf7d620-921f-4269-ad0c-8368d150130d)  
![First 2 Employees C](https://github.com/user-attachments/assets/edf0d908-69c6-4c67-ba88-f1ead7c073c6)

---

## 🔍 Findings

### 🔁 Compare Salaries Using `LAG()` and `LEAD()`
```sql
SELECT emp_id, emp_name, salary,
       LAG(salary) OVER (ORDER BY emp_id) AS prev_salary,
       LEAD(salary) OVER (ORDER BY emp_id) AS next_salary,
       CASE
         WHEN salary > LAG(salary) OVER (ORDER BY emp_id) THEN 'HIGHER'
         WHEN salary < LAG(salary) OVER (ORDER BY emp_id) THEN 'LOWER'
         ELSE 'EQUAL'
       END AS compare_prev
FROM employees;
```
Explanation:
This query checks how each employee's salary compares to the person before and after them (based on emp_id). It helps track increases or decreases in pay step-by-step. Useful for salary trend analysis.


### 🥇 Ranking Salaries Per Department – `RANK()` vs `DENSE_RANK()`
```sql
SELECT emp_id, emp_name, department, salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_salary,
       DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dense_rank_salary
FROM employees;
```
Explanation:
This ranks employees within each department by salary. RANK() leaves gaps when salaries tie, while DENSE_RANK() does not. Helps managers see top earners fairly and understand performance levels.

### 🏆 Top 3 Salaries Per Department
```sql
SELECT * FROM (
  SELECT emp_id, emp_name, department, salary,
         RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk
  FROM employees
) WHERE rnk <= 3;
```
Explanation:
Finds the top 3 earners in each department. Very useful when a company wants to reward or promote its best-performing staff.

### ⏳ First 2 Employees per Department – `ROW_NUMBER()`
```sql
SELECT * FROM (
  SELECT emp_id, emp_name, department, hire_date,
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY hire_date) AS row_num
  FROM employees
) WHERE row_num <= 2;
```
Explanation:
Gets the first two employees hired in each department. Ideal for HR to track seniority, loyalty programs, or anniversary celebrations.



### 📊 Aggregation: `MAX()` in Group vs Overall
```sql
SELECT emp_id, emp_name, department, salary,
       MAX(salary) OVER (PARTITION BY department) AS max_in_dept,
       MAX(salary) OVER () AS overall_max
FROM employees;
```
Explanation:
Compares each employee's salary with the maximum in their department and the overall company. Great for spotting high performers or salary outliers.

---

## 🌍 Real-Life Applications

### 1. 🔁 Compare with Previous/Next
```sql
-- Used to track salary progression/regression.
-- Example: Payroll reports, salary audits.
```

### 2. 🏅 Rank with `RANK()` and `DENSE_RANK()`
```sql
-- Understand rank distribution, handle salary ties.
-- Example: Identifying top performers per department.
```

### 3. 🏆 Top Earners
```sql
-- Filter top 3 per department.
-- Example: Quarterly bonus candidates.
```

### 4. ⏳ First Employees
```sql
-- Rank by hire date using ROW_NUMBER().
-- Example: Loyalty recognition or anniversary rewards.
```

### 5. 📊 Aggregation
```sql
-- Compare departmental max vs global max.
-- Example: Detect underpaid or overpaid employees.
```

---

## 🙏 Wrapping Up

Thank you for taking the time to explore our project!

Your interest means a lot to us — whether you're a fellow student, a curious developer, or a potential recruiter.  
We hope this walkthrough of SQL Window Functions was not only informative but also enjoyable to read and learn from.

If you have any feedback, suggestions, or just want to geek out over SQL — feel free to connect.

Until then, keep your queries optimized and your `NULLs` handled 😉

> **With appreciation,**  
> **The Never_Null Team**

---

