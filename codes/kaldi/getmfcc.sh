directory_path=Coswara
for dir in $directory_path; do
steps/make_fbank.sh /home/oem/Desktop/DiCOVA/$dir/vowel-e_fbank /home/oem/Desktop/DiCOVA/$dir/vowel-e_fbank/log /home/oem/Desktop/DiCOVA/$dir/vowel-e_fbank/fbank
done
