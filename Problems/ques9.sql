-- Group the orders by date and calculate the average number of pizzas ordered per day.


-- SELECT ORDER_DATE, count(ORDER_ID) AS TOTAL_ORDERS
-- FROM ORDERS
-- GROUP BY ORDER_DATE



SELECT ROUND(AVG(TOTAL_QUANTITY),0) FROM 
(SELECT ORDERS.ORDER_DATE , sum(order_details.QUANTITY) AS TOTAL_QUANTITY
FROM orders JOIN order_details
ON orders.ORDER_ID = order_details.ORDER_ID
GROUP BY ORDERS.ORDER_DATE) AS ORDER_QUANTITY_BASED_ON_DATES


