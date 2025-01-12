-- Create Data Base
create database SQL_Project ;
USE SQL_Project;

-- create table
create table Retail_Sales
(transactions_id int primary key,
sale_date date ,
sale_time time ,
customer_id int,
gender varchar(20),
age int,
category varchar(25),
quantiy float,
price_per_unit float,
cogs float,
total_sale float);

SELECT * 
FROM retail_sales;

 select count(*) 
 from retail_sales;

select * 
from retail_sales
where transactions_id is null or	
		sale_date	is null or 
	    sale_time 	is null or	
        customer_id	is null or
        gender	 is null or
        age	 is null or
        category is null or
        quantiy	is null or
        price_per_unit	is null or
        cogs is null or
        total_sale is null ;
        
        delete  
        from retail_sales
        where transactions_id is null or	
		sale_date	is null or 
	    sale_time 	is null or	
        customer_id	is null or
        gender	 is null or
        age	 is null or
        category is null or
        quantiy	is null or
        price_per_unit	is null or
        cogs is null or
        total_sale is null ;
        
        
        -- SQL QUERIES 
        -- 1.Write a sql query to retrieve all columns for sales mode on '2022-11-05'
        
        select * 
        from retail_sales 
        where sale_date = '2022-11-05';
        
        -- Write a sql query to retrieve all transactions where the category is 'Clothing' and quantity sold is more than 2 in month of NOV 2022
        
        select *
        from retail_sales
        where category = 'Clothing' and quantiy > 2 and date_format(sale_date,'%Y-%m') = '2022-11';
       
-- 3.Write a SQL query to calculate the total sales (total_sale) for each category:

SELECT category , 
sum(total_sale) AS TOTAL_Category_Sales
FROM Retail_Sales
GROUP BY category;

-- 4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category

SELECT category ,AVG(age) as Avg_Age
FROM Retail_Sales
WHERE category='Beauty';

-- 5.Write a SQL query to find all transactions where the total_sale is greater than 1000:
select *
FROM Retail_Sales
WHERE total_sale>1000;



-- 6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

select category,gender,count(transaction_id)
FROM Retail_Sales
order by category,gender;

-- 7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT * 
FROM (
    SELECT 
        YEAR(sale_date) AS 'Year',
        MONTH(sale_date) AS 'Month',
        ROUND(AVG(total_sale), 2) AS 'avg sale for month',
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY ROUND(AVG(total_sale), 2) DESC) AS ranks
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS T1
WHERE ranks = 1;


-- 8.Write a SQL query to find the top 5 customers based on the highest total sales
select customer_id ,sum(total_sale) as "sales"
from retail_sales
group by customer_id
order by sum(total_sale) desc
limit 5;

-- 9.Write a SQL query to find the number of unique customers who purchased items from each category.
select distinct count(customer_id) as 'unique customers' , category
from retail_sales
group by category;

-- 10.Write a SQL query to create each shift and number of orders (Example Morning less than 12, Afternoon Between 12 & 17, Evening more than 17)
SELECT
    CASE 
        WHEN hour(sale_time) < 12 THEN 'Morning'
        WHEN hour(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) as 'num_orders'
FROM retail_sales
GROUP BY shift
order by
field(shift, 'Morning','Afternoon','Evening');

        
        


        

