# 🛒 Blinkit Retail Data Analysis with SQL

## 📌 Project Overview

**Project Title**: Blinkit Sales & Outlet Analysis  
**Level**: Beginner – Intermediate  
**Database Table**: `blinkit_data`

This project focuses on data cleaning, transformation, and exploratory SQL analysis of the Blinkit sales dataset. Using **Microsoft SQL Server**, the project explores multiple business KPIs including total sales, customer preferences by item fat content, sales trends by outlet size and location, and overall outlet performance metrics.

---

## 🧽 Data Cleaning & Preparation

Standardized `Item_Fat_Content` values for consistency in reporting:

```sql
UPDATE blinkit_data
SET Item_Fat_Content = 
    CASE 
        WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
        WHEN Item_Fat_Content = 'reg' THEN 'Regular'
        ELSE Item_Fat_Content
    END;
```

Check cleanup success:
```sql
SELECT DISTINCT Item_Fat_Content FROM blinkit_data;
```

---

## 📊 KPI Metrics

### A. Key Metrics Overview

- **Total Sales (in Millions):**
```sql
SELECT CAST(SUM(Total_Sales) / 1000000.0 AS DECIMAL(10,2)) AS Total_Sales_Million FROM blinkit_data;
```

- **Average Sales per Transaction:**
```sql
SELECT CAST(AVG(Total_Sales) AS INT) AS Avg_Sales FROM blinkit_data;
```

- **Total Number of Orders:**
```sql
SELECT COUNT(*) AS No_of_Orders FROM blinkit_data;
```

- **Average Product Rating:**
```sql
SELECT CAST(AVG(Rating) AS DECIMAL(10,1)) AS Avg_Rating FROM blinkit_data;
```

---

### B. Sales by Item Fat Content
```sql
SELECT Item_Fat_Content, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Item_Fat_Content;
```

---

### C. Sales by Item Type
```sql
SELECT Item_Type, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales DESC;
```

---

### D. Fat Content by Outlet (Pivot Table)
```sql
SELECT Outlet_Location_Type, 
       ISNULL([Low Fat], 0) AS Low_Fat, 
       ISNULL([Regular], 0) AS Regular
FROM 
(
    SELECT Outlet_Location_Type, Item_Fat_Content, 
           CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
    FROM blinkit_data
    GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT 
(
    SUM(Total_Sales) 
    FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY Outlet_Location_Type;
```

> 📌 **Explanation**: This pivot query shows total sales for each `Outlet_Location_Type` split by `Item_Fat_Content`. `ISNULL` ensures missing values appear as `0`.

---

### E. Total Sales by Outlet Establishment Year
```sql
SELECT Outlet_Establishment_Year, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year;
```

---

### F. Percentage of Sales by Outlet Size
```sql
SELECT 
    Outlet_Size, 
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;
```

> 📌 **Explanation**: This query calculates what percentage of total sales each `Outlet_Size` contributes to the overall sales.

---

### G. Sales by Outlet Location
```sql
SELECT Outlet_Location_Type, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;
```

---

### H. Summary Metrics by Outlet Type
```sql
SELECT Outlet_Type, 
       CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
       CAST(AVG(Total_Sales) AS DECIMAL(10,0)) AS Avg_Sales,
       COUNT(*) AS No_Of_Items,
       CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
       CAST(AVG(Item_Visibility) AS DECIMAL(10,2)) AS Item_Visibility
FROM blinkit_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;
```

---

## ✅ Conclusion

This project demonstrates practical SQL data analysis on retail data from Blinkit. Key takeaways include:

- Cleaning and transforming raw fields to enable better reporting.
- Creating KPIs like total sales, average rating, and item counts.
- Performing aggregations by product, fat content, outlet type, and establishment year.
- Using `PIVOT` and window functions to derive meaningful business insights.

The project can be extended by building visual dashboards in **Power BI** or **Tableau** using these queries as a data source.

---
