-- Updates data and inserts new data related to craftsmans into dwh.d_craftsman from source3
MERGE INTO dwh.d_craftsmans AS target
USING source3.craft_market_craftsmans AS source
ON target.craftsman_id_in_source = source.craftsman_id AND target.source = 3
WHEN MATCHED AND (
    target.craftsman_name IS DISTINCT FROM source.craftsman_name OR
    target.craftsman_address IS DISTINCT FROM source.craftsman_address OR
    target.craftsman_birthday IS DISTINCT FROM source.craftsman_birthday OR
    target.craftsman_email IS DISTINCT FROM source.craftsman_email
) THEN
    UPDATE SET
        craftsman_name = source.craftsman_name,
        craftsman_address = source.craftsman_address,
        craftsman_birthday = source.craftsman_birthday,
        craftsman_email = source.craftsman_email,
        load_dttm = NOW()
WHEN NOT MATCHED THEN
    INSERT (craftsman_name, craftsman_address, craftsman_birthday, craftsman_email, source, craftsman_id_in_source, load_dttm)
    VALUES (source.craftsman_name, source.craftsman_address, source.craftsman_birthday, 
		source.craftsman_email, 3, source.craftsman_id, NOW());


-- Updates data and inserts new data related to craftsmans into dwh.d_craftsman from source2
MERGE INTO dwh.d_craftsmans AS target
USING source2.craft_market_masters_products AS source
ON target.craftsman_id_in_source = source.craftsman_id AND target.source = 2
WHEN MATCHED AND (
    target.craftsman_name IS DISTINCT FROM source.craftsman_name OR
    target.craftsman_address IS DISTINCT FROM source.craftsman_address OR
    target.craftsman_birthday IS DISTINCT FROM source.craftsman_birthday OR
    target.craftsman_email IS DISTINCT FROM source.craftsman_email
) THEN
    UPDATE SET
        craftsman_name = source.craftsman_name,
        craftsman_address = source.craftsman_address,
        craftsman_birthday = source.craftsman_birthday,
        craftsman_email = source.craftsman_email,
        load_dttm = NOW()
WHEN NOT MATCHED THEN
    INSERT (craftsman_name, craftsman_address, craftsman_birthday, craftsman_email, source, craftsman_id_in_source, load_dttm)
    VALUES (source.craftsman_name, source.craftsman_address, source.craftsman_birthday, 
		source.craftsman_email, 2, source.craftsman_id, NOW());


-- Updates data and inserts new data related to craftsmans into dwh.d_craftsman from source2
MERGE INTO dwh.d_craftsmans AS target
USING (
	select craftsman_id, craftsman_name, craftsman_address, craftsman_birthday, craftsman_email 
	from source1.craft_market_wide
	group by craftsman_id, craftsman_name, craftsman_address, craftsman_birthday, craftsman_email
	) AS source
ON target.craftsman_id_in_source = source.craftsman_id AND target.source = 1
WHEN MATCHED AND (
    target.craftsman_name IS DISTINCT FROM source.craftsman_name OR
    target.craftsman_address IS DISTINCT FROM source.craftsman_address OR
    target.craftsman_birthday IS DISTINCT FROM source.craftsman_birthday OR
    target.craftsman_email IS DISTINCT FROM source.craftsman_email
) THEN
    UPDATE SET
        craftsman_name = source.craftsman_name,
        craftsman_address = source.craftsman_address,
        craftsman_birthday = source.craftsman_birthday,
        craftsman_email = source.craftsman_email,
        load_dttm = NOW()
WHEN NOT MATCHED THEN
    INSERT (craftsman_name, craftsman_address, craftsman_birthday, craftsman_email, source, craftsman_id_in_source, load_dttm)
    VALUES (source.craftsman_name, source.craftsman_address, source.craftsman_birthday, 
		source.craftsman_email, 1, source.craftsman_id, NOW());
    

	
	
	
	
	
	

