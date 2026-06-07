orders
CREATE TABLE Orders (

Order_ID VARCHAR(50),
Order_Date DATE,
Ship_Date DATE,

Customer_ID VARCHAR(50),
Customer_Name VARCHAR(100),

Segment VARCHAR(50),
Country VARCHAR(50),
City VARCHAR(100),
State VARCHAR(100),
Region VARCHAR(50),

Category VARCHAR(50),
Sub_Category VARCHAR(50),

Product_Name TEXT,

Sales DECIMAL(10,2),
Quantity INT,
Discount DECIMAL(5,2),
Profit DECIMAL(10,2)

);

SELECT *
FROM Orders
LIMIT 10;


SELECT

SUM(Sales) AS Total_Sales,

SUM(Profit) AS Total_Profit,

ROUND(
(SUM(Profit)/SUM(Sales))*100,
2
)

AS Profit_Margin_Percent

FROM Orders;


SELECT

Region,

ROUND(SUM(Sales),2) AS Total_Sales,

ROUND(SUM(Profit),2) AS Total_Profit

FROM Orders

GROUP BY Region

ORDER BY Total_Sales DESC;


SELECT

Category,

ROUND(SUM(Sales),2) AS Total_Sales,

ROUND(SUM(Profit),2) AS Total_Profit

FROM Orders

GROUP BY Category

ORDER BY Total_Sales DESC;


SELECT

DATE_FORMAT(
Order_Date,
'%Y-%m'
) AS MonthYear,

ROUND(
SUM(Sales),2
) AS Monthly_Sales

FROM Orders

GROUP BY MonthYear

ORDER BY MonthYear;

SELECT

Customer_Name,

ROUND(
SUM(Sales),2
) AS Total_Sales

FROM Orders

GROUP BY Customer_Name

ORDER BY Total_Sales DESC

LIMIT 10;


SELECT

Order_ID,
Product_Name,
Category,
Sales,
Profit

FROM Orders

WHERE Profit < 0

ORDER BY Profit ASC

LIMIT 20;

SELECT

ROUND(

AVG(
DATEDIFF(
Ship_Date,
Order_Date
)
),

2

)

AS Avg_Shipping_Days

FROM Orders;


WITH MonthlySales AS
(

SELECT

DATE_FORMAT(
Order_Date,
'%Y-%m'
) AS MonthYear,

SUM(Sales) AS Sales

FROM Orders

GROUP BY MonthYear

)

SELECT

MonthYear,

ROUND(Sales,2),

ROUND(

LAG(Sales)
OVER(
ORDER BY MonthYear
),

2

)

AS PreviousMonth,

ROUND(

(
Sales -

LAG(Sales)
OVER(
ORDER BY MonthYear)

)

/

LAG(Sales)
OVER(
ORDER BY MonthYear)

*100,

2

)

AS GrowthPercent

FROM MonthlySales;

SELECT

ROUND(SUM(Sales),2) AS Total_Sales,

ROUND(SUM(Profit),2) AS Total_Profit,

ROUND(
(SUM(Profit)/SUM(Sales))*100,
2
)

AS Profit_Margin_Percent

FROM Orders;