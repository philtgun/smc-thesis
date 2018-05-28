import numpy as np
import matplotlib.pyplot as plt
import scipy.spatial.distance as dist

theta = np.arange(0, np.pi, 0.01)
cos = 1 - np.cos(theta)
eucl = 2 * np.sin(theta / 2)
manh = np.abs(np.sin(theta)) + np.abs(np.cos(theta) - 1)
cheb = [dist.chebyshev([0, 1], [np.sin(phi), np.cos(phi)]) for phi in theta]

plt.figure(figsize=[8, 4])
plt.plot(theta, cos)
plt.plot(theta, eucl)
plt.plot(theta, manh)
plt.plot(theta, cheb)
plt.grid()
plt.legend(['Cosine', 'Euclidean', 'Manhattan', 'Chebushev'])
plt.title('Distance comparison')
plt.savefig('dist.png')
plt.show()
