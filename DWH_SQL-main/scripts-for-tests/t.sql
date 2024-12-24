SELECT craft.load_dttm 
FROM dwh.d_craftsmans as craft
WHERE not EXISTS (SELECT 1 FROM dwh.load_dates_craftsman_report_datamart AS ld WHERE craft.craftsman_id = ld.id);