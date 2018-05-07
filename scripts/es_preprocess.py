data_file = 'data/lowlevel_json_1k.json'
ids_file = 'data/lowlevel_json_1k_ids.txt'
output_file = 'data/lowlevel_json_1k_es.json'

PROGRESS_DELTA = 100
count = 0

with open(data_file, 'r') as fp_data, open(ids_file, 'r') as fp_ids, open(output_file, 'w') as fp_out:
    for index, (data, db_id) in enumerate(zip(fp_data, fp_ids)):
        if data.strip() and db_id.strip():
            fp_out.write('{"index":{"_id":"%s"}}\n' % db_id.strip())
            fp_out.write(data.strip() + '\n')

            if count % PROGRESS_DELTA == 0:
                print('*', end='')
            count += 1

