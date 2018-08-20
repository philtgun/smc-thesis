import json


def count(data):
    if isinstance(data, list):
        return len(data)
    if isinstance(data, dict):
        sum = 0
        for value in data.values():
            sum += count(value)
        return sum
    return 1


with open('tiny-data/pretty-data.json') as fp:
    data = json.load(fp)
    total = count(data['lowlevel']) + count(data['tonal']) + count(data['rhythm'])
    print("Total: {}".format(total))
