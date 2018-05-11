
SELECT distinct highlevel FROM highlevel_model_1k limit 20;

DROP FUNCTION vec(int, int);

CREATE OR REPLACE FUNCTION vec(int, int) RETURNS float[]
LANGUAGE sql IMMUTABLE
AS
$$
  SELECT ARRAY(SELECT (jsonb_each_text(data->'all')).value::float - 1. / (SELECT count(*) FROM jsonb_each(data->'all')))
  FROM highlevel_model_1k WHERE model=$2 AND highlevel=$1;
$$;

CREATE OR REPLACE FUNCTION vec_prob(int, int) RETURNS float[]
LANGUAGE sql IMMUTABLE
AS
$$
  SELECT ARRAY(SELECT (jsonb_each_text(data->'all')).value::float)
  FROM highlevel_model_1k WHERE model=$2 AND highlevel=$1;
$$;


SELECT (jsonb_each_text(data->'all')).value::float - 1. / (SELECT count(*) FROM jsonb_each(data->'all'))
FROM highlevel_model_1k WHERE model=3 AND highlevel=1546799;


SELECT * FROM unnest(vec(1546799, 3), vec(1546799, 3)) AS t(x,y);


CREATE OR REPLACE FUNCTION dot(float[], float[]) RETURNS float
LANGUAGE plpgsql IMMUTABLE
AS
$$
DECLARE
  sum float;
  rec record;
BEGIN
  sum := 0;
FOR rec IN SELECT * FROM unnest($1, $2) AS t(x1, x2) LOOP
   sum := sum + rec.x1 * rec.x2;
END LOOP;
RETURN sum;
END
$$;

CREATE OR REPLACE FUNCTION pearson_sqr(int, int, int) RETURNS float
LANGUAGE sql IMMUTABLE
AS
$$
  SELECT (dot(vec($1, $3), vec($2, $3)) ^ 2) / (dot(vec($1, $3), vec($1, $3)) * dot(vec($2, $3), vec($2, $3)))
$$;

CREATE OR REPLACE FUNCTION pearson(int, int, int) RETURNS float
LANGUAGE sql IMMUTABLE
AS
$$
  SELECT dot(vec($1, $3), vec($2, $3))  / sqrt(dot(vec($1, $3), vec($1, $3)) * dot(vec($2, $3), vec($2, $3)))
$$;


SELECT pearson_sqr(1546800, 1546801, 3);

SELECT dot(vec(1546800, 3), vec(1546800, 3));
SELECT dot(vec(1546801, 3), vec(1546801, 3));
SELECT dot(vec(1546800, 3), vec(1546801, 3));
SELECT vec(1546800, 3), vec(1546801, 3);

EXPLAIN ANALYSE
SELECT id,
--   clas_pears_wm(id, 1546800) as dist
  pearson(id, 1546800, 3) as dist
FROM highlevel_model_1k AS highlevel_model
ORDER BY dist
LIMIT 10;

-- 19s
-- 27826868
-- 27826869
-- 27826870
-- 27826871
-- 27826872
-- 27826873
-- 27826874
-- 27826875
-- 27826876
-- 27826867


CREATE OR REPLACE FUNCTION clas_pears_wm(int, int) RETURNS float
LANGUAGE sql IMMUTABLE
AS
$$
  SELECT
    (pearson($1, $2, 3) + pearson($1, $2, 5) + pearson($1, $2, 6)) / 3 * 0.5 +
    (pearson($1, $2, 8) + pearson($1, $2, 9) + pearson($1, $2, 10) + pearson($1, $2, 11) + pearson($1, $2, 12)
     + pearson($1, $2, 13) + pearson($1, $2, 14) + pearson($1, $2, 18)) / 8 * 0.3 +
    (pearson($1, $2, 7)) / 1 * 0.2;
$$;

SELECT clas_pears_wm(1546800, 1546801);