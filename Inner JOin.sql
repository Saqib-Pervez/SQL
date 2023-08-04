SELECT 
    products.product_id, name
FROM
    order_items
        JOIN
    products ON order_items.product_id = order_items.product_id