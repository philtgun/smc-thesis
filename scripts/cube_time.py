import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit


def func(x, a, b, c):
    return a*np.log(x + b) + c


sizes = np.array([1000, 10_000, 100_000, 1_000_000, 8_000_000])
time = np.array([0.023, 0.03, 0.16, 1.1, 2.9])

popt, pcov = curve_fit(func, sizes, time, p0=(1, 0, 0))
plt.loglog(sizes, time, linestyle=' ', marker='o')
plt.loglog(sizes, func(sizes, *popt))
est = func(10_000_000, *popt)
print('Estimated usage at 10m: {}'.format(est))

plt.grid(which='minor', linestyle='--')
plt.grid(which='major', linestyle='-')
plt.title('Gaia memory usage')
plt.xlabel('Number of points')
plt.ylabel('Memory usage (MB)')
plt.savefig('cube.png', bbox_inches='tight')
plt.show()
