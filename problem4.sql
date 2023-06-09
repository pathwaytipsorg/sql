Id,Name,Salary,ManagerId
1,Joe,70000,3
2,Henry,80000,4
3,Sam,60000,NULL
4,Max,90000,NULL 

--Given the Employee table, write a SQL query that finds out employees who earn more than their managers. 
--For the above table, Joe is the only employee who earns more than his manager.

SELECT e.Name AS Employee
FROM Employee e
JOIN Employee m ON e.ManagerId = m.Id
WHERE e.Salary > m.Salary;
