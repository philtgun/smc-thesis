CREATE OR REPLACE FUNCTION mfcc(jsonb) RETURNS float
LANGUAGE sql
AS
$$
  SELECT ($1->'lowlevel'->'mfcc'->'mean'->>0)::float
$$;

DROP FUNCTION mfcc(jsonb);

CREATE OR REPLACE FUNCTION mfcc_dist(jsonb, jsonb) RETURNS float
LANGUAGE sql
AS
$$
  SELECT ABS(mfcc($1) - mfcc($2))
$$;


WITH
  target AS (SELECT data FROM lowlevel_json_1k LIMIT 1)
SELECT id, mfcc(lowlevel.data), mfcc(target.data), mfcc_dist(target.data, lowlevel.data)
FROM lowlevel_json_1k as lowlevel, target
ORDER BY mfcc_dist(target.data, lowlevel.data)
LIMIT 10;

SELECT * FROM lowlevel WHERE id=1546799 LIMIT 1;