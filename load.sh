#!/usr/bin/env bash
curl -H 'Content-Type: application/json' -XPOST 'localhost:9200/test/data' -d @tiny-data/pretty-data.json