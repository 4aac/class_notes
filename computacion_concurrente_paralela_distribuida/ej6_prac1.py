from memory_profiler import profile
import numpy as np

@profile(precision=6)
def types():
    a = np.random.rand(10**7).astype(np.float16)
    del a
    a = np.random.rand(10**7).astype(np.float32)
    del a
    a = np.random.rand(10**7).astype(np.float64)
    del a

@profile(precision=6)
def listas():
    a = [1] * (10 ** 7)
    b = [2] * (2 * 10 ** 7)
    c = a + b
    d = c
    del b
    a = None
    del c
    del d

@profile(precision=6)
def numpy():
    SIZE = int(1e4)
    a = np.random.rand(SIZE, SIZE)
    b = np.random.rand(SIZE, SIZE)
    b2 = b.copy()
    b3 = b
    c = a + b
    del b2
    del b3
    a = None
    d = np.random.rand(SIZE, SIZE)
    sum = np.sum(d)
    tr = d.T
    trcopy = d.T.copy()
    concat = np.concatenate((c, d), axis=0)
    split = np.split(concat, 2, axis=0)
    del c, d, tr, trcopy, concat, split

def main():
    types()
    listas()
    numpy()

if __name__ == '__main__':
    main()


# python -m memory_profiler ej6_prac1.py

# mprof run ej6_prac1.py
# mprof plot

