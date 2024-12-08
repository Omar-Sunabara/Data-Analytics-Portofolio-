SELECT 
    sp.Name AS Region, 
    SUM(s.SubTotal) AS RegionalSales -- Total sales in this region
FROM Sales.SalesOrderHeader AS s
INNER JOIN Person.Address AS a ON s.BillToAddressID = a.AddressID
INNER JOIN Person.StateProvince AS sp ON a.StateProvinceID = sp.StateProvinceID
WHERE sp.CountryRegionCode = (
    SELECT TOP 1 
        c.CountryRegionCode 
    FROM Sales.SalesOrderHeader AS s
    INNER JOIN Person.Address AS a ON s.BillToAddressID = a.AddressID
    INNER JOIN Person.StateProvince AS sp ON a.StateProvinceID = sp.StateProvinceID
    INNER JOIN Person.CountryRegion AS c ON sp.CountryRegionCode = c.CountryRegionCode
    GROUP BY c.CountryRegionCode
    ORDER BY SUM(s.SubTotal) DESC 
)
GROUP BY sp.Name
ORDER BY RegionalSales DESC;


--This SQL query calculates regional sales for the best-performing country by total revenue. 

--Main Query:
--Groups sales by regions (sp.Name) and calculates total sales (SUM(s.SubTotal)) for each region.
--Uses joins to link sales orders (Sales.SalesOrderHeader) to regions (Person.StateProvince) via billing addresses.

--Subquery:
--Identifies the best-performing country by:
--Summing sales (SUM(s.SubTotal)) grouped by country (c.CountryRegionCode).
--Selecting the country with the highest total sales (SELECT TOP 1 ... ORDER BY SUM(s.SubTotal) DESC).

--Filtering:
--Filters the main query to include only regions within the best-performing country (sp.CountryRegionCode).
--Output:

--Returns each region's name and total sales (RegionalSales) in descending order of sales.