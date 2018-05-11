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

