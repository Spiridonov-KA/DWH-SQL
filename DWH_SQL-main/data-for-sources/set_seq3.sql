-- SELECT setval(pg_get_serial_sequence('source1.craft_market_wide', 'id'), 
-- 	coalesce(max(id), 0) + 1, false) FROM source1.craft_market_wide;
--
-- SELECT setval(pg_get_serial_sequence('source2.craft_market_masters_products ', 'craftsman_id'), 
-- 	coalesce(max(craftsman_id), 0) + 1, false) FROM source2.craft_market_masters_products;

SELECT setval(pg_get_serial_sequence('source2.craft_market_masters_customers', 'order_id'), 
	coalesce(max(order_id), 0) + 1, false) FROM source2.craft_market_masters_customers;

-- SELECT setval(pg_get_serial_sequence('source3.craft_market_craftsmans', 'craftsman_id'), 
-- 	coalesce(max(craftsman_id), 0) + 1, false) FROM source3.craft_market_craftsmans;
--
-- SELECT setval(pg_get_serial_sequence('source3.craft_market_orders', 'order_id'), 
-- 	coalesce(max(order_id), 0) + 1, false) FROM source3.craft_market_orders;
--
-- SELECT setval(pg_get_serial_sequence('source3.craft_market_customers', 'customer_id'), 
-- 	coalesce(max(customer_id), 0) + 1, false) FROM source3.craft_market_customers;
