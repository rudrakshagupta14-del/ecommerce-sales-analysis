CREATE TABLE ecommerce_sales (
    order_id VARCHAR(50),
    ship_mode VARCHAR(50),
    customer_name VARCHAR(150),
    segment VARCHAR(50),
    state VARCHAR(100),
    country VARCHAR(100),
    market VARCHAR(50),
    region VARCHAR(100),
    product_id VARCHAR(50),
    category VARCHAR(100),
    sub_category VARCHAR(100),
    product_name TEXT,
    sales NUMERIC(14,2),
    quantity INTEGER,
    discount NUMERIC(8,4),
    profit NUMERIC(14,4),
    shipping_cost NUMERIC(14,2),
    order_priority VARCHAR(30),
    year SMALLINT,
    Total_Cost NUMERIC(14,4),
    order_date DATE,
    ship_date DATE,
    Order_Processing_Days INTEGER
);
select * from ecommerce_sales;
select count(*) as total_rows from ecommerce_sales;

select 
	count(*) filter(where profit is null) as null_profit,
	count(*) filter(where total_cost is null) as null_total_cost,
	count(*) filter(where order_date is null) as null_order_date
from ecommerce_sales;

select
	count(*) as unknown_customers
from ecommerce_sales
where customer_name='unknown';


--Top 10 profitable products 
select
    product_id,
    product_name,
    sum(profit) as total_profit
from ecommerce_sales
group by
    product_id,
    product_name
order by total_profit desc
limit 10;


--Top 10 customers by sales 
select
    customer_name,
    sales 
from ecommerce_sales
order by sales desc
limit 10;


--Region-wise total sales 
select 
	region,
	sum(sales) as total_sales
from ecommerce_sales
group by region
order by total_sales desc;


--Category-wise average profit 
select 
	category,
	avg(profit) as avg_profit
from ecommerce_sales
group by category
order by avg_profit desc;


--Highest discount category
select
	category,
	round(avg(discount) * 100, 2) AS avg_discount
from ecommerce_sales
group by category
order by avg_discount desc
limit 1;

--Orders with negative profit 
select count(*) from ecommerce_sales where profit<0;

select 
	order_id,
	profit as negative_profit
from ecommerce_sales
where profit<0
order by profit desc;

--Monthly sales trend 
select
    to_char(order_date,'Mon yyyy') AS month,
	sum(sales) as total_sales
from ecommerce_sales
group by month
order by month;


--Market-wise revenue analysis 
select 
	market,
	sum(sales) as total_sales
from ecommerce_sales
group by market
order by total_sales desc;

--Top-performing sub-categories
select 
	sub_category,
	round(sum(sales),2) as total_sales,
	round(sum(profit),2) as total_profit,
	round(avg(discount),2)  as avg_discount
from ecommerce_sales
group by sub_category
order by total_profit desc;

--Ship mode usage analysis
select
    ship_mode,
    count(distinct order_id) as total_orders,
    sum(quantity) as total_quantity,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit
from ecommerce_sales
group by ship_mode
order by total_orders desc;