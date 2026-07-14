# 🍕 Pizza Sales SQL Analysis

A data analysis project using **MySQL** to explore and derive business insights from a Pizza Sales dataset. The project progresses from basic filtering and aggregation to intermediate joins/grouping and advanced window functions.

## 📌 About

This project contains SQL queries and solutions based on a Pizza Sales Dataset using MySQL. It covers **basic, intermediate, and advanced** SQL concepts including filtering, aggregation, joins, grouping, window functions, and revenue analysis.

## 🗂️ Dataset

The dataset consists of the following tables:
- `orders` — order id, date, time
- `order_details` — order id, pizza id, quantity
- `pizzas` — pizza id, pizza type id, size, price
- `pizza_types` — pizza type id, name, category, ingredients

## 🛠️ Tools Used
- MySQL / MySQL Workbench

## 🔍 Questions & Queries

### Basic

**1. Retrieve the total number of orders placed.**
```sql
SELECT COUNT(ORDER_ID) AS TOTAL_ORDERS 
FROM ORDERS;
```
> Result: **21,350** orders

**2. Calculate the total revenue generated from pizza sales.**
```sql
SELECT ROUND(SUM(order_details.QUANTITY * pizzas.price), 2) AS TOTAL_REVENUE 
FROM order_details 
JOIN pizzas ON order_details.PIZZA_ID = pizzas.pizza_id;
```
> Result: **$817,860.05**

**3. Identify the highest-priced pizza.**
```sql
SELECT pizza_types.name, pizzas.price 
FROM pizza_types 
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id 
ORDER BY pizzas.price DESC 
LIMIT 1;
```
> Result: The Greek Pizza — **$35.95**

**4. Identify the most common pizza size ordered.**
```sql
SELECT pizzas.size, COUNT(order_details.ORDER_DETAILS_ID) AS ORDER_COUNT 
FROM pizzas 
JOIN order_details ON pizzas.pizza_id = order_details.PIZZA_ID 
GROUP BY pizzas.size 
ORDER BY ORDER_COUNT DESC;
```
> Result: **L (18,526)** > M (15,385) > S (14,137) > XL (544) > XXL (28)

**5. List the top 5 most ordered pizza types along with their quantities.**
```sql
SELECT pizza_types.name, SUM(order_details.QUANTITY) AS QUANTITY 
FROM pizza_types 
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id 
JOIN order_details ON order_details.PIZZA_ID = pizzas.pizza_id 
GROUP BY pizza_types.name 
ORDER BY QUANTITY DESC 
LIMIT 5;
```
> Result: Classic Deluxe (2,453), Barbecue Chicken (2,432), Hawaiian (2,422), Pepperoni (2,418), Thai Chicken (2,371)

### Intermediate

**6. Join the necessary tables to find the total quantity of each pizza category ordered.**
```sql
SELECT pizza_types.category, SUM(order_details.QUANTITY) AS TOTAL_QUANTITY 
FROM pizza_types 
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id 
JOIN order_details ON order_details.PIZZA_ID = pizzas.pizza_id 
GROUP BY pizza_types.category 
ORDER BY TOTAL_QUANTITY DESC;
```
> Result: Classic (14,888), Supreme (11,987), Veggie (11,649), Chicken (11,050)

**7. Determine the distribution of orders by hour of the day.**
```sql
SELECT HOUR(ORDER_TIME), COUNT(ORDER_ID) AS TOTAL_ORDER 
FROM ORDERS 
GROUP BY HOUR(ORDER_TIME) 
ORDER BY TOTAL_ORDER DESC;
```
> Result: Peak hour is **12:00 (2,520 orders)**, followed by 13:00, 18:00, 17:00

**8. Join relevant tables to find the category-wise distribution of pizzas.**
```sql
SELECT category, COUNT(pizza_type_id) 
FROM pizza_types 
GROUP BY category;
```
> Result: Chicken (6), Classic (8), Supreme (9), Veggie (9)

