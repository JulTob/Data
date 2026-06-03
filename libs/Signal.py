class Signal(list):
    import random
    from random import choices, seed
    def __init__(self, X, P, seed=0):
        self.X = X
        self.P = P
        self.__seed__ = seed
        self.rng = random.Random(seed)
    
    def seed(self, seed_val=0):
        if seed_val:
            self.rng.seed(seed_val)
        else:
            self.rng.seed(self.__seed__)
    
    def mean(self):
        return sum(
            [x * self.P[x] 
            for x in self.X])
    
    def var(self):
        mean = self.mean()
        return sum(
            [(x - mean)**2 * self.P[x] 
            for x in self.X])
        
    def __getitem__(self, key):
        if isinstance(key, slice):
            start = key.start or 0
            stop = key.stop or start + 1
            k = max(0, stop - start)
            self.seed(start)
            return self.rng.choices(self.X, self.P, k=k)
        else:
            self.seed(key)
            return self.rng.choices(self.X, self.P, k=1)[0]

