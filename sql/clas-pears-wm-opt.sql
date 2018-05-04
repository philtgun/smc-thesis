
SELECT distinct highlevel FROM highlevel_model_1k limit 20;

DROP FUNCTION vec(int, int);
DROP FUNCTION cvec(jsonb);

CREATE OR REPLACE FUNCTION cvec(jsonb) RETURNS cube
LANGUAGE sql IMMUTABLE
AS
$$
  SELECT cube(ARRAY(SELECT (jsonb_each_text($1->'all')).value::float - 1. / (SELECT count(*) FROM jsonb_each($1->'all'))));
$$;

SELECT cvec(data) FROM highlevel_model_1k WHERE highlevel=1546799 AND model=3;

CREATE INDEX highlevel_model_1k_cvec_gist_idx ON highlevel_model_1k USING gist(cvec(data));
DROP INDEX highlevel_model_1k_cvec_gist_idx;

CREATE OR REPLACE FUNCTION dot(cube, cube) RETURNS float
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

CREATE OR REPLACE FUNCTION dist_pearson(cube, cube) RETURNS float
LANGUAGE sql IMMUTABLE
AS
$$
  SELECT dot(vec($1, $3), vec($2, $3))  / sqrt(dot(vec($1, $3), vec($1, $3)) * dot(vec($2, $3), vec($2, $3)))
$$;

CREATE OPERATOR <%>



SELECT (jsonb_each_text(data->'all')).value::float - 1. / (SELECT count(*) FROM jsonb_each(data->'all'))
FROM highlevel_model_1k WHERE model=3 AND highlevel=1546799;


SELECT * FROM unnest(vec(1546799, 3), vec(1546799, 3)) AS t(x,y);




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
SELECT id
FROM highlevel_model_1k AS highlevel_model
ORDER BY clas_pears_wm(id, 1546800)
LIMIT 10;

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