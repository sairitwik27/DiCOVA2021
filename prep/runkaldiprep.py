from kaldiprepfunc import *
import subprocess

FOLDER_PATH = "/home/oem/Desktop/DiCOVA/Coswara/healthy"
sub = [ f.path for f in os.scandir(FOLDER_PATH) if f.is_dir() ]
print(len(sub))

"""
Run this to get utt2spk and spk2utt file for aspire
"""

TEXT_PATH = 'utt2spk'
my_dict = uttspkdict(FOLDER_PATH)
writeuttspk(TEXT_PATH,my_dict,'append')

#subprocess.call(['sh','./getspk2utt.sh'])

"""
Run this to get the wavscp file for aspire
"""

SCP_PATH = '/home/oem/Desktop/DiCOVA/Coswara/wav.scp'

wavpathlist = []
my_dict = uttspkdict(FOLDER_PATH)
spkrlist = os.listdir(FOLDER_PATH)
spkrlist.sort()
for k in range(len(spkrlist)):
    spkr = spkrlist[k]
    utt = [x for x in os.listdir(FOLDER_PATH+"/"+spkrlist[k]) if x.endswith("fast.wav")]
    utt.sort()
    wavpathlist.append(sub[k]+"/"+utt[0])
    txt = gettext(wavpathlist[k],'aspire','convert')
    if(k==0):
        writescp(spkr,utt[0],txt,my_dict,SCP_PATH,'new')           
    else:
        writescp(spkr,utt[0],txt,my_dict,SCP_PATH,'append') 
