/* Select a random sample from huge table ((n_rows * 100) / total_rows) */
SELECT * FROM lowlevel_json TABLESAMPLE system ((1000 * 100) / 8400000.0);

/* Get the size of the tables in database */
SELECT relname as "Table",
  pg_size_pretty(pg_total_relation_size(relid)) As "Size",
  pg_size_pretty(pg_total_relation_size(relid) - pg_relation_size(relid)) as "External Size"
  FROM pg_catalog.pg_statio_user_tables ORDER BY pg_total_relation_size(relid) DESC;