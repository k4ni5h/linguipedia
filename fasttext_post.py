res_f = open("data.results")
res = res_f.readlines()
res_f.close()

test_f = open("test.csv")
test = test_f.readlines()
test_f.close()

f = open("results.csv", "w+")
f.write("id,label\n")
for r, t in zip(res, test[1:]):
	if r != "\n":
		f.write((t.split(",")[0])+","+r[9]+"\n")
f.close()