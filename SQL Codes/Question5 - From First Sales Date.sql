-- Question 5 - Using the first sales order date

SELECT 
    st.Name AS StoreName, 
    DATEDIFF(YEAR, MIN(soh.OrderDate), GETDATE()) AS TradingDurationYears, -- Approximate trading duration
    SUM(soh.SubTotal) AS Revenue -- Total revenue
FROM Sales.Store AS st
INNER JOIN Sales.Customer AS sc ON st.BusinessEntityID = sc.StoreID -- Adjust based on actual link
INNER JOIN Sales.SalesOrderHeader AS soh ON sc.CustomerID = soh.CustomerID -- Join sales with customers
GROUP BY st.Name
ORDER BY Revenue DESC;
