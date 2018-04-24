/* Create table of same structure */
CREATE TABLE lowlevel_json_30k (LIKE lowlevel_json);

/* Select a random sample from huge table ((n_rows * 100) / total_rows) */
SELECT * FROM lowlevel_json TABLESAMPLE system ((1000 * 100) / 8400000.0);

/* Get the size of the tables in database */
SELECT relname as "Table",
  pg_size_pretty(pg_total_relation_size(relid)) As "Size",
  pg_size_pretty(pg_total_relation_size(relid) - pg_relation_size(relid)) as "External Size"
  FROM pg_catalog.pg_statio_user_tables ORDER BY pg_total_relation_size(relid) DESC;

/* Get the size of biggest relations */
SELECT nspname || '.' || relname AS "relation",
    pg_size_pretty(pg_relation_size(C.oid)) AS "size"
  FROM pg_class C
  LEFT JOIN pg_namespace N ON (N.oid = C.relnamespace)
  WHERE nspname NOT IN ('pg_catalog', 'information_schema')
        AND relaname LIKE 'mfcc'
  ORDER BY pg_relation_size(C.oid) DESC
  LIMIT 20;