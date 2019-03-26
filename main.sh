#!/bin/bash
python fasttext_prep.py
cat data.txt | sed -e "s/\([-]\)/ /g" | sed -e 's/[^ ]*@[^ ]*/name/ig' | tr -s ' ' | tr "[:upper:]" "[:lower:]" > data.all
#cat data_t.txt | tr -s ' ' | tr "[:upper:]" "[:lower:]" > data_p.txt
N=$(wc -l < data.all)
echo "preprocessed!!!"
#for i in {1..100}
#do
#	shuf data_p.txt > data_t.txt
#	shuf data_t.txt > data_p.txt
#done
#echo "shuffled!!!"
head -n $((N-1000)) data.all > data.train
tail -n 1000 data.all > data.valid
./fastText/fasttext supervised -input data.train -inputModel wiki.en.bin -output model -lr 0.1 -epoch 500 -wordNgrams 3
#./fastText/fasttext supervised -input data.train -output model -lr 1 -epoch 50 -wordNgrams 2
./fastText/fasttext test model.bin data.valid
rm -rf data.* model.*