 INSERT INTO dwh.f_orders(product_id, craftsman_id, customer_id, order_created_date, order_completion_date, order_status,
 		source, order_id_in_source, product_id_in_source, craftsman_id_in_source, customer_id_in_source, load_dttm)
	SELECT dwh.d_products.product_id, dwh.d_craftsmans.craftsman_id, dwh.d_customers.customer_id,
		src.order_created_date, src.order_completion_date, src.order_status, 3, src.order_id, 
		src.product_id, src.craftsman_id, src.customer_id, NOW()
	FROM source3.craft_market_orders as src
	LEFT JOIN dwh.f_orders ON dwh.f_orders.source = 3 AND src.order_id = dwh.f_orders.order_id_in_source
	LEFT JOIN dwh.d_products ON dwh.d_products.source = 3 AND dwh.d_products.product_id_in_source = src.product_id
	LEFT JOIN dwh.d_craftsmans ON dwh.d_craftsmans.source = 3 AND dwh.d_craftsmans.craftsman_id_in_source = src.craftsman_id
	LEFT JOIN dwh.d_customers on dwh.d_customers.source = 3 AND dwh.d_customers.customer_id_in_source = src.customer_id
	WHERE dwh.f_orders.order_id IS NULL;

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
FROM source3.craft_market_orders as src
	LEFT JOIN dwh.f_orders as dwhf ON dwhf.source = 3 AND src.order_id = dwhf.order_id_in_source
	LEFT JOIN dwh.d_products ON dwh.d_products.source = 3 AND dwh.d_products.product_id_in_source = src.product_id
	LEFT JOIN dwh.d_craftsmans ON dwh.d_craftsmans.source = 3 AND dwh.d_craftsmans.craftsman_id_in_source = src.craftsman_id
	LEFT JOIN dwh.d_customers on dwh.d_customers.source = 3 AND dwh.d_customers.customer_id_in_source = src.customer_id
WHERE
	dwh.f_orders.order_id_in_source = src.order_id AND dwh.f_orders.source = 3 AND
	(src.product_id <> dwh.f_orders.product_id_in_source OR
		src.craftsman_id <> dwh.f_orders.craftsman_id_in_source OR
		src.customer_id <> dwh.f_orders.customer_id_in_source OR
		src.order_created_date <> dwh.f_orders.order_created_date OR
		src.order_completion_date <> dwh.f_orders.order_completion_date OR
		src.order_status <> dwh.f_orders.order_status
	);
	




 INSERT INTO dwh.f_orders(product_id, craftsman_id, customer_id, order_created_date, order_completion_date, order_status,
 		source, order_id_in_source, product_id_in_source, craftsman_id_in_source, customer_id_in_source, load_dttm)
	SELECT dwh.d_products.product_id, dwh.d_craftsmans.craftsman_id, dwh.d_customers.customer_id,
		src.order_created_date, src.order_completion_date, src.order_status, 2, src.order_id, 
		src.product_id, src.craftsman_id, src.customer_id, NOW()
	FROM source2.craft_market_orders_customers as src
	LEFT JOIN dwh.f_orders ON dwh.f_orders.source = 2 AND src.order_id = dwh.f_orders.order_id_in_source
	LEFT JOIN dwh.d_products ON dwh.d_products.source = 2 AND dwh.d_products.product_id_in_source = src.product_id
	LEFT JOIN dwh.d_craftsmans ON dwh.d_craftsmans.source = 2 AND dwh.d_craftsmans.craftsman_id_in_source = src.craftsman_id
	LEFT JOIN dwh.d_customers on dwh.d_customers.source = 2 AND dwh.d_customers.customer_id_in_source = src.customer_id
	WHERE dwh.f_orders.order_id IS NULL;

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
	dwh.f_orders.order_id_in_source = src.order_id AND dwh.f_orders.source = 2 AND
	(src.product_id <> dwh.f_orders.product_id_in_source OR
		src.craftsman_id <> dwh.f_orders.craftsman_id_in_source OR
		src.customer_id <> dwh.f_orders.customer_id_in_source OR
		src.order_created_date <> dwh.f_orders.order_created_date OR
		src.order_completion_date <> dwh.f_orders.order_completion_date OR
		src.order_status <> dwh.f_orders.order_status
	);





 INSERT INTO dwh.f_orders(product_id, craftsman_id, customer_id, order_created_date, order_completion_date, order_status,
 		source, order_id_in_source, product_id_in_source, craftsman_id_in_source, customer_id_in_source, load_dttm)
	SELECT dwh.d_products.product_id, dwh.d_craftsmans.craftsman_id, dwh.d_customers.customer_id,
		src.order_created_date, src.order_completion_date, src.order_status, 1, src.order_id, 
		src.product_id, src.craftsman_id, src.customer_id, NOW()
	FROM source1.craft_market_wide as src
	LEFT JOIN dwh.f_orders ON dwh.f_orders.source = 1 AND src.order_id = dwh.f_orders.order_id_in_source
	LEFT JOIN dwh.d_products ON dwh.d_products.source = 1 AND dwh.d_products.product_id_in_source = src.product_id
	LEFT JOIN dwh.d_craftsmans ON dwh.d_craftsmans.source = 1 AND dwh.d_craftsmans.craftsman_id_in_source = src.craftsman_id
	LEFT JOIN dwh.d_customers on dwh.d_customers.source = 1 AND dwh.d_customers.customer_id_in_source = src.customer_id
	WHERE dwh.f_orders.order_id IS NULL;

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
FROM source1.craft_market_wide as src
	LEFT JOIN dwh.f_orders AS dwhf ON dwhf.source = 1 AND src.order_id = dwhf.order_id_in_source
	LEFT JOIN dwh.d_products ON dwh.d_products.source = 1 AND dwh.d_products.product_id_in_source = src.product_id
	LEFT JOIN dwh.d_craftsmans ON dwh.d_craftsmans.source = 1 AND dwh.d_craftsmans.craftsman_id_in_source = src.craftsman_id
	LEFT JOIN dwh.d_customers on dwh.d_customers.source = 1 AND dwh.d_customers.customer_id_in_source = src.customer_id
WHERE
	dwh.f_orders.order_id_in_source = src.order_id AND dwh.f_orders.source = 1 AND
	(src.product_id <> dwh.f_orders.product_id_in_source OR
		src.craftsman_id <> dwh.f_orders.craftsman_id_in_source OR
		src.customer_id <> dwh.f_orders.customer_id_in_source OR
		src.order_created_date <> dwh.f_orders.order_created_date OR
		src.order_completion_date <> dwh.f_orders.order_completion_date OR
		src.order_status <> dwh.f_orders.order_status
	);
