WITH XMLNAMESPACES (DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey')
SELECT 
    st.Name,
    CAST(Demographics AS XML).value('(/StoreSurvey/YearOpened)[1]', 'INT') AS YearOpened,
	-- CAST function is being use to extract 'Year Opened' data from an xml metadata file linked in the Demographics column in Sales.Store
    DATEDIFF(YEAR, 
             DATEFROMPARTS(CAST(Demographics AS XML).value('(/StoreSurvey/YearOpened)[1]', 'INT'), 1, 1), 
             '2014-06-30') AS TradingDurationYears, -- Approximate trading duration in years
    -- DATEDIFF function is used to find the trading duration years, by subtracting the current year away from the year the store opened.
    -- DATEFROMPARTS function is being used because SQL needs a full date to use DATEDIFF, hence the '1, 1' section- so 2000 > 1/1/2000 for example.
    -- MAX(OrderDate) FROM Sales.SalesOrderHeader is being used as the last trading year, as the dataset does not extend to the current year 2024. 
    (SELECT SUM(soh.SubTotal) 
     FROM Sales.SalesOrderHeader AS soh
     INNER JOIN Sales.Customer AS sc ON sc.CustomerID = soh.CustomerID
     WHERE sc.StoreID = st.BusinessEntityID) AS Revenue
	 -- Total revenue is aggregated in the Sales.SalesOrderHeader table independently for each StoreID, then joined to Sales.Customer to indentify its respective BusinessEntityID. Then it can be brought back into the main query.
FROM Sales.Store AS st
ORDER BY Revenue DESC;
--No explicit GROUP BY is required because the SUM is handled within the subquery.
