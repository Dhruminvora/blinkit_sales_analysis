-- Viewing Entire Data SET
SELECT * FROM blinkit_data;

----------------------------------------------------------------------------------------------------------------------------------

-- CLeaning Data to perform further operations on it
UPDATE blinkit_data
SET Item_Fat_Content = 
CASE WHEN Item_Fat_Content IN ('LF', 'low fat')
     THEN 'Low Fat'
     WHEN Item_Fat_Content = ('reg')
     THEN 'Regular'
ELSE Item_Fat_Content
END;

SELECT DISTINCT(Item_Fat_Content) FROM blinkit_data;

----------------------------------------------------------------------------------------------------------------------------------
-- Finding Overall Revenue Generated from all items sold using Aggregate Functions and rounding the amount to Millions
SELECT CONCAT(CAST(SUM(Total_Sales)/ 1000000 AS DECIMAL(10,2)), ' millions') Total_Revenue_Millions
FROM blinkit_data;

----------------------------------------------------------------------------------------------------------------------------------

--Finding Average Revenue per sale
SELECT CAST(AVG(Total_Sales) AS DECIMAL(10,0)) Average_Sales FROM blinkit_data;

----------------------------------------------------------------------------------------------------------------------------------

-- Finding the Total Count of Items Sold using COUNT Function
SELECT COUNT(*) Number_of_items FROM blinkit_data;

----------------------------------------------------------------------------------------------------------------------------------

-- Finding the average customer rating using Aggregate Functions(AVG) and then rounding the value to 2 decimal points
SELECT CAST(AVG(Rating) AS DECIMAL(10,2)) Average_Rating FROM blinkit_data;

----------------------------------------------------------------------------------------------------------------------------------

-- Analyzing the impact of Fat Contenet on Total Sales, Average Sales, Number of Items Sold And Average Rating for the same
SELECT Item_Fat_Content, 
       CAST(SUM(Total_Sales) AS DECIMAL(10,2)) Total_Revenue,
       CAST(AVG(Total_Sales) AS DECIMAL(10,2)) Average_Sales,
       COUNT(*) Number_of_items,
       CAST(AVG(Rating) AS DECIMAL(10,2)) Average_Rating
FROM blinkit_data
GROUP BY Item_Fat_Content
ORDER BY Total_Revenue DESC;

----------------------------------------------------------------------------------------------------------------------------------

-- Identifying the performance of different item types in terms of total sales
SELECT Item_Type, 
       CAST(SUM(Total_Sales) AS DECIMAL(10,2)) Total_Revenue,
       CAST(AVG(Total_Sales) AS DECIMAL(10,2)) Average_Sales,
       COUNT(*) Number_of_items,
       CAST(AVG(Rating) AS DECIMAL(10,2)) Average_Rating
FROM blinkit_data
GROUP BY Item_Type
ORDER BY Total_Revenue DESC;

----------------------------------------------------------------------------------------------------------------------------------

-- Identifying the Total Sales across different outlets in terms of fat content
SELECT Item_Fat_Content, Outlet_Location_Type, 
       CAST(SUM(Total_Sales) AS DECIMAL(10,2)) Total_Revenue,
       CAST(AVG(Total_Sales) AS DECIMAL(10,2)) Average_Sales,
       COUNT(*) Number_of_items,
       CAST(AVG(Rating) AS DECIMAL(10,2)) Average_Rating
FROM blinkit_data
GROUP BY Item_Fat_Content, Outlet_Location_Type
ORDER BY Total_Revenue DESC;

SELECT Outlet_Location_Type,
       SUM(CASE WHEN Item_Fat_Content = 'Low Fat' THEN Total_Sales ELSE 0 END) AS Low_Fat,
       SUM(CASE WHEN Item_Fat_Content = 'Regular' THEN Total_Sales ELSE 0 END) AS Regular
FROM
    blinkit_data
GROUP BY
    Outlet_Location_Type
ORDER BY
    Outlet_Location_Type;

----------------------------------------------------------------------------------------------------------------------------------


SELECT Item_Fat_Content, 
       CAST(SUM(Total_Sales) AS DECIMAL(10,2)) Total_Revenue,
       CAST(AVG(Total_Sales) AS DECIMAL(10,2)) Average_Sales,
       COUNT(*) Number_of_items,
       CAST(AVG(Rating) AS DECIMAL(10,2)) Average_Rating
FROM blinkit_data
GROUP BY Item_Fat_Content
ORDER BY Total_Revenue DESC;