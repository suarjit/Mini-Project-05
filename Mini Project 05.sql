DROP DATABASE IF EXISTS online_bookstore;

CREATE DATABASE online_bookstore;

USE online_bookstore;

-- TABLE 1 : BOOK CATALOG
CREATE TABLE book_catalog (
    book_id INT PRIMARY KEY,
    genre VARCHAR(40),
    title VARCHAR(100),
    selling_price DECIMAL(10,2));

-- INSERT NEW BOOK DATA
INSERT INTO book_catalog
(book_id, genre, title, selling_price)
VALUES
(101, 'Science', 'The Hidden Universe', 650.00),
(102, 'Science', 'Modern Physics', 820.00),
(103, 'Science', 'Chemistry Essentials', 750.00),
(104, 'Science', 'World of Biology', 590.00),

(105, 'Fiction', 'The Silent River', 450.00),
(106, 'Fiction', 'Midnight Story', 550.00),
(107, 'Fiction', 'The Last Journey', 620.00),
(108, 'Fiction', 'Beyond the Horizon', 480.00),

(109, 'Technology', 'Python Made Easy', 700.00),
(110, 'Technology', 'Database Fundamentals', 850.00),
(111, 'Technology', 'Artificial Intelligence', 950.00),
(112, 'Technology', 'Web Development Guide', 780.00),

(113, 'History', 'Ancient Civilizations', 520.00),
(114, 'History', 'History of India', 680.00),
(115, 'History', 'World War Chronicles', 760.00);

-- Check book table
SELECT * FROM book_catalog;

-- TABLE 2: CUSTOMER ORDERS
CREATE TABLE customer_orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_amount DECIMAL(10,2));

-- INSERT NEW ORDER DATA
INSERT INTO customer_orders
(order_id, customer_id, order_date, order_amount)
VALUES
(501, 2001, '2026-01-04', 1500.00),
(502, 2002, '2026-01-11', 2200.00),
(503, 2001, '2026-01-19', 900.00),

(504, 2003, '2026-02-05', 1800.00),
(505, 2002, '2026-02-14', 2500.00),
(506, 2004, '2026-02-23', 1200.00),

(507, 2001, '2026-03-03', 1700.00),
(508, 2003, '2026-03-15', 2100.00),
(509, 2004, '2026-03-27', 1300.00),

(510, 2002, '2026-04-06', 2800.00),
(511, 2005, '2026-04-13', 1600.00),
(512, 2001, '2026-04-25', 1900.00),

(513, 2003, '2026-05-07', 2300.00),
(514, 2004, '2026-05-18', 1500.00),
(515, 2005, '2026-05-29', 2100.00),

(516, 2002, '2026-06-05', 2700.00),
(517, 2001, '2026-06-16', 2200.00),
(518, 2005, '2026-06-28', 2400.00);

-- Check order table
SELECT * FROM customer_orders;

-- TASK 1
-- RANK BOOKS WITHIN EACH GENRE
-- Highest selling price = Rank 1
SELECT genre,title,selling_price,
    DENSE_RANK() OVER (
        PARTITION BY genre
        ORDER BY selling_price DESC
    ) AS price_rank
FROM book_catalog
ORDER BY genre, price_rank;

-- TASK 2
-- RUNNING TOTAL OF CUSTOMER ORDERS
-- Calculate cumulative order amount for each customer
SELECT customer_id,order_date,order_amount,
SUM(order_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS cumulative_amount
FROM customer_orders
ORDER BY customer_id, order_date;

-- TASK 3
-- TOP 3 MOST EXPENSIVE BOOKS FROM EACH GENRE
WITH BookRanking AS
(SELECT genre,title,selling_price,
        ROW_NUMBER() OVER (
            PARTITION BY genre
            ORDER BY selling_price DESC
        ) AS book_rank
FROM book_catalog)
SELECT genre,title,selling_price,book_rank
FROM BookRanking
WHERE book_rank <= 3
ORDER BY genre, book_rank;

-- TASK 4
-- MONTH-OVER-MONTH ORDER ANALYSIS
-- Compare current month's revenue
-- with previous month's revenue
WITH MonthlyRevenue AS
(SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS order_month,
        SUM(order_amount) AS monthly_revenue
FROM customer_orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m'))
SELECT order_month,monthly_revenue,
    LAG(monthly_revenue, 1) OVER (
        ORDER BY order_month
    ) AS previous_month_revenue,
ROUND(
        monthly_revenue
        - LAG(monthly_revenue, 1) OVER (
            ORDER BY order_month),2) AS revenue_change FROM MonthlyRevenue
ORDER BY order_month;

-- TASK 5
-- GROWTH ANALYSIS
-- Calculate percentage growth from previous month
WITH MonthlyRevenue AS
(SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS order_month,
        SUM(order_amount) AS monthly_revenue FROM customer_orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')),
RevenueComparison AS
(SELECT order_month,monthly_revenue,
        LAG(monthly_revenue, 1) OVER (
            ORDER BY order_month
        ) AS previous_month_revenue FROM MonthlyRevenue)
SELECT order_month,monthly_revenue,previous_month_revenue,
ROUND(monthly_revenue - previous_month_revenue,2) AS growth_amount,
    ROUND(((monthly_revenue - previous_month_revenue)
            / previous_month_revenue
        ) * 100,2
    ) AS growth_percentage FROM RevenueComparison
ORDER BY order_month;

-- TASK 6
-- THREE-MONTH MOVING AVERAGE
-- Current month + previous two months
WITH MonthlyRevenue AS
(SELECT
DATE_FORMAT(order_date, '%Y-%m') AS order_month,
        SUM(order_amount) AS monthly_revenue FROM customer_orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m'))
SELECT order_month,monthly_revenue,
    ROUND(
        AVG(monthly_revenue) OVER (
            ORDER BY order_month
            ROWS BETWEEN 2 PRECEDING
            AND CURRENT ROW),2) AS three_month_moving_average
FROM MonthlyRevenue
ORDER BY order_month;