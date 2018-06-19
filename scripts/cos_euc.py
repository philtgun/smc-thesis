import numpy as np
import numpy.linalg as la
import matplotlib.pyplot as plt
import scipy.spatial.distance as dist

probs = np.arange(0, 1, 0.01)
theta = np.arange(0, np.pi, 0.01)


def uniform_angle():
    return np.array([[np.cos(phi), np.sin(phi)] for phi in theta])


def prob_vector():
    return np.array([[1 - p, p] for p in probs])


def sub_mean(vectors):
    return np.array([vector - vector.mean() for vector in vectors])


def norm(vectors):
    return np.array([vector / la.norm(vector) for vector in vectors])


distances = {
    'Cosine': dist.cosine,
    'Manhattan (L1)': dist.cityblock,
    'Euclidean (L2)': dist.euclidean,
    'Chebushev (L-inf)': dist.chebyshev
}

plt.figure(figsize=[8, 4])
for name, func in distances.items():
    vals = np.array([func([1, 0], vector) for vector in sub_mean(prob_vector())])
    vals = vals / vals.max()
    plt.plot(probs, vals)

plt.grid()
plt.legend(distances.keys())
plt.title('Distance comparison')
plt.savefig('pears.png', bbox_inches='tight')
plt.show()
