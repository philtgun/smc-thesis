SELECT * FROM lowlevel_json_1k WHERE id=1546799 LIMIT 1;
SELECT * FROM lowlevel_json_10k WHERE id=3791 LIMIT 1;
SELECT id FROM lowlevel_json_10k LIMIT 3;

SELECT id, mfcc(data) FROM lowlevel_json_10k LIMIT 1;

SELECT ARRAY[1,2];

CREATE INDEX lowlevel_json_10k_mfcc_gist_idx ON lowlevel_json_10k USING gist(cube(mfcc(data)));

DROP INDEX lowlevel_json_10k_mfcc_gist_idx;