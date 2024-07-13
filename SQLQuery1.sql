Select * 
From PizzaProject..pizza_sales 
Order by 1,2 

--KPI

--View total Revenue
Select Sum(total_price) As Total_Revenue 
From pizza_sales

--View average order value
Select Sum(total_price)/ Count(Distinct order_id) As Average_Order_Value
From PizzaProject..pizza_sales

--Total Pizzas Sold
Select Sum(quantity) As total_pizza_sold
From PizzaProject..pizza_sales

--Total Orders
Select Count(Distinct order_id) As total_orders
From PizzaProject..pizza_sales

--Average Pizzas Per Order
Select CAST(CAST(SUM(quantity) As DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) As DECIMAL(10,2)) As DECIMAL(10,2))
As Avg_Pizzas_per_order
From pizza_sales

--DAILY TREND FOR TOTAL ORDERS
Select DATENAME(DW, order_date) As order_day, Count(DISTINCT order_id) AS total_orders 
From pizza_sales
Group by DATENAME(DW, order_date)

--MONTHLY TREND FOR TOTAL ORDERS
Select DATENAME(MONTH, order_date) As Month_name, Count(Distinct order_id) AS total_orders 
From pizza_sales
Group by DATENAME(MONTH, order_date)
Order by 2 desc

--PERCENTAGE OF SALES BY PIZZA CATEGORY
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category

--Percentage of Sales by Pizza Size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size

--Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

--Top 5 Pizzas by Revenue
SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

--Bottom 5 Pizzas by Revenue
SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC

--Top 5 Pizzas by Quantity
SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC

--Bottom 5 Pizzas by Quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC

--Top 5 Pizzas by Total Orders
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC

--Borrom 5 Pizzas by Total Orders
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC
