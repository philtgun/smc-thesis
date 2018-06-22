CREATE EXTENSION IF NOT EXISTS cube;

DROP FUNCTION mfcc(jsonb);
CREATE OR REPLACE FUNCTION mfcc(jsonb) RETURNS cube
LANGUAGE sql IMMUTABLE
AS
$$
  SELECT cube(ARRAY(SELECT jsonb_array_elements_text($1->'lowlevel'->'mfcc'->'mean')::float)) AS mfcc
$$;

CREATE OR REPLACE FUNCTION mbid(jsonb) RETURNS text
LANGUAGE sql IMMUTABLE
AS
$$
  SELECT $1->'metadata'->'tags'->'musicbrainz_recordingid'->>0 as mbid
$$;

CREATE EXTENSION IF NOT EXISTS plsql;

CREATE OR REPLACE FUNCTION vector_bpm(jsonb) RETURNS DOUBLE PRECISION[]
LANGUAGE plpgsql IMMUTABLE
AS
$$
DECLARE temp double precision;
DECLARE result double precision[];
BEGIN
  temp := $1->'rhythm'->'bpm';
  temp := log(2.0, temp::numeric);
  RETURN ARRAY[cos(temp), sin(temp)];
END
$$;

SELECT vector_bpm(data) FROM lowlevel_json_1k LIMIT 1;