lattice-to-post --acoustic-scale=0.1 "ark:gunzip -c exp/tdnn_7b_chain_online/decode_ASR_demo/lat.4.gz|" ark:- | post-to-phone-post exp/tdnn_7b_chain_online/final.mdl ark:- ark,t:post4.txt
