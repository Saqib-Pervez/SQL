SELECT 
    clients.name, payments.amount, payments.payment_method
FROM
    payments
        JOIN
    clients ON payments.client_id = clients.client_id
        JOIN
    payment_methods ON payment_methods.payment_method_id = payments.payment_method
