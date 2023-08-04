SELECT 
    customer_id, first_name, points, 'Bronze' AS type
FROM
    customers
WHERE
    points <= 1000 
UNION SELECT 
    customer_id, first_name, points, 'Silver' AS type
FROM
    customers
WHERE
    points BETWEEN 1000 AND 2000 
UNION SELECT 
    customer_id, first_name, points, 'Gold' AS type
FROM
    customers
WHERE
    points > 2000
ORDER BY type
