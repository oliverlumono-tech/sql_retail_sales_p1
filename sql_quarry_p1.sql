CREATE DATABASE sql_project_p1;

CREATE DATABASE sql_project_p1;

DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
(	
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantiy INT, 
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

SELECT * FROM retail_sales
LIMIT 10;

SELECT 
   COUNT(*)
FROM retail_sales; 


SELECT * FROM retail_sales
WHERE 
    transactions_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR gender IS NULL
    OR category IS NULL
    OR quantiy IS NULL
    OR price_per_unit IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;
	
DELETE FROM retail_sales
WHERE 
    transactions_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR gender IS NULL
    OR category IS NULL
    OR quantiy IS NULL
    OR price_per_unit IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;

-- DATA exploration
--how many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales

SELECT COUNT(DISTINCT customer_id) AS unique_customers 
FROM retail_sales

SELECT DISTINCT category  FROM retail_sales

--Data analysis 

--Q.1 Write an sql quarry to retrive all columnns for sales made on '2022-11-05'
SELECT * 
FROM retail_sales 
WHERE sale_date = '2022-11-05';

--Q.2 Write a sql quarry to retrive all transactions where the category is 'clothing' and the quantity sold is more than 4 in the monthh of Nov-2022?
SELECT 
    *
FROM retail_sales
WHERE category = 'Clothing'
   AND
   TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
   AND 
   quantiy >= 4

--Q.3 Write a sql quarry to calculate the total sales for each category?

SELECT
    category,
    SUM(total_sale) AS net_sale,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY 1;

--Q.4 WRITE a sql quarry to find the average age of customers who purchased items from the 'Beauty' category?
SELECT
  ROUND(AVG(age),2) as avg_age 
FROM retail_sales
WHERE category = 'Beauty'

--Q.5 Write a sql quarry to find all transactions where the total_sale is greater than 1000?
SELECT * FROM retail_sales
WHERE total_sale > 1000

--Q.6 Write a sql quarry to find the total number of transactions made by each gender in each category?
SELECT 
   category,
   gender,
   COUNT(*) as toatl_trans
FROM retail_sales
GROUP BY 
      category,
	  gender
ORDER BY 1

--Q 7 Write a sql quarry to calculate the average sales for each month . find out best selling month in each year?
SELECT
      year,
	  month,
	  avg_sales
FROM
(   
SELECT
    EXTRACT(Year FROM sale_date) AS year,
    EXTRACT(Month FROM sale_date) AS month,
    AVG(total_sale) AS avg_sales,
    RANK() OVER(PARTITION BY EXTRACT(Year FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
FROM retail_sales
GROUP BY 1, 2
) AS t1
WHERE rank = 1

--ORDER BY 1, 3 DESC

--Q.8 Write a sql to find the top 5 customers based on teh highest total sales?
SELECT 
     customer_id,
	 SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--Q.9 Write a sql quarry to find the number of unique customers who purchased items from each category?
SELECT 
     category,
     COUNT(DISTINCT customer_id) as cnt_of_customer
FROM retail_sales
GROUP BY category

--Q.10 Write a sql quarry to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(
SELECT *,
     CASE 
	    WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	 END as shift
FROM retail_sales
)
SELECT 
     shift,
     COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift
 










 


	   

