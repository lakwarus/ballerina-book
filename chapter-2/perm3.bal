import ballerina/io;

public function main() {
    int a = 5; int b = 10;
    _ = perm(a, b);
    int result2 = perm(5, 3);
    io:println(result1);
    io:println(result2);
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
