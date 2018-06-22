import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit


def func(x, a, b):
    return a*x + b


sizes = np.array([100, 300, 1000, 3000, 10000])
memory = np.array([25.3, 29.5, 44.5, 95.9, 266.7])

popt, pcov = curve_fit(func, sizes, memory, p0=(1, 0))
plt.loglog(sizes, memory, linestyle=' ', marker='o')
plt.loglog(sizes, func(sizes, *popt))
est = func(8_000_000, *popt)
print('Estimated usage at 8m: {}'.format(est))

plt.grid(which='minor', linestyle='--')
plt.grid(which='major', linestyle='-')
plt.title('Gaia memory usage')
plt.xlabel('Number of points')
plt.ylabel('Memory usage (MB)')
plt.show()

