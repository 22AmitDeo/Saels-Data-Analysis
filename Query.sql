select * from sales;
select sum(`Total Revenue`), Region from sales group by Region;

select `Product Name`,`Units Sold` from sales order by `Units Sold` desc limit 5;
select monthname(Date) from sales;

alter table sales add column month_column varchar(20);
update sales set month_column=monthname(Date);
select * from sales;

with c_month_sales as(
		select month_column as Month_Name ,sum(`Total Revenue`) as Total_Sales from sales group by Month_Name
	),
c_prev_month as (
	select 
		c.Month_Name,
		c.Total_Sales,
		lag(c.Total_Sales,1,c.Total_Sales) over(order by Month_Name) as prev_sales_Amount

	from c_month_sales as c
)
select 
	cp.*,
    ((cp.Total_Sales-cp.prev_sales_Amount)/cp.prev_sales_Amount) *100 as mom_growth
from
c_prev_month as cp
