from __future__ import print_function
from gaia2 import *
from yaml import safe_dump
from json import loads
import sys
import resource

ds = DataSet()
data_file = 'data/lowlevel_json_10k.json'

counter = 0
limit = 10000
step = 1000

# descriptors = ['lowlevel.*', 'rhythm.*', 'tonal.*']
descriptors = [
    'rhythm.bpm',
    'rhythm.onset_rate',
    'lowlevel.mfcc.mean',
    'lowlevel.gfcc.mean'
]

print('Loading data', end='')
with open(data_file) as infile:
    for line in infile:
        try:
            data = loads(line)

            p = Point()
            p.loadFromString(safe_dump(data), descriptors)

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


def get_memory(context):
    memory = resource.getrusage(resource.RUSAGE_SELF).ru_maxrss
    print('Memory ({}): {} mb'.format(context, float(memory)/1000))


get_memory('Dataset')

dist = DistanceFunctionFactory.create('euclidean', ds.layout())
view = View(ds, dist)
similar = view.nnSearch('item0').get(10)

get_memory('Metric and view')
