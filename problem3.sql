--For each manager, show all the employee's working under them(including themselves)

--STEP 1
SELECT e.id, e.name, eh.id as manager_ids
    FROM (SELECT id, name, id as manager_ids
    FROM `composed-slice-383418.demo.employees_details` WHERE id=1) e
    JOIN `composed-slice-383418.demo.employees_details` eh ON e.id = eh.manager_id

--STEP 2
SELECT e.id, e.name, eh.id as manager_ids
    FROM (SELECT e.id, e.name, eh.id as manager_ids
    FROM (SELECT id, name, id as manager_ids
    FROM `composed-slice-383418.demo.employees_details` WHERE id=1) e
    JOIN `composed-slice-383418.demo.employees_details` eh ON e.id = eh.manager_id) e
    JOIN `composed-slice-383418.demo.employees_details` eh ON e.manager_ids = eh.manager_id

--STEP 3
WITH RECURSIVE employee_hierarchy  AS (
    SELECT id, name, id as manager_ids
    FROM `composed-slice-383418.demo.employees_details`
    UNION ALL
    SELECT e.id, e.name, eh.id as manager_ids
    FROM employee_hierarchy e
    JOIN `composed-slice-383418.demo.employees_details` eh ON e.manager_ids = eh.manager_id
)
SELECT * FROM employee_hierarchy order by id,manager_ids;

--Alternate Approach

SELECT e.id, e.name, eh.manager_ids
    FROM ( SELECT id, name, id as manager_ids
    FROM `composed-slice-383418.demo.employees_details` WHERE id=1) eh
    JOIN `composed-slice-383418.demo.employees_details` e ON e.manager_id = eh.id

SELECT * FROM employee_hierarchy ORDER BY manager_ids, id;
--
WITH RECURSIVE employee_hierarchy AS (
    SELECT id, name, id as manager_ids
    FROM `composed-slice-383418.demo.employees_details`
    UNION ALL
    SELECT e.id, e.name, eh.manager_ids
    FROM employee_hierarchy eh
    JOIN `composed-slice-383418.demo.employees_details` e ON e.manager_id = eh.id
)
SELECT * FROM employee_hierarchy ORDER BY manager_ids, id;
