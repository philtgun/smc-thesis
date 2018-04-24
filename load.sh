#!/usr/bin/env bash
curl -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9200/ab-test/data/_bulk?pretty' --data-binary @data/lowlevel_json_3.json