-- Determine the distribution of orders by hour of the day.

SELECT hour(ORDER_TIME),
COUNT(ORDER_ID) 
AS TOTAL_ORDER 
FROM ORDERS 
group by hour(ORDER_TIME)
ORDER BY TOTAL_ORDER DESC;
