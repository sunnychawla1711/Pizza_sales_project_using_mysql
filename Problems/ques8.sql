-- Join relevant tables to find the category-wise distribution of pizzas.

SELECT category, count(pizza_type_id) 
FROM pizza_types
group by category;