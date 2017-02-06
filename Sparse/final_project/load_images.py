import numpy as np
import tarfile as tar
from PIL import Image
import matplotlib.pyplot as plt
import os
import code.cod as sparse_CoD

def run_cod_on_patches(I, patch_size, dict_size):
    n, m = I.shape
    #TODO: smart patch extractor
    patch = I[np.floor(n/2):np.floor(n/2) + patch_size,
            np.floor(m/2):np.floor(m/2) + patch_size]
    patch = patch.reshape(patch_size ** 2, 1)
    p_mean = np.mean(patch)
    patch = patch - p_mean
    Wd_init = np.random.rand(patch_size ** 2, dict_size)
    col_norm = np.linalg.norm(Wd_init, axis=0)
    Wd_init = Wd_init / col_norm


def train_cod(image_dirpath):
    for f_img in os.listdir(image_dirpath):
        I = Image.open(f_img)
        I = np.asarray(I.convert('L')) 





   # I = Image.open('./images/BSDS300/images/test/101085.jpg')
   # I = np.asarray(I.convert('L'))
   # n, m = I.shape
   # patch_size = 10
   # patch = I[int(n/2):int(n/2) + patch_size,
        #int(m/2):int(m/2) + patch_size]
   #patch = patch.reshape(patch_size*patch_size, 1
   #p_mean = np.mean(patch)
   #patch = patch - p_mean
   #Wd_init = np.random.rand(patch_size ** 2, dict_size)
   #col_norm = np.linalg.norm(Wd_init, axis=0)
   #Wd_init = Wd_init / col_norm

