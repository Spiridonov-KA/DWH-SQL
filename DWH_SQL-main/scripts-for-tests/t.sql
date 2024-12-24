INSERT INTO dwh.load_dates_craftsman_report_datamart(load_dttm)
SELECT NOW() FROM dwh.craftsman_report_datamart AS rp
WHERE EXISTS (SELECT 1 FROM dwh.load_dates_craftsman_report_datamart AS ld WHERE rp.craftsman_id not in 
	(SELECT id FROM dwh.load_dates_craftsman_report_datamart));