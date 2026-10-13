/*
===============================================================================================================
Advanced Data Analysis Project
===============================================================================================================
Purpose:
	-	This project is designed to address business questions such as identifying trends over time, 
		comparing performance and segmenting data.

Usage:
	-	Run the queries one by one to obtain more targeted results
===============================================================================================================
*/

--=============================================================================================================
-- STEP 1: Change-over-Time Analysis
--=============================================================================================================

-- Analyze sales performance over time (by Year)
select
	year(order_date) as order_year,
	sum(sales_amount) as total_sales,
	count(distinct customer_key) as total_customers,
	sum(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by year(order_date)
order by year(order_date) asc

-- Analyze sales performance over time (by Month)
select
	year(order_date) as order_year,
	month(order_date) as order_month,
	sum(sales_amount) as total_sales,
	count(distinct customer_key) as total_customers,
	sum(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by year(order_date), month(order_date)
order by year(order_date), month(order_date) asc

-- Analyze sales performance over time (by Month using DATETRUNC for month and year data in one column)
select
	datetrunc(month, order_date) as order_date,
	sum(sales_amount) as total_sales,
	count(distinct customer_key) as total_customers,
	sum(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by datetrunc(month, order_date)
order by datetrunc(month, order_date) asc

--=============================================================================================================
-- STEP 2: Cumulative Analysis
--=============================================================================================================

-- Calculate the total sales per month
select
	DATETRUNC(month, order_date) as order_date,
	sum(sales_amount) as total_sales
from gold.fact_sales
where order_date is not null
group by datetrunc(month, order_date)
order by datetrunc(month, order_date)

-- Calculate the running total of sales over time
select
	order_date,
	total_sales,
	sum(total_sales) over(order by order_date) as running_total
from (
	select
		DATETRUNC(year, order_date) as order_date,
		sum(sales_amount) as total_sales
	from gold.fact_sales
	where order_date is not null
	group by datetrunc(year, order_date)
)t

-- Calculate the moving average of sales over time
select
	order_date,
	total_sales,
	avg_price,
	sum(total_sales) over(order by order_date) as running_total_sales,
	avg(avg_price) over(order by order_date) as moving_avg_price
from (
	select
		DATETRUNC(year, order_date) as order_date,
		sum(sales_amount) as total_sales,
		avg(price) as avg_price
	from gold.fact_sales
	where order_date is not null
	group by datetrunc(year, order_date)
)t

--=============================================================================================================
-- STEP 3: Performance Analysis
--=============================================================================================================

-- Analyze the yearly performance of products:
-- by comparing their sales to both the average sales performance of the product and the previous year's sales
with yearly_product_sales as (
select
	year(f.order_date) as order_year,
	p.product_name,
	sum(f.sales_amount) as current_sales
from gold.fact_sales as f
left join gold.dim_products as p
on f.product_key = p.product_key
where order_date is not null
group by
	year(f.order_date),
	p.product_name
)
select
	order_year,
	product_name,
	current_sales,
	avg(current_sales) over(partition by product_name) as avg_sales,
	current_sales - avg(current_sales) over(partition by product_name) as diff_avg,
	case
		when current_sales - avg(current_sales) over(partition by product_name) > 0 then 'Above Avg'
		when current_sales - avg(current_sales) over(partition by product_name) < 0 then 'Below Avg'
		else 'Avg'
	end as avg_change,
	-- YoY Analysis --
	lag(current_sales) over(partition by product_name order by order_year) as prev_year_sales,
	current_sales - lag(current_sales) over(partition by product_name order by order_year) as diff_prev_year,
	case
		when current_sales - lag(current_sales) over(partition by product_name order by order_year) > 0 then 'Increase'
		when current_sales - lag(current_sales) over(partition by product_name order by order_year) < 0 then 'Decrease'
		else 'No Change'
	end as prev_year_change
from yearly_product_sales
order by product_name, order_year

--=============================================================================================================
-- STEP 4: Part-to-Whole (Proportional) Analysis
--=============================================================================================================

-- Find categories contribute the most to overall sales
with category_sales as (
select
	p. category,
	sum(f. sales_amount) as total_sales
from gold.fact_sales as f
left join gold.dim_products as p
on f.product_key = p.product_key
group by category
)
select
	category,
	total_sales,
	sum(total_sales) over() as overall_sales,
	concat(round((cast(total_sales as float) / sum(total_sales) over())*100, 2), '%') as perc_of_total
from category_sales
order by total_sales desc

--=============================================================================================================
-- STEP 5:  Data Segmentation
--=============================================================================================================

-- Segment products into cost ranges and count how many products fall into each segment
with product_segments as (
select
	product_key,
	product_name,
	cost,
	case
		when cost < 100 then 'Below 100'
		when cost between 100 and 500 then '100-500'
		when cost between 500 and 1000 then '500-1000'
		else 'Above 1000'
	end as cost_range
from gold.dim_products
)
select
	cost_range,
	count(product_key) as total_products
from product_segments
group by cost_range
order by total_products desc

/* Group customers into three segments based on their spending behaviour:
	1. VIP: customers with at least 12 months of history and spending more than $5,000.
	2. Regular: customers with at least 12 months of history but spending $5,000 or less.
	3. New: customers with a lifespan less than 12 months.
And find the total number of customers by each group */
with customer_spending as (
select
	c.customer_key,
	sum(f.sales_amount) as total_spending,
	min(order_date) as first_order,
	max(order_date) as last_order,
	datediff(month, min(order_date), max(order_date)) as lifespan
from gold.fact_sales as f
left join gold.dim_customers as c
on f.customer_key = c.customer_key
group by c.customer_key
)
select
	customer_segment,
	count(customer_key) as total_customer
from (
	select
		customer_key,
		total_spending,
		lifespan,
		case
			when lifespan >= 12 and total_spending > 5000 then 'VIP'
			when lifespan >= 12 and total_spending <= 5000 then 'Regular'
			else 'New'
		end as customer_segment
	from customer_spending
)t
group by customer_segment 
order by total_customer desc
