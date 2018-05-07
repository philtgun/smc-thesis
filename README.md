# Exploring Music Similarity with AcousticBrainz

## How to transfer data to ElasticSearch

- Run `export.sh lowlevel_json_1k` on server with data, it will produce 2 files:
  - `lowlevel_json_1k.json` - important json data
  - `lowlevel_json_1k_ids.txt` - db indexes
- Copy those files to elasticsearch server into `data` folder
- Run `import.sh lowlevel_json_1k` from same level as `data` folder
