-- Calculate the percentage contribution of each pizza type to total revenue.

SELECT pizza_types.category,
ROUND(sum(pizzas.PRICE * order_details.QUANTITY) / (SELECT 
ROUND(SUM(ORDER_DETAILS.QUANTITY * PIZZAS.PRICE),2) AS TOTAL_REVENUE
FROM ORDER_DETAILS JOIN PIZZAS
ON PIZZAS.PIZZA_ID = ORDER_DETAILS.PIZZA_ID ) * 100,0) AS REVENUE
FROM pizzas JOIN order_details
ON pizzas.pizza_id = order_details.PIZZA_ID
JOIN pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.category ORDER BY REVENUE DESC;