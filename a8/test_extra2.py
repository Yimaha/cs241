f = open("test_extra2.wlp4", "w+")
f.write("int foo0" + "(int a, int b, int c, int d) {return a + b + c + d;}\n")
for i in range(1, 1001):
    f.write("int foo" + i.__str__() + "(int a, int b, int c, int d) {int g = 0; int e = 0; int f = 0; return a + b + c + d + foo" + (i - 1).__str__() + "(0,1,0,0);}\n")
f.write("int wain(int a, int b) {return foo1000(0,0,0,1);}")
