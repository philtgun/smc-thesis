from __future__ import print_function
from gaia2 import *
from yaml import safe_dump
from json import loads
import resource

ds = DataSet()
data_file = 'data/lowlevel_json_1k.json'

counter = 0
limit = 1000
step = 10

print('Loading data', end='')
with open(data_file) as infile:
    for line in infile:
        data = loads(line)

        p = Point()
        p.loadFromString(safe_dump(data), ['lowlevel.*', 'rhythm.*', 'tonal.*'])

        p.setName('item' + str(counter))
        ds.addPoint(p)
        counter += 1
        # if counter % step == 0:
        print('.', end='')
        if counter >= limit:
            break

memory = resource.getrusage(resource.RUSAGE_SELF).ru_maxrss
print('Memory peak: {}'.format(memory))
