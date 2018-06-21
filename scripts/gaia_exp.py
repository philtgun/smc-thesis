from __future__ import print_function
from gaia2 import *
from yaml import safe_dump
from json import loads
import sys
import resource

ds = DataSet()
data_file = 'data/lowlevel_json_10k.json'

counter = 0
limit = 3000
step = 100

print('Loading data', end='')
with open(data_file) as infile:
    for line in infile:
        try:
            data = loads(line)

            p = Point()
            p.loadFromString(safe_dump(data), ['lowlevel.*', 'rhythm.*', 'tonal.*'])

            p.setName('item' + str(counter))
            ds.addPoint(p)

        except ValueError:
            pass

        if counter % step == 0:
            print('.', end='')
            sys.stdout.flush()
        counter += 1

        if counter >= limit:
            break



memory = resource.getrusage(resource.RUSAGE_SELF).ru_maxrss
print('Memory peak: {} mb'.format(float(memory)/1000))
