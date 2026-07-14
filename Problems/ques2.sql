-- Calculate the total revenue generated from pizza sales.

-- SELECT 
-- ROUND(SUM(ORDER_DETAILS.QUANTITY * PIZZAS.PRICE),2) AS TOTAL_REVENUE
-- FROM ORDER_DETAILS JOIN PIZZAS
-- ON PIZZAS.PIZZA_ID = ORDER_DETAILS.PIZZA_ID;


SELECT ROUND(SUM(order_details.QUANTITY * pizzas.price),2) AS TOTAL_REVENUE
FROM order_details JOIN pizzas
ON order_details.PIZZA_ID = pizzas.pizza_id;



