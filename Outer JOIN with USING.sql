SELECT p.date, c.name AS client, p.amount, pm.name AS payment_method
FROM payments p
LEFT JOIN clients c
	USING (client_id)
LEFT JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id 