import csv
import numpy as np
import matplotlib.pyplot as plt
import scipy.stats as stats
import itertools

filename = 'results_20180829.csv'
data = []
with open(filename, 'r') as fp:
    reader = csv.reader(fp, delimiter=',')
    next(reader, None)
    for row in reader:
        data.append(row)

results_metrics = {}
bias_recording = {}

tracks_labels = {
    'ebf79ba5-085e-48d2-9eb8-2d992fbf0f6d': 'Queen',
    '8d5f76cf-0fa1-45a1-8464-68053d03b46b': 'Amorphis',
    '919a494b-dccc-4801-8aff-779ba574afae': 'McTell',
    '47974dfd-f37d-4f41-b952-18a86af009d2': 'Skrillex',
    '0cdc9b5b-b16b-4ff1-9f16-5b4ba76f1c17': 'Beatles',
    'b7ffa922-7bb8-4703-aa51-3bcc6d9cc364': 'H.Shore'
}


def create_or_append(target, key, value):
    if key not in target:
        target[key] = np.array([])
    target[key] = np.append(target[key], value)


for mbid, metric, rating in data:
    create_or_append(results_metrics, metric, int(rating))
    create_or_append(bias_recording, tracks_labels[mbid], int(rating))


def print_stats(data):
    for key, values in data.items():
        print('{:20} {:.2f} {:.2f} {:2}'.format(key, np.mean(values), np.std(values), len(values)))


print('Metric mean ratings:')
print_stats(results_metrics)

print('Recording mean ratings (bias):')
print_stats(bias_recording)

metrics_all = {
    'timbre': ['mfccs', 'mfccsw', 'gfccs', 'gfccsw'],
    'rhythm': ['bpm', 'bpm_onsetrate', 'bpm_onsetrate_key'],
    'highlevel': ['instruments', 'moods', 'rosamerica', 'dortmund']
}


for metrics in metrics_all.values():
    for m1, m2 in itertools.combinations(metrics, 2):
        t, p = stats.ttest_ind(results_metrics[m1], results_metrics[m2])
        print('{} - {}: t={:.2f}, p={:.2f}'.format(m1, m2, t, p))


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


# for category, metrics in metrics_all.items():
#     plot(results, metrics, metrics, 'BROAD evaluation ({})'.format(category), 'broad-{}.png'.format(category))


plot(bias_recording, bias_recording.keys(), bias_recording.keys(), 'Mean evaluation score per track', 'broad-bias.png')
