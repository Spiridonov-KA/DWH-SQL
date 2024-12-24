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




-- -- -- Updates data and inserts new data related to orders into dwh.f_orders from source3
-- MERGE INTO dwh.f_orders AS target
-- USING source3.craft_market_orders AS source
-- ON target.order_id_in_source = source.order_id AND target.source = 3
-- WHEN MATCHED AND (
--     target.product_id_in_source IS DISTINCT FROM source.product_id OR
--     target.craftsman_id_in_source IS DISTINCT FROM source.craftsman_id OR
--     target.customer_id_in_source IS DISTINCT FROM source.customer_id OR
--     target.order_created_date IS DISTINCT FROM source.order_created_date OR
--     target.order_completion_date IS DISTINCT FROM source.order_completion_date OR
--     target.order_status IS DISTINCT FROM source.order_status
-- ) THEN
--     UPDATE SET
-- 		product_id = SELECT dw.product_id FROM dwh.d_products dw WHERE dw.source = 3 AND product_id_in_source = source.product_id,
--         product_id_in_source = source.product_id,
-- 		craftsman_id = (SELECT dw.craftsman_id FROM dwh.d_craftsmans dw WHERE dw.source = 3 AND dw.craftsman_id_in_source = source.craftsman_id), 
--         craftsman_id_in_source = source.craftsman_id,
--         customer_id_in_source = source.customer_id,
--         order_created_date = source.order_created_date,
--     	order_completion_date = source.order_completion_date,
--     	order_status = source.order_status,
--         load_dttm = NOW()
-- WHEN NOT MATCHED THEN
--     INSERT (product_id, craftsman_id, customer_id, order_created_date, order_completion_date,
-- 		order_status, source, order_id_in_source, product_id_in_source, craftsman_id_in_source, 
-- 		customer_id_in_source, load_dttm)
--     VALUES ((SELECT dw.product_id FROM dwh.d_products dw WHERE dw.source = 3 AND dw.product_id_in_source = source.product_id), 
-- 		(SELECT dw.craftsman_id FROM dwh.d_craftsmans dw WHERE dw.source = 3 AND dw.craftsman_id_in_source = source.craftsman_id),
-- 		source.customer_id, source.order_created_date, 
-- 		source.order_completion_date, source.order_status, 3, source.order_id, 8, 8, 8, NOW());
--
--
--
-- -- Updates data and inserts new data related to orders into dwh.f_orders from source3
-- MERGE INTO dwh.f_orders AS target
-- USING source1.craft_market_wide AS source
-- ON target.order_id_in_source = source.order_id AND target.source = 1
-- WHEN MATCHED AND (
--     target.product_id IS DISTINCT FROM source.product_id OR
--     target.craftsman_id IS DISTINCT FROM source.craftsman_id OR
--     target.customer_id IS DISTINCT FROM source.customer_id OR
--     target.order_created_date IS DISTINCT FROM source.order_created_date OR 
--     target.order_completion_date IS DISTINCT FROM source.order_completion_date OR
--     target.order_status IS DISTINCT FROM source.order_status
-- ) THEN
--     UPDATE SET
--         product_id = source.product_id,
--         craftsman_id = source.craftsman_id,
--         customer_id = source.customer_id,
--         order_created_date = source.order_created_date,
--     	order_completion_date = source.order_completion_date,
--     	order_status = source.order_status,
--         load_dttm = NOW()
-- WHEN NOT MATCHED THEN
--     INSERT (product_id, craftsman_id, customer_id, order_created_date, order_completion_date,
-- 		order_status, source, order_id_in_source, load_dttm)
--     VALUES (source.product_id, source.craftsman_id, source.customer_id, source.order_created_date, 
-- 		source.order_completion_date, source.order_status, (SELECT MAX(order_id) FROM source1.craft_market_wide), source.order_id, NOW());
