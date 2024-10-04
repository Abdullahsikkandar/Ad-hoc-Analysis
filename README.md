# Ad-hoc-Analysis
Atliq Hardware Sales Ad-hoc Analysis and Insights
Table of Contents
Project Overview
Technologies Used
Database Structure
Queries Overview
Installation
Usage
Contributing
License
Project Overview
The Atliq Hardware Sales Ad Hoc Analysis and Insights project aims to analyze sales data to uncover insights related to hardware products, sales channels, and customer behavior. The analysis uses SQL queries to derive actionable insights that support strategic decision-making for sales and marketing efforts.

Technologies Used
Database: MySQL
Tools: MySQL Workbench (or any preferred SQL IDE)
Version Control: Git and GitHub
Database Structure
This project involves the following key tables:

dim_customer: Contains customer information.
dim_product: Stores product details, including categories and segments.
fact_sales_monthly: Records monthly sales data for analysis.
fact_gross_price: Holds information about product pricing.
fact_manufacturing_cost: Details manufacturing costs of products.
fact_pre_invoice_deductions: Contains pre-invoice discount data for customers.
Queries Overview
The project includes a series of SQL queries that provide insights into hardware sales, including but not limited to:

Market Analysis: Identify markets where "Atliq Exclusive" operates.
Product Growth: Calculate the percentage increase in unique products from 2020 to 2021.
Segment Performance: Generate reports on unique product counts by segment.
Customer Insights: Identify top customers and their contribution to sales.
Sales Channel Analysis: Analyze the performance of different sales channels.
Sample Queries
Identify Unique Products by Year:

sql
Copy code
WITH cte AS (
    SELECT fiscal_year, COUNT(DISTINCT product) AS count 
    FROM fact_sales_monthly 
    JOIN dim_product dp USING(product_code) 
    GROUP BY fiscal_year
)
SELECT 
    MAX(CASE WHEN fiscal_year = '2020' THEN count END) AS unique_product_2020,
    MAX(CASE WHEN fiscal_year = '2021' THEN count END) AS unique_product_2021
FROM cte;
Top Customer Analysis:

sql
Copy code
SELECT customer_code, COUNT(*) AS sales_count
FROM fact_sales_monthly
GROUP BY customer_code
ORDER BY sales_count DESC
LIMIT 1;
Installation
Clone the repository:
bash
Copy code
git clone https://github.com/your-username/Atliq-Hardware-Sales-Analysis.git
Import the SQL scripts into your MySQL database using MySQL Workbench or command-line tools.
Usage
Open your MySQL environment and connect to the database.
Run the provided SQL queries to generate insights on hardware sales.
Modify queries as necessary to explore different aspects of the data.
