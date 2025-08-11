--SQl Retail Sales Analysis

-- Create table 
create table retail_sales(
				transactions_id int primary key,
				sale_date date,
				sale_time Time,
				customer_id  Int,
				gender  varchar(20),
				age	int,
				category  varchar(20),
				quantity int,  
				price_per_unit   Float,
				cogs    Float,
				total_sale  Float

		);

select 
	* 
from Retail_sales	;

select 
	count(*) 
from retail_sales;

-- Data Cleaning
select 
	* 
From retail_sales
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
	 quantity is null 
	 or 
	 price_per_unit is null 
	 or 
	 cogs is null 
	 or 
	 total_sale is null ;

--
delete from retail_sales
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
	quantity is null 
	or 
	price_per_unit is null
	or
	cogs is null 
	or
	total_sale is null;


-- Data Exploration

-- How many sales data we Have ?
select 
	  count(*) as Total_number_of_sales 
from retail_sales;

-- How many Unique Charachter we have ?
Select 
	  count(distinct customer_id) as total_unique_charachter 
from retail_sales;


select distinct category from retail_sales;

-- Data analysis & business Key problems & Answer 

-- My Analysis And Finding
-- 0.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'.
-- 0.2 Write a SQL query to retrieve all transaction where the category is 'clothing' and the quantity sold is more than 10 in the month of nov_2022.
-- 0.3 Write a SQL query to calculate the total sales(total_sales) for each category.
-- 0.4 Write a SQL query to find the average age of customer who purchased items from the 'Beauty' category.
-- 0.5 Write a SQL query to find all transation where the total_sales is greater than 1000.
-- 0.6 Write a SQL query to find total number of transaction (transaction_id)made by each gender in each category.
-- 0.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
-- 0.8 Write a SQL query to find the top 5 customer based on the highest total sales.
-- 0.9 Write a SQl query to find the number of unique customer who purchased items from each category.
-- 0.10 Write a SQL query to create each shift and number of orders(example Morning<=12, Afternoon between 12 & 17 pm, Evening >17)


-- 0.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'.

select * 
From retail_sales
where sale_date='2022-11-05';

-- 0.2 Write a SQL query to retrieve all transaction where the category is 'clothing' and the quantity sold is more than 10 in the month.

select
	   * 
from retail_sales
where
	category='Clothing' 
	and
	to_char(sale_date,'YYYY-MM')='2022-11'
	and
	quantity>=4;
		
-- 0.3 Write a SQL query to calculate the total sales(total_sales) for each category.

select 
	   category,
	   sum(total_sale) as net_sales,
	   count(*) as total_orders
from retail_sales
group by category;

-- 0.4 Write a SQL query to find the average age of customer who purchased items from the 'Beauty' category.

select 
	  round(avg(age),2) as Average_Age_of_Customer
from retail_sales
where category='Beauty';

-- 0.5 Write a SQL query to find all transation where the total_sales is greater than 1000.

select 
	  * 
from retail_sales
where total_sale>1000;

-- 0.6 Write a SQL query to find total number of transaction (transaction_id)made by each gender in each category.

select 
		Category,
		gender,
		count(*)
from retail_sales
group by 
		category,
		gender
order by 1;

-- 0.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.

select 
	  year,
	  month,
	  avg_sale
from(
select
	  extract(year from sale_date) as year,
	  extract(month from sale_date)as month,
	  avg(total_sale) as avg_sale,
	  rank() over(partition by extract(year from sale_date)order by avg(total_sale)desc)as rank
from retail_sales
group by 1,2
) as t1 
where rank=1;


-- 0.8 Write a SQL query to find the top 5 customer based on the highest total sales.

select 
	   customer_id,
	   sum(total_sale)as total_sale
from retail_sales
group by customer_id
order by total_sale desc
limit 5;

-- 0.9 Write a SQl query to find the number of unique customer who purchased items from each category.

select 
	   category,
	   count(distinct customer_id) as unique_customer
from retail_sales
group by category;


-- 0.10 Write a SQL query to create each shift and number of orders(example Morning<=12, Afternoon between 12 & 17 pm, Evening >17)

with hourly_sale
as
(
select *,
	   case
	   		when extract(hour from sale_time)<12 then 'Morning'
			when extract(hour from sale_time)between 12 and 17 then 'Afternoon'
			else 'Evening'
		end as Shift
from retail_sales
)
select 
	  shift,
	  count(*) as total_orders
	  from hourly_sale
	  group by shift;


-- End This Project



		