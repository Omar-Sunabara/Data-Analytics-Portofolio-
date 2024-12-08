WITH BestCountry AS (
    SELECT TOP 1 sp.CountryRegionCode
    FROM Sales.SalesOrderHeader soh
    INNER JOIN Person.Address addr ON soh.BillToAddressID = addr.AddressID
    INNER JOIN Person.StateProvince sp ON addr.StateProvinceID = sp.StateProvinceID
    GROUP BY sp.CountryRegionCode
    ORDER BY SUM(soh.SubTotal) DESC
)
SELECT 
    t.Name AS Region, -- Region name from SalesTerritory
    SUM(soh.SubTotal) AS RegionSales
FROM Sales.SalesOrderHeader soh
INNER JOIN Person.Address addr ON soh.BillToAddressID = addr.AddressID
INNER JOIN Person.StateProvince sp ON addr.StateProvinceID = sp.StateProvinceID
INNER JOIN Sales.SalesTerritory t ON sp.TerritoryID = t.TerritoryID
WHERE sp.CountryRegionCode = (SELECT CountryRegionCode FROM BestCountry)
GROUP BY t.Name
ORDER BY RegionSales DESC;


--This SQL query calculates regional sales for the best-performing country based on total revenue. 
--WITH BestCountry CTE:
--Determines the best-performing country by:
--Aggregating total sales (SUM(soh.SubTotal)) grouped by CountryRegionCode.
--Selecting the top country with the highest total sales (TOP 1).

--Main Query:
--Filters sales to include only regions within the best-performing country.
--Joins data from sales orders (Sales.SalesOrderHeader), addresses, states/provinces, and sales territories to calculate total sales per region.

--Grouping and Sorting:
--Groups results by region (t.Name).
--Calculates total sales for each region (SUM(soh.SubTotal)).
--Sorts the regions by total sales in descending order.