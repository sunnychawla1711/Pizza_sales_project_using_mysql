-- Join the necessary tables to find the total quantity of each pizza category ordered. 

SELECT pizza_types.category, SUM(order_details.QUANTITY) AS TOTAL_QUANTITY
FROM pizza_types JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.PIZZA_ID = pizzas.pizza_id
GROUP BY pizza_types.category ORDER BY TOTAL_QUANTITY DESC;