SET STATISTICS IO ON 
GO

SET STATISTICS TIME ON
GO

SELECT 
	e.EmployeeID, e.city
FROM 
	Employees e
WHERE
	e.city IN (SELECT city from Customers)


SELECT 
	e.EmployeeID,e.city
FROM 
	Employees e
WHERE
	EXISTS (SELECT c.city FROM Customers c WHERE c.city=e.city)


SELECT 
	DISTINCT (e.EmployeeID), e.city
FROM 
	Employees e
LEFT OUTER JOIN
	Customers c
ON
	e.city = c.city
WHERE
  c.city IS NOT NULL


SELECT 
	DISTINCT (e.EmployeeID), e.city
FROM 
	Employees e
INNER JOIN
	Customers c
ON
	e.city = c.city



SELECT 
	e.EmployeeID, e.city
FROM 
	Employees e
WHERE
	e.city NOT IN (SELECT city from Customers)

SELECT 
	e.EmployeeID, e.city
FROM 
	Employees e
WHERE
	NOT EXISTS (SELECT c.city FROM Customers c WHERE c.city=e.city)

SELECT 
	DISTINCT (e.EmployeeID), e.city
FROM 
	Employees e
LEFT OUTER JOIN
	Customers c
ON
	e.city = c.city
WHERE
  c.city IS NULL

