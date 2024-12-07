WITH XMLNAMESPACES (
    'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey' AS ns
)
SELECT 
    Demographics,
    Demographics.value('(/ns:StoreSurvey/ns:SquareFeet)[1]', 'VARCHAR(100)') AS extracted_squarefeet,
    Demographics.value('(/ns:StoreSurvey/ns:AnnualRevenue)[1]', 'VARCHAR(100)') AS extracted_annual_revenue,
    Demographics.value('(/ns:StoreSurvey/ns:NumberEmployees)[1]', 'VARCHAR(100)') AS extracted_number_employees
FROM Sales.Store
WHERE Demographics.exist('/ns:StoreSurvey') = 1;