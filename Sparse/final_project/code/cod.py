import numpy as np



class CoD(object):
    """
    Learn sprse represintainon of input
    """

    def __init__(self, Wd,  max_iter=100, thresh=0.1, alpha=0.5):
        self.max_iter = max_iter
        self.thresh   = thresh
        self.alpha    = alpha
        self.Wd        = Wd


    def soft_threshold(self, x, threshold):
        ret = x
        j = np.abs(x) <= threshold
        ret[j] = 0
        ret = ret - np.sign(ret)*threshold
        return ret

    def run_cod(self, X, Wd=None, max_iter=None, thresh=None, alpha=None):
        """
        Find sparse representation via coordiant dicent.
        """
        Wd = self.Wd if Wd is None else Wd
        max_iter = self.max_iter if max_iter is None else max_iter
        thresh   = self.thresh   if thresh is None else thresh
        alpha   =  self.alpha    if alpha is None else alpha

        n, m  = Wd.shape
        # S = I - Wd*Wd^T
        S = np.eye(m) - np.einsum('ji, jk->ik', Wd, Wd)
        # B = Wd^T*X
        B = np.einsum('ij, ik->jk', Wd, X)
        Z_hist = []
        Z    = np.zeros((m, 1))

        for i in range(0, max_iter):
            print('iter %d'%i)
            Zhat = self.soft_threshold(B, alpha)
            res  = Zhat - Z
            k    = np.argmax(np.abs(res), axis=0)
            B    = B + S[...,k]*(res[k, range(res.shape[-1])])
            Z_hist.append(Z)
            Z[k] = Zhat[k]
            if np.linalg.norm(Z -  Z_hist[i], 2) < thresh : 
                break
        else:
            print('sparse rep did not converge broke after max iter')
        Z = self.soft_threshold(B, alpha)

        return (Z, Z_hist)
