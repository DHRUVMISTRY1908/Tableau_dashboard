/*print the database*/
select * from pizza_sales;

/*calculate total revenue*/ 
select sum(total_price) as total_revenue from pizza_sales;

/*calculate average order price*/
select sum(total_price)/count(distinct order_id) as average_order_price from pizza_sales;

/*calculate total pizza sold*/
select sum(quantity) as total_pizzas_sold from pizza_sales;

/*calculate total orders*/
select count(distinct order_id) as total_orders from pizza_sales;

/*average pizzas per order*/
select cast(cast(sum(quantity) as decimal(10,2))/count(distinct order_id) as decimal(10,2)) as pizza_per_order from pizza_sales;

--hourly trend for total pizzas sold
select DATEPART(hour,order_time) as order_hour,sum(quantity) as total_pizza_sold from pizza_sales  
group by DATEPART(hour,order_time) 
order by DATEPART(hour,order_time);

--weekly trend for total orders
select DATEPART(iso_week,order_date) as order_week,year(order_date) as order_year,count(distinct order_id) as total_orders from pizza_sales 
group by DATEPART(iso_week,order_date),year(order_date)
order by DATEPART(iso_week,order_date),year(order_date) ;

--percentage of sales by pizza category
select distinct pizza_category,sum(total_price) as total_sales,sum(total_price)*100/(select sum(total_price) from pizza_sales) as percentage_of_total
from pizza_sales 
group by pizza_category;

--from just one month
select distinct pizza_category,sum(total_price) as total_sales_jan,sum(total_price)*100/(select sum(total_price) from pizza_sales where MONTH(order_date)=1) as percentage_of_total_jan
from pizza_sales 
where MONTH(order_date)=1
group by pizza_category;

--percentage by pizza size
select distinct pizza_size,sum(total_price) as total_sales_jan,sum(total_price)*100/(select sum(total_price) from pizza_sales ) as percentage_of_total_jan
from pizza_sales 
group by pizza_size;

--top 5 best seller pizza
select top 5 pizza_name,sum(total_price) as total_revenue from pizza_sales
group by pizza_name
order by total_revenue desc;

--top 5 worst seller pizza
select top 5 pizza_name,sum(total_price) as total_revenue from pizza_sales
group by pizza_name
order by total_revenue asc;


--top 5 best seller pizza(quantity)
select top 5 pizza_name,sum(quantity) as total_quantity from pizza_sales
group by pizza_name
order by total_quantity desc;