--INSERT INTO dwh.d_craftsmans (
--    craftsman_name,
--    craftsman_address,
--    craftsman_birthday,
--    craftsman_email,
--    load_dttm
--)
--SELECT 
--    scm.craftsman_name,
--    scm.craftsman_address,
--    scm.craftsman_birthday,
--    scm.craftsman_email,
--    CURRENT_TIMESTAMP
--FROM source3.craft_market_craftsmans scm
--WHERE NOT EXISTS (
--    SELECT 1
--    FROM dwh.d_craftsmans dcm
--    WHERE scm.craftsman_id = dcm.craftsman_id
--);
--
--INSERT INTO dwh.d_customers (
--    customer_name,
--    customer_address,
--    customer_birthday,
--    customer_email,
--    load_dttm
--)
--SELECT 
--    src.customer_name,
--    src.customer_address,
--    src.customer_birthday,
--    src.customer_email,
--    CURRENT_TIMESTAMP
--FROM source3.craft_market_customers src
--WHERE NOT EXISTS (
--    SELECT 1
--    FROM dwh.d_customers tgt
--    WHERE src.customer_id = tgt.customer_id
--);
--
--INSERT INTO dwh.d_products (product_name, product_description, product_type, product_price, load_dttm)
--SELECT 
--    p.product_name,
--    p.product_description,
--    p.product_type,
--    p.product_price,
--    CURRENT_TIMESTAMP AS load_dttm
--FROM 
--    source2.craft_market_masters_products p
--WHERE 
--    NOT EXISTS (
--        SELECT 1 
--        FROM dwh.d_products dp
--        WHERE dp.product_id = p.product_id
--    );
   
   
   
TRUNCATE TABLE dwh.f_orders RESTART IDENTITY;

INSERT INTO dwh.f_orders (
    craftsman_id,
    customer_id,
    order_created_date,
    order_completion_date,
    order_status,
    load_dttm
)
SELECT 
    cmo.craftsman_id,
    cmo.customer_id,
    cmo.order_created_date,
    cmo.order_completion_date,
    cmo.order_status,
    CURRENT_TIMESTAMP AS load_dttm
FROM 
    source3.craft_market_orders cmo
WHERE 
    NOT EXISTS (
        SELECT 1 
        FROM dwh.f_orders fo
        WHERE cmo.order_id = fo.order_id
    );