-- Updates data and inserts new data related to customers into dwh.d_craftsman from source3
MERGE INTO dwh.d_customers AS target
USING source3.craft_market_customers AS source
ON target.customer_id_in_source = source.customer_id AND target.source = 3
WHEN MATCHED AND (
    target.customer_name IS DISTINCT FROM source.customer_name OR
    target.customer_address IS DISTINCT FROM source.customer_address OR
    target.customer_birthday IS DISTINCT FROM source.customer_birthday OR
    target.customer_email IS DISTINCT FROM source.customer_email
) THEN
    UPDATE SET
        customer_name = source.customer_name,
        customer_address = source.customer_address,
        customer_birthday = source.customer_birthday,
        customer_email = source.customer_email,
        load_dttm = NOW()
WHEN NOT MATCHED THEN
    INSERT (customer_name, customer_address, customer_birthday, customer_email, source, customer_id_in_source, load_dttm)
    VALUES (source.customer_name, source.customer_address, source.customer_birthday, 
		source.customer_email, 3, source.customer_id, NOW());




-- Updates data and inserts new data related to customers into dwh.d_customer from source2
MERGE INTO dwh.d_customers AS target
USING (
	select customer_id, customer_name, customer_address, customer_birthday, customer_email 
	from source2.craft_market_orders_customers
	group by customer_id, customer_name, customer_address, customer_birthday, customer_email
	) AS source
ON target.customer_id_in_source = source.customer_id AND target.source = 2
WHEN MATCHED AND (
    target.customer_name IS DISTINCT FROM source.customer_name OR
    target.customer_address IS DISTINCT FROM source.customer_address OR
    target.customer_birthday IS DISTINCT FROM source.customer_birthday OR
    target.customer_email IS DISTINCT FROM source.customer_email
) THEN
    UPDATE SET
        customer_name = source.customer_name,
        customer_address = source.customer_address,
        customer_birthday = source.customer_birthday,
        customer_email = source.customer_email,
        load_dttm = NOW()
WHEN NOT MATCHED THEN
    INSERT (customer_name, customer_address, customer_birthday, customer_email, source, customer_id_in_source, load_dttm)
    VALUES (source.customer_name, source.customer_address, source.customer_birthday, 
		source.customer_email, 2, source.customer_id, NOW());

-- Updates data and inserts new data related to customers into dwh.d_customer from source1
MERGE INTO dwh.d_customers AS target
USING (
	select customer_id, customer_name, customer_address, customer_birthday, customer_email 
	from source1.craft_market_wide
	group by customer_id, customer_name, customer_address, customer_birthday, customer_email
	) AS source
ON target.customer_id_in_source = source.customer_id AND target.source = 1
WHEN MATCHED AND (
    target.customer_name IS DISTINCT FROM source.customer_name OR
    target.customer_address IS DISTINCT FROM source.customer_address OR
    target.customer_birthday IS DISTINCT FROM source.customer_birthday OR
    target.customer_email IS DISTINCT FROM source.customer_email
) THEN
    UPDATE SET
        customer_name = source.customer_name,
        customer_address = source.customer_address,
        customer_birthday = source.customer_birthday,
        customer_email = source.customer_email,
        load_dttm = NOW()
WHEN NOT MATCHED THEN
    INSERT (customer_name, customer_address, customer_birthday, customer_email, source, customer_id_in_source, load_dttm)
    VALUES (source.customer_name, source.customer_address, source.customer_birthday, 
		source.customer_email, 1, source.customer_id, NOW());





-- Updates data and inserts new data related to products into dwh.d_products from source3
MERGE INTO dwh.d_products AS target
USING (
	select product_id, product_name, product_description, product_type, product_price
	from source3.craft_market_orders
	group by product_id, product_name, product_description, product_type, product_price
	) AS source
ON target.product_id_in_source = source.product_id AND target.source = 3
WHEN MATCHED AND (
    target.product_name IS DISTINCT FROM source.product_name OR
    target.product_description IS DISTINCT FROM source.product_description OR
    target.product_type IS DISTINCT FROM source.product_type OR
    target.product_price IS DISTINCT FROM source.product_price
) THEN
    UPDATE SET
        product_name = source.product_name,
        product_description = source.product_description,
        product_type = source.product_type,
        product_price = source.product_price,
        load_dttm = NOW()
WHEN NOT MATCHED THEN
    INSERT (product_name, product_description, product_type, product_price, source, product_id_in_source, load_dttm)
    VALUES (source.product_name, source.product_description, source.product_type, 
		source.product_price, 3, source.product_id, NOW());


