use case_study
go

select * from customer
select * from Data_Dictionary
select * from product
select * from transactions


/*1. Calculate the Total Sale Amount by the merchant location. (7 Marks)
Hint:
-- Aggregate the sale amount by each merchant location.*/

select p.merchant_location, sum(t.sale_amount) as tot_sale
from transactions as t join (select distinct merchant_id,merchant_location from product) as p on t.merchant_id=p.Merchant_id
group by p.merchant_location

/*2. Find the total number of customers who purchased between July 2012 and December
2012. (7 Marks)
Hint:
--Filter transactions between July 2012 and December 2012 and count the distinct
customers.*/

select  count(distinct user_id)tot_customer
from Transactions
where order_time between '2012-07-01' and '2012-12-31' 


/*3. What is the average transaction value by the top 10 customers in terms of sales? (8
Marks)
Hint:
-- Identify the top 10 customers based on total sales.
-- Calculate the average transaction value using the formula:
-- Average Transaction Value = Total Sales (including returns) by a customers /Number of
Orders by the customer.*/

select top 10 customer_id, customer_total_value, customer_total_value/total_orders as Average_Transaction_Value
from customer
order by customer_total_value desc

/*4. Find the third and fourth top product categories by sales and what is their contribution
to overall sales in percentage? (8 Marks)
Hint:
 Rank product categories by total sales. Identify the third and fourth categories.
 Calculate their contribution to the overall sales as a percentage.*/

with mine as (select p.sub_category_name, t.merchant_id, sum(t.sale_amount) as tot_sale
from transactions as t join(select distinct merchant_id, sub_category_name from product)as p
on t.merchant_id = p.Merchant_id
group by p.sub_category_name, t.merchant_id)
select sub_category_name, merchant_id, tot_sale,
dense_rank()over( partition by sub_category_name order by tot_sale desc) as rnk,
(tot_sale * 100.0 / sum(tot_sale) over()) as percent_contribution
from mine

/*6. Which Merchant Location has the highest discount percentage?
Hint:
--Calculate the discount for each transaction using:
--Discount = (Sale Price * Units) - Sale Amount
-- Discount Percentage = Discount /(Sale Price * Units)
-- Aggregate by merchant location and 􀏐ind the one with the highest discount percentage.*/

select
p.merchant_location,
sum((p.avg_price * t.quantity) - t.sale_amount) as total_discount,

(sum((p.avg_price * t.quantity) - t.sale_amount) / nullif(sum(p.avg_price * t.quantity), 0)) * 100 as discount_percentage
from transactions as t
join (
select merchant_id, merchant_location, avg(cost_price) as avg_price
from product
group by merchant_id, merchant_location
) as p on t.merchant_id = p.merchant_id
group by p.merchant_location
order by discount_percentage desc
