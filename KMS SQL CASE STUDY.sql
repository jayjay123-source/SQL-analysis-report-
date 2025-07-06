----- DSA Capstone Project 
-----Kultra Mega Stores Inventory Case Study
-----Candidate Name: Adeiye Akande 


----1. Product Category With The Highest Sale is Technology with Total sales of 5984248.18199998
SELECT TOP 1
  Product_Category,
  SUM(Sales) AS TotalSales
FROM
  [dbo].[KMS Sql Case Study]
GROUP BY
  Product_Category
ORDER BY
  TotalSales DESC;


----2. Top 3 and Bottom 3 regions in terms of sales 
---- Top 3 regions (West, Ontario, Praire)
---- Bottom 3 Regions (Yukon, Northwest Territories, Nunavut)
SELECT
  Region,
  TotalSales,
  SalesRankType
FROM
(
  SELECT TOP 3
    Region,
    SUM(Sales) AS TotalSales,
    'Top' AS SalesRankType
  FROM
    [dbo].[KMS Sql Case Study]
  GROUP BY
    Region
  ORDER BY
    TotalSales DESC
) AS TopRegions

UNION ALL

SELECT
  Region,
  TotalSales,
  SalesRankType
FROM
(
  SELECT TOP 3
    Region,
    SUM(Sales) AS TotalSales,
    'Bottom' AS SalesRankType
  FROM
    [dbo].[KMS Sql Case Study]
  GROUP BY
    Region
  ORDER BY
    TotalSales ASC
) AS BottomRegions
ORDER BY
  SalesRankType DESC, TotalSales DESC;


----3. Total Sales of Appliances In Ontario : There was no sale of any appliance in Ontario
SELECT
  SUM(Sales) AS TotalSalesAppliancesOntario
FROM
  [dbo].[KMS Sql Case Study]
WHERE
  "Product_Category" = 'Appliances' AND Province = 'Ontario';


----4. Advise to the management of KMS on what to do to increase the revenue from the bottom 10 customers
---- a) Targeted marketing campaigns that Offer personalized promotions, discounts, or loyalty programs specifically designed to re-engage these customers



-----5. Shipping Method with the highest Shipping Cost is Delivery Truck with Total shipping Cost of 51971.9399999998
SELECT TOP 1
  "Ship_Mode",
  SUM("Shipping_Cost") AS TotalShippingCost
FROM
  [dbo].[KMS Sql Case Study]
GROUP BY
  "Ship_Mode"
ORDER BY
  TotalShippingCost DESC;

-----Case Scenario II

----6. The most valuable customers, and the products or services they typically purchase

SELECT TOP 5
  "Customer_Name",
  SUM(Sales) AS TotalSales
FROM
  [dbo].[KMS Sql Case Study]
GROUP BY
  "Customer_Name"
ORDER BY
  TotalSales DESC;

  SELECT DISTINCT
  "Customer_Name",
  "Product_Category"
FROM
  [dbo].[KMS Sql Case Study]
WHERE
  "Customer_Name" IN ('Emily Phan', 'Deborah Brumfield', 'Roy Skaria', 'Sylvia Foulston', 'Grant Carroll')
ORDER BY
  "Customer_Name",
  "Product_Category";

-----7. Small business Customer with the highest sales is Dennis Kane with Total sales of 75967.5905
SELECT TOP 1
  "Customer_Name",
  SUM(Sales) AS TotalSales
FROM
  [dbo].[KMS Sql Case Study]
WHERE
  "Customer_Segment" = 'Small Business'
GROUP BY
  "Customer_Name"
ORDER BY
  TotalSales DESC;

-----8. Corporate customer with the most number of orders in 2009-2012 is Adam Hart with 18 orders
SELECT TOP 1
  "Customer_Name",
  COUNT(DISTINCT "Order_ID") AS NumberOfOrders
FROM
  [dbo].[KMS Sql Case Study]
WHERE
  "Customer_Segment" = 'Corporate'
  AND "Order_Date" BETWEEN '2009-01-01' AND '2012-12-31'
GROUP BY
  "Customer_Name"
ORDER BY
  NumberOfOrders DESC;

 ----9. Most Profitable Consumer Customer is Emily Phan with Total profit of 34005.44
SELECT TOP 1
  "Customer_Name",
  SUM(Profit) AS TotalProfit
FROM
  [dbo].[KMS Sql Case Study]
WHERE
  "Customer_Segment" = 'Consumer'
GROUP BY
  "Customer_Name"
ORDER BY
  TotalProfit DESC;

----10. Customer who returned items, and what segment they belong to
SELECT DISTINCT
  T1."Customer_Name",
  T1."Customer_Segment"
FROM
  [dbo].[KMS Sql Case Study] AS T1
JOIN
  [dbo].[Order_Status] AS T2
ON
  T1."Order_ID" = T2."Order_ID"
WHERE
  T2.Status = 'Returned';

----11. If the delivery truck is the most economical but the slowest shipping method and Express Air is the fastest but the most expensive one, do you think the company appropriately spent shipping costs based on the Order Priority 
------Average Shipping Cost By Ship Mode
SELECT
  "Ship_Mode",
  AVG("Shipping_Cost") AS AverageShippingCost
FROM
  [dbo].[KMS Sql Case Study]
GROUP BY
  "Ship_Mode"
ORDER BY
  AverageShippingCost DESC;

  SELECT
  "Ship_Mode",
  "Order_Priority",
  COUNT("Order_ID") AS NumberOfOrders
FROM
  [dbo].[KMS Sql Case Study]
GROUP BY
  "Ship_Mode",
  "Order_Priority"
ORDER BY
  "Ship_Mode",
  CASE
    WHEN "Order_Priority" = 'Critical' THEN 1
    WHEN "Order_Priority" = 'High' THEN 2
    WHEN "Order_Priority" = 'Medium' THEN 3
    WHEN "Order_Priority" = 'Low' THEN 4
    WHEN "Order_Priority" = 'Not Specified' THEN 5
    ELSE 6
  END;

  