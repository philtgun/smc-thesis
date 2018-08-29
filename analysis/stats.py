import csv
import numpy as np
import matplotlib.pyplot as plt

filename = 'results_20180829.csv'
data = []
with open(filename, 'r') as fp:
    reader = csv.reader(fp, delimiter=',')
    next(reader, None)
    for row in reader:
        data.append(row)

results = {}
bias_recording = {}


def create_or_append(target, key, value):
    if key not in target:
        target[key] = np.array([])
    target[key] = np.append(target[key], value)


for mbid, metric, rating in data:
    create_or_append(results, metric, int(rating))
    create_or_append(bias_recording, mbid, int(rating))


def print_stats(data):
    for key, values in data.items():
        print('{:20} {:.2f} {:.2f} {:2}'.format(key, np.mean(values), np.std(values), len(values)))


print('Metric mean ratings:')
print_stats(results)

print('Recording mean ratings (bias):')
print_stats(bias_recording)

metrics_all = {
    'timbre': ['mfccs', 'mfccsw', 'gfccs', 'gfccsw'],
    'rhythm': ['bpm', 'bpm_onsetrate', 'bpm_onsetrate_key'],
    'highlevel': ['instruments', 'moods', 'rosamerica', 'dortmund']
}

plt.ioff()


def plot(data, keys, labels, title, filename):
    fig, ax = plt.subplots()
    x = np.arange(len(keys))
    y = [np.mean(data[key]) for key in keys]
    yerr = [np.std(data[key]) for key in keys]
    ax.errorbar(x, y, yerr, linestyle='None', marker='o')
    for y in np.arange(3):
        ax.axhline(y=y, color='red', linestyle=':')
    ax.set_xticks(x)
    ax.set_xticklabels(labels)
    ax.set_title(title)
    plt.savefig(filename, bbox_inches='tight')
    plt.close(fig)


for category, metrics in metrics_all.items():
    plot(results, metrics, metrics, 'BROAD evaluation ({})'.format(category), 'broad-{}.png'.format(category))

plot(bias_recording, bias_recording.keys(), [s[:4] for s in bias_recording.keys()], 'Mean evaluation score per track',
     'broad-bias.png')
