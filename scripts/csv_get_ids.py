import csv

input_file = '../data/lowlevel_json_1k.csv'
output_file = '../data/lowlevel_json_1k_ids.txt'

PROGRESS_DELTA = 100
count = 0
with open(input_file, 'r') as fp_in, open(output_file, 'w') as fp_out:
    reader = csv.reader(fp_in)
    for row in reader:
        if row:
            fp_out.write(row[0] + '\n')
            if count % PROGRESS_DELTA == 0:
                print('*', end='')
            count += 1
