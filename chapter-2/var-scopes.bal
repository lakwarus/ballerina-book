import ballerina/io;

public function main() {
    int i = 0;
    while i < 10 {
        io:println(i);
        i = i + 1;
        int j = 20;
    }
    io:println(j);
}

function perm(int n, int r) returns int {
   int x = n - r;
   int nf = 1;
   int xf = 1;
   int i = n;
   while (i > 0) {
       nf = nf * i;
       i = i - 1;
   }
   i = x;
   while (i > 0) {
      xf = xf * i;
       i = i - 1;
   }
   int result = nf / xf;
   return result;
}
