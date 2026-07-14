-- Determine the top 3 most ordered pizza types based on revenue

SELECT NAME, REVENUE FROM (SELECT CATEGORY, NAME , REVENUE, 
RANK() OVER (PARTITION BY CATEGORY ORDER BY REVENUE DESC ) AS RN FROM
(SELECT pizza_types.category,pizza_types.name,
sum(pizzas.price * order_details.QUANTITY) AS REVENUE
FROM pizza_types JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.PIZZA_ID = pizzas.pizza_id
GROUP BY pizza_types.category,pizza_types.name) AS A) AS B WHERE RN<=3;

