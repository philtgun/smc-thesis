import numpy as np

x1 = [-0.11029978758759011,-0.10912281983635111,-0.10797208231977111,-0.10781844389728111,-0.11095373101286711,0.84405916266988880,-0.08134515500731110,-0.10564113465241111,-0.11090601724734210]
x2 = [-0.09831040176671110,-0.10238704375095110,-0.07875737837621110,-0.07884336925211110,-0.10796336467481110,0.39482974343788885,0.15524955921688888,0.020146005683888885,-0.10396372770063110]

x1 = np.array(x1)
x2 = np.array(x2)

n1 = np.dot(x1, x1)
n2 = np.dot(x2, x2)
d = np.dot(x1, x2)

print(n1, n2, d, (d * d)/(n1*n2))