				-- ASSIGNMENT

/*Show records from sales order details table, with tuppels sales order id, order quantity, unit price.
Include total amount due, discount of 10% to each product*/

SELECT 
	SalesOrderID, 
	OrderQty,
	UnitPrice, 
	OrderQty * UnitPrice as total_amount_due,
	(OrderQty * UnitPrice * 0.1) as '10% Discount',
	(OrderQty * UnitPrice * 0.9) as 'Discounted Price'
FROM Sales.SalesOrderDetail


/*extract order date, customer ID, todal due, from the sales order header table. 
Include a new column as next due where the next due is the 
difference of the tax amount from the total due and another column known as
hidden charges which is 20% of the neXt due. Show this for only items that do not have a purchase order number*/

SELECT 
    OrderDate,
    CustomerID,
    TotalDue,
    TaxAmt,
    TotalDue - TaxAmt AS next_due,
    (TotalDue - TaxAmt) * 0.2 AS hidden_charges
FROM Sales.SalesOrderHeader
WHERE PurchaseOrderNumber IS NULL;


/*1. Retrieve information about the products with color values except null, Red, silver/black, white and list price between £75 and £750.
Rename the column StandardCost to price. Also, sort the result in descending order by list price*/

SELECT
	ProductId,
	Color,
	StandardCost as Price
FROM Production.Product
WHERE Color IS NOT NULL
AND Color NOT IN ('red', 'silver/black', 'white')
AND ListPrice between 75 and 750
order by ListPrice desc

/*2.Find all the male employees born between 1962 to 1970 and with hire date greater than 2001 
and female employees born between 1972 and 1975 and hire date between 2001 and 2002.*/

--for male
select *
from HumanResources.Employee
where Gender ='m' and YEAR(BirthDate) between 1962 and 1970 and YEAR(HireDate)>2001
or --and
--for female
Gender ='f' and YEAR(BirthDate) between 1972 and 1975 and YEAR(HireDate) between 2001 and 2002


/*3. From the sales.salesorderheader table write a query in SQL to find the average and the sum of the subtotal for every customer. 
Return customerid, average and sum of the subtotal. Group the result on customerid and salespersonid. 
Sort the result on customerid column in descending order */

SELECT 
	CustomerID, 
	SalesPersonID, 
    AVG(SubTotal) AS Average_SubTotal,
    SUM(SubTotal) AS Total_SubTotal
FROM Sales.SalesOrderHeader
GROUP BY CustomerID, SalesPersonID
ORDER BY CustomerID DESC;


/*4. From the production.productinventory table write a query in SQL to retrieve total quantity of each productid which are in shelf of 'A' or 'C' or 'H'. 
Filter the results for sum quantity is more than 500. Return productid and sum of the quantity. 
Sort the results according to the productid in ascending order.*/

SELECT 
	ProductID, 
	SUM(Quantity) AS Total_Quantity
FROM Production.ProductInventory
WHERE Shelf IN ('A', 'C', 'H')
GROUP BY ProductID
HAVING SUM(Quantity) > 500
ORDER BY ProductID ASC;


/*5. From the Sales.SalesOrderHeader table write a query in SQL to retrieve the total sales for each year. 
Return the year part of order date and total due amount. Sort the result in ascending order on year part of order date.*/

SELECT 
	YEAR(OrderDate) AS OrderYear, 
    SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear ASC;
