

Welcome to **Not_Null**, where smart queries meet teamwork and good humor!  
This is our official submission for the **SQL Window Functions** assignment using **Oracle 21c**.

> **Team Members:**  
> - Shema Placide (ID: 26497)  
> - Nziza Prince (ID: 26651)  
> 👨‍🏫 **Lecturer:** [Maniraguha Eric](https://github.com/ericmaniraguha)

---

## 🎯 Objective

Our mission: Use SQL Window Functions to analyze and compare employee data in real-world scenarios.  
This project demonstrates practical usage of:

- `LAG()` & `LEAD()` – Compare values across rows  
- `RANK()` & `DENSE_RANK()` – Rank employees by salary  
- `ROW_NUMBER()` – Find the earliest employees  
- `MAX() OVER` – Perform aggregation within and across partitions

---

## 🗃️ Dataset: `employees`

We created a dataset simulating employees in different departments:

```sql
CREATE TABLE employees (
  emp_id     NUMBER PRIMARY KEY,
  emp_name   VARCHAR2(100),
  department VARCHAR2(50),
  salary     NUMBER,
  hire_date  DATE
);
```

### 📥 Sample Data Inserted

![Insert Data](https://github.com/user-attachments/assets/0ea26e63-38af-4de0-a442-7b5e09de7621)

---

## 🔍 SQL Window Function Queries

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
- 📌 **Purpose:** Track salary progression or regression between rows.
- 🧠 **Use Case:** HR salary analysis.

---

### 🥇 Ranking Salaries Per Department – `RANK()` vs `DENSE_RANK()`
```sql
RANK() OVER (PARTITION BY department ORDER BY salary DESC)
DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC)
```
- 📌 **Purpose:** Identify top earners in each department.
- 🧠 **Use Case:** For bonuses, performance reviews.

---

### 🏆 Top 3 Salaries Per Department
![Top 3 Salaries](https://github.com/user-attachments/assets/dc69c589-6adb-4e10-aa41-64963e98349e)

---

### ⏳ First 2 Employees per Department – `ROW_NUMBER()`
![First 2 Employees A](https://github.com/user-attachments/assets/6e760cfd-49d6-452e-9d82-170fa6903911)  
![First 2 Employees B](https://github.com/user-attachments/assets/baf7d620-921f-4269-ad0c-8368d150130d)  
![First 2 Employees C](https://github.com/user-attachments/assets/edf0d908-69c6-4c67-ba88-f1ead7c073c6)

- 📌 **Purpose:** Determine the earliest hires per department.
- 🧠 **Use Case:** HR loyalty tracking or retirement planning.

---

### 📊 Aggregation: `MAX()` in Group vs Overall
```sql
MAX(salary) OVER (PARTITION BY department) AS max_in_dept
MAX(salary) OVER () AS overall_max
```
- 📌 **Purpose:** Compare employee salary against departmental and company-wide max.
- 🧠 **Use Case:** Benchmarking and identifying outliers.

---

## 🧠 Real-Life Applications

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



Thank you for taking the time to explore our project!

Your interest means a lot to us — whether you're a fellow student, a curious developer, or a potential recruiter. We hope this walkthrough of SQL Window Functions was not only informative but also enjoyable to read and learn from.

If you have any feedback, suggestions, or just want to geek out over SQL — feel free to connect.

Until then, keep your queries optimized and your `NULLs` handled 😉

> **With appreciation,**  
> **The Not_Null Team**



