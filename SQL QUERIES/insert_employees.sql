-- Insert sample data into employees table
INSERT INTO employees VALUES (10, 'Alice',  'IT',      5000, TO_DATE('2022-01-15', 'YYYY-MM-DD'));
INSERT INTO employees VALUES (11, 'Bob',    'HR',      4500, TO_DATE('2022-01-20', 'YYYY-MM-DD'));
INSERT INTO employees VALUES (12, 'Carol',  'IT',      5200, TO_DATE('2022-02-15', 'YYYY-MM-DD'));
INSERT INTO employees VALUES (13, 'David',  'Finance', 4300, TO_DATE('2022-03-01', 'YYYY-MM-DD'));
INSERT INTO employees VALUES (14, 'Eve',    'HR',      4600, TO_DATE('2022-03-05', 'YYYY-MM-DD'));

-- Commit the changes
COMMIT;
