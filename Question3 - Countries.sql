SELECT 
    c.Name AS Country,
    SUM(soh.SubTotal) AS Revenue
FROM Sales.SalesOrderHeader AS soh
INNER JOIN Person.Address AS a ON soh.BillToAddressID = a.AddressID
INNER JOIN Person.StateProvince AS sp ON a.StateProvinceID = sp.StateProvinceID
INNER JOIN Person.CountryRegion AS c ON sp.CountryRegionCode = c.CountryRegionCode
GROUP BY c.Name
ORDER BY Revenue DESC;
