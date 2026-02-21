🛒 Retail Sales Analysis — SQL Project

📌 Project Overview
This project demonstrates core SQL skills used by data analysts to explore, clean, and analyze retail sales data. It covers setting up a retail sales database, performing exploratory data analysis (EDA), and answering real-world business questions through SQL queries.

Perfect for anyone starting their data analysis journey and looking to build a solid SQL foundation.


🎯 Objectives

Set up a retail sales database — Create and populate the database with sales data
Data Cleaning — Identify and remove records with missing or null values
Exploratory Data Analysis (EDA) — Understand the dataset through basic queries
Business Analysis — Answer business questions and derive meaningful insights


🗂️ Project Structure

1. Database Setup
sqlCREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales (
    transactions_id   INT PRIMARY KEY,
    sale_date         DATE,
    sale_time         TIME,
    customer_id       INT,
    gender            VARCHAR(10),
    age               INT,
    category          VARCHAR(35),
    quantity          INT,
    price_per_unit    FLOAT,
    cogs              FLOAT,
    total_sale        FLOAT
);

2. Data Exploration & Cleaning
sql-- Total records
SELECT COUNT(*) FROM retail_sales;

-- Unique customers
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

-- Unique categories
SELECT DISTINCT category FROM retail_sales;

-- Check for nulls
SELECT * FROM retail_sales
WHERE sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL
   OR gender IS NULL OR age IS NULL OR category IS NULL
   OR quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

-- Remove null records
DELETE FROM retail_sales
WHERE sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL
   OR gender IS NULL OR age IS NULL OR category IS NULL
   OR quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

3. Business Analysis Queries
Q1. Retrieve all sales made on '2022-11-05'

SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

Q2. Clothing transactions with quantity ≥ 4 in November 2022

SELECT * FROM retail_sales
WHERE category = 'Clothing'
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
  AND quantity >= 4;
  
Q3. Total sales per category

SELECT category,
       SUM(total_sale) AS net_sale,
       COUNT(*)        AS total_orders
FROM retail_sales
GROUP BY category;

Q4. Average age of Beauty category customers

SELECT ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';

Q5. Transactions where total sale > 1000

SELECT * FROM retail_sales
WHERE total_sale > 1000;

Q6. Transaction count by gender per category

SELECT category, gender, COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY category;

Q7. Best-selling month per year (by average sale)

SELECT year, month, avg_sale
FROM (
    SELECT EXTRACT(YEAR FROM sale_date)  AS year,
           EXTRACT(MONTH FROM sale_date) AS month,
           AVG(total_sale)               AS avg_sale,
           RANK() OVER (
               PARTITION BY EXTRACT(YEAR FROM sale_date)
               ORDER BY AVG(total_sale) DESC
           )                             AS rank
    FROM retail_sales
    GROUP BY 1, 2
) t1
WHERE rank = 1;

Q8. Top 5 customers by total sales

SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

Q9. Unique customers per category

SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;

Q10. Orders by shift (Morning / Afternoon / Evening)


WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM Retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift


📊 Key Findings
AreaInsightCustomer DemographicsCustomers span various age groups across categories like Clothing and BeautyHigh-Value TransactionsMultiple transactions exceeded $1,000, indicating premium purchasesSales TrendsMonthly analysis reveals peak seasons and slower periodsTop CustomersA small group of customers contributes disproportionately to total revenue

📁 Reports Generated

Sales Summary — Total sales, customer demographics, and category performance
Trend Analysis — Sales patterns across months and time-of-day shifts
Customer Insights — Top spenders and unique customer counts per category


🏁 Conclusion
This project provides a comprehensive introduction to SQL for data analysts, covering:

✅ Database setup and table design
✅ Data cleaning with null handling
✅ Exploratory data analysis
✅ Business-driven SQL queries using aggregations, window functions, and CTEs

The insights derived can help drive business decisions around sales strategy, customer targeting, and inventory planning.

🛠️ Tools Used

Database: PostgreSQL
Language: SQL

👤 Author
Devanarayanan
Aspiring Data Analyst | SQL Enthusiast
