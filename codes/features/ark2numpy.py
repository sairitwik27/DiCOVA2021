import kaldiio
import numpy as np
PARENT_DIR = "/home/oem/Desktop/DiCOVA"
FOLDER_PATH = "/home/oem/Desktop/DiCOVA/Coswara"
with open(FOLDER_PATH+"/feats.scp",'r') as f:
    for line in f:
        (key,rxfile) = line.split(' ')
        mfcc = kaldiio.load_mat(rxfile)
        np.save(PARENT_DIR+"/feats/mfcc/"+key,mfcc)
