create table Retail_sales
             (
               transactions_id	int primary key,
			   sale_date date,
			   sale_time time,	
			   customer_id  int,	
			   gender	varchar(15),
			   age	int,
			   category	varchar(15),
			   quantiy	int,
			   price_per_unit float,	
			   cogs	float,
			   total_sale int
			 );

select * from Retail_sales
limit 10
--Data cleaning
select count(*) from Retail_sales

select * from Retail_sales where transactions_id is null

select * from Retail_sales where sale_date is null

select * from Retail_sales
where 
transactions_id is null
or
sale_date is null
or
sale_time is null
or 
customer_id is null
or
gender is null
or 
age is null
or
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null

delete  from Retail_sales
where 
transactions_id is null
or
sale_date is null
or
sale_time is null
or 
customer_id is null
or
gender is null
or 
age is null
or
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null

---data exploration
--how many sales  we have
select count(*) as total_sale from Retail_sales

--how many customer we have
select count(Distinct customer_id)as total_sale from Retail_sales

--howmany category we have
select Distinct category from Retail_sales

--Data Analysis  and Business key problems and Answers

--Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT *
FROM Retail_sales
WHERE sale_date = '2022-11-05';

--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT 
  *
FROM Retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantiy >= 4

---Write a SQL query to calculate the total sales (total_sale) for each category.:

SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM Retail_sales
GROUP BY 1

----Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM Retail_sales
WHERE category = 'Beauty'

---Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT * FROM retail_sales
WHERE total_sale > 1000

---Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM Retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1
---Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM Retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1

---**Write a SQL query to find the top 5 customers based on the highest total sales **:--
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM Retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
---Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM Retail_sales
GROUP BY category
---Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

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


---END OF PROJECT---
