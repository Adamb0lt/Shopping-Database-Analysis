# Shopping Trends Analysis Project

## Overview

This project involves the analysis of consumer behavior and shopping habits using a dataset obtained from [Kaggle](https://www.kaggle.com/datasets/zeesolver/consumer-behavior-and-shopping-habits-dataset). The project includes SQL scripts for creating tables, triggers, and answering specific business questions based on the dataset.

## Files

- `table_creation.sql`: Script for creating tables and importing data.
- `business_questions.sql`: Script for answering business questions.
- `shopping_trends.csv`: Sample CSV file with shopping data (Note: The file used with the database is "shopping_trends.csv" not "shopping_trends_updated.csv" included in the Kaggle download).

## How to Use

1. **Setting up the Database:**
   - Execute `table_creation.sql` in an SQLite environment to create tables and import data.

2. **Answering Business Questions:**
   - Execute `business_questions.sql` to run SQL queries answering specific business questions.
   - View the results directly or uncomment specific sections to view intermediate results.

## Dataset Source

The dataset used in this project is sourced from Kaggle. You can find it [here](https://www.kaggle.com/datasets/zeesolver/consumer-behavior-and-shopping-habits-dataset). The CSV file included in this project is "shopping_trends.csv."

## Details

### `table_creation.sql`

- Creates tables for storing customer information, purchase history, item details, order information, and units sold.
- Defines triggers for updating the units sold table.
- Inserts data from the CSV file into the created tables.

### `business_questions.sql`

#### Question 1

- Creates a view (`subscriber_item_revenue`) that identifies orders for accessories with promo codes or discounts made by subscribed customers.
- Orders the view by total revenue.

#### Question 2

- Identifies the top 10 most sold items among male customers.
- Displays total revenue produced from these items.
- Explores the correlation between the count of orders and total revenue.

#### Question 3

- Uses Common Table Expressions (CTE) to find the most used payment method by young adults in each season.
- Compares the most used payment method overall with the most used payment method in each season.

## Conclusion

This README provides an overview of the project structure, files, and how to use the scripts to set up the database and answer business questions.
