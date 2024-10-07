# Atliq Hardware Sales Ad-hoc Analysis and Insights

## Table of Contents
- Project Overview
- Technologies Used
- Database Structure
- Queries Overview
- Insights
- How to Use

## Project Overview
The Atliq Hardware Sales Ad Hoc Analysis and Insights project aims to analyze sales data to uncover insights related to hardware products, sales channels, and customer behavior. The analysis uses SQL queries to derive actionable insights that support strategic decision-making for sales and marketing efforts.

## Technologies Used
- **Database:** MySQL
- **Tools:** MySQL Workbench (or any preferred SQL IDE)
- **Version Control:** Git and GitHub

## Database Structure
This project involves the following key tables:
- **dim_customer:** Contains customer information.
- **dim_product:** Stores product details, including categories and segments.
- **fact_sales_monthly:** Records monthly sales data for analysis.
- **fact_gross_price:** Holds information about product pricing.
- **fact_manufacturing_cost:** Details manufacturing costs of products.
- **fact_pre_invoice_deductions:** Contains pre-invoice discount data for customers.

## Queries Overview
The project includes a series of SQL queries that provide insights into hardware sales, including but not limited to:
- **Market Analysis:** Identify markets where "Atliq Exclusive" operates.
- **Product Growth:** Calculate the percentage increase in unique products from 2020 to 2021.
- **Segment Performance:** Generate reports on unique product counts by segment.
- **Customer Insights:** Identify top customers and their contribution to sales.
- **Sales Channel Analysis:** Analyze the performance of different sales channels.

## Insights
- The analysis reveals key trends in hardware sales, highlighting which products perform best across different sales channels.
- Identifying unique products and their growth trends helps the company strategize inventory and marketing efforts.
- Insights into customer behavior allow for targeted marketing initiatives to enhance customer retention and sales growth.

## How to Use
- 1.Clone the repository:
   ```bash
   git clone https://github.com/your-username/Atliq-Hardware-Sales-Analysis.git
- 2.Import the SQL scripts into your MySQL database using MySQL Workbench or command-line tools.
- 3.Open your MySQL environment and connect to the database.
- 4.Run the provided SQL queries to generate insights on hardware sales.
- 5.Modify queries as necessary to explore different aspects of the data.
- 6.Review the results to inform strategic decisions in sales and marketing.
