# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis 

This project demonstrates essential SQL skills used by data analysts to explore, clean, and analyze retail sales data. It covers database setup, data cleaning, exploratory data analysis (EDA), and answering real business questions using SQL queries. Perfect for beginners building a strong foundation in SQL for data analysis.

## Objectives

1. **Set up a retail sales database**: Create and populate the database with sales data.
2. **Data Cleaning**: Identify and remove records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Understand the dataset through basic analysis.
4. **Business Analysis**: Answer key business questions and derive insights using SQL.

## Project Structure

### 1. Database Setup

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

-- Total records
SELECT COUNT(*) FROM retail_sales;

-- Unique customers
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

-- Unique categories
SELECT DISTINCT category FROM retail_sales;

-- Check for NULL values
SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

-- Remove records with NULL values
DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

3. Data Analysis & Findings

Retrieve all columns for sales made on '2022-11-05':

SQLSELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

Transactions where category is 'Clothing' and quantity ≥ 4 in Nov-2022:

SQLSELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
  AND quantity >= 4;

Total sales and order count for each category:

SQLSELECT 
    category,
    SUM(total_sale) AS net_sale,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;

Average age of customers who purchased from 'Beauty' category:

SQLSELECT ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';

Transactions with total_sale > 1000:

SQLSELECT * FROM retail_sales
WHERE total_sale > 1000;

Total transactions by gender in each category:

SQLSELECT 
    category,
    gender,
    COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY category;

Average sale per month + best selling month each year:

SQLSELECT 
    year,
    month,
    avg_sale
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) 
                    ORDER BY AVG(total_sale) DESC) AS rank
    FROM retail_sales
    GROUP BY year, month
) t1
WHERE rank = 1;

Top 5 customers by total sales:

SQLSELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

Number of unique customers per category:

SQLSELECT 
    category,    
    COUNT(DISTINCT customer_id) AS cnt_unique_cs
FROM retail_sales
GROUP BY category;

Number of orders by shift (Morning <12, Afternoon 12–17, Evening >17):

SQLWITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders    
FROM hourly_sale
GROUP BY shift;

Findings

Customer Demographics: Sales span various age groups across categories like Clothing and Beauty.
High-Value Transactions: Multiple transactions exceeded $1000, showing premium purchases.
Sales Trends: Clear monthly variations help identify peak seasons.
Customer Insights: Top spenders and category-wise unique customer counts provide valuable business direction.

Reports

Sales Summary: Total sales, customer demographics, category performance.
Trend Analysis: Monthly and shift-based sales patterns.
Customer Insights: Top customers and unique buyers per category.

Conclusion
This project is a complete beginner-to-intermediate SQL portfolio piece covering database creation, cleaning, EDA, and business-oriented analysis. The insights can directly support retail decision-making around sales patterns, customer behavior, and product performance.

Author
Devanarayana


