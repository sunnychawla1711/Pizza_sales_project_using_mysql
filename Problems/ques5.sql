-- List the top 5 most ordered pizza types along with their quantities. 

SELECT pizza_types.name, SUM(order_details.QUANTITY) AS QUANTITY
FROM pizza_types JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.PIZZA_ID = pizzas.pizza_id
GROUP BY pizza_types.name ORDER BY QUANTITY DESC LIMIT 5;



SELECT pizza_types.name, SUM(order_details.QUANTITY) AS TOTAL_QUANTITY 
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON order_details.PIZZA_ID = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY TOTAL_QUANTITY DESC LIMIT 5;







