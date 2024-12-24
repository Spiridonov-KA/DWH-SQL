-- schema source1 table craft_market_wide
COPY source1.craft_market_wide (id, craftsman_id, craftsman_name, craftsman_address, craftsman_birthday, craftsman_email,
product_id, product_name, product_description, product_type, product_price,
order_id, order_created_date, order_completion_date, order_status,
customer_id, customer_name, customer_address, customer_birthday, customer_email)
FROM '/data-for-sources/complete_craft_market_wide_20230730.csv'
DELIMITER ','
CSV header;

SELECT setval(pg_get_serial_sequence('source1.craft_market_wide', 'id'), 
	coalesce(max(id), 0) + 1, false) FROM source1.craft_market_wide;

-- schema source2 table craft_market_masters_products 
copy source2.craft_market_masters_products (craftsman_id, craftsman_name, craftsman_address, craftsman_birthday, craftsman_email, 
product_id, product_name, product_description, product_type, product_price)
FROM '/data-for-sources/complete_craft_market_masters_products_202305071535.csv'
DELIMITER ','
CSV header;

SELECT setval(pg_get_serial_sequence('source2.craft_market_masters_products ', 'craftsman_id'), 
	coalesce(max(craftsman_id), 0) + 1, false) FROM source2.craft_market_masters_products;


-- schema source2 table craft_market_orders_customers  
copy source2.craft_market_orders_customers (order_id, craftsman_id, product_id, order_created_date, order_completion_date, order_status, 
customer_id, customer_name, customer_address, customer_birthday, customer_email)
FROM '/data-for-sources/complete_craft_market_orders_customers_202305071535.csv'
DELIMITER ','
CSV header;

SELECT setval(pg_get_serial_sequence('source2.craft_market_orders_customers', 'order_id'), 
	coalesce(max(order_id), 0) + 1, false) FROM source2.craft_market_orders_customers;



-- schema source3 table craft_market_orders_craftsmans  
copy source3.craft_market_craftsmans (craftsman_id, craftsman_name, craftsman_address, craftsman_birthday, craftsman_email)
FROM '/data-for-sources/complete_craft_market_craftsmans_202305071534.csv'
DELIMITER ','
CSV header;

SELECT setval(pg_get_serial_sequence('source3.craft_market_craftsmans', 'craftsman_id'), 
	coalesce(max(craftsman_id), 0) + 1, false) FROM source3.craft_market_craftsmans;


-- schema source3 table craft_market_orders_customers  
copy source3.craft_market_customers (customer_id, customer_name, customer_address, customer_birthday, customer_email)
FROM '/data-for-sources/complete_craft_market_customers_202305071535.csv'
DELIMITER ','
CSV header;

SELECT setval(pg_get_serial_sequence('source3.craft_market_customers', 'customer_id'), 
	coalesce(max(customer_id), 0) + 1, false) FROM source3.craft_market_customers;


-- schema source3 table craft_market_orders_orders  
copy source3.craft_market_orders (order_id, product_id, craftsman_id, customer_id, order_created_date, order_completion_date, 
order_status, product_name, product_description, product_type, product_price)
FROM '/data-for-sources/complete_craft_market_orders_202305071535.csv'
DELIMITER ','
CSV header;

SELECT setval(pg_get_serial_sequence('source3.craft_market_orders', 'order_id'), 
	coalesce(max(order_id), 0) + 1, false) FROM source3.craft_market_orders;
