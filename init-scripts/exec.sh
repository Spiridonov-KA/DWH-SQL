psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /data-for-sources/DDL_craft_market_source_1.sql
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /data-for-sources/DDL_craft_market_source_2.sql
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /data-for-sources/DDL_craft_market_source_3.sql
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /data-for-sources/fill_sources.sql > /dev/null
# psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /data-for-sources/set_seq1.sql > /dev/null
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /data-for-dwh/DDL_craft_market_dwh.sql
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /data-for-dwh/DDL_craft_market_datamart_increment.sql
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /data-for-dwh/fill_dwh.sql
