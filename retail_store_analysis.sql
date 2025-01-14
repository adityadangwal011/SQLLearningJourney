-- Create a new database
CREATE DATABASE SQL_Project;

-- Switch to the created database
USE SQL_Project;

-- Create the Retail_Sales table 

CREATE TABLE Retail_Sales (
    transactions_id INT PRIMARY KEY, -- Unique ID for each transaction
    sale_date DATE,                 -- Date of the sale
    sale_time TIME,                -- Time of the sale
    customer_id INT,                  -- ID of the customer
    gender VARCHAR(20),             -- Gender of the customer
    age INT,                        -- Age of the customer
    category VARCHAR(25),              -- Product category
    quantiy FLOAT,                 -- Quantity of items sold
    price_per_unit FLOAT,         -- Price per unit of the item
    cogs FLOAT,                    -- Cost of goods sold
    total_sale FLOAT              -- Total sale amount
);

-- Retrieve all rows from the Retail_Sales table
SELECT * 
FROM Retail_Sales;

-- Count the total number of rows in the Retail_Sales table
SELECT COUNT(*) 
FROM Retail_Sales;

-- Check for rows with NULL values in any column
SELECT * 
FROM Retail_Sales
WHERE transactions_id IS NULL OR    
      sale_date IS NULL OR 
      sale_time IS NULL OR    
      customer_id IS NULL OR
      gender IS NULL OR
      age IS NULL OR
      category IS NULL OR
      quantiy IS NULL OR
      price_per_unit IS NULL OR
      cogs IS NULL OR
      total_sale IS NULL;

-- Delete rows with NULL values in any column
DELETE  
FROM Retail_Sales
WHERE transactions_id IS NULL OR    
      sale_date IS NULL OR 
      sale_time IS NULL OR    
      customer_id IS NULL OR
      gender IS NULL OR
      age IS NULL OR
      category IS NULL OR
      quantiy IS NULL OR
      price_per_unit IS NULL OR
      cogs IS NULL OR
      total_sale IS NULL;

-- Q1.Write a sql query to retrieve all columns for sales mode on '2022-11-05'
-- Retrieve all sales made on '2022-11-05'
SELECT * 
FROM Retail_Sales 
WHERE sale_date = '2022-11-05';

-- Q2.Write a sql query to retrieve all transactions where the category is 'Clothing' and quantity sold is more than 2 in month of NOV 2022
-- Retrieve transactions for 'Clothing' category with quantity > 2 in November 2022
SELECT *
FROM Retail_Sales
WHERE category = 'Clothing' 
  AND quantiy > 2 
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';

-- Q3.Write a SQL query to calculate the total sales (total_sale) for each category:
-- Calculate total sales for each category
SELECT category, 
       SUM(total_sale) AS Total_Category_Sales
FROM Retail_Sales
GROUP BY category;

-- Q4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
-- Find the average age of customers who purchased items from the 'Beauty' category
SELECT category, 
       AVG(age) AS Avg_Age
FROM Retail_Sales
WHERE category = 'Beauty';

-- Q5.Write a SQL query to find all transactions where the total_sale is greater than 1000:
-- Retrieve all transactions where the total sale is greater than 1000
SELECT * 
FROM Retail_Sales
WHERE total_sale > 1000;

-- Q6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Count the number of transactions made by each gender in each category
SELECT category, 
       gender, 
       COUNT(transactions_id)
FROM Retail_Sales
GROUP BY category, gender
ORDER BY category, gender;

-- Q7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Find the best-selling month in each year based on average monthly sales
SELECT * 
FROM (
    SELECT 
        YEAR(sale_date) AS 'Year',
        MONTH(sale_date) AS 'Month',
        ROUND(AVG(total_sale), 2) AS 'Avg_Sale_for_Month',
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY ROUND(AVG(total_sale), 2) DESC) AS ranks
    FROM Retail_Sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS T1
WHERE ranks = 1;

-- Q8.Write a SQL query to find the top 5 customers based on the highest total sales
-- Retrieve the top 5 customers based on the highest total sales
SELECT customer_id, 
       SUM(total_sale) AS Total_Sales
FROM Retail_Sales
GROUP BY customer_id
ORDER BY SUM(total_sale) DESC
LIMIT 5;

-- Q9.Write a SQL query to find the number of unique customers who purchased items from each category.
-- Count the number of unique customers who purchased items from each category
SELECT category, 
       COUNT(DISTINCT customer_id) AS Unique_Customers
FROM Retail_Sales
GROUP BY category;

-- Q10.Write a SQL query to create each shift and number of orders (Example Morning less than 12, Afternoon Between 12 & 17, Evening more than 17)
-- Determine order counts for each time shift (Morning, Afternoon, Evening)
SELECT
    CASE 
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS Shift,
    COUNT(*) AS Num_Orders
FROM Retail_Sales
GROUP BY Shift
ORDER BY FIELD(Shift, 'Morning', 'Afternoon', 'Evening');
