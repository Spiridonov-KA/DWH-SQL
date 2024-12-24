-- CREATE TABLE IF NOT EXISTS dwh.craftsman_report_datamart (
-- 	id BIGINT GENERATED ALWAYS AS IDENTITY NOT NULL, -- идентификатор записи
-- 	craftsman_id BIGINT NOT NULL, -- идентификатор мастера
-- 	craftsman_name VARCHAR NOT NULL, -- ФИО мастера
-- 	craftsman_address VARCHAR NOT NULL, -- адрес мастера
-- 	craftsman_birthday DATE NOT NULL, -- дата рождения мастера
-- 	craftsman_email VARCHAR NOT NULL, -- электронная почта мастера
-- 	craftsman_money NUMERIC(15,2) NOT NULL, -- сумма денег, которую заработал мастер (-10% на платформы) за месяц
-- 	platform_money BIGINT NOT NULL, -- сумма денег, которая заработала платформа от продаж мастера за месяц
-- 	count_order BIGINT NOT NULL, -- количество заказов у мастера за месяц
-- 	avg_price_order NUMERIC(10,2) NOT NULL, -- средняя стоимость одного заказа у мастера за месяц
-- 	avg_age_customer NUMERIC(3,1) NOT NULL, -- средний возраст покупателей
-- 	median_time_order_completed NUMERIC(10,1), -- медианное время в днях от момента создания заказа до его завершения  за месяц
-- 	top_product_category VARCHAR NOT NULL, -- самая популярная категория товаров у этого мастера  за месяц
-- 	count_order_created BIGINT NOT NULL, -- количество созданных заказов за месяц
-- 	count_order_in_progress BIGINT NOT NULL, -- количество заказов в процессе изготовки за месяц
-- 	count_order_delivery BIGINT NOT NULL, -- количество заказов в доставке за месяц
-- 	count_order_done BIGINT NOT NULL, -- количество завершенных заказов за месяц
-- 	count_order_not_done BIGINT NOT NULL, -- количество незавершенных заказов за месяц
-- 	report_period VARCHAR NOT NULL, -- отчетный период год и месяц
-- 	CONSTRAINT craftsman_report_datamart_pk PRIMARY KEY (id)
-- );

INSERT INTO dwh.craftsman_report_datamart (craftsman_id, craftsman_name, craftsman_address, craftsman_birthday,
		craftsman_email, craftsman_money, platform_money, count_order, avg_price_order,
		avg_age_customer, median_time_order_completed, top_product_category, count_order_created,
		count_order_in_progress, count_order_delivery, count_order_done, count_order_not_done, report_period)
SELECT dwh.d_craftsmans.craftsman_id,  dwh.d_craftsmans.craftsman_name, dwh.d_craftsmans.craftsman_address, 
	dwh.d_craftsmans.craftsman_birthday, dwh.d_craftsmans.craftsman_email, 
	ROUND(SUM(dwh.d_products.product_price) * 0.9, 2) AS earned,
	ROUND(SUM(dwh.d_products.product_price) * 0.1, 2) AS tax,
	-- SUM(dwh.d_products.product_price)  AS all_money,
	COUNT(dwh.d_craftsmans.craftsman_id),
	AVG(dwh.d_products.product_price),
	AVG(DATE_PART('YEAR', AGE(dwh.f_orders.order_created_date, dwh.d_customers.customer_birthday))),
	-- IF (dwh.f_orders.order_completion_date IS NULL, 0.0, 
	-- 	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY dwh.f_orders.order_completion_date - dwh.f_orders.order_created_date)),
	CASE WHEN dwh.f_orders.order_completion_date IS NULL THEN 0.0 
	ELSE PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY dwh.f_orders.order_completion_date - dwh.f_orders.order_created_date) END,
	(SELECT tmp_product.product_type
		FROM dwh.d_products tmp_product
		JOIN dwh.f_orders tmp_orders ON tmp_product.product_id = tmp_orders.product_id
		WHERE tmp_orders.craftsman_id = dwh.d_craftsmans.craftsman_id
		GROUP BY tmp_product.product_type
		ORDER BY COUNT(*) DESC LIMIT 1),
	COUNT(CASE WHEN dwh.f_orders.order_status = 'created' THEN 1 END) AS count_order_created,
	COUNT(CASE WHEN dwh.f_orders.order_status = 'in progress' THEN 1 END) AS count_order_in_progress,
	COUNT(CASE WHEN dwh.f_orders.order_status = 'delivery' THEN 1 END) AS count_order_delivery,
	COUNT(CASE WHEN dwh.f_orders.order_status = 'done' THEN 1 END) AS count_order_done,
	COUNT(CASE WHEN dwh.f_orders.order_status <> 'done' THEN 1 END) AS count_order_not_done,
	TO_CHAR(DATE_TRUNC('month', dwh.f_orders.order_created_date), 'YYYY-MM') AS report_period
FROM
	dwh.f_orders
	JOIN dwh.d_craftsmans ON dwh.d_craftsmans.craftsman_id = dwh.f_orders.craftsman_id
	JOIN dwh.d_customers ON dwh.d_customers.customer_id = dwh.f_orders.customer_id
	JOIN dwh.d_products ON dwh.d_products.product_id = dwh.f_orders.product_id 
WHERE
	dwh.d_craftsmans.craftsman_id NOT IN (SELECT craftsman_id FROM dwh.craftsman_report_datamart GROUP BY craftsman_id)
GROUP BY
		dwh.d_craftsmans.craftsman_id,
		dwh.d_craftsmans.craftsman_name,
		dwh.d_craftsmans.craftsman_address,
		dwh.d_craftsmans.craftsman_birthday,
		dwh.d_craftsmans.craftsman_email,
		dwh.f_orders.order_completion_date,
		DATE_TRUNC('month', dwh.f_orders.order_created_date),
		DATE_TRUNC('year', dwh.f_orders.order_created_date);

