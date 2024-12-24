-- INSERT INTO dwh.d_craftsmans (
--    craftsman_name,
--    craftsman_address,
--    craftsman_birthday,
--    craftsman_email,
--    source,
--    craftsman_id_in_source,
--    load_dttm
-- )
-- SELECT 
--    src.craftsman_name,
--    src.craftsman_address,
--    src.craftsman_birthday,
--    src.craftsman_email,
--    3,
--    src.craftsman_id,
--    CURRENT_TIMESTAMP
-- FROM source3.craft_market_craftsmans src
-- WHERE NOT EXISTS (
--    SELECT 1
--    FROM dwh.d_craftsmans dw
--    WHERE src.craftsman_id = dw.craftsman_id
-- );
--
-- INSERT INTO dwh.d_customers (
--    customer_name,
--    customer_address,
--    customer_birthday,
--    customer_email,
--    load_dttm
-- )
-- SELECT 
--    src.customer_name,
--    src.customer_address,
--    src.customer_birthday,
--    src.customer_email,
--    CURRENT_TIMESTAMP
-- FROM source3.craft_market_customers src
-- WHERE NOT EXISTS (
--    SELECT 1
--    FROM dwh.d_customers dw
--    WHERE src.customer_id = dw.customer_id
-- );
--
-- INSERT INTO dwh.d_products (product_name, product_description, product_type, product_price, load_dttm)
-- SELECT 
--    src.product_name,
--    src.product_description,
--    src.product_type,
--    src.product_price,
--    CURRENT_TIMESTAMP AS load_dttm
-- FROM 
--    source2.craft_market_masters_products src
-- WHERE 
--    NOT EXISTS (
--        SELECT 1 
--        FROM dwh.d_products dw
--        WHERE dw.product_id = src.product_id
--    );
--    
--    
-- INSERT INTO dwh.f_orders (
-- 	product_id,
--     craftsman_id,
--     customer_id,
--     order_created_date,
--     order_completion_date,
--     order_status,
--     load_dttm
-- )
-- SELECT 
-- 	src.product_id,
--     src.craftsman_id,
--     src.customer_id,
--     src.order_created_date,
--     src.order_completion_date,
--     src.order_status,
--     CURRENT_TIMESTAMP AS load_dttm
-- FROM 
--     source3.craft_market_orders src
-- WHERE 
--     NOT EXISTS (
--         SELECT 1 
--         FROM dwh.f_orders dw
--         WHERE src.order_id = dw.order_id
--     );