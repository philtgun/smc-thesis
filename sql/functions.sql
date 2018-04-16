CREATE EXTENSION IF NOT EXISTS cube;

CREATE OR REPLACE FUNCTION mfcc(jsonb) RETURNS float[]
LANGUAGE sql IMMUTABLE
AS
$$
  SELECT ARRAY(SELECT jsonb_array_elements_text($1->'lowlevel'->'mfcc'->'mean')::float) AS mfcc
$$;

CREATE OR REPLACE FUNCTION mbid(jsonb) RETURNS text
LANGUAGE sql IMMUTABLE
AS
$$
  SELECT $1->'metadata'->'tags'->'musicbrainz_recordingid'->>0 as mbid
$$;

CREATE OR REPLACE FUNCTION mfcc_dist(jsonb, jsonb) RETURNS float
LANGUAGE sql IMMUTABLE
AS
$$
  SELECT ABS(mfcc($1)->>0, mfcc($2)->>0)
$$;
