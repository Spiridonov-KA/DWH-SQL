-- This test creates a new product, new customer, new craftsman and order for this craftsman


INSERT INTO source3.craft_market_craftsmans(craftsman_name, craftsman_address, craftsman_birthday, craftsman_email)
VALUES
	('Craftsmanovich Hammer', 'Craftsmgorod', '2000-02-02', 'craf@gmail.com');

INSERT INTO source3.craft_market_customers(customer_name, customer_address, customer_birthday, customer_email)
VALUES
	('Lion', 'Moscow', '2000-02-02', 'lion@gmail.com');

INSERT INTO source3.craft_market_orders(product_id, craftsman_id, customer_id, order_created_date, order_completion_date,
	order_status, product_name, product_description, product_type, product_price)
VALUES
	(1000, (SELECT craftsman_id FROM source3.craft_market_craftsmans WHERE craftsman_name = 'Craftsmanovich Hammer'), 
		(SELECT customer_id FROM source3.craft_market_customers WHERE customer_name = 'Lion'), NOW(), NULL, 'in progress',
		'toy', 'cowboy', 'toy', 23231);
