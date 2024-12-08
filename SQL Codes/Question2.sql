-- Question 2: What is the relationship between annual leave taken and bonus?

-- Selected the following columns to show
SELECT 
	e.BusinessEntityID,
	p.FirstName,
	p.LastName,
	e.VacationHours,
	sp.Bonus, 
	e.JobTitle

-- Used an INNER JOIN to combine Employee table to Person table (To get name information)
FROM HumanResources.Employee AS e
JOIN Person.Person AS p 

-- Joined using Business entity ID column
ON e.BusinessEntityID = p.BusinessEntityID

-- Used LEFT JOIN to combine Employee table and the SalesPerson table (To get bonus information)
LEFT JOIN Sales.SalesPerson AS sp 
ON e.BusinessEntityID = sp.BusinessEntityID 

-- Filtered bonus so that it is greater than 0 (To only show employees who have recieved a bonus)
WHERE sp.Bonus > 0
ORDER BY e.VacationHours DESC;
 
 

