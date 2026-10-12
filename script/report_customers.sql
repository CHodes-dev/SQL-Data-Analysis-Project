/*
===================================================================================
Customer Report
===================================================================================
Purpose:
	- This report consolidates key customer metrics and behaviors

Highlights:
	1. Gather essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
	3. Aggregates customer-level metrics:
		- total orders
		- total sales
		- total quantity purchased
		- total products
		- lifespan (in month)
	4. Calculates valuable KPIs:
		- recency (month since last order)
		- average order value
		- average monthly spend
===================================================================================
*/
create view gold.report_customers as
/* --------------------------------------------------------------------------------
1) Base Query: Retrives core columns from tables
---------------------------------------------------------------------------------*/
with base_query as (
select
	fs.order_name,
	fs.product_key,
	fs.order_date,
	fs.sales_amount,
	fs.quantity,
	dc.customer_key,
	dc.customer_number,
	concat(dc.first_name, ' ', dc.last_name) as customer_name,
	datediff(year, dc.birtdate, getdate()) as age
from gold.fact_sales as fs
left join gold.dim_customers as dc
on fs.customer_key = dc.customer_key
where order_date is not null
),
/* --------------------------------------------------------------------------------
2) Customer Aggregation: Summarize key metrics at the customer level
---------------------------------------------------------------------------------*/
customer_aggregation as (
select
	customer_key,
	customer_number,
	customer_name,
	age,
	count(distinct order_name) as total_orders,
	sum(sales_amount) as total_sales,
	sum(quantity) as total_quantity,
	count(distinct product_key) as total_products,
	max(order_date) as last_order_date,
	datediff(month, min(order_date), max(order_date)) as lifespan
from base_query
group by
	customer_key,
	customer_number,
	customer_name,
	age
)
/* --------------------------------------------------------------------------------
3) Final Query: Combines all product results into one output
---------------------------------------------------------------------------------*/
select
	customer_key,
	customer_number,
	customer_name,
	age,
	case
		when age < 20 then 'under 20'
		when age between 20 and 29 then '20-29'
		when age between 30 and 39 then '30-39'
		when age between 40 and 49 then '40-49'
		else '50 and above'
	end as age_group,
	case 
		when lifespan >= 12 and total_sales > 5000 then 'VIP'
		when lifespan >= 12 and total_sales <= 5000 then 'Regular'
		else 'New'
	end as customer_segment,
	last_order_date,
	datediff(month, last_order_date, getdate()) as recency,
	total_orders,
	total_sales,
	total_quantity,
	total_products,
	lifespan,
	case
		when total_sales = 0 then 0
		else total_sales / total_orders
	end as avg_order_value,
	case
		when lifespan = 0 then total_sales
		else total_sales / lifespan
	end as avg_monthly_spend
from customer_aggregation
