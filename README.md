# Mini-Project-05
# Online Bookstore SQL Project

## 📌 Project Overview
This project demonstrates the use of MySQL window functions and analytical SQL queries to analyze book prices, customer orders, and monthly revenue trends. The project uses a sample `online_bookstore` database containing book catalog and customer order information.

The main objective is to practice SQL analytical techniques for ranking books, calculating cumulative order amounts, comparing monthly revenue, measuring growth, and identifying revenue trends.

## 🎯 Project Objectives
- Create and populate an online bookstore database.
- Rank books within each genre based on selling price.
- Calculate cumulative order amounts for individual customers.
- Identify the three most expensive books in each genre.
- Perform month-over-month revenue analysis.
- Calculate monthly revenue growth and growth percentages.
- Calculate a three-month moving average of monthly revenue.

## 🛠️ Technologies Used
- **Database:** MySQL
- **Language:** SQL
- **Platform:** MySQL Workbench
- **Concepts:** Window Functions, Common Table Expressions (CTEs), Data Aggregation, and Revenue Analysis

## 📂 Database Structure

### 1. `book_catalog`
Stores information about the books available in the bookstore.

| Column | Data Type | Description |
|---|---|---|
| `book_id` | INT | Unique identifier for each book |
| `genre` | VARCHAR(40) | Genre or category of the book |
| `title` | VARCHAR(100) | Title of the book |
| `selling_price` | DECIMAL(10,2) | Selling price of the book |

**Records:** 15 books across four genres: Science, Fiction, Technology, and History.

### 2. `customer_orders`
Stores customer order information, including order dates and amounts.

| Column | Data Type | Description |
|---|---|---|
| `order_id` | INT | Unique identifier for each order |
| `customer_id` | INT | Identifier of the customer |
| `order_date` | DATE | Date the order was placed |
| `order_amount` | DECIMAL(10,2) | Total amount of the order |

**Records:** 18 orders from January to June 2026, involving five customers.

## 📊 SQL Tasks and Analysis

### Task 1: Rank Books Within Each Genre
Uses the `DENSE_RANK()` window function to rank books within each genre according to selling price in descending order.

**Key concepts:**
- `DENSE_RANK()`
- `PARTITION BY`
- `ORDER BY`

**Outcome:** Identifies the highest-priced books in each genre, assigning rank 1 to the highest-priced book.

### Task 2: Running Total of Customer Orders
Uses the `SUM()` window function to calculate the cumulative order amount for each customer over time.

**Key concepts:**
- `SUM() OVER()`
- `PARTITION BY`
- `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`

**Outcome:** Shows how each customer's cumulative order amount changes with every new order.

### Task 3: Top 3 Most Expensive Books From Each Genre
Uses a Common Table Expression (CTE) and the `ROW_NUMBER()` window function to rank books by selling price within each genre.

**Key concepts:**
- `WITH` clause
- `ROW_NUMBER()`
- `PARTITION BY`
- Filtering ranked results

**Outcome:** Returns up to three books per genre, ordered from highest to lowest selling price.

### Task 4: Month-over-Month Order Analysis
Aggregates order amounts by month and uses the `LAG()` function to compare each month's revenue with the previous month's revenue.

**Key concepts:**
- `SUM()`
- `DATE_FORMAT()`
- `LAG()`
- `ROUND()`
- Common Table Expressions

**Outcome:** Displays monthly revenue, previous month's revenue, and the absolute revenue change.

### Task 5: Monthly Revenue Growth Analysis
Calculates the difference between current and previous monthly revenue and determines the percentage growth.

**Key concepts:**
- `LAG()`
- `ROUND()`
- Revenue difference calculation
- Percentage growth calculation

**Outcome:** Identifies monthly revenue increases or decreases and expresses the change as a percentage of the previous month's revenue.

### Task 6: Three-Month Moving Average
Uses the `AVG()` window function to calculate a moving average of monthly revenue over the current month and the previous two months.

**Key concepts:**
- `AVG() OVER()`
- `ROWS BETWEEN 2 PRECEDING AND CURRENT ROW`
- `ORDER BY`

**Outcome:** Smooths monthly revenue fluctuations and helps reveal broader revenue trends. The first two months use fewer than three available months.

## 🧠 SQL Concepts Practiced
- Database creation and selection
- Table creation and data insertion
- Primary keys and data types
- Aggregate functions: `SUM()`, `AVG()`
- Window functions: `DENSE_RANK()`, `ROW_NUMBER()`, `LAG()`
- Common Table Expressions (CTEs)
- `PARTITION BY` and `ORDER BY`
- Window frame specifications
- Date formatting and monthly grouping
- Revenue change and percentage growth calculations

## 📈 Expected Outcomes
- Identify the most expensive books in each genre.
- Understand customer-level cumulative order values.
- Compare book prices within different genres.
- Track monthly revenue changes over time.
- Calculate monthly revenue growth percentages.
- Analyze revenue trends using moving averages.

## ⚙️ How to Run the Project
1. Install and open MySQL Workbench.
2. Open the project `.sql` file.
3. Execute the SQL script to create the `online_bookstore` database and its tables.
4. Insert the sample book and customer order data.
5. Run the six analytical tasks individually or execute the complete script.
6. Review the result grids in MySQL Workbench.

**Important:** The statement `DROP DATABASE IF EXISTS online_bookstore;` deletes the existing database with this name, including its tables and data, before recreating it. Back up any important data before executing the full script.

## 📁 Project Structure

```text
Online-Bookstore-SQL-Project/
│
├── online_bookstore.sql
└── README.md
```

## 👨‍💻 Author
**Surajit Bera**

## 📜 License
This project is created for educational purposes and SQL practice.