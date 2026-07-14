-- Determine the top 3 most ordered pizza types based on revenue.

SELECT pizza_types.name,
sum(ORDER_DETAILS.QUANTITY * pizzas.price) AS REVENUE
FROM  pizza_types JOIN pizzas
ON pizzas.pizza_type_id = pizza_types.pizza_type_id
JOIN order_details
ON order_details.PIZZA_ID = pizzas.PIZZA_ID
GROUP BY pizza_types.name 
ORDER BY REVENUE DESC LIMIT 3;