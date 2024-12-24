UPDATE dwh.f_orders 
SET
	product_id = dwh.d_products.product_id,
	product_id_in_source = src.product_id,
	craftsman_id = dwh.d_craftsmans.craftsman_id,
	craftsman_id_in_source = src.craftsman_id,
	customer_id = dwh.d_products.product_id,
	customer_id_in_source = src.customer_id,
	order_created_date = src.order_created_date,
	order_completion_date = src.order_completion_date,
	order_status = src.order_status
FROM source2.craft_market_orders_customers as src
	LEFT JOIN dwh.f_orders AS dwhf ON dwhf.source = 2 AND src.order_id = dwhf.order_id_in_source
	LEFT JOIN dwh.d_products ON dwh.d_products.source = 2 AND dwh.d_products.product_id_in_source = src.product_id
	LEFT JOIN dwh.d_craftsmans ON dwh.d_craftsmans.source = 2 AND dwh.d_craftsmans.craftsman_id_in_source = src.craftsman_id
	LEFT JOIN dwh.d_customers on dwh.d_customers.source = 2 AND dwh.d_customers.customer_id_in_source = src.customer_id
WHERE
	dwh.f_orders.order_id_in_source = src.order_id and 
	(src.product_id <> dwh.f_orders.product_id_in_source OR
		src.craftsman_id <> dwh.f_orders.craftsman_id_in_source OR
		src.customer_id <> dwh.f_orders.customer_id_in_source OR
		src.order_created_date <> dwh.f_orders.order_created_date OR
		src.order_completion_date <> dwh.f_orders.order_completion_date OR
		src.order_status <> dwh.f_orders.order_status
	);