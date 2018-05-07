#!/usr/bin/env bash
psql -U acousticbrainz acousticbrainz -c "SELECT id FROM $1" -t > $1_ids.txt
psql -U acousticbrainz acousticbrainz -c "SELECT data FROM $1" -t > $1.json
