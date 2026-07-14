-- Analyze the cumulative revenue generated over time.


SELECT ORDER_DATE,SUM(REVENUE) OVER(ORDER BY ORDER_DATE) AS CUM_REVENUE FROM
(SELECT orders.ORDER_DATE,sum(pizzas.PRICE * order_details.QUANTITY) AS REVENUE 
FROM pizzas JOIN order_details
ON pizzas.pizza_id = order_details.PIZZA_ID JOIN orders
ON orders.ORDER_ID = order_details.ORDER_ID GROUP BY orders.ORDER_DATE) as SALES;