INSERT INTO dwh.load_dates_craftsman_report_datamart(load_dttm)
SELECT craft.load_dttm FROM dwh.craftsman_report_datamart AS rp, dwh.d_craftsmans as craft
WHERE EXISTS (SELECT 1 FROM dwh.load_dates_craftsman_report_datamart AS ld WHERE rp.craftsman_id not in 
	(SELECT id FROM dwh.load_dates_craftsman_report_datamart));


UPDATE dwh.craftsman_report_datamart 
SET
	craftsman_name = new_data.craftsman_name,
	craftsman_address = new_data.craftsman_address, 
	craftsman_birthday = new_data.craftsman_birthday, 
	craftsman_email = new_data.craftsman_email, 
	craftsman_money = new_data.craftsman_money,
	platform_money = new_data.platform_money,
	count_order = new_data.count_order,
	avg_price_order = new_data.avg_price_order,
	avg_age_customer = new_data.avg_age_customer,
	median_time_order_completed = new_data.median_time_order_completed, 
	top_product_category = new_data.top_product_category,
	count_order_created = new_data.count_order_created,
	count_order_in_progress = new_data.count_order_in_progress,
	count_order_delivery = new_data.count_order_delivery,
	count_order_done = new_data.count_order_done,
	count_order_not_done = new_data.count_order_not_done,
	report_period = new_data.report_period
FROM
	(
		SELECT dwh.d_craftsmans.craftsman_id,  dwh.d_craftsmans.craftsman_name, dwh.d_craftsmans.craftsman_address, 
			dwh.d_craftsmans.craftsman_birthday, dwh.d_craftsmans.craftsman_email, 
			ROUND(SUM(dwh.d_products.product_price) * 0.9, 2) AS craftsman_money,
			ROUND(SUM(dwh.d_products.product_price) * 0.1, 2) AS platform_money,
			-- SUM(dwh.d_products.product_price)  AS all_money,
			COUNT(dwh.d_craftsmans.craftsman_id) AS count_order,
			AVG(dwh.d_products.product_price) AS avg_price_order,
			AVG(DATE_PART('YEAR', AGE(dwh.f_orders.order_created_date, dwh.d_customers.customer_birthday))) AS avg_age_customer,
			-- IF (dwh.f_orders.order_completion_date IS NULL, 0.0, 
			-- 	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY dwh.f_orders.order_completion_date - dwh.f_orders.order_created_date)),
			CASE WHEN dwh.f_orders.order_completion_date IS NULL THEN 0.0 
			ELSE PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY dwh.f_orders.order_completion_date - dwh.f_orders.order_created_date) END AS median_time_order_completed,
			(SELECT tmp_product.product_type
				FROM dwh.d_products tmp_product
				JOIN dwh.f_orders tmp_orders ON tmp_product.product_id = tmp_orders.product_id
				WHERE tmp_orders.craftsman_id = dwh.d_craftsmans.craftsman_id
				GROUP BY tmp_product.product_type
				ORDER BY COUNT(*) DESC LIMIT 1) AS top_product_category,
			COUNT(CASE WHEN dwh.f_orders.order_status = 'created' THEN 1 END) AS count_order_created,
			COUNT(CASE WHEN dwh.f_orders.order_status = 'in progress' THEN 1 END) AS count_order_in_progress,
			COUNT(CASE WHEN dwh.f_orders.order_status = 'delivery' THEN 1 END) AS count_order_delivery,
			COUNT(CASE WHEN dwh.f_orders.order_status = 'done' THEN 1 END) AS count_order_done,
			COUNT(CASE WHEN dwh.f_orders.order_status <> 'done' THEN 1 END) AS count_order_not_done,
			TO_CHAR(DATE_TRUNC('month', dwh.f_orders.order_created_date), 'YYYY-MM') AS report_period
		FROM
			dwh.f_orders
			JOIN dwh.d_craftsmans ON dwh.d_craftsmans.craftsman_id = dwh.f_orders.craftsman_id
			JOIN dwh.d_customers ON dwh.d_customers.customer_id = dwh.f_orders.customer_id
			JOIN dwh.d_products ON dwh.d_products.product_id = dwh.f_orders.product_id 
		WHERE
			dwh.d_craftsmans.craftsman_id NOT IN (SELECT craftsman_id FROM dwh.craftsman_report_datamart GROUP BY craftsman_id)
		GROUP BY
				dwh.d_craftsmans.craftsman_id,
				dwh.d_craftsmans.craftsman_name,
				dwh.d_craftsmans.craftsman_address,
				dwh.d_craftsmans.craftsman_birthday,
				dwh.d_craftsmans.craftsman_email,
				dwh.f_orders.order_completion_date,
				DATE_TRUNC('month', dwh.f_orders.order_created_date),
				DATE_TRUNC('year', dwh.f_orders.order_created_date)
	) AS new_data, dwh.d_craftsmans AS craftsmans, dwh.load_dates_craftsman_report_datamart AS loadings
WHERE
	craftsmans.craftsman_id = loadings.id AND 
		craftsmans.load_dttm <> loadings.load_dttm;

UPDATE dwh.load_dates_craftsman_report_datamart
SET 
	load_dttm = craftsmans.load_dttm
FROM dwh.d_craftsmans AS craftsmans
WHERE craftsmans.craftsman_id = dwh.load_dates_craftsman_report_datamart.id AND dwh.load_dates_craftsman_report_datamart.load_dttm <> craftsmans.load_dttm
