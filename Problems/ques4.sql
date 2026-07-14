-- Identify the most common pizza size ordered.

-- SELECT 
-- pizzas.size,COUNT(order_details.ORDER_DETAILS_ID) AS ORDER_COUNT
-- FROM pizzas JOIN order_details
-- ON pizzas.pizza_id = order_details.PIZZA_ID
-- GROUP BY SIZE
-- ORDER BY ORDER_COUNT DESC;






SELECT pizzas.size,COUNT(order_details.ORDER_DETAILS_ID) AS ORDER_COUNT
FROM pizzas JOIN order_details
ON pizzas.pizza_id = order_details.PIZZA_ID
GROUP BY PIZZAS.SIZE
ORDER BY ORDER_COUNT DESC;



