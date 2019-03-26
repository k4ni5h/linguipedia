test_f = open("test.csv")
test = test_f.readlines()
test_f.close()

f1 = open("test.txt","+w")
for row in test[1:]:
	if row != "\n":
		f1.write((",".join(row.split(",")[1:])).replace("$&@*#","fuck"))
f1.close()

train_f = open("train.csv")
train = train_f.readlines()
train_f.close()

f2 = open("data.txt","+w")
for row in train[1:]:
	if row != "\n":
		x=row.split(",")
		f2.write("__label__"+x[1]+" "+(",".join(x[2:])).replace("$&@*#","fuck"))
f2.close()