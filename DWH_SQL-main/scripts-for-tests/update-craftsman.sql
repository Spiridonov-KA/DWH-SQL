UPDATE source3.craft_market_craftsmans
SET craftsman_email = 'profi@gmail.com'
WHERE craftsman_name = 'Craftsmanovich Hammer';

UPDATE source2.craft_market_masters_products 
SET craftsman_email = 'profi@gmail.com'
WHERE craftsman_id = 997;
