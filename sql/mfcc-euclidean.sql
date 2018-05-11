-- EXPLAIN ANALYZE
SELECT id, mbid(data)
FROM lowlevel_json_10k AS lowlevel_json
ORDER BY mfcc(data) <-> (SELECT mfcc(data) FROM lowlevel_json_10k WHERE id=3792)
LIMIT 10;
