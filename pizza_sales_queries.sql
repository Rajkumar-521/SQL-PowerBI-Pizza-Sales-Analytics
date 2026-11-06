-- ================================================
-- PIZZA SALES ANALYTICS - SQL SERVER QUERIES
-- Developed by: Raj Kumar Chadalavada
-- ================================================

-- ------------------------------------------------
-- 1. KEY PERFORMANCE INDICATORS (KPIs)
-- ------------------------------------------------

-- A. Total Revenue
SELECT SUM(total_price) AS Total_Revenue 
FROM pizza_sales;

-- B. Average Order Value (AOV)
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_Order_Value 
FROM pizza_sales;

-- C. Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizzas_Sold 
FROM pizza_sales;

-- D. Total Orders Placed
SELECT COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales;

-- E. Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
       CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_Per_Order 
FROM pizza_sales;


-- ------------------------------------------------
-- 2. TREND & CHART REQUIREMENTS
-- ------------------------------------------------

-- A. Daily Trend for Total Orders (Peak Days)
SELECT DATENAME(DW, order_date) AS order_day, 
       COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)
ORDER BY total_orders DESC;

-- B. Monthly Trend for Total Orders (Peak Months)
SELECT DATENAME(MONTH, order_date) AS Month_Name, 
       COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_Orders DESC;

-- C. Percentage of Sales by Pizza Category
SELECT pizza_category, 
       CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
       CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT_Total_Sales
FROM pizza_sales
GROUP BY pizza_category
ORDER BY PCT_Total_Sales DESC;

-- D. Percentage of Sales by Pizza Size
SELECT pizza_size, 
       CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
       CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT_Total_Sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT_Total_Sales DESC;

-- E. Total Pizzas Sold by Pizza Category
SELECT pizza_category, 
       SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;


-- ------------------------------------------------
-- 3. BEST AND WORST SELLERS ANALYSIS
-- ------------------------------------------------

-- Top 5 Pizzas by Revenue
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;

-- Bottom 5 Pizzas by Revenue
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC;

-- Top 5 Pizzas by Quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC;

-- Bottom 5 Pizzas by Quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC;

-- Top 5 Pizzas by Total Orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC;

-- Bottom 5 Pizzas by Total Orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC;
