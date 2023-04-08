//Find the hierarchy of employees under a given manager in SQL

//Create a table named employees_details with columns id, name, manager_id, salary, and designation i
CREATE TABLE `demo.employee_dataset.employees_details`  (
    id INT64,
    name STRING,
    manager_id INT64,
    salary FLOAT64,
    designation STRING
);

//INSERT queries that you can use to insert data into the employees_details table with columns id, name, manager_id, salary, and designation
INSERT INTO `demo.employee_dataset.employees_details` (id, name, manager_id, salary, designation)
VALUES (1, 'John Doe', NULL, 100000, 'CEO');

INSERT INTO `demo.employee_dataset.employees_details` (id, name, manager_id, salary, designation)
VALUES (2, 'Jane Smith', 1, 80000, 'Manager');

INSERT INTO `demo.employee_dataset.employees_details` (id, name, manager_id, salary, designation)
VALUES (3, 'Bob Johnson', 1, 80000, 'Manager');

INSERT INTO `demo.employee_dataset.employees_details` (id, name, manager_id, salary, designation)
VALUES (4, 'Alice Brown', 2, 60000, 'Senior Developer');

INSERT INTO `demo.employee_dataset.employees_details` (id, name, manager_id, salary, designation)
VALUES (5, 'Charlie Davis', 2, 60000, 'Senior Developer');

INSERT INTO `demo.employee_dataset.employees_details` (id, name, manager_id, salary, designation)
VALUES (6, 'Dave Evans', 3, 60000,'Senior Developer');

INSERT INTO `demo.employee_dataset.employees_details` (id,name ,manager_id,salary ,designation )
VALUES(7,'Eve Foster',3 ,60000 ,'Senior Developer');

INSERT INTO `demo.employee_dataset.employees_details`(id,name ,manager_id,salary ,designation )
VALUES(8,'Frank Green',4 ,40000 ,'Developer');

INSERT INTO `demo.employee_dataset.employees_details`(id,name ,manager_id,salary ,designation )
VALUES(9,'Grace Hall',4 ,40000 ,'Developer');

INSERT INTO `demo.employee_dataset.employees_details`(id,name ,manager_id,salary ,designation )
VALUES(10,'Henry Irwin',5 ,40000 ,'Developer');

//Find the hierarchy of employees under a given manager in SQL
WITH RECURSIVE employee_hierarchy (id, name, manager_id) AS (
    SELECT id, name, manager_id
    FROM employees
    WHERE manager_id = [given_manager_id]
    UNION ALL
    SELECT e.id, e.name, e.manager_id
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.id
)
SELECT * FROM employee_hierarchy;

or
WITH RECURSIVE employee_hierarchy  AS (
    SELECT id, name, manager_id
    FROM `demo.employee_dataset.employees_details`
    WHERE manager_id = 1
    UNION ALL
    SELECT e.id, e.name, e.manager_id
    FROM `demo.employee_dataset.employees_details` e
    JOIN `demo.employee_dataset.employees_details` eh 
    ON e.manager_id = eh.id WHERE e.manager_id = 1
)
SELECT distinct * FROM employee_hierarchy order by manager_id;

//Find the hierarchy of managers for a given employee in SQL
WITH RECURSIVE manager_hierarchy (id, name, manager_id) AS (
    SELECT id, name, manager_id
    FROM employees
    WHERE id = [given_employee_id]
    UNION ALL
    SELECT e.id, e.name, e.manager_id
    FROM employees e
    JOIN manager_hierarchy mh ON e.id = mh.manager_id
)
SELECT * FROM manager_hierarchy;

