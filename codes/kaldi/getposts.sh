steps/online/nnet3/prepare_online_decoding.sh --mfcc-config conf/mfcc_hires.conf data/lang_chain exp/nnet3/extractor exp/chain/tdnn_7b exp/tdnn_7b_chain_online;
utils/mkgraph.sh — self-loop-scale 1.0 data/lang_pp_test exp/tdnn_7b_chain_online exp/tdnn_7b_chain_online/graph;
steps/online/nnet3/decode.sh — nj 1 — acwt 1.0 — post-decode-acwt 10.0 exp/tdnn_7b_chain_online/graph ~/Desktop/ASR_demo/ exp/tdnn_7b_chain_online/decode_ASR_demo;
lattice-to-post --acoustic-scale=0.1 "ark:gunzip -c exp/tdnn_7b_chain_online/decode_ASR_demo/lat.1.gz|" ark:- | post-to-phone-post exp/tdnn_7b_chain_online/final.mdl ark:- ark,t:phone-post1.txt
