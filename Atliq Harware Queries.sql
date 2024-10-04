-- 1. Provide the list of markets in which customer "Atliq Exclusive" operates its business in the APAC region.

SELECT 
    *
FROM
    dim_customer
WHERE
    customer = 'Atliq Exclusive'
        AND region = 'APAC'
;

-- 2. What is the percentage of unique product increase in 2021 vs. 2020?
-- The final output contains these fields, unique_products_2020 unique_products_2021 percentage_chg

with cte as(SELECT fiscal_year,count(distinct product) as count FROM fact_sales_monthly
join dim_product dp using(product_code)
group by fiscal_year),
cte2 as(select max(case when fiscal_year = '2020' then count end)  as unique_product_2020,
       max(case when fiscal_year = '2021' then count  end) as unique_product_2021
      from cte)
select *,round(((unique_product_2021-unique_product_2020)*100/unique_product_2020),2) as percentage_increase from cte2
;


-- 3. Provide a report with all the unique product counts for each segment and sort them in descending order of product counts.
-- The final output contains 2 fields, segment product_count

SELECT 
    segment, COUNT(product) AS Total_number_of_products
FROM
    dim_product
GROUP BY segment;


-- 4. Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? 
-- The final output contains these fields, segment product_count_2020 product_count_2021 difference

with cte as(select distinct dp.segment as segment,fs.product_code,fs.fiscal_year as year 
from fact_sales_monthly fs
join dim_product dp using(product_code))
select segment, sum(case when year ='2020' then 1 else 0 end) as product_count_2020,
        sum(case when year ='2021' then 1 else 0 end) as product_count_2021,
        sum(case when year ='2021' then 1 else 0 end) - sum(case when year ='2020' then 1 else 0 end) as difference
        from cte
group by segment
order by difference desc

;


-- 5. Get the products that have the highest and lowest manufacturing costs.
-- The final output should contain these fields, product_code product manufacturing_cost

WITH cte AS (
    SELECT product_code, SUM(manufacturing_cost) AS cost
    FROM fact_manufacturing_cost
    GROUP BY product_code
)
SELECT dp.product, c.product_code, c.cost
FROM dim_product dp
JOIN cte c ON dp.product_code = c.product_code
where cost = (select max(cost) from cte)

UNION 

SELECT dp.product, c.product_code, c.cost
FROM dim_product dp
JOIN cte c ON dp.product_code = c.product_code
where cost = (select min(cost) from cte)
;

-- 6. Generate a report which contains the top 5 customers who received an average high pre_invoice_discount_pct for the fiscal year 2021 and in the Indian market. 
-- The final output contains these fields, customer_code customer average_discount_percentage


with cte as (select customer_code,avg(pre_invoice_discount_pct) as discount from fact_pre_invoice_deductions fp
where fiscal_year='2021' 
group by customer_code)
select c.customer_code,dc.customer,round(c.discount,2) as discount from cte c
join dim_customer dc using(customer_code)
where dc.market = 'india'
order by discount desc
limit 5;


-- 7. Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month . This analysis helps to get an idea of low and high-performing months and take strategic decisions.
-- The final report contains these columns: Month Year Gross sales Amount


SELECT 
    YEAR(fs.date) AS year,
    MONTH(fs.date) AS month,
    ROUND(SUM(fs.sold_quantity * fg.gross_price)) AS Gross_sales_Amount
FROM
    fact_sales_monthly fs
        JOIN
    dim_customer dc USING (customer_code)
        JOIN
    fact_gross_price fg USING (product_code)
WHERE
    dc.customer = 'Atliq exclusive'
GROUP BY year , month
ORDER BY year , month
;


-- 8. In which quarter of 2020, got the maximum total_sold_quantity?
-- The final output contains these fields sorted by the total_sold_quantity, Quarter total_sold_quantity


with cte as (select *,
       case when month(date) >=9 and month(date)<=11 then 'Q1'
            when month(date) =12 or month(date)<=2 then 'Q2'
			when month(date) >=3 and month(date)<=6 then 'Q3'
            else 'Q4' end as quarter
            from fact_sales_monthly)

select quarter,sum(sold_quantity) as total from  cte 

where fiscal_year = '2021'
group by quarter
order by total desc
limit 1;


-- 9. Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution?
-- The final output contains these fields, channel gross_sales_mln percentage


with cte as (select channel,sold_Quantity,gross_price from dim_customer dc
join fact_sales_monthly fs using(customer_code)
join fact_gross_price fg using(product_code)
where fs.fiscal_year = '2021'),
 cte2 as (select channel,(sum(sold_Quantity * gross_price)/1000000) as revenue from cte
group by channel)
select channel,revenue,round((revenue * 100/( select sum(revenue) from cte2 )),2) as Percentage_contribution from cte2
order by Percentage_contribution desc
limit 1

;

-- 10. Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021?
-- The final output contains these fields, division,product_code,product,total_sold_quantity,rank_order

with cte as (SELECT dp.division,dp.product_code,dp.product,sum(sold_quantity) as total_quantity,
rank() over(partition by division order by sum(sold_quantity) desc)  as rank_order
  FROM fact_sales_monthly fs
join dim_product dp using(product_code)
group by dp.division,dp.product_code,dp.product
)
select * from cte
where rank_order in (1,2,3)



