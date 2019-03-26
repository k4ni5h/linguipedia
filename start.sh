#!/bin/bash
python fasttext_prep.py
cat data.txt | sed -e "s/\([-]\)/ /g" | sed -e 's/[^ ]*@[^ ]*/name/ig' | tr -s ' ' | tr "[:upper:]" "[:lower:]" > data.all
cat test.txt  | sed -e "s/\([-]\)/ /g" | sed -e 's/[^ ]*@[^ ]*/name/ig' | tr -s ' ' | tr "[:upper:]" "[:lower:]" > data.test
#cat data_t.txt | tr -s ' ' | tr "[:upper:]" "[:lower:]" > data_p.txt
#echo "start preprocessing..."
#for i in {1..100}
#do
#	shuf data_p.txt > data_t.txt
#	shuf data_t.txt > data_p.txt
#done
echo "starting training..."
cat data.all > data.train
./fastText/fasttext supervised -input data.train -inputModel wiki.en.bin -output model -lr 0.1 -epoch 500 -wordNgrams 2
#../fastText/fasttext supervised -input data.train -output model -lr 1 -epoch 50 -wordNgrams 2
echo "starting testing..."
./fastText/fasttext predict model.bin data.test > data.results
python fasttext_post.py
rm -rf data.* model.*