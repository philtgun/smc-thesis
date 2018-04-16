-- EXPLAIN ANALYZE
SELECT id
FROM lowlevel_json_10k AS lowlevel_json
ORDER BY cube(mfcc(lowlevel_json.data)) <-> (SELECT cube(mfcc(data)) FROM lowlevel_json_10k WHERE id=3792)
LIMIT 10;
