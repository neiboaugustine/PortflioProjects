
-- Total Customers
SELECT COUNT(DISTINCT CustomerKey) AS TotalCustomers
FROM [Sales Data 2022];


--Total Unique Orders
SELECT COUNT(DISTINCT OrderNumber) AS TotalOrders
FROM [Sales Data 2022];


--Total Revenue
SELECT SUM([Sales Data 2022].[OrderQuantity] * [Product Lookup].[ProductPrice]) AS TotalRevenue
FROM [Sales Data 2022]
JOIN [Product Lookup]
    ON [Sales Data 2022].[ProductKey] = [Product Lookup].[ProductKey];


-- Total Profit
SELECT 
    SUM([Sales Data 2022].[OrderQuantity] * [Product Lookup].[ProductPrice]) - SUM([Sales Data 2022].[OrderQuantity] * [Product Lookup].[ProductCost]) AS TotalProfit
FROM 
    [Sales Data 2022]
JOIN 
    [Product Lookup]
    ON [Sales Data 2022].[ProductKey] = [Product Lookup].[ProductKey];


--Total orders by categories
SELECT 
    [Product Categories Lookup].CategoryName,
    COUNT(DISTINCT [Sales Data 2022].OrderNumber) AS TotalOrders
FROM 
    [Sales Data 2022]
JOIN 
    [Product Lookup] ON [Sales Data 2022].ProductKey = [Product Lookup].ProductKey
JOIN 
    [Product Subcategories Lookup] ON [Product Lookup].ProductSubcategoryKey = [Product Subcategories Lookup].ProductSubCategoryKey
JOIN 
	[Product Categories Lookup] ON [Product Subcategories Lookup].ProductCategoryKey = [Product Categories Lookup].ProductCategoryKey
GROUP BY 
    [Product Categories Lookup].CategoryName;


	--Top 15 customers by total revenue
SELECT TOP 15
    [Customer Lookup].FullName,
    SUM([Sales Data 2022].OrderQuantity * [Product Lookup].ProductPrice) AS TotalRevenue
FROM 
    [Sales Data 2022]
JOIN 
    [Customer Lookup] ON [Sales Data 2022].CustomerKey = [Customer Lookup].CustomerKey
JOIN 
    [Product Lookup] ON [Sales Data 2022].ProductKey = [Product Lookup].ProductKey
GROUP BY 
	[Customer Lookup].CustomerKey,
    [Customer Lookup].FullName
ORDER BY 
    TotalRevenue DESC;


-- Top 10 products by revenue
SELECT TOP 10
    [Product Lookup].ProductName,
    SUM([Sales Data 2022].OrderQuantity * [Product Lookup].ProductPrice) AS TotalRevenue
FROM 
    [Sales Data 2022]
JOIN 
    [Product Lookup] ON [Sales Data 2022].ProductKey = [Product Lookup].ProductKey
JOIN 
    [Product Subcategories Lookup] ON [Product Lookup].ProductSubcategoryKey = [Product Subcategories Lookup].ProductSubCategoryKey
JOIN 
    [Product Categories Lookup] ON [Product Subcategories Lookup].ProductCategoryKey = [Product Categories Lookup].ProductCategoryKey
GROUP BY 
    [Product Lookup].ProductName
ORDER BY 
    TotalRevenue DESC;




	--Most ordered product
SELECT TOP 1
    [Product Lookup].ProductName,
    count( distinct [Sales Data 2022].OrderNumber) AS TotalOrders
FROM 
    [Sales Data 2022]
JOIN 
    [Product Lookup] ON [Sales Data 2022].ProductKey = [Product Lookup].ProductKey
JOIN 
    [Product Subcategories Lookup] ON [Product Lookup].ProductSubcategoryKey = [Product Subcategories Lookup].ProductSubCategoryKey
GROUP BY 
    [Product Lookup].ProductName
ORDER BY 
    TotalOrders DESC;


	--Least Ordered Product
SELECT TOP 1
    [Product Lookup].ProductName,
    count( distinct [Sales Data 2022].OrderNumber) AS TotalOrders
FROM 
    [Sales Data 2022]
JOIN 
    [Product Lookup] ON [Sales Data 2022].ProductKey = [Product Lookup].ProductKey
JOIN 
    [Product Subcategories Lookup] ON [Product Lookup].ProductSubcategoryKey = [Product Subcategories Lookup].ProductSubCategoryKey
GROUP BY 
    [Product Lookup].ProductName
ORDER BY 
    TotalOrders ASC;



	--Total Revenue by Continent
SELECT 
    [Territory Lookup].Continent,
    SUM([Sales Data 2022].OrderQuantity * [Product Lookup].ProductPrice) AS TotalRevenue
FROM 
    [Sales Data 2022]
JOIN 
    [Product Lookup] ON [Sales Data 2022].ProductKey = [Product Lookup].ProductKey
JOIN 
    [Customer Lookup] ON [Sales Data 2022].CustomerKey = [Customer Lookup].CustomerKey
JOIN 
    [Territory Lookup] ON [Sales Data 2022].TerritoryKey = [Territory Lookup].SalesTerritoryKey
GROUP BY 
    [Territory Lookup].Continent;


	-- Total revenue by Country
SELECT 
    [Territory Lookup].Country,
    SUM([Sales Data 2022].OrderQuantity * [Product Lookup].ProductPrice) AS TotalRevenue
FROM 
    [Sales Data 2022]
JOIN 
    [Product Lookup] ON [Sales Data 2022].ProductKey = [Product Lookup].ProductKey
JOIN 
    [Customer Lookup] ON [Sales Data 2022].CustomerKey = [Customer Lookup].CustomerKey
JOIN 
    [Territory Lookup] ON [Sales Data 2022].TerritoryKey = [Territory Lookup].SalesTerritoryKey
GROUP BY 
    [Territory Lookup].Country;


	-- Total orders by occupation
SELECT 
    [Customer Lookup].Occupation,
    COUNT(DISTINCT [Sales Data 2022].OrderNumber) AS TotalOrders
FROM 
    [Sales Data 2022]
JOIN 
    [Customer Lookup] ON [Sales Data 2022].CustomerKey = [Customer Lookup].CustomerKey
GROUP BY 
    [Customer Lookup].Occupation;



		-- Total orders by Income Level
SELECT 
    [Customer Lookup].Income_level,
    COUNT(DISTINCT [Sales Data 2022].OrderNumber) AS TotalOrders
FROM 
    [Sales Data 2022]
JOIN 
    [Customer Lookup] ON [Sales Data 2022].CustomerKey = [Customer Lookup].CustomerKey
GROUP BY 
    [Customer Lookup].Income_level;