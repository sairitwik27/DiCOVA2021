import glob
import re
import pathlib
import os
import numpy as np
def uttspkdict(FOLDER_PATH):
    spkrlist = os.listdir(FOLDER_PATH)
    spkrlist.sort()
    uttspk = {}
    for a in range(len(spkrlist)):
        uttspk[spkrlist[a]] = [x for x in os.listdir(FOLDER_PATH+'/'+str(spkrlist[a])) if x.endswith("fast.wav")]
    return uttspk

def writeuttspk(TEXT_PATH,dictionary,mode):
    d_keys = dictionary.keys()
    newlines = []
    for spkr in d_keys:
        for utt in dictionary[spkr]:
            newline = spkr+'-'+utt + ' ' + spkr        
            newlines.append(newline)
    if (mode == 'new'):
        with open(TEXT_PATH,'w') as f:
            f.write("\n".join(newlines))
    elif (mode == 'append'):
        with open(TEXT_PATH,'a') as f:
            f.write("\n".join(newlines))
            f.write("\n")
    else:
        raise ValueError('Mode Not supported')
    return 


def getwavpath(FOLDER_PATH):
    my_list = list(pathlib.Path(FOLDER_PATH).glob('*fast.wav'))
    my_list = [x.as_posix() for x in my_list]
    my_list.sort()
    return my_list

def gettext(wavpath,asr,mode):
    if(asr == 'aspire'):
        if (mode == 'convert'):
            text = "/usr/bin/sox -t wav " + wavpath + " -c 1 -b 16 -r 8000 -t wav - |"
        elif(mode == 'direct'):
            text = wavpath
    elif(asr == 'timit'):
        if (mode == 'convert'):
            text = "/home/oem/Desktop/kaldi/egs/timit/s5/../../../tools/sph2pipe_v2.5/sph2pipe -f wav " + wavpath + " |"
        elif(mode == 'direct'):
            text = wavpath
    return text

def writescp(spkr,utt,text,dictionary,TEXT_PATH,mode):
    d_keys = dictionary.keys()
    newlines = []
    newline = spkr+'-'+utt + ' ' + text        
    newlines.append(newline)
    if (mode == 'new'):
        with open(TEXT_PATH,'w') as f:
            f.write("\n".join(newlines))
    elif (mode == 'append'):
        with open(TEXT_PATH,'a') as f:
            f.write("\n")
            f.write("\n".join(newlines))
    else:
        raise ValueError('Mode Not supported')
    return 

