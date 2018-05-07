#!/usr/bin/env bash
curl -H 'Content-Type: application/json' -XPUT "localhost:9200/$1" -d @schemas/lowlevel-schema-es-new.json
curl -H 'Content-Type: application/x-ndjson' -XPOST "localhost:9200/$1/lowlevel_data/_bulk?pretty" --data-binary @data/$1_es.json