-- Updates data and inserts new data related to products into dwh.d_products from source2
MERGE INTO dwh.d_products AS target
USING (
	select product_id, product_name, product_description, product_type, product_price
	from source2.craft_market_masters_products
	group by product_id, product_name, product_description, product_type, product_price
	) AS source
ON target.product_id_in_source = source.product_id AND target.source = 2
WHEN MATCHED AND (
    target.product_name IS DISTINCT FROM source.product_name OR
    target.product_description IS DISTINCT FROM source.product_description OR
    target.product_type IS DISTINCT FROM source.product_type OR
    target.product_price IS DISTINCT FROM source.product_price
) THEN
    UPDATE SET
        product_name = source.product_name,
        product_description = source.product_description,
        product_type = source.product_type,
        product_price = source.product_price,
        load_dttm = NOW()
WHEN NOT MATCHED THEN
    INSERT (product_name, product_description, product_type, product_price, source, product_id_in_source, load_dttm)
    VALUES (source.product_name, source.product_description, source.product_type, 
		source.product_price, 2, source.product_id, NOW());



-- Updates data and inserts new data related to products into dwh.d_products from source1
MERGE INTO dwh.d_products AS target
USING (
	select product_id, product_name, product_description, product_type, product_price
	from source1.craft_market_wide
	group by product_id, product_name, product_description, product_type, product_price
	) AS source
ON target.product_id_in_source = source.product_id AND target.source = 1
WHEN MATCHED AND (
    target.product_name IS DISTINCT FROM source.product_name OR
    target.product_description IS DISTINCT FROM source.product_description OR
    target.product_type IS DISTINCT FROM source.product_type OR
    target.product_price IS DISTINCT FROM source.product_price
) THEN
    UPDATE SET
        product_name = source.product_name,
        product_description = source.product_description,
        product_type = source.product_type,
        product_price = source.product_price,
        load_dttm = NOW()
WHEN NOT MATCHED THEN
    INSERT (product_name, product_description, product_type, product_price, source, product_id_in_source, load_dttm)
    VALUES (source.product_name, source.product_description, source.product_type, 
		source.product_price, 1, source.product_id, NOW());




-- Updates data and inserts new data related to orders into dwh.f_orders from source3
 INSERT INTO dwh.f_orders(product_id, craftsman_id, customer_id, order_created_date, order_completion_date, order_status,
 		source, order_id_in_source, product_id_in_source, craftsman_id_in_source, customer_id_in_source, load_dttm)
	SELECT dwh.d_products.product_id, dwh.d_craftsmans.craftsman_id, dwh.d_customers.customer_id,
		src.order_created_date, src.order_completion_date, src.order_status, 3, src.order_id, 
		src.product_id, src.craftsman_id, src.customer_id, NOW()
	FROM source3.craft_market_orders as src
	LEFT JOIN dwh.f_orders ON dwh.f_orders.source = 3 AND src.order_id = dwh.f_orders.order_id_in_source
	LEFT JOIN dwh.d_products ON dwh.d_products.source = 3 AND dwh.d_products.product_id_in_source = src.product_id
	LEFT JOIN dwh.d_craftsmans ON dwh.d_craftsmans.source = 3 AND dwh.d_craftsmans.craftsman_id_in_source = src.craftsman_id
	LEFT JOIN dwh.d_customers ON dwh.d_customers.source = 3 AND dwh.d_customers.customer_id_in_source = src.customer_id
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
	



-- Updates data and inserts new data related to orders into dwh.f_orders from source2
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




-- Updates data and inserts new data related to orders into dwh.f_orders from source1
 INSERT INTO dwh.f_orders(product_id, craftsman_id, customer_id, order_created_date, order_completion_date, order_status,
 		source, order_id_in_source, product_id_in_source, craftsman_id_in_source, customer_id_in_source, load_dttm)
	SELECT dwh.d_products.product_id, dwh.d_craftsmans.craftsman_id, dwh.d_customers.customer_id,
		src.order_created_date, src.order_completion_date, src.order_status, 1, src.order_id, 
		src.product_id, src.craftsman_id, src.customer_id, NOW()
	FROM source1.craft_market_wide AS src
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
FROM source1.craft_market_wide AS src
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
