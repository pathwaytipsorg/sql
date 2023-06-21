--For each manager, show all the employee's working under them(including themselves)

--STEP 1
SELECT e.id, e.name, m.id as associate_id
FROM 
    (SELECT id, name, id as associate_id
    FROM `pathwaytips001.staging.employees_details` WHERE id=1) e
JOIN `pathwaytips001.staging.employees_details` m 
ON e.associate_id = m.manager_id

--STEP 2
SELECT e.id, e.name, m.id as associate_id
FROM 
    (SELECT id, name, id as associate_id
    FROM `pathwaytips001.staging.employees_details`) e
JOIN `pathwaytips001.staging.employees_details` m 
ON e.associate_id = m.manager_id

--STEP 3
WITH RECURSIVE employee_hierarchy  AS (
    SELECT id, name, id as associate_id
    FROM `pathwaytips001.staging.employees_details`
    UNION ALL
    SELECT e.id, e.name, m.id as associate_id
    FROM employee_hierarchy e
    JOIN `pathwaytips001.staging.employees_details` m ON e.associate_id = m.manager_id
)
SELECT * FROM employee_hierarchy order by id,associate_id;
