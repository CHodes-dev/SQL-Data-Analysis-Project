/*
===============================================================================================================
Exploratory Data Analysis (EDA) Project
===============================================================================================================
Purpose:
	-	This project focuses on understanding the data, extracting implicit information from it, and 
		understanding all aspects of the dataset using simple aggregation.

Usage:
	-	Run the queries one by one to obtain more targeted results
===============================================================================================================
*/

--=============================================================================================================
-- STEP 1: Database Exploration
--=============================================================================================================

-- Explore All Objects in the Database
select * from INFORMATION_SCHEMA.TABLES

-- Explore All Columns in the Database
select * from INFORMATION_SCHEMA.COLUMNS

-- Explore Specific Table Information in the Database
select * from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'dim_customers'

--=============================================================================================================
-- STEP 2: Dimensions Exploration
--=============================================================================================================

-- Exploring the countries from which customers are from
select distinct country from gold.dim_customers

-- Explore all categories "The major divisions"
select distinct category, subcategory, product_name from gold.dim_products
order by 1, 2, 3

--=============================================================================================================
-- STEP 3: Date Exploration
--=============================================================================================================

-- Find the date of the first and last order
select 
	min(order_date) as first_order_date,
	max(order_date) as last_oder_date
from gold.fact_sales

-- How many years of sales are available
select 
	min(order_date) as first_order_date,
	max(order_date) as last_oder_date,
	datediff (
		year, 
		min(order_date),
		max(order_date))
as order_range_years
from gold.fact_sales

-- Find the youngest and the oldest customer
select
	min (birtdate) as oldest_birthdate,
	datediff (year, min(birtdate), getdate()) as oldest_age,
	max (birtdate) as youngest_birthdate,
	datediff (year, max(birtdate), getdate()) as youngest_age
from gold.dim_customers

--=============================================================================================================
-- STEP 4: Measure Exploration
--=============================================================================================================

-- Find how many items are sold
select
	sum(sales_amount) as total_sales
from gold.fact_sales

-- Find the average selling price
select
	avg (price) as avg_price
from gold.fact_sales

-- Find the total number of orders (Include duplicate data of order number)
select
	count(order_name) as total_orders
from gold.fact_sales

-- Unique order number
select
	count(distinct order_name) as total_orders
from gold.fact_sales

-- Find the total number of products
select
	count(product_key) as total_products
from gold.dim_products

-- Find the total number of customers
select
	count(customer_key) as total_customers
from gold.dim_customers

-- Find the total number of customers that has placed an order
select
	count(distinct customer_key) as total_customers
from gold.fact_sales

	------------------------------------------------------------------------------------------------------------
	-- Genarte Report that shows all key metrics of the business
	------------------------------------------------------------------------------------------------------------
	select 'Total Sales' as measure_name, sum(sales_amount) as measure_value from gold.fact_sales
	union all
	select 'Total Quantity', sum(quantity) from gold.fact_sales
	union all
	select 'Average Price', avg(price) from gold.fact_sales
	union all
	select 'Total Nr. Orders', count(distinct order_name) from gold.fact_sales
	union all
	select 'Total Nr. Products', count(product_name) from gold.dim_products
	union all
	select 'Total Nr. Customers', count(customer_key) from gold.dim_customers

--=============================================================================================================
-- STEP 5: Magnitude Analysis
--=============================================================================================================

-- Find total customers by countries
select
	country,
	count(customer_key) as total_customers
from gold.dim_customers
group by country
order by total_customers desc

-- Find total customers by gender
select
	gender,
	count(customer_key) as total_customers
from gold.dim_customers
group by gender
order by total_customers desc

-- Find total products by category
select
	category,
	count(product_id) as total_products
from gold.dim_products
group by category
order by total_products desc

-- Find the average costs in each category
select
	category,
	avg(cost) as avg_costs
from gold.dim_products
group by category
order by avg_costs desc

-- Find the total revenue generated for each category
select
	p.category,
	sum(f.sales_amount) as total_revenue
from gold.dim_products as p
left join gold.fact_sales as f
on p.product_key = f.product_key
group by p.category
order by total_revenue desc

-- Find total revenue is generated by each customer
select
	c.customer_key,
	c.first_name,
	c.last_name,
	sum(f.sales_amount) as total_revenue
from gold.fact_sales as f
left join gold.dim_customers as c
on c.customer_key = f.customer_key
group by
	c.customer_key,
	c.first_name,
	c.last_name
order by total_revenue desc

-- Find the distribution of sold items across countries
select
	c.country,
	sum(f.quantity) as total_sold_item
from gold.fact_sales as f
left join gold.dim_customers as c
on f.customer_key = c.customer_key
group by c.country
order by total_sold_item desc

--=============================================================================================================
-- STEP 6: Ranking Analysis
--=============================================================================================================

-- Find 5 products generate the highest revenue
select top 5
	p.product_name,
	sum(f.sales_amount) as total_revenue
from gold.fact_sales as f
left join gold.dim_products as p
on f.product_key = p.product_key
group by p.product_name
order by total_revenue desc;
		select * from (
			select
				p.product_name,
				sum(f.sales_amount) as total_revenue,
				row_number() over (order by sum(f.sales_amount) desc) as rank_products
			from gold.fact_sales as f
			left join gold.dim_products as p
			on f.product_key = p.product_key
			group by p.product_name
			)t
		where rank_products <= 5;

-- Find the 5 worst-performing products in terms of sales
select top 5
	p.product_name,
	sum(f.sales_amount) as total_revenue
from gold.fact_sales as f
left join gold.dim_products as p
on f.product_key = p.product_key
group by p.product_name
order by total_revenue asc

-- Find the Top-10 customers who have generated the highest revenue
select top 10
	c.customer_key,
	c.first_name,
	c.last_name,
	sum(f.sales_amount) as total_revenue
from gold.fact_sales as f
left join gold.dim_customers as c
on c.customer_key = f.customer_key
group by
	c.customer_key,
	c.first_name,
	c.last_name
order by total_revenue desc

-- Find 3 customers with the fewest orders placed
select top 3
	c.customer_id,
	c.first_name,
	c.last_name,
	count(distinct order_name) as total_orders
from gold.dim_customers as c
left join gold.fact_sales as f
on c.customer_key = f.customer_key
group by c.customer_id, c.first_name, c.last_name
order by total_orders asc