**9. Group the orders by date and calculate the average number of pizzas ordered per day.**
```sql
SELECT ROUND(AVG(TOTAL_QUANTITY), 0) 
FROM (
    SELECT orders.ORDER_DATE, SUM(order_details.QUANTITY) AS TOTAL_QUANTITY 
    FROM orders 
    JOIN order_details ON orders.ORDER_ID = order_details.ORDER_ID 
    GROUP BY orders.ORDER_DATE
) AS ORDER_QUANTITY_BASED_ON_DATES;
```
> Result: **138** pizzas/day on average

**10. Determine the top 3 most ordered pizza types based on revenue.**
```sql
SELECT pizza_types.name, SUM(order_details.QUANTITY * pizzas.price) AS REVENUE 
FROM pizza_types 
JOIN pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id 
JOIN order_details ON order_details.PIZZA_ID = pizzas.PIZZA_ID 
GROUP BY pizza_types.name 
ORDER BY REVENUE DESC 
LIMIT 3;
```
> Result: Thai Chicken ($43,434.25), Barbecue Chicken ($42,768), California Chicken ($41,409.50)

### Advanced

**11. Calculate the percentage contribution of each pizza category to total revenue.**
```sql
SELECT pizza_types.category,
    ROUND(SUM(pizzas.price * order_details.QUANTITY) / (
        SELECT ROUND(SUM(order_details.QUANTITY * pizzas.price), 2) AS TOTAL_REVENUE 
        FROM order_details 
        JOIN pizzas ON pizzas.pizza_id = order_details.PIZZA_ID
    ) * 100, 0) AS REVENUE
FROM pizzas 
JOIN order_details ON pizzas.pizza_id = order_details.PIZZA_ID 
JOIN pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id 
GROUP BY pizza_types.category 
ORDER BY REVENUE DESC;
```
> Result: Classic (27%), Supreme (25%), Veggie (24%), Chicken (24%)

**12. Analyze the cumulative revenue generated over time.**
```sql
SELECT ORDER_DATE, SUM(REVENUE) OVER (ORDER BY ORDER_DATE) AS CUM_REVENUE 
FROM (
    SELECT orders.ORDER_DATE, SUM(pizzas.price * order_details.QUANTITY) AS REVENUE 
    FROM pizzas 
    JOIN order_details ON pizzas.pizza_id = order_details.PIZZA_ID 
    JOIN orders ON orders.ORDER_ID = order_details.ORDER_ID 
    GROUP BY orders.ORDER_DATE
) AS SALES;
```
> Result: Running daily revenue total across the year (e.g. Jan 1: $2,713.85 → Jan 12: $27,781.70)

**13. Determine the top 3 most ordered pizza types based on revenue for each pizza category.**
```sql
SELECT NAME, REVENUE 
FROM (
    SELECT CATEGORY, NAME, REVENUE,
        RANK() OVER (PARTITION BY CATEGORY ORDER BY REVENUE DESC) AS RN
    FROM (
        SELECT pizza_types.category, pizza_types.name,
            SUM(pizzas.price * order_details.QUANTITY) AS REVENUE
        FROM pizza_types 
        JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id 
        JOIN order_details ON order_details.PIZZA_ID = pizzas.pizza_id 
        GROUP BY pizza_types.category, pizza_types.name
    ) AS A
) AS B 
WHERE RN <= 3;
```
> Result: Top 3 pizzas ranked by revenue within each category (Chicken, Classic, Supreme, Veggie)

## 📊 Key Insights
- Total of **21,350 orders** generated **$817,860.05** in revenue.
- **Large (L)** is the most popular pizza size, followed by Medium and Small.
- **Classic** category pizzas drive the highest order volume and the largest share of revenue (27%).
- Order volume peaks around **midday (12–1 PM)** and again in the **evening (5–7 PM)**, aligning with lunch and dinner rushes.
- On average, the restaurant sells about **138 pizzas per day**.
- Chicken-based pizzas (Thai Chicken, Barbecue Chicken, California Chicken) top the list of highest revenue-generating individual pizza types, despite Classic leading by category.

## 🚀 Future Improvements
- Visualize these results in Power BI / Tableau for an interactive dashboard.
- Add time-series forecasting for demand planning.
- Analyze customer/order-level patterns if additional data becomes available.

---
⭐ If you found this useful, feel free to star the repo